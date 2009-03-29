<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "letter_info">
    select L.*, S.status_name from default_letters L, record_status S where
    L.letter_id = ? AND L.status_id = S.status_id

    <sql:param value = "${param.letter_id}"/>
</sql:query>

<sql:query var = "status">
    select * from record_status
</sql:query>

<h3>

<fmt:message key = "185" /></h3>

<c:forEach var = "row" items = "${letter_info.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_letters'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "edit">
        <input type = "hidden" name = "letter_id"
        value = "<c:out value='${row.letter_id}'/>">
        <input type = "hidden" name = "letter_subject_required"
        value = "<fmt:message key='481' />"> <input type = "hidden"
        name = "letter_body_required"
        value = "<fmt:message key='482' />">

        <fmt:message key = "42" />

        :

        <br>
        <input type = "text" name = "letter_subject" size = "40"
               value = "<c:out value='${row.letter_subject}'/>">

        <p>
        <fmt:message key = "167" />:

        <br>
        <textarea name = "letter_body" cols = "40" rows = "5" wrap>
            <c:out value = '${row.letter_body}'/>
        </textarea>

        <p>
        <fmt:message key = "58" />:

        <br>
        <select name = "status_id">
            <option value = "<c:out value='${row.status_id}'/>">
            <c:out value = '${row.status_name}'/>
</c:forEach>

<c:forEach var = "row" items = "${status.rows}">
    <option value = "<c:out value='${row.status_id}'/>">
    <c:out value = '${row.status_name}'/>
</c:forEach>

</select>

<p>
<input type = "submit"
       value = " <fmt:message key="456"  /> ">

</form>
