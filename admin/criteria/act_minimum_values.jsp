<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<%@ include file = "../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<!--- Modify or Add Funding Initiative Information --->

<sql:update var = "add_funding_initative">
    update initiative_setup set minimum_score = ?

    <sql:param value = "${param.minimum_score}"/>
</sql:update>

<!--- redirect to main funding information page --->

<c:import url = "criteria/dsp_criteria.jsp?fuseaction=criteria&${user}"/>
