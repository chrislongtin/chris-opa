<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "title">
    select * from standardjobnames where seq_no = ?

    <sql:param value = "${param.seq_no}"/>
</sql:query>

<h3>

<fmt:message key = "1018" /></h3>

<c:forEach var = "row" items = "${title.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_titles'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "Edit">
        <input type = "hidden" name = "seq_no_required"
        value = "<fmt:message key='1014' />"> <input type = "hidden" name = "job_name_required" value = "<fmt:message key='1015' />">
        <b>

        <fmt:message key = "1016" />:</b>

        <br>
        <input type = "text" name = "seq_no"
               value = " <c:out value="${row.seq_no}" />">

        <br>
        <b>

        <fmt:message key = "1017" />:</b>

        <br>
        <input type = "text" name = "job_name"
               value = " <c:out value="${row.job_name}" />">

        <br>
        <input type = "submit"
               value = " <fmt:message key="456"  /> ">
    </form>
</c:forEach>
