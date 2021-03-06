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
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import opa.Utils;
import opa.model.InitiativeSetup;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Chris Longtin
 * @email chris.longtin@gmail.com
 * 
 *        This filter will ensure that initiative_setup table is stored in
 *        application context as the InitiativeSetup domain object named
 *        initiativeSetup.
 *        
 *        TODO: instead of doing lookup all of the time, implement a TTL cache
 */
public class LoadInitiativeSetup implements Filter {

    private final static Log log = LogFactory.getLog(BlockProcessing.class);

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
        
        Connection conn = null;

        try {
            HttpServletRequest request = (HttpServletRequest) req;
            HttpServletResponse response = (HttpServletResponse) res;

            /*
             * select the fields from initiative_setup and translate them to the
             * InitiativeSetup model.
             * 
             * TODO: use a real object-relational-mapper like hibernate.
             */
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/" + jdbcJndi);
            conn = ds.getConnection();

            ResultSet rs = conn.createStatement().executeQuery(
                    "select I.*, L.language from initiative_setup I, languages L " +
                    "where I.default_lang = L.lang_id");
            
            if(rs.next() == false) {
                log.fatal("Could not get info from initiative_setup table.");
                response.sendError(500);
            }
            
            InitiativeSetup setup = new InitiativeSetup();
            Map<String, Object> map = Utils.resultSetToMap(rs);
            
            try {
                BeanUtils.populate(setup, map);
            } catch (Exception e) {
                log.fatal("could not build InitiativeSetup from table initiative_setup");
                log.fatal(e, e);
                response.sendError(500);
            }

            request.getSession().setAttribute("initiativeSetup", setup);

        } catch (NamingException e) {
            log.fatal(e, e);
        } catch (SQLException e) {
            log.fatal(e, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    // bleh
                }
            }
        }

        fc.doFilter(req, res);
    }
}
