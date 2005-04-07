<%--
/*
 * ============================================================================
 *                   PDF Reports Display
 * ============================================================================
 * 
 */
--%>

<%@ page errorPage = "dsp_error.jsp"%>
<%@ page import = "dori.jasper.engine.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "x" uri = "http://java.sun.com/jstl/xml"%>

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
    String appUrl = null;
    String separator = null;

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

        byte [] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters,
                                                        new JRResultSetDataSource(rs));

        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream ouputStream = response.getOutputStream();
        ouputStream.write(bytes, 0, bytes.length);
        ouputStream.flush();
        ouputStream.close();
        }
    catch (Exception e)
        {
        e.printStackTrace(System.err);
        }
%>
