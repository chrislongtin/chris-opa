<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
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

<sql:setDataSource var = "lyrics" dataSource = "Lyris" url = ""/>

<sql:query var = "listmembers" dataSource = "${lyris}">
    SELECT list, fullname, emailaddr, datejoined, subtype FROM members WHERE list = ? ORDER BY fullname, emailaddr

    <sql:param value = "${list}"/>
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "173" lang_id = "${lang}"/></h3>

<table cellpadding = "3">
    <TR bgcolor = "A8A8A8">
        <TD>
            <font face = "Arial" size = "-1"><b>

            <cf:GetPhrase phrase_id = "66" lang_id = "${lang}"/></b>
        </TD>

        <TD>
            <font face = "Arial" size = "-1"><b>

            <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/></b>
        </TD>

        <TD>
            <font face = "Arial" size = "-1"><b>

            <cf:GetPhrase phrase_id = "174" lang_id = "${lang}"/></b>
        </TD>
    </TR>

    <c:forEach var = "row" items = "${listmembers.rows}">
        <tr>
            <TD bgcolor = "d2d2d2">
                <font face = "Arial" size = "-1">

                <c:out value = '${row.fullname}'/>
            </TD>

            <TD>
                <font face = "Arial" size = "-1"><a STYLE="text-decoration: underline"  href = "mailto:<c:out value='${row.emailaddr}'/>">

                <c:out value = '${row.emailaddr}'/></A>
            </TD>

            <TD>
                <font face = "Arial" size = "-1">

                <center>
                    <fmt:formatDate pattern = 'dd-MMM-yyyy' value = '${row.datejoined}'/>
                </center>
            </TD>
        </TR>
    </c:forEach>
</TABLE>
