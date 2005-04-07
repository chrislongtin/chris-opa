<%--
/*
 * ============================================================================
 *                  HTML Reports Display
 * ============================================================================
 * 
 */
--%>

<%@ page errorPage = "dsp_error.jsp"%>
<%@ page import = "dori.jasper.engine.*"%>
<%@ page import = "dori.jasper.engine.util.*"%>
<%@ page import = "dori.jasper.engine.export.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ taglib prefix = "x" uri = "http://java.sun.com/jstl/xml"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>

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

        JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());

        JasperPrint jasperPrint   = JasperFillManager.fillReport(jasperReport, parameters, new JRResultSetDataSource(rs));

        JRHtmlExporter exporter   = new JRHtmlExporter();

        int pageIndex             = 0;
        int lastPageIndex         = 0;

        if (jasperPrint.getPages() != null)
            {
            lastPageIndex = jasperPrint.getPages().size() - 1;
            }

        String pageStr = request.getParameter("page");

        try
            {
            pageIndex = Integer.parseInt(pageStr);
            }
        catch (Exception e)
            {
            }

        if (pageIndex < 0)
            {
            pageIndex = 0;
            }

        if (pageIndex > lastPageIndex)
            {
            pageIndex = lastPageIndex;
            }

        StringBuffer sbuffer = new StringBuffer();

        Map imagesMap = new HashMap();
        session.setAttribute("IMAGES_MAP", imagesMap);

        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER, sbuffer);
        exporter.setParameter(JRHtmlExporterParameter.IMAGES_MAP, imagesMap);
        exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, "image.jsp?image=");
        exporter.setParameter(JRExporterParameter.PAGE_INDEX, new Integer(pageIndex));
        exporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML, "");
        exporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");

        exporter.exportReport();
%>

        <table width = "100%" cellpadding = "0" cellspacing = "0" border = "0">
            <tr>
                <td width = "50%">
                    &nbsp;
                </td>

                <td align = "left">
                    <hr size = "1" color = "#000000">
                    <table width = "100%" cellpadding = "0" cellspacing = "0" border = "0">
                        <tr>
                            <td>
                                <a STYLE="text-decoration: underline"  href = "<%= appUrl %>htmlReportsDisplay.jsp?selection=<%= selection %>&displayType=html&reload=true"><img src = "../images/reload.GIF"
                                                                                                                                             border = "0"></a>
                            </td>

                            <td>
                                &nbsp;&nbsp;&nbsp;
                            </td>

<%
                            if (pageIndex > 0)
                                {
%>

                                <td>
                                    <a STYLE="text-decoration: underline"  href = "<%= appUrl %>htmlReportsDisplay.jsp?selection=<%= selection %>&displayType=html&page=0"><img src = "../images/first.GIF"
                                                                                                                                            border = "0"></a>
                                </td>

                                <td>
                                    <a STYLE="text-decoration: underline"  href = "<%= appUrl %>htmlReportsDisplay.jsp?selection=<%= selection %>&displayType=html&page=<%= pageIndex - 1 %>"><img src = "../images/previous.GIF"
                                                                                                                                                               border = "0"></a>
                                </td>

<%
                                }

                            else
                                {
%>

                                <td>
                                    <img src = "../images/first_grey.GIF" border = "0">
                                </td>

                                <td>
                                    <img src = "../images/previous_grey.GIF" border = "0">
                                </td>

<%
                                }

                            if (pageIndex < lastPageIndex)
                                {
%>

                                <td>
                                    <a STYLE="text-decoration: underline"  href = "<%= appUrl %>htmlReportsDisplay.jsp?selection=<%= selection %>&displayType=html&page=<%= pageIndex + 1 %>"><img src = "../images/next.GIF"
                                                                                                                                                               border = "0"></a>
                                </td>

                                <td>
                                    <a STYLE="text-decoration: underline"  href = "<%= appUrl %>htmlReportsDisplay.jsp?selection=<%= selection %>&displayType=html&page=<%= lastPageIndex %>"><img src = "../images/last.GIF"
                                                                                                                                                               border = "0"></a>
                                </td>

<%
                                }

                            else
                                {
%>

                                <td>
                                    <img src = "../images/next_grey.GIF" border = "0">
                                </td>

                                <td>
                                    <img src = "../images/last_grey.GIF" border = "0">
                                </td>

<%
                                }
%>

                                <td width = "100%">
                                    &nbsp;
                                </td>
                        </tr>
                    </table>

                    <hr size = "1" color = "#000000">
                </td>

                <td width = "50%">
                    &nbsp;
                </td>
            </tr>

            <tr>
                <td width = "50%">
                    &nbsp;
                </td>

                <td align = "center">
                    <%= sbuffer.toString() %>
                </td>

                <td width = "50%">
                    &nbsp;
                </td>
            </tr>
        </table>

<%
        }
    catch (Exception e)
        {
        e.printStackTrace(System.err);
        }
%>
