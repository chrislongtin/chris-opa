<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*,com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!-- Get new report appraisal id --->

<sql:query var = "report_appraisal" maxRows = "1">
    select report_appraisal_id from report_appraisal
</sql:query>

<c:set var = "report_appraisal_id">
    <c:out value = "${report_appraisal_id}" default = "1"/>
</c:set>

<c:forEach var = "row" items = "${report_appraisal.rows}">
    <c:set var = "report_appraisal_id"
           value = "${row.report_appraisal_id + 1}"/>
</c:forEach>

<!-- Add report appraisal/review--->

<sql:update var = "review_add">
    insert into report_appraisal (report_appraisal_id,
    reviewer_id,tracking_code,doc_id,report_comments) values ( ?, ?, ?, ?, ? )

    <sql:param value = "${report_appraisal_id}"/>

    <sql:param value = "${rid}"/>

    <sql:param value = "${param.tracking_code}"/>

    <sql:param value = "${param.doc_id}"/>

    <sql:param value = "${param.report_review}"/>
</sql:update>

<!-- update reviewer assignment --->

<sql:update var = "reviewer_assignment">
    update reviewer_assignment set report_review_completed = 1 where
    reviewer_id = ? and tracking_code = ?

    <sql:param value = "${rid}"/>

    <sql:param value = "${param.tracking_code}"/>
</sql:update>

<c:import url = "proposals/dsp_proposal_main.jsp">
</c:import>
