<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "msg_type">
    select L.*, S.status_name from default_letters L, record_status S where letter_id = ? and L.status_id = S.status_id

    <sql:param value = "${param.letter_id}"/>
</sql:query>

<c:forEach var = "row" items = "${msg_type.rows}">
    <h3>

    <cf:GetPhrase phrase_id = "58" lang_id = "${lang}"/>

    :

    <c:out value = '${row.status_name}'/></h3> <b>

    <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:</b>

    <c:out value = '${row.letter_subject}'/>

    <p>
    <cf:GetPhrase phrase_id = "184" lang_id = "${lang}"/>

    <menu><c:out value = '${row.letter_body}'/></menu>
</c:forEach>
