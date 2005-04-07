<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<c:set var = "cfp_cat_name">
    <c:out value = "${param.cfp_cat_name}" default = ""/>
</c:set>

<!--- use this page to display the option to add or edit CFP Categories --->

<c:choose>
    <c:when test = "${act == 'edit'}">
        <sql:query var = "edit_cfp_cat">
            select * from cfp_category where cfp_cat_id = ?

            <sql:param value = "${param.cfp_cat_id}"/>
        </sql:query>

        <c:forEach var = "row" items = "${edit_cfp_cat.rows}">
            <c:set var = "cfp_cat_name" value = "${row.cfp_cat_name}"/>
        </c:forEach>

        <h3>

        <cf:GetPhrase phrase_id = "454" lang_id = "${lang}"/></h3>
    </c:when>

    <c:otherwise>
        <h3>

        <cf:GetPhrase phrase_id = "455" lang_id = "${lang}"/></h3>
    </c:otherwise>
</c:choose>

<form action = "index.jsp?fuseaction=act_cfp_cat" method = "post">
    <input type = "hidden" name = "cfp_code" value = "<c:out value='${param.cfp_code}'/>">
    <c:if test = "${act == 'edit'}">
        <input type = "hidden" name = "cfp_cat_id" value = "<c:out value='${param.cfp_cat_id}'/>">
    </c:if>

    <input type = "hidden" name = "act" value = "<c:out value='${act}'/>">

    <cf:GetPhrase phrase_id = "457" lang_id = "${lang}"/>:
    <input type = "text" name = "cfp_cat_name" value = "<c:out value='${cfp_cat_name}'/>" size = "50">

    <br>
    <input type = "submit" value = "   <cf:GetPhrase phrase_id="456" lang_id="${lang}" />   ">
</form>
