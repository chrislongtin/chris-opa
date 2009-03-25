<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "faq">
    select * from faq
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "181" lang_id = "${lang}"/></h3>

<c:choose>
    <c:when test = "${faq.rowCount == 0}">
        <cf:GetPhrase phrase_id = "108" lang_id = "${lang}"/>
    </c:when>

    <c:otherwise>
        <a STYLE = "text-decoration: underline" href = "#add">

        <cf:GetPhrase phrase_id = "175" lang_id = "${lang}"/></a>
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

    <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a>
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='dsp_edit_comm_faq'/>
<c:param name='faq_id' value='${row.faq_id}'/>
<c:param name='act' value='Edit'/>
<c:param name='${user}'/>
</c:url>">

    <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
</c:forEach>

<a name = "add"> <h4>

<cf:GetPhrase phrase_id = "175" lang_id = "${lang}"/>:</h4>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_comm_faq'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "act" value = "Add">
    <input type = "hidden" name = "faq_question_required"
    value = "<cf:GetPhrase phrase_id='483' lang_id='${lang}'/>"> <input type = "hidden"
    name = "faq_answer_required"
    value = "<cf:GetPhrase phrase_id='484' lang_id='${lang}'/>"> <b>

    <cf:GetPhrase phrase_id = "176" lang_id = "${lang}"/>:</b>

    <br>
    <textarea name = "faq_question" cols = "40" rows = "3" wrap>
    </textarea>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "177" lang_id = "${lang}"/>:</b>

    <br>
    <textarea name = "faq_answer" cols = "40" rows = "3" wrap>
    </textarea>

    <p>
    <input type = "submit"
           value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
