/* 
 * Copyright (C) 2009 Chris Longtin
 * 
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 51
 * Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 * 
 * This class will retrieve messages from the database instead of a message
 * resource file.
 */

package opa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.core.Config;
import javax.servlet.jsp.jstl.fmt.LocalizationContext;

import opa.DatabaseResourceBundle;
import opa.model.InitiativeSetup;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * This filter will load a ResourceBundle into the users session based on the
 * InitiativeSetup.lang_id stored in their session.
 * 
 * @author Chris Longtin
 * @email chris.longtin@gmail.com
 */
public class LoadResourceBundle implements Filter {

    private final static Log log = LogFactory.getLog(LoadResourceBundle.class);
	private String jdbcJndi;

	@Override
	public void init(FilterConfig fc) throws ServletException {
        jdbcJndi = fc.getInitParameter("jdbcJndi");		
	}
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc)
			throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();
        
        DatabaseResourceBundle bundle = null;
        
        InitiativeSetup setup = 
            (InitiativeSetup)session.getAttribute("initiativeSetup");

    	LocalizationContext context = (LocalizationContext) 
    		Config.get(session, Config.FMT_LOCALIZATION_CONTEXT);

    	if(context != null)
    		bundle = (DatabaseResourceBundle)context.getResourceBundle();
        
        if(setup == null || setup.getLang_id() == null) {
        	throw new ServletException(
					"Could not get language from InitiativeSetup object in application context.");
        }
        
        if(bundle == null || !bundle.getLangId().equals(setup.getLang_id())) {
        	if(bundle != null) {
        		bundle.destroy();
        		bundle = null;
        	}
        	
        	bundle = new DatabaseResourceBundle(jdbcJndi, setup.getLang_id());
        	bundle.init();
        	
        	/*
             * set the localization context of the session for jsp to process  
             */
            Config.set(session, Config.FMT_LOCALIZATION_CONTEXT, 
            		new LocalizationContext(bundle, null));
            
            log.info("setting language for current user to: " + 
            		bundle.getLangId());
        }

        fc.doFilter(req, res);
    }
}
