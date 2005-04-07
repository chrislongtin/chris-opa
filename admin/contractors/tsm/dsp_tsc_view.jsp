<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../../act_session_check_sub.jsp"%>

<c:set var = "ts_id">
    <c:out value = "${param.ts}" default = "0"/>
</c:set>

<c:if test = "${(sessionScope.user == 'coordinator') || (sessionScope.rcoord == 1)}">
    <sql:query var = "ts">
        select contractor_timesheets.*, timesheetstatus.ts_status, proponent_record.proposal_title,
        contractors.contractor_lastname, contractors.contractor_firstname from contractor_timesheets, timesheetstatus,
        proponent_record, contractors where contractor_timesheets.timesheet_id = ? and contractor_timesheets.status_id
        = timesheetstatus.status_id and contractor_timesheets.tracking_code = proponent_record.tracking_code and
        contractor_timesheets.contractor_id = contractors.contractor_id and ( contractor_timesheets.status_id = 2 or
        contractor_timesheets.status_id = 3 )

        <sql:param value = "${ts_id}"/>
    </sql:query>

    <c:if test = "${ts.rowCount == 1}">
        <c:set var = "ts" value = "${ts.rows[0]}"/>

        <sql:query var = "tr">
            select * from contractor_timerecords where timesheet_id = ? order by activity_date desc

            <sql:param value = "${ts_id}"/>
        </sql:query>

        <c:set var = "hs" value = "0"/>

        <c:set var = "ha" value = "0"/>

        <h3>

        <c:out value = "${ts.tracking_code}. ${ts.proposal_title}"/></h3> <h4>

        <c:out value = "${ts.contractor_firstname} ${ts.contractor_lastname}"/>

        (

        <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.start_date}'/>

        -

        <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.end_date}'/>

        ) -

        <c:out value = "${ts.ts_status}"/></h4>

        <c:if test = "${(ts.status_id == 2) && (sessionScope.user == 'coordinator')}">
            <form name = "app_form" method = "post" action = "index.jsp?fuseaction=c_tsc_update">
                <input type = "hidden" name = "act" value = "approve_ts">
                <input type = "hidden" name = "ts" value = "<c:out value="${ts_id}" />">
                <input type = "submit" name = "submit_ts" value = "<cf:GetPhrase phrase_id="856" lang_id="${lang}" />">
            </form>
        </c:if>

        <table width = "100%" border = "0" cellspacing = "7" cellpadding = "0">
            <c:forEach var = "row" items = "${tr.rows}">
                <tr>
                    <td colspan = "2">
                        <hr size = "1" noshade color = "#CCCCCC">
                    </td>
                </tr>

                <tr>
                    <td>
                        <font face = "Arial" size = "-1">

                        <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/>

                        :

                        <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.activity_date}'/>

                        <br>
                        <cf:GetPhrase phrase_id = "850" lang_id = "${lang}"/>:

                        <c:out value = "${row.hours_spent}"/>

                        <br>
                        <br>
                        <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:

                        <cf:ParagraphFormat value = "${row.comments}"/></font><font face = "Arial, Helvetica, sans-serif"
                                                                                    size = "-1"></font>
                    </td>

                    <td bgcolor = "#EEEEEE"                   align = "center" valign = "middle""> <font
                        face = "Arial, Helvetica, sans-serif" size = "-1">
                        <c:choose>
                            <c:when test = "${(ts.status_id == 2) && (sessionScope.user == 'coordinator')}">
                                <form name = "app_h_form" method = "post" action = "index.jsp?fuseaction=c_tsc_update">
                                    <input type = "text"
                                           name = "approved"
                                           size = "2"
                                           value = "<c:out value="${row.hours_approved}" />"> <input type = "hidden"
                                           name = "approved_required"
                                           value = "<cf:GetPhrase phrase_id="877" lang_id="${lang}" />">
                                    <input type = "hidden" name = "act" value = "approve_h">
                                    <input type = "hidden" name = "tr" value = "<c:out value="${row.record_id}" />">
                                    <input type = "submit" name = "Submit"
                                           value = "<cf:GetPhrase phrase_id="857" lang_id="${lang}" />">
                                </form>
                            </c:when>

                            <c:otherwise>
                                <cf:GetPhrase phrase_id = "853" lang_id = "${lang}"/>

                                :

                                <c:out value = "${row.hours_approved}"/>
                            </c:otherwise>
                        </c:choose>

                        </font>
                    </td>
                </tr>

                <c:set var = "hs" value = "${hs + row.hours_spent}"/>

                <c:set var = "ha" value = "${ha + row.hours_approved}"/>
            </c:forEach>
        </table>

        <hr size = "1" noshade>
        <font size = "3" face = "Arial, Helvetica, sans-serif"><b><i>

        <cf:GetPhrase phrase_id = "850" lang_id = "${lang}"/>

        :

        <c:out value = "${hs}"/>

        <br>
        <cf:GetPhrase phrase_id = "853" lang_id = "${lang}"/>:

        <c:out value = "${ha}"/></i></b></font>
    </c:if>
</c:if>
