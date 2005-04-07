<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "ts">
    select timesheets.*, timesheetstatus.ts_status, proponent_record.proposal_title from timesheets, timesheetstatus,
    proponent_record where timesheets.reviewer_id = ? and timesheets.status_id = timesheetstatus.status_id and
    timesheets.tracking_code = proponent_record.tracking_code order by timesheets.tracking_code, timesheets.start_date
    desc

    <sql:param value = "${sessionScope.rid}"/>
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "841" lang_id = "${lang}"/></h3>

<p>
<a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=tsr_create">&gt;&gt;

<cf:GetPhrase phrase_id = "842" lang_id = "${lang}"/></a>

<br>
<br>
<br></p>

<c:forEach var = "row" items = "${ts.rows}">
    <p>
    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=tsr_view&ts=<c:out value="${row.timesheet_id}" />">

    <c:out value = "${row.tracking_code}. ${row.proposal_title}"/>

    (

    <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.start_date}'/>

    -

    <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.end_date}'/>)</a> -

    <c:out value = "${row.ts_status}"/></p>
</c:forEach>
