<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "faq">
    select * from faq
</sql:query>

<h3>

<fmt:message key = "181" /></h3>

<c:choose>
    <c:when test = "${faq.rowCount == 0}">
        <fmt:message key = "108" />
    </c:when>

    <c:otherwise>
        <a STYLE = "text-decoration: underline" href = "#add">

        <fmt:message key = "175" /></a>
    </c:otherwise>
</c:choose>

<c:forEach var = "row" items = "${faq.rows}">
    <p>
    <b>Q:</b>

    <c:out value = '${row.faq_question}'/>

    <menu><b>A:</b>

    <c:out value = '${row.faq_answer}'/></menu>

    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_comm_faq'/>
<c:param name='faq_id' value='${row.faq_id}'/>
<c:param name='act' value='Delete'/>
<c:param name='${user}'/>
</c:url>">

    <fmt:message key = "143" /></a>
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='dsp_edit_comm_faq'/>
<c:param name='faq_id' value='${row.faq_id}'/>
<c:param name='act' value='Edit'/>
<c:param name='${user}'/>
</c:url>">

    <fmt:message key = "144" /></a>
</c:forEach>

<a name = "add"> <h4>

<fmt:message key = "175" />:</h4>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_comm_faq'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "act" value = "Add">
    <input type = "hidden" name = "faq_question_required"
    value = "<fmt:message key='483' />"> <input type = "hidden"
    name = "faq_answer_required"
    value = "<fmt:message key='484' />"> <b>

    <fmt:message key = "176" />:</b>

    <br>
    <textarea name = "faq_question" cols = "40" rows = "3" wrap>
    </textarea>

    <p>
    <b>

    <fmt:message key = "177" />:</b>

    <br>
    <textarea name = "faq_answer" cols = "40" rows = "3" wrap>
    </textarea>

    <p>
    <input type = "submit"
           value = " <fmt:message key="456"  /> ">
</form>
