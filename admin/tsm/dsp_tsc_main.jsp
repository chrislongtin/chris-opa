<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "tc">
    <c:out value = "${param.tracking_code}" default = "0"/>
</c:set>

<c:set var = "show_app">
    <c:out value = "${param.show_app}" default = "no"/>
</c:set>

<c:if test = "${(sessionScope.user == 'coordinator') || (sessionScope.rcoord == 1)}">
    <sql:query var = "ts">
        select timesheets.*, timesheetstatus.ts_status, proponent_record.proposal_title, reviewers.reviewer_lastname,
        reviewers.reviewer_firstname from timesheets, timesheetstatus, proponent_record, reviewers where
        timesheets.tracking_code = ? and timesheets.status_id = timesheetstatus.status_id and timesheets.tracking_code
        = proponent_record.tracking_code and timesheets.reviewer_id = reviewers.reviewer_id and ( timesheets.status_id
        = 2 or timesheets.status_id = 3 ) order by timesheets.start_date, reviewers.reviewer_id desc

        <sql:param value = "${tc}"/>
    </sql:query>

    <h3>

    <cf:GetPhrase phrase_id = "841" lang_id = "${lang}"/></h3>

    <c:choose>
        <c:when test = "${ts.rowCount > 0}">
            <h4>

            <c:out value = "${ts.rows[0].tracking_code}. ${ts.rows[0].proposal_title}"/></h4>

            <c:choose>
                <c:when test = "${show_app == 'no'}">
                    <p>
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=tsc_main&tracking_code=<c:out value="${tc}&show_app=yes" />">>>

                    <cf:GetPhrase phrase_id = "854" lang_id = "${lang}"/></a></p>
                </c:when>

                <c:otherwise>
                    <p>
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=tsc_main&tracking_code=<c:out value="${tc}&show_app=no" />">>>

                    <cf:GetPhrase phrase_id = "855" lang_id = "${lang}"/></a></p>
                </c:otherwise>
            </c:choose>

            <c:forEach var = "row" items = "${ts.rows}">
                <c:choose>
                    <c:when test = "${show_app == 'yes'}">
                        <p>
                        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=tsc_view&ts=<c:out value="${row.timesheet_id}" />">

                        <c:out value = "${row.reviewer_firstname} ${row.reviewer_lastname}"/>

                        (

                        <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.start_date}'/>

                        -

                        <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.end_date}'/>)</a> -

                        <c:out value = "${row.ts_status}"/></p>
                    </c:when>

                    <c:otherwise>
                        <c:if test = "${row.status_id == 2}">
                            <p>
                            <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=tsc_view&ts=<c:out value="${row.timesheet_id}" />">

                            <c:out value = "${row.reviewer_firstname} ${row.reviewer_lastname}"/>

                            (

                            <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.start_date}'/>

                            -

                            <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.end_date}'/>)</a> -

                            <c:out value = "${row.ts_status}"/></p>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <cf:GetPhrase phrase_id = "876" lang_id = "${lang}"/>
        </c:otherwise>
    </c:choose>
</c:if>
