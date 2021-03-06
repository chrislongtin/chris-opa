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

<!--- list of reviewers who are associated with the cfp & category of the proposal --->
<sql:query var = "reviewers">
    select reviewer_lastname, reviewer_firstname, reviewer_id from reviewers
    where (cfp_code = ? or cfp_code = 0) and (cfp_cat_id = ? or cfp_cat_id =
    0) order by reviewer_lastname, reviewer_firstname

    <sql:param value = "${cfp_code}"/>

    <sql:param value = "${cfp_cat_id}"/>
</sql:query>

<!--- list of reviewers who have already been assigned to review the proposal --->
<sql:query var = "reviewer_info">
    select r.reviewer_lastname, r.reviewer_firstname, r.reviewer_id,
    ra.assignment_id, ra.proposal_review_completed from reviewer_assignment
    ra, reviewers r where ra.tracking_code = ? and ra.reviewer_id =
    r.reviewer_id and proposal = 1

    <sql:param value = "${tracking_code}"/>
</sql:query>

<sql:query var = "proposal_name">
    select proposal_title from proponent_record where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<h3>

<c:out value = "${proposal_name.rows[0].proposal_title}"/>

:

<fmt:message key = "250" /></h3> <b>

<fmt:message key = "56" />:</b> CFP-

<c:out value = "${cfp_code}"/>

<br>
<b>

<fmt:message key = "57" />:</b> P-

<c:out value = "${tracking_code}"/><c:choose>
    <c:when test = "${reviewer_info.rowCount==0}">
        <p>
        <fmt:message key = "251" />
    </c:when>

    <c:otherwise>
        <p>
        <b>

        <fmt:message key = "252" />:</b>
        <c:forEach items = "${reviewer_info.rows}" var = "row">
            <p>
            <c:out value = "${row.reviewer_lastname}, ${row.reviewer_firstname}"/><c:if test = "${row.proposal_review_completed!=1}">
                <br>
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=act_proposal_reviewer_delete&assignment_id=<c:out value="${row.assignment_id}" />&tracking_code=<c:out value="${tracking_code}" />&cfp_code=<c:out value="${cfp_code}" />&cfp_cat_id=<c:out value="${cfp_cat_id}" />">

                <fmt:message key = "253" /></a>
            </c:if>
        </c:forEach>
    </c:otherwise>
</c:choose>

<p>
<hr size = "1">
<b>

<fmt:message key = "254" />:</b>

<p>
<fmt:message key = "255" />: <i>(

<fmt:message key = "256" />)</i>

<p>
<fmt:message key = "600" />

<form action = "index.jsp?fuseaction=act_proposal_assign" method = "post">
    <input type = "hidden" name = "cfp_code"
    value = "<c:out value="${cfp_code}" />">
    <input type = "hidden" name = "cfp_cat_id"
    value = "<c:out value="${cfp_cat_id}" />">
    <input type = "hidden" name = "tracking_code"
    value = "<c:out value="${tracking_code}" />">
    <input type = "hidden" name = "reviewer_id_required"
    value = "<fmt:message key="601"  />"> <input type = "checkbox"
    name = "proposal_assigned" value = "P" checked>

    <fmt:message key = "122" />
    <input type = "checkbox" name = "report_assigned" value = "R" checked>

    <fmt:message key = "311" />

    <br>
    <select name = "reviewer_id" size = "3" multiple = "yes">
        <c:forEach items = "${reviewers.rows}" var = "row">
            <option value = "<c:out value="${row.reviewer_id}" />">
            <c:out value = "${row.reviewer_lastname}, ${row.reviewer_firstname}"/>
        </c:forEach>
    </select>

    <input type = "submit"
           value = " <fmt:message key="599"  /> ">
</form>
