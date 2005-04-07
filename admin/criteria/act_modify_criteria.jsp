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

<!--- process criteria modifications --->

<c:choose>
    <c:when test = "${param.act == 'add'}">
        <c:out value = "${i_criteria_weight}"/>

        <sql:query var = "criteria_num" maxRows = "1">
            select i_criteria_id from initiative_criteria order by i_criteria_id desc
        </sql:query>

        <c:choose>
            <c:when test = "${criteria_num.rowCount != 0}">
                <c:forEach var = "row" items = "${criteria_num.rows}">
                    <c:set var = "i_criteria_id" value = "${row.i_criteria_id + 1}"/>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <c:set var = "i_criteria_id" value = "1"/>
            </c:otherwise>
        </c:choose>

        <sql:update var = "add_criteria">
            insert into initiative_criteria ( i_criteria_id, i_criteria_name, i_criteria_weight, i_low_rank,
            i_high_rank ) values ( ?, ?, ?, ?, ? )

            <sql:param value = "${i_criteria_id}"/>

            <sql:param value = "${param.i_criteria_name}"/>

            <sql:param value = "${param.i_criteria_weight}"/>

            <sql:param value = "${param.i_low_rank}"/>

            <sql:param value = "${param.i_high_rank}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'edit'}">
        <sql:update var = "update_criteria">
            update initiative_criteria set i_criteria_name = ?, i_criteria_weight = ?, i_low_rank = ?, i_high_rank = ?
            where i_criteria_id = ?

            <sql:param value = "${param.i_criteria_name}"/>

            <sql:param value = "${param.i_criteria_weight}"/>

            <sql:param value = "${param.i_low_rank}"/>

            <sql:param value = "${param.i_high_rank}"/>

            <sql:param value = "${param.i_criteria_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'del_criteria'}">
        <sql:update var = "criteria_delete">
            delete from initiative_criteria where i_criteria_id = ?

            <sql:param value = "${param.i_criteria_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "criteria/dsp_criteria.jsp?fuseaction=criteria&${user}"/>
