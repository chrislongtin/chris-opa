<%@ page errorPage = "dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- initiative website information setup --->

<h3>

<fmt:message key = "1126" /></h3> <h4>

<fmt:message key = "1046" /></h4>

<!--- display selection --->

<sql:query var = "chapters">
    select distinct C.chapter_id,C.chapter_name from chapters C,
    organization_types I, languages N where C.chapter_id != ? and C.chapter_id
    = I.chapter_id order by C.chapter_id

    <sql:param value = "${sessionScope.chapter}"/>
</sql:query>

<p>
<form action = "<c:url value='index.jsp'>
        <c:param name='fuseaction' value='act_copy_organization_types'/>
        </c:url>"
      method = "post">
    <p>
    <b>

    <fmt:message key = "1043" /></b>

    <br>
    <select name = "source_chapter_id" size = "1">
        <c:forEach items = "${chapters.rows}" var = "rowa">
            <option value = "<c:out value="${rowa.chapter_id}" />">
            <c:out value = "${rowa.chapter_name}"/>
        </c:forEach>
    </select>

    <p>
    <input type = "submit"
           value = " <fmt:message key="456"  /> ">
</form>
