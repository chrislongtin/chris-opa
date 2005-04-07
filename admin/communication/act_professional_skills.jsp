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

<c:choose>
    <c:when test = "${param.act == 'Add'}">
        <sql:query var = "skill_num" maxRows = "1">
            select skill_id from professional_skills order by skill_id desc
        </sql:query>

        <c:set var = "skill_id" value = "${skill_num.rows[0].skill_id + 1}"/>

        <sql:update var = "skill_add">
            insert into professional_skills (skill_id, skill_name, industry_id) values ( ?, ?, ? )

            <sql:param value = "${skill_id}"/>

            <sql:param value = "${param.skill_name}"/>

            <sql:param value = "${param.industry_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Delete'}">
        <sql:update var = "skill_delete">
            delete from professional_skills where skill_id = ?

            <sql:param value = "${param.skill_id}"/>
        </sql:update>

        <sql:update var = "contractor_skill_delete">
            delete from contractor_skills where skill_id = ?

            <sql:param value = "${param.skill_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Edit'}">
        <sql:update var = "skill_add2">
            update professional_skills set skill_id = ?, skill_name = ?, industry_id = ? where skill_id = ?

            <sql:param value = "${param.skill_id}"/>

            <sql:param value = "${param.skill_name}"/>

            <sql:param value = "${param.industry_id}"/>

            <sql:param value = "${param.skill_id}"/>
        </sql:update>

        <sql:update var = "skill_add3">
            update contractor_skills set skill_id = ? where skill_id = ?

            <sql:param value = "${param.skill_id}"/>

            <sql:param value = "${param.skill_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "communication/dsp_professional_skills.jsp?fuseaction=skills&${user}"/>
