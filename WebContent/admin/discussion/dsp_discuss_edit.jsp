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

<fmt:message key = "495" /></h4>

<c:forEach var = "row" items = "${edit_msg.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='admin_act_discuss_edit'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "discussion_id"
        value = "<c:out value='${row.discussion_id}'/>"> <input type = "hidden"
        name = "act" value = "edit"> <b>

        <fmt:message key = "42" />:</b>
        <input type = "text" name = "discuss_subject" size = "40"
               value = "<c:out value='${row.discuss_subject}'/>">

        <p>
        <b>

        <fmt:message key = "171" />:</b>
        <input type = "text"
               name = "discuss_date"
               value = "<fmt:formatDate pattern='dd-MMM-yy' value='${row.discuss_date}'/>">

        <p>
        <b>

        <fmt:message key = "43" />:</b>
        <input type = "text" name = "discuss_author"
        value = "<c:out value='${row.discuss_author}'/>"> <i>(

        <fmt:message key = "45" />)</i>

        <br>
        <b>

        <fmt:message key = "44" />:</b>
        <input type = "text" name = "discuss_email"
        value = "<c:out value='${row.discuss_email}'/>"> <i>(

        <fmt:message key = "45" />)</i>

        <p>
        <font color = "FF0000">* <b>

        <fmt:message key = "46" />:</b></font>

        <br>
        <textarea name = "discuss_message" cols = "60" rows = "15" wrap>
            <c:out value = '${row.discuss_message}'/>
        </textarea>

        <input type = "submit"
               value = " <fmt:message key="456"  /> ">
    </form>
</c:forEach>

<h3>

<fmt:message key = "496" /></h3>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='admin_act_discuss_edit'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "discussion_id"
    value = "<c:out value='${param.discussion_id}'/>"> <input type = "hidden" name = "act" value = "delete">
    <input type = "submit"
    value = " <fmt:message key="143"  /> ">
</form>
