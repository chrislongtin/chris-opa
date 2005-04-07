<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- copy cfp criteria from one cfp to another --->

<c:set var = "dest_code" value = "${param.cfp_code}"/>

<sql:query var = "source_criteria">
    select * from cfp_criteria where cfp_code = ?

    <sql:param value = "${param.source_cfp_code}"/>
</sql:query>

<c:forEach var = "crit" items = "${source_criteria.rows}">
    <sql:query var = "criteria_num" maxRows = "1">
        select cfp_criteria_id from cfp_criteria order by cfp_criteria_id desc
    </sql:query>

    <c:forEach var = "row" items = "${criteria_num.rows}">
        <c:set var = "cfp_criteria_id2" value = "${row.cfp_criteria_id + 1}"/>
    </c:forEach>

    <sql:update var = "insert_criteria">
        insert into cfp_criteria ( cfp_criteria_id, cfp_code, cfp_criteria_name, cfp_criteria_weight, cfp_high_rank,
        cfp_low_rank ) values ( ?, ?, ?, ?, ?, ? )

        <sql:param value = "${cfp_criteria_id2}"/>

        <sql:param value = "${dest_code}"/>

        <sql:param value = "${crit.cfp_criteria_name}"/>

        <sql:param value = "${crit.cfp_criteria_weight}"/>

        <sql:param value = "${crit.cfp_high_rank}"/>

        <sql:param value = "${crit.cfp_low_rank}"/>
    </sql:update>
</c:forEach>

<c:import url = "cfp/dsp_cfp.jsp?fuseaction=show_cfp&cfp_code=${dest_code}&${user}"/>
