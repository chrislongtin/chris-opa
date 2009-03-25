<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "edit_msg">
    select discuss_subject, discuss_author, discuss_email, discuss_date,
    discuss_message, discussion_id from admin_discussion where discussion_id = ?

    <sql:param value = "${param.discussion_id}"/>
</sql:query>

<h4>

<cf:GetPhrase phrase_id = "495" lang_id = "${lang}"/></h4>

<c:forEach var = "row" items = "${edit_msg.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='admin_act_discuss_edit'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "discussion_id"
        value = "<c:out value='${row.discussion_id}'/>"> <input type = "hidden"
        name = "act" value = "edit"> <b>

        <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:</b>
        <input type = "text" name = "discuss_subject" size = "40"
               value = "<c:out value='${row.discuss_subject}'/>">

        <p>
        <b>

        <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/>:</b>
        <input type = "text"
               name = "discuss_date"
               value = "<fmt:formatDate pattern='dd-MMM-yy' value='${row.discuss_date}'/>">

        <p>
        <b>

        <cf:GetPhrase phrase_id = "43" lang_id = "${lang}"/>:</b>
        <input type = "text" name = "discuss_author"
        value = "<c:out value='${row.discuss_author}'/>"> <i>(

        <cf:GetPhrase phrase_id = "45" lang_id = "${lang}"/>)</i>

        <br>
        <b>

        <cf:GetPhrase phrase_id = "44" lang_id = "${lang}"/>:</b>
        <input type = "text" name = "discuss_email"
        value = "<c:out value='${row.discuss_email}'/>"> <i>(

        <cf:GetPhrase phrase_id = "45" lang_id = "${lang}"/>)</i>

        <p>
        <font color = "FF0000">* <b>

        <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:</b></font>

        <br>
        <textarea name = "discuss_message" cols = "60" rows = "15" wrap>
            <c:out value = '${row.discuss_message}'/>
        </textarea>

        <input type = "submit"
               value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
    </form>
</c:forEach>

<h3>

<cf:GetPhrase phrase_id = "496" lang_id = "${lang}"/></h3>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='admin_act_discuss_edit'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "discussion_id"
    value = "<c:out value='${param.discussion_id}'/>"> <input type = "hidden" name = "act" value = "delete">
    <input type = "submit"
    value = " <cf:GetPhrase phrase_id="143" lang_id="${lang}" /> ">
</form>
