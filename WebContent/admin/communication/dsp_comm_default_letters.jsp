<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "letter_info">
    select L.letter_id, L.letter_subject, S.status_name from default_letters
    L, record_status S where L.status_id = S.status_id
</sql:query>

<sql:query var = "status">
    select * from record_status
</sql:query>

<h3>

<fmt:message key = "164" /></h3>

<c:if test = "${letter_info.rowCount != 0}">
    <fmt:message key = "165" />
</c:if>

<c:forEach var = "row" items = "${letter_info.rows}">
    <p>
    <fmt:message key = "42" />:
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_default_letter_body'/>
<c:param name='letter_id' value='${row.letter_id}'/>
<c:param name='${user}'/>
</c:url>">

    <c:out value = '${row.letter_subject}'/></a>

    <br>
    <fmt:message key = "58" />:

    <c:out value = '${row.status_name}'/>

    <br>
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_letters'/>
<c:param name='act' value='delete'/>
<c:param name='letter_id' value='${row.letter_id}'/>
<c:param name='${user}'/>
</c:url>">

    <fmt:message key = "143" /></a> |
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='edit_letter'/>
<c:param name='letter_id' value='${row.letter_id}'/>
<c:param name='${user}'/>
</c:url>">

    <fmt:message key = "144" /></a>
</c:forEach>

<h3>

<fmt:message key = "166" /></h3>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_letters'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "act" value = "add">
    <input type = "hidden" name = "letter_subject_required"
    value = "<fmt:message key='481' />"> <input type = "hidden"
    name = "letter_body_required"
    value = "<fmt:message key='482' />">

    <fmt:message key = "42" />

    :

    <br>
    <input type = "text" name = "letter_subject" size = "40">

    <p>
    <fmt:message key = "167" />:

    <br>
    <textarea name = "letter_body" cols = "40" rows = "5" wrap>
    </textarea>

    <p>
    <fmt:message key = "58" />:

    <br>
    <select name = "status_id">
        <c:forEach var = "row" items = "${status.rows}">
            <option value = "<c:out value='${row.status_id}'/>">
            <c:out value = '${row.status_name}'/>

            (

            <c:out value = '${row.status_id}'/>

            )
        </c:forEach>
    </select>

    <p>
    <input type = "submit"
           value = "<fmt:message key="166"  />">
</form>
