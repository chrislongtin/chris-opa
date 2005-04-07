<%@ page language = "java"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.*"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ page errorPage = "admin/dsp_error.jsp"%>

<%!
    String setValue(String s)
        {
        return ((s == null) || (s.equals("null"))) ? "-" : s;
        }
%>

<%
    String body  = "<p><center><font face='arial,helvetica' size=3><STRONG>" + "<font color=blue>CFP Search</font>"
                       + "</STRONG></font></center><br><br><a STYLE="text-decoration: underline"  href = \"../admin/index.jsp?fuseaction=list_cfp\">Back to Selection</a>";

    ResultSet rs = null;
    ResultSetMetaData rsmd;
    String query = null;
    int numColumns = 0;
    String columnNames = null;
    String rowValues = null;
    String outUrl = null;

    Calendar cal = Calendar.getInstance();
    int currentYear = cal.get(Calendar.YEAR);
    int currentMonth = cal.get(Calendar.MONTH);
    int currentDay = cal.get(Calendar.DAY_OF_MONTH);
    int currentHour = cal.get(Calendar.HOUR);
    int currentMin = cal.get(Calendar.MINUTE);
    int currentSec = cal.get(Calendar.SECOND);
    currentMonth++;
    String timestamp = Integer.toString(currentYear) + Integer.toString(currentMonth) + Integer.toString(currentDay)
                           + Integer.toString(currentHour) + Integer.toString(currentMin)
                           + Integer.toString(currentSec);
    String tableFile = timestamp + ".csv";
    FileWriter file  = new FileWriter(tableFile);
    PrintWriter outfile = new PrintWriter(file);

    String columnNamesTrans = null;
    int year         = 0;
    int day          = 0;
    int month        = 0;
    String listUrl   = null;
    String monthx    = null;
    String yearx     = null;
    String dayx      = null;
%>

<%
    Connection conn  = null;

    try
        {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/applicants?user=root&password=");
        Statement stmt                    = conn.createStatement();

        //		       	   body = body +  "<br><br><br><p><center><h2>CFP List</h2></center><br><br>";
        String [] columnNamesTranslation7 =
            {
            "Title",
            "Start Date",
            "Deadline",
            "Company"
            };

        query = "select cfp_title,  " + "cfp_startdate, cfp_deadline,cfp_focus " + "from cfp_info "
                    + "where cfp_deadline >= CURDATE() " + " order by cfp_deadline asc";

        rs = stmt.executeQuery(query);

        rsmd = rs.getMetaData();

        numColumns = rsmd.getColumnCount();
        columnNamesTrans = columnNamesTranslation7[0];

        for (int f = 1; f < numColumns; f++)
            {
            columnNamesTrans = columnNamesTrans + "\t" + columnNamesTranslation7[f];
            }

        columnNamesTrans = columnNamesTrans + "\n";
        outfile.print(columnNamesTrans);

        while (rs.next())
            {
            rowValues = setValue(rs.getString(1)).trim();

            for (int s = 2; s < numColumns + 1; s++)
                {
                rowValues = rowValues + "\t" + setValue(rs.getString(s)).trim();
                }

            rowValues = rowValues + "\n";
            outfile.print(rowValues);
            }
        }
    catch (ClassNotFoundException e)
        {
        throw new ServletException("Database drivers not available", e);
        }
    catch (SQLException e)
        {
        throw new ServletException("Your query isn't working. " + query, e);
        }
    catch (Exception e)
        {
        e.printStackTrace(System.err);
        }
    finally
        {
        try
            {
            conn.close();
            outfile.close();
            }
        catch (Exception e)
            {
            e.printStackTrace(System.err);
            }
        }

    try
        {
        String outConfigFile = timestamp + ".txt";
        //String outConfigFile = timestamp;

        FileWriter xfile = new FileWriter(outConfigFile);
        PrintWriter outx = new PrintWriter(xfile);
        outx.println("data=" + tableFile);
        outx.println("format=2");
        outx.println("page=10");
        outx.println("table=width=\"80%\" border=2 cellpadding=4 cellspacing=2");
        //outx.println("body=background=\"docs/regionsbk.jpg\"> "+body +"<center");
        outx.println("title_row=bgcolor=\"FFFFCC\"");
        outx.println("odd_row=bgcolor=\"CCCCFF\" BORDERCOLOR=#c0c0c0 font size=\"1\"");
        outx.println("even_row=bgcolor=\"CCCCCC\" BORDERCOLOR=#c0c0c0 font size=\"1\"");
        outx.close();
        outUrl = "../servlet/PubCatServlet";
        //outUrl = outConfigFile;

%>

        <center>
            <form action = " <%= outUrl %> ">
                <input type = "hidden" name = "config" value = "<%= outConfigFile %>">
                <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
            </form>
        </center>

<%
        }
    catch (IOException e)
        {
        e.printStackTrace(System.err);
        }
%>
