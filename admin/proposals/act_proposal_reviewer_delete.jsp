<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

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

<c:set var = "assignment_id">
    <c:out value = "${param.assignment_id}" default = "yes"/>
</c:set>

<c:set var = "reviewer_id">
    <c:out value = "${param.reviewer_id}" default = ""/>
</c:set>

<sql:update>
    delete from reviewer_assignment where assignment_id = ?

    <sql:param value = "${assignment_id}"/>
</sql:update>

<!--- check if any reviewers are still assigned to this proposal --->
<sql:query var = "status_check">
    select assignment_id from reviewer_assignment where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<!--- if no reviewers are assigned, change proposal status from under review to pending review --->
<c:if test = "${status_check.rowCount==0}">
    <sql:update>
        update proponent_record set status_id = 1 where tracking_code = ?

        <sql:param value = "${tracking_code}"/>
    </sql:update>
</c:if>

<c:import url = "proposals/dsp_proposal_assign.jsp">
    <c:param name = "tracking_code" value = "${tracking_code}"/>

    <c:param name = "cfp_code" value = "${cfp_code}"/>

    <c:param name = "cfp_cat_id" value = "${cfp_cat_id}"/>
</c:import>
