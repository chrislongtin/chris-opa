package opa.filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

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
import javax.sql.DataSource;

/**
 * @author Chris Longtin
 * @email chris.longtin@gmail.com
 * 
 *        This filter will ensure that initiative_setup.host_doc_dir is always
 *        saved in application context as DOCS_DIR. This is used as the path to
 *        store uploaded files.
 */
public class LoadInitiativeSetup implements Filter {

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
            Context ctx = new InitialContext();

            /*
             * TODO: get jndi value string from somewhere else  
             */
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/" + jdbcJndi);
            conn = ds.getConnection();

            ResultSet rs = conn.createStatement().executeQuery(
                    "select host_doc_dir from initiative_setup");
            rs.next();

            String host_doc_dir = rs.getString("host_doc_dir");
            request.getSession().setAttribute("DOCS_DIR", host_doc_dir);

        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
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
