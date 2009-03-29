<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "msg_type">
    select L.*, S.status_name from default_letters L, record_status S where
    letter_id = ? and L.status_id = S.status_id

    <sql:param value = "${param.letter_id}"/>
</sql:query>

<c:forEach var = "row" items = "${msg_type.rows}">
    <h3>

    <fmt:message key = "58" />

    :

    <c:out value = '${row.status_name}'/></h3> <b>

    <fmt:message key = "42" />:</b>

    <c:out value = '${row.letter_subject}'/>

    <p>
    <fmt:message key = "184" />

    <menu><c:out value = '${row.letter_body}'/></menu>
</c:forEach>
