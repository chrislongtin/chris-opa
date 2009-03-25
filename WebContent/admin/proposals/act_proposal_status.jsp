<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check.jsp"%>

<!--- change proposal status --->

<c:set var = "status_id">
    <c:out value = "${param.status_id}" default = ""/>
</c:set>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "awarded_amount">
    <c:out value = "${param.awarded_amount}" default = ""/>
</c:set>

<c:set var = "proposal_hide">
    <c:out value = "${param.proposal_hide}" default = "0"/>
</c:set>

<c:set var = "redirect">
    <c:out value = "${param.redirect}" default = "info"/>
</c:set>

<sql:update>
    update proponent_record set status_id = ?, proposal_hide = ?

    <c:if test = "${!empty awarded_amount}">
        , awarded_amount = ?
    </c:if>

    where tracking_code = ?

    <sql:param value = "${status_id}"/>

    <sql:param value = "${proposal_hide}"/>

    <c:if test = "${!empty awarded_amount}">
        <sql:param value = "${awarded_amount}"/>
    </c:if>

    <sql:param value = "${tracking_code}"/>
</sql:update>

<c:choose>
    <c:when test = "${redirect=='info'}">
        <c:set var = "u"
               value = "proposals/dsp_proposal_info.jsp?tracking_code=${tracking_code}"
               scope = "page"/>

        <c:import url = "${u}"/>
    </c:when>

    <c:otherwise>
        <c:if test = "${redirect=='summary'}">
            <c:set var = "u"
                   value = "proposals/dsp_proposal_summary.jsp?tracking_code=${tracking_code}"
                   scope = "page"/>

            <c:import url = "${u}"/>
        </c:if>
    </c:otherwise>
</c:choose>
