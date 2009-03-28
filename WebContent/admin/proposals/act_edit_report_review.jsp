<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!-- Update report appraisal --->

<sql:update var = "review_chg">
    update report_appraisal set report_comments = ? where report_appraisal_id
    = ?

    <sql:param value = "${param.report_review}"/>

    <sql:param value = "${param.report_appraisal_id}"/>
</sql:update>

</c:if>

<c:import url = "proposals/dsp_proposal_main.jsp">
</c:import>
