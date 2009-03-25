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
    <c:when test = "${param.act == 'add'}">

        <!--- add new CFP Criteria --->

        <sql:query var = "criteria_id" maxRows = "1">
            select cfp_criteria_id from cfp_criteria order by cfp_criteria_id
            desc
        </sql:query>

        <!--- set the CFP_Criteria_id variable to the next highest value --->

        <c:choose>
            <c:when test = "${criteria_id.rowCount != 0}">
                <c:forEach var = "row" items = "${criteria_id.rows}">
                    <c:set var = "cfp_criteria_id"
                           value = "${row.cfp_criteria_id + 1}"/>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <c:set var = "cfp_criteria_id" value = "1"/>
            </c:otherwise>
        </c:choose>

        <sql:update var = "new_cfp_criteria">
            insert into cfp_criteria ( cfp_criteria_id, cfp_code,
            cfp_criteria_name, cfp_criteria_weight, cfp_high_rank,
            cfp_low_rank ) values ( ?, ?, ?, ?, ?, ? )

            <sql:param value = "${cfp_criteria_id}"/>

            <sql:param value = "${param.cfp_code}"/>

            <sql:param value = "${param.cfp_criteria_name}"/>

            <sql:param value = "${param.cfp_criteria_weight}"/>

            <sql:param value = "${param.cfp_high_rank}"/>

            <sql:param value = "${param.cfp_low_rank}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'edit'}">
        <sql:update var = "edit_cfp_criteria">
            update cfp_criteria set cfp_criteria_name = ?, cfp_criteria_weight
            = ?, cfp_high_rank = ?, cfp_low_rank = ? where cfp_criteria_id = ?

            <sql:param value = "${param.cfp_criteria_name}"/>

            <sql:param value = "${param.cfp_criteria_weight}"/>

            <sql:param value = "${param.cfp_high_rank}"/>

            <sql:param value = "${param.cfp_low_rank}"/>

            <sql:param value = "${param.cfp_criteria_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'delete'}">

        <!--- remove cfp criteria --->

        <sql:update var = "delete_criteria">
            delete from cfp_criteria where cfp_criteria_id = ?

            <sql:param value = "${param.cfp_criteria_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "cfp/dsp_cfp.jsp?fuseaction=show_cfp&cfp_code=${param.cfp_code}&${user}"/>
