<%--
/*
 * ============================================================================
 *                   CSV Reports
 * ============================================================================
 */
--%>

<%@ page errorPage = "dsp_error.jsp"%>
<%@ page import = "dori.jasper.engine.*"%>
<%@ page import = "dori.jasper.engine.util.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "dori.jasper.engine.data.*"%>
<%@ page import = "dori.jasper.engine.export.*"%>
<%@ page import = "javax.servlet.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "x" uri = "http://java.sun.com/jstl/xml"%>

<jsp:include page = "header.jsp" flush = "true"/>

<jsp:useBean id = "get" class = "opa.DataSources" scope = "session"/>

<jsp:setProperty name = "get" property = "*"/>

</jsp:useBean>

<%
    int selection = Integer.parseInt(request.getParameter("selection"));

    ResultSet rs = null;
    String query = null;
    Connection conn = null;
    String filename = null;
    String reportFileName = null;
    String xmlfilename = null;
    String exportFile = null;
    String exportUrl = null;
    String appUrl = null;
    String separator = null;
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

    try
        {
        conn = get.dbConnection();

        reportFileName = get.ReportName(conn, selection);

        appUrl = get.AppUrl(conn);

        String xmlUrl = appUrl + "reports/" + reportFileName + ".xml";
        session.setAttribute("xmlUrl", xmlUrl);
%>

        <c:import url = "${sessionScope.xmlUrl}" var = "xml"/>

        <x:parse var = "doc" xml = "${xml}"/>

        <x:set var = "sqlStmt" select = "$doc/jasperReport/queryString" scope = "page"/>

        <c:set var = "sqll">
            <x:out escapeXml = "false" select = "string($sqlStmt)"/>
        </c:set>

<%
        if (System.getProperty("os.name").indexOf("Windows") > -1)
            separator = "\\";

        else
            separator = "/";

        filename = separator + "admin" + separator + "reports" + separator + reportFileName + ".jasper";
        xmlfilename = separator + "admin" + separator + "reports" + separator + reportFileName + ".xml";

        File sourceFile = new File(filename);

        File reportFile = new File(application.getRealPath(filename));
        File xmlreportFile = new File(application.getRealPath(xmlfilename));

        rs = get.ResultSetForReport(conn, (String)pageContext.getAttribute("sqll", PageContext.PAGE_SCOPE));

        Map parameters = new HashMap();
        parameters.put("ReportTitle", reportFileName);
        parameters.put("BaseDir", reportFile.getParentFile());

        JasperReport jasperReportz = (JasperReport)JRLoader.loadObject(reportFile.getPath());
        JasperPrint jasperPrintz = JasperFillManager.fillReport(jasperReportz, parameters,
                                                                new JRResultSetDataSource(rs));
        File destFilez           = new File(reportFile.getParentFile(),
                                            separator + "export" + separator + reportFileName + "_" + timestamp
                                                + ".csv");

        JRCsvExporter exporterz  = new JRCsvExporter();

        exporterz.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrintz);
        exporterz.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFilez.toString());
        exporterz.setParameter(JRCsvExporterParameter.FIELD_DELIMITER, ",");

        exporterz.exportReport();
        exportFile = reportFile.getParentFile() + separator + "export" + separator + reportFileName + "_" + timestamp
                         + ".csv";

        exportUrl = appUrl + "reports/export/" + reportFileName + "_" + timestamp + ".csv";
        }
    catch (Exception e)
        {
        e.printStackTrace(System.err);
        }
%>

<br>
<br>
<br>
<p>
<font size = "+3" color = "#FF0000">

<center>
    Export Completed
</center>

</font></p>

<p>
<font size = "+2" color = "#FF0000">

<center>
    Use MS Excel to view .csv file.
</center>

</font></p>

<p>
<font size = "+2" color = "#FF0000">

<center>
    <a STYLE="text-decoration: underline"  href = "<%= exportUrl %>">Download</font><font size = "1" color = "#FF0000">(Right Mouse Button... Save Traget
As..)</font>

</center>

</a>
