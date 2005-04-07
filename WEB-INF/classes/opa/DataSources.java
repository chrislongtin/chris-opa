package opa;
import java.util.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *  Description of the Class
 *
 *@author     Administrator
 *@created    May 24, 2004
 */

public class DataSources {
	private  Hashtable  errors;
	         String     query   = null;



	/**
	 *  Description of the Method
	 *
	 *@return                             Description of the Return Value
	 *@exception  ClassNotFoundException  Description of the Exception
	 *@exception  SQLException            Description of the Exception
	 */
	public Connection dbConnection()
		throws ClassNotFoundException, SQLException {

	Connection  conn  = null;

		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/coseopajava?user=root&password=");
		}

		catch (Exception e) {
			e.printStackTrace(System.err);
		}

		return conn;
	}



	/**
	 *  Description of the Method
	 *
	 *@param  conn                        Description of the Parameter
	 *@return                             Description of the Return Value
	 *@exception  ClassNotFoundException  Description of the Exception
	 */
	public String AppUrl(Connection conn)
		throws ClassNotFoundException {

	ResultSet  rs       = null;
	String     query    = null;
	String     hostUrl  = null;

		try {

		Statement  stmt  = conn.createStatement();
			query = "select host_url from initiative_setup";
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				hostUrl = rs.getString(1);
			}

		}

		catch (Exception e) {
			e.printStackTrace(System.err);
		}

		return hostUrl;
	}


	/**
	 *  Description of the Method
	 *
	 *@param  conn                        Description of the Parameter
	 *@param  selection                   Description of the Parameter
	 *@return                             Description of the Return Value
	 *@exception  ClassNotFoundException  Description of the Exception
	 */
	public String ReportName(Connection conn, int selection)
		throws ClassNotFoundException {

	ResultSet  rs          = null;
	String     query       = null;
	String     reportName  = null;

		try {

		Statement  stmt  = conn.createStatement();
			query = "select report_filename from reports_control_table where report_id = " + selection;
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				reportName = rs.getString(1);
			}

		}

		catch (Exception e) {
			e.printStackTrace(System.err);
		}

		return reportName;
	}


	/**
	 *  Description of the Method
	 *
	 *@param  conn                        Description of the Parameter
	 *@param  selection                   Description of the Parameter
	 *@param  xmlfilename                 Description of the Parameter
	 *@return                             Description of the Return Value
	 *@exception  ClassNotFoundException  Description of the Exception
	 *@exception  SQLException            Description of the Exception
	 */
	public ResultSet ResultSetForSelection(Connection conn, int selection, java.io.File xmlfilename)
		throws ClassNotFoundException, SQLException {

	ResultSet  rs          = null;
	String     query       = null;
	String     reportName  = null;
	String     s           = "**";

	String     oneLine     = null;

		try {

		Statement       stmt     = conn.createStatement();

		FileReader      theFile  = new FileReader(xmlfilename);
		BufferedReader  fileIn   = new BufferedReader(theFile);

			while ((oneLine = fileIn.readLine()) != null) {

				s = s + " " + oneLine;
			}

		int             q1       = s.indexOf("<queryString><![CDATA[");
		int             q2       = s.indexOf("]]></queryString>");

			query = s.substring(q1 + 22, q2);

			rs = stmt.executeQuery(query);

		}

		catch (Exception e) {
			e.printStackTrace(System.err);
		}

		return rs;
	}


	/**
	 *  Description of the Method
	 *
	 *@param  conn                        Description of the Parameter
	 *@param  query                       Description of the Parameter
	 *@return                             Description of the Return Value
	 *@exception  ClassNotFoundException  Description of the Exception
	 *@exception  SQLException            Description of the Exception
	 */
	public ResultSet ResultSetForReport(Connection conn, String query)
		throws ClassNotFoundException, SQLException {

	ResultSet  rs  = null;

		try {

		Statement  stmt  = conn.createStatement();
			rs = stmt.executeQuery(query);
		}

		catch (Exception e) {
			e.printStackTrace(System.err);
		}

		return rs;
	}
}


