<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "skill">
    select * from professional_skills where skill_id = ?

    <sql:param value = "${param.skill_id}"/>
</sql:query>

<h3>

<fmt:message key = "1009" /></h3>

<c:forEach var = "row" items = "${skill.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_skills'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "Edit">
        <input type = "hidden" name = "skill_id_required"
        value = "<fmt:message key='1005' />"> <input type = "hidden" name = "skill_name_required" value = "<fmt:message key='1006' />">
        <input type = "hidden" name = "industry_id"
        value = " <c:out value="${row.industry_id}" />"> <b>

        <fmt:message key = "1007" />:</b>

        <br>
        <input type = "text" name = "skill_id"
               value = " <c:out value="${row.skill_id}" />">

        <br>
        <b>

        <fmt:message key = "1008" />:</b>

        <br>
        <input type = "text" name = "skill_name"
               value = " <c:out value="${row.skill_name}" />">

        <br>
        <input type = "submit"
               value = " <fmt:message key="456"  /> ">
    </form>
</c:forEach>
