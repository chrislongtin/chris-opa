<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "skills">
    select * from professional_skills order by skill_name asc
</sql:query>

<sql:query var = "last_skill">
    select max(skill_id)+1 as next_skill_id from professional_skills
</sql:query>

<c:set var = "next_id" value = "${last_skill.rows[0].next_skill_id}"/>

<h3>

<fmt:message key = "1002" /></h3>

<c:choose>
    <c:when test = "${skills.rowCount == 0}">
        <fmt:message key = "1003" />
    </c:when>

    <c:otherwise>
        <a STYLE = "text-decoration: underline" href = "#add">

        <fmt:message key = "1004" /></a>
    </c:otherwise>
</c:choose>

<p>
<table>
    <c:forEach var = "row" items = "${skills.rows}">
        <tr>
            <td valign = "top">
                <c:out value = '${row.skill_id}'/>
            </td>

            <td valign = "top">
                <c:out value = '${row.skill_name}'/>
            </td>

            <td valign = "top">
                <a STYLE = "text-decoration: underline"
                   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_skills'/>
<c:param name='skill_id' value='${row.skill_id}'/>
<c:param name='act' value='Delete'/>
<c:param name='${user}'/>
</c:url>">

                <fmt:message key = "143" /></a>
                <a STYLE = "text-decoration: underline"
                   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='dsp_edit_skills'/>
<c:param name='skill_id' value='${row.skill_id}'/>
<c:param name='act' value='Edit'/>
<c:param name='${user}'/>
</c:url>">

                <fmt:message key = "144" /></a>
            </td>
        </tr>
    </c:forEach>
</table>

<a name = "add"> <h4>

<fmt:message key = "1004" />:</h4>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_skills'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "act" value = "Add">
    <input type = "hidden" name = "skill_id_required"
    value = "<fmt:message key='1005' />"> <input type = "hidden"
    name = "skill_name_required"
    value = "<fmt:message key='1006' />"> <input type = "hidden"
    name = "industry_id" value = "0"> <b>

    <fmt:message key = "1007" />:</b>

    <br>
    <input type = "text" name = "skill_id" length = "4"
           value = " <c:out value="${next_id}" />">

    <p>
    <b>

    <fmt:message key = "1008" />:</b>

    <br>
    <input type = "text" name = "skill_name" length = "30">

    <p>
    <input type = "submit"
           value = " <fmt:message key="456"  /> ">
</form>
