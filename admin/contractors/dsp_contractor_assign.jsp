<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = ""/>
</c:set>

<c:set var = "cfp_cat_id">
    <c:out value = "${param.cfp_cat_id}" default = ""/>
</c:set>

<!--- list of contractors who are associated with the cfp & category of the proposal --->
<sql:query var = "contractors">
    select contractor_lastname, contractor_firstname, contractor_id from contractors where (cfp_code = ? or cfp_code =
    0) and (cfp_cat_id = ? or cfp_cat_id = 0) order by contractor_lastname, contractor_firstname

    <sql:param value = "${cfp_code}"/>

    <sql:param value = "${cfp_cat_id}"/>
</sql:query>

<!--- list of contractors who have already been assigned to the proposal/project --->
<sql:query var = "contractor_info">
    select c.contractor_lastname, c.contractor_firstname, c.contractor_id, ca.assignment_id, ca.end_date from
    contractor_assignment ca, contractors c where ca.tracking_code = ? and ca.contractor_id = c.contractor_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<sql:query var = "proposal_name">
    select proposal_title from proponent_record where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<h3>

<c:out value = "${proposal_name.rows[0].proposal_title}"/>

:

<cf:GetPhrase phrase_id = "961" lang_id = "${lang}"/></h3> <b>

<cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/>:</b> CFP-

<c:out value = "${cfp_code}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:</b> P-

<c:out value = "${tracking_code}"/><c:choose>
    <c:when test = "${contractor_info.rowCount==0}">
        <p>
        <cf:GetPhrase phrase_id = "962" lang_id = "${lang}"/>
    </c:when>

    <c:otherwise>
        <p>
        <b>

        <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/>:</b>
        <c:forEach items = "${contractor_info.rows}" var = "row">
            <p>
            <c:out value = "${row.contractor_lastname}, ${row.contractor_firstname}"/>
            <c:if test = "${empty row.end_date}">
                <br>
                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=act_proposal_contractor_delete&assignment_id=<c:out value="${row.assignment_id}" />&tracking_code=<c:out value="${tracking_code}" />&cfp_code=<c:out value="${cfp_code}" />&cfp_cat_id=<c:out value="${cfp_cat_id}" />">

                <cf:GetPhrase phrase_id = "253" lang_id = "${lang}"/></a>
            </c:if>
        </c:forEach>
    </c:otherwise>
</c:choose>

<p>
<hr size = "1">
<b>

<cf:GetPhrase phrase_id = "968" lang_id = "${lang}"/>:</b>

<p>
<cf:GetPhrase phrase_id = "963" lang_id = "${lang}"/>: <i>(

<cf:GetPhrase phrase_id = "964" lang_id = "${lang}"/>)</i>

<p>
<cf:GetPhrase phrase_id = "966" lang_id = "${lang}"/>

<form action = "index.jsp?fuseaction=act_contractor_assign" method = "post">
    <input type = "hidden" name = "cfp_code" value = "<c:out value="${cfp_code}" />">
    <input type = "hidden" name = "cfp_cat_id" value = "<c:out value="${cfp_cat_id}" />">
    <input type = "hidden" name = "tracking_code" value = "<c:out value="${tracking_code}" />">
    <input type = "hidden" name = "contractor_id_required" value = "<cf:GetPhrase phrase_id="967" lang_id="${lang}" />">

    <br>
    <select name = "contractor_id" size = "3" multiple = "yes">
        <c:forEach items = "${contractors.rows}" var = "row">
            <option value = "<c:out value="${row.contractor_id}" />">
            <c:out value = "${row.contractor_lastname}, ${row.contractor_firstname}"/>
        </c:forEach>
    </select>

    <input type = "submit" value = " <cf:GetPhrase phrase_id="599" lang_id="${lang}" /> ">
</form>
