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
        
        InitiativeSetup setup = 
            (InitiativeSetup)session.getAttribute("initiativeSetup");

        /*
		 * store current language in session to avoid reconstructing
		 * DatabaseResourceBundle
		 */
        Integer langId = 
        	(Integer)session.getAttribute(this.getClass().getName());
        
        if(setup == null || setup.getLang_id() == null) {
        	throw new ServletException(
					"Could not get language from InitiativeSetup object in application context.");
        }
        
        if(langId == null || !langId.equals(setup.getLang_id())) {
        	DatabaseResourceBundle bundle = 
        		new DatabaseResourceBundle(jdbcJndi, setup.getLang_id());
        	
        	/*
             * set the localization context of the session for jsp to process  
             */
            Config.set(session, Config.FMT_LOCALIZATION_CONTEXT, 
            		new LocalizationContext(bundle, null));
            
            session.setAttribute(this.getClass().getName(), langId);
            
            log.info("setting language for current user to: " + 
            		bundle.getLangId());
        }

        fc.doFilter(req, res);
    }
}
