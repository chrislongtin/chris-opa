package opa.filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

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

public class LoadInitiativeSetup implements Filter {
	
	//private final static Logger logger = Logger.getLogger(LoadInitiativeSetup.class);
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc)
			throws IOException, ServletException {
		
		Connection conn = null;

		try {
			HttpServletRequest request = (HttpServletRequest) req;
			System.out.println("AAA");
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/opa");
			conn = ds.getConnection();
			ResultSet rs = conn.createStatement().executeQuery(
					"select host_doc_dir from initiative_setup");
			rs.next();
			String host_doc_dir = rs.getString("host_doc_dir");
			request.getSession().setAttribute("DOCS_DIR", host_doc_dir);
			System.out.println("BBB: " + host_doc_dir);

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
//
	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
