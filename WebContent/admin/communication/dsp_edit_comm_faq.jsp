<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "faq">
    select * from faq where faq_id = ?

    <sql:param value = "${param.faq_id}"/>
</sql:query>

<h3>

<fmt:message key = "911" /></h3>

<c:forEach var = "row" items = "${faq.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_comm_faq'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "Edit">
        <input type = "hidden" name = "faq_question_required"
        value = "<fmt:message key='483' />"> <input type = "hidden" name = "faq_answer_required" value = "<fmt:message key='484' />">
        <input type = "hidden" name = "faq_id"
        value = "<c:out value = '${row.faq_id}'/>"> <b>

        <fmt:message key = "176" />:</b>

        <br>
        <textarea name = "faq_question" cols = "40" rows = "3" wrap>
            <c:out value = '${row.faq_question}'/>
        </textarea>

        <p>
        <b>

        <fmt:message key = "177" />:</b>

        <br>
        <textarea name = "faq_answer" cols = "40" rows = "3" wrap>
            <c:out value = '${row.faq_answer}'/>
        </textarea>

        <p>
        <input type = "submit"
               value = " <fmt:message key="456"  /> ">
    </form>
</c:forEach>
