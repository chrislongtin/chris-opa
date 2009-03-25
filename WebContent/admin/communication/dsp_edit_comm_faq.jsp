<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "faq">
    select * from faq where faq_id = ?

    <sql:param value = "${param.faq_id}"/>
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "911" lang_id = "${lang}"/></h3>

<c:forEach var = "row" items = "${faq.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_comm_faq'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "Edit">
        <input type = "hidden" name = "faq_question_required"
        value = "<cf:GetPhrase phrase_id='483' lang_id='${lang}'/>"> <input type = "hidden" name = "faq_answer_required" value = "<cf:GetPhrase phrase_id='484' lang_id='${lang}'/>">
        <input type = "hidden" name = "faq_id"
        value = "<c:out value = '${row.faq_id}'/>"> <b>

        <cf:GetPhrase phrase_id = "176" lang_id = "${lang}"/>:</b>

        <br>
        <textarea name = "faq_question" cols = "40" rows = "3" wrap>
            <c:out value = '${row.faq_question}'/>
        </textarea>

        <p>
        <b>

        <cf:GetPhrase phrase_id = "177" lang_id = "${lang}"/>:</b>

        <br>
        <textarea name = "faq_answer" cols = "40" rows = "3" wrap>
            <c:out value = '${row.faq_answer}'/>
        </textarea>

        <p>
        <input type = "submit"
               value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
    </form>
</c:forEach>
