<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "org">
    select * from organization_types where organization_type_id = ?

    <sql:param value = "${param.organization_type_id}"/>
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "1125" lang_id = "${lang}"/></h3>

<c:forEach var = "row" items = "${org.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_organization_type'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "Edit">
        <input type = "hidden"
               name = "organization_type_name_required"
               value = "<cf:GetPhrase phrase_id='1122' lang_id='${lang}'/>">
        <input type = "hidden" name = "organization_type_id"
               value = " <c:out value="${row.organization_type_id}" />"> <b>

        <cf:GetPhrase phrase_id = "1123" lang_id = "${lang}"/>:</b>

        <br>
        <c:out value = "${row.organization_type_id}"/>

        <br>
        <b>

        <cf:GetPhrase phrase_id = "1124" lang_id = "${lang}"/>:</b>

        <br>
        <input type = "text" name = "organization_type_name"
               value = " <c:out value="${row.organization_type_name}" />">

        <br>
        <br>
        <input type = "submit"
               value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
    </form>
</c:forEach>
