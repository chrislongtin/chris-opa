<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- select status information where default letters have been setup for that status --->

<sql:query var = "status_select">
    select RS.status_id, RS.status_name from record_status RS, default_letters
    DL where RS.status_id = DL.status_id order by RS.status_id
</sql:query>

<h3>

<fmt:message key = "264" /></h3>

<fmt:message key = "506" />

<c:choose>
    <c:when test = "${status_select.rowCount == 0}">
        <p>
        <fmt:message key = "507" />
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=comm_default_letters">

        <fmt:message key = "508" />.</a>
    </c:when>

    <c:otherwise>
        <form action = "index.jsp?fuseaction=act_send_letters" method = "post">
            <select name = "status_id">
                <c:forEach var = "row" items = "${status_select.rows}">
                    <option value = "<c:out value='${row.status_id}'/>">
                    <c:out value = '${row.status_name}'/>
                </c:forEach>
            </select>

            <input type = "submit"
                   value = " <fmt:message key="264"  /> ">
        </form>
    </c:otherwise>
</c:choose>
