<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "list_qry">
    select listname from initiative_setup
</sql:query>

<c:forEach var = "row" items = "${list_qry.rows}">
    <c:forTokens var = "it" items = "row.listname" delims = "@" end = "0">
        <c:set var = "list" value = "${it}"/>
    </c:forTokens>
</c:forEach>

<c:set var = "sort">
    <c:out value = "${param.sort}" default = "creatstamp"/>
</c:set>

<sql:setDataSource var = "lyrics" dataSource = "Lyris" url = ""/>

<sql:query var = "messagedates" dataSource = "${lyris}">
    SELECT created, hdrfrom, hdrsubject, hdrfromspc, messageid FROM messages
    where list = ? order by ?

    <c:if test = "${sort == 'creatstamp'}">
        desc
    </c:if>

    <sql:param value = "${list}"/>

    <sql:param value = "${sort}"/>
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "168" lang_id = "${lang}"/></h3>

<center>
    <p>
    <table width = "100%" border = "0" cellspacing = "0" cellpadding = "3">
        <tr>
            <td>
                <font face = "Arial"
                      size = "-1"><a STYLE = "text-decoration: underline"
                                     href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_email_members'/>
<c:param name='${user}'/>
</c:url>">

                <cf:GetPhrase phrase_id = "169" lang_id = "${lang}"/></a>
            </td>

            <td align = right colspan = 2>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "170" lang_id = "${lang}"/>:</b>
                <a STYLE = "text-decoration: underline"
                   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_email_archive'/>
<c:param name='${user}'/>
<c:param name='sort' value='creatstamp'/>
</c:url>"><i>

                <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/></i></a> |
                <a STYLE = "text-decoration: underline"
                   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_email_archive'/>
<c:param name='${user}'/>
<c:param name='sort' value='hdrsubject'/>
</c:url>"><i>

                <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/></i></a> |
                <a STYLE = "text-decoration: underline"
                   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_email_archive'/>
<c:param name='${user}'/>
<c:param name='sort' value='hdrfrom'/>
</c:url>"><i>

                <cf:GetPhrase phrase_id = "66"
                              lang_id = "${lang}"/></i></a></font>
            </td>
        </tr>

        <tr bgcolor = "A8A8A8">
            <TD>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "172" lang_id = "${lang}"/></b>
            </TD>

            <TD>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/></b>
            </TD>

            <td>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/></b>
            </td>
        </TR>

        <tr>
        </tr>

        <c:forEach var = "row" items = "${messagedates.rows}">
            <tr BGCOLOR = "cccccc">
                <td>
                    <img src = "images/arrow_red.gif" border = 0
                         alt = ""                     width = 13
                         height = 8><font face = "Arial" size = "-1">

                    <c:out value = '${row.hdrfrom}'/></font>
                </TD>

                <TD>
                    <a STYLE = "text-decoration: underline"
                       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_email_message'/>
<c:param name='id' value='${row.messageid}'/>
<c:param name='${user}'/>
</c:url>"><font face = "Arial"
                                                                                                                                                   size = "-1">

                    <c:out value = '${row.hdrsubject}'/></font></a>
                </TD>

                <TD>
                    <font face = "Arial" size = "-1">

                    <c:out value = '${row.created}'/></font>
                </TD>
            </TR>
        </c:forEach>
    </TABLE>
</CENTER>
