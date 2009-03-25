<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:setDataSource var = "lyrics" dataSource = "Lyris" url = ""/>

<sql:query var = "messagedates" dataSource = "${lyris}">
    SELECT created, hdrfrom, hdrsubject, hdrfromspc, body, messageid FROM messages where messageid = ? ;

    <sql:param value = "${param.id}"/>
</sql:query>

<c:forEach var = "row" items = "${messagedates.rows}">
    <CFX_MIME SrcString = "#body#" Action = "QPDecode" Result = "decoded">
        <CF_Wrap WrapSource = #decoded# WrapLength = 80 Web = "NO" Wrap = "YES" OutputVar = "formattedmessage">
        </c:forEach>

        <center>
            <c:forEach var = "row" items = "${messagedates.rows}">
                <BR>
                <H3>

                <c:out value = '${row.hdrsubject}'/></H3>

                <table cellspacing = "2" cellpadding = "2" width = "600">
                    <tr bgcolor = "d2d2d2">
                        <td align = "right"><FONT face = "arial" size = "-1" COLOR = "blue">

                            <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/>:</FONT></td>

                        <td><font face = "arial" size = "-1">

                            <c:out value = '${row.created}'/></font></td>
                    </tr>

                    <tr bgcolor = "d2d2d2">
                        <td align = "right"><FONT face = "arial" size = "-1" COLOR = "blue">

                            <cf:GetPhrase phrase_id = "172" lang_id = "${lang}"/>:</FONT></td>

                        <td><font size = "-1">

                            <c:out value = '${row.hdrfrom}'/></font></td>
                    </tr>

                    <tr bgcolor = "cccccc">
                        <td align = "right"><FONT face = "arial" size = "-1" COLOR = "blue">

                            <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:</FONT></td>

                        <td><font face = "arial" size = "-1"><b>

                            <c:out value = '${row.hdrsubject}'/></b></font></td>
                    </tr>

                    <tr bgcolor = "cccccc">
                        <td valign = top align = right><FONT face = "arial" size = "-1" COLOR = "blue">

                            <cf:GetPhrase phrase_id = "167" lang_id = "${lang}"/>:</FONT></td>

                        <td valign = top>
<%
                            String fmsg = (String)pageContext.getAttribute("formattedmessage");

                            int pos1 = fmsg.indexOf("Content-Type");
                            int pos2 = fmsg.indexOf("Content-Type", pos1 + 10);

                            if ((pos1 >= 0) && (pos2 >= 0))
                                {
                                String firstchunk = "";

                                if (fmsg.indexOf("MIME-Autoconverted") >= 0)
                                    {
                                    firstchunk = fmsg.substring(pos1 + 174, pos2 - 189);
                                    }

                                else
                                    {
                                    firstchunk = fmsg.substring(pos1 + 74, pos2 - 111);
                                    }
%><font face = "arial" size = "-1"><pre><%= firstchunk %></pre></font>

<%
                                }

                            else
                                {
%><font face = "arial" size = "-1"><pre><c:out value='${formattedmessage}'/></pre></font>

<%
                                }
%>
                        </td>
                    </tr>
                </table>
        </center>

        </c:forEach>


