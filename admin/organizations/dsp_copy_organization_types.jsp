<%@ page errorPage = "dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- initiative website information setup --->

<h3>

<cf:GetPhrase phrase_id = "1126" lang_id = "${lang}"/></h3> <h4>

<cf:GetPhrase phrase_id = "1046" lang_id = "${lang}"/></h4>

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

    <cf:GetPhrase phrase_id = "1043" lang_id = "${lang}"/></b>

    <br>
    <select name = "source_chapter_id" size = "1">
        <c:forEach items = "${chapters.rows}" var = "rowa">
            <option value = "<c:out value="${rowa.chapter_id}" />">
            <c:out value = "${rowa.chapter_name}"/>
        </c:forEach>
    </select>

    <p>
    <input type = "submit"
           value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
