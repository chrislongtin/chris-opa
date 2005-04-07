<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "ts_id">
    <c:out value = "${param.ts}" default = "0"/>
</c:set>

<sql:query var = "prop">
    select p.proposal_title, t.*, s.ts_status from proponent_record p, timesheets t, timesheetstatus s where
    t.reviewer_id = ? and t.timesheet_id = ? and t.tracking_code = p.tracking_code and t.status_id = s.status_id

    <sql:param value = "${sessionScope.rid}"/>

    <sql:param value = "${ts_id}"/>
</sql:query>

<c:if test = "${prop.rowCount == 1}">
    <c:set var = "ts" value = "${prop.rows[0]}"/>

    <sql:query var = "tr">
        select * from timerecords where timesheet_id = ? order by activity_date desc

        <sql:param value = "${ts_id}"/>
    </sql:query>

    <c:set var = "hs" value = "0"/>

    <c:set var = "ha" value = "0"/>

    <h4>

    <c:out value = "${ts.tracking_code}. ${ts.proposal_title}"/>

    (

    <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.start_date}'/>

    -

    <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.end_date}'/>

    ) -

    <c:out value = "${ts.ts_status}"/></h4>

    <c:choose>
        <c:when test = "${ts.status_id == 1}">
            <form name = "del_form" method = "post" action = "index.jsp?fuseaction=tsr_update">
                <input type = "hidden" name = "act" value = "delete">
                <input type = "hidden" name = "ts" value = "<c:out value="${ts_id}" />">
                <input type = "submit" name = "submit_ts" value = "<cf:GetPhrase phrase_id="867" lang_id="${lang}" />">
            </form>

            <c:if test = "${tr.rowCount > 0}">
                <form name = "submit_form" method = "post" action = "index.jsp?fuseaction=tsr_update">
                    <input type = "hidden" name = "act" value = "submit">
                    <input type = "hidden" name = "ts" value = "<c:out value="${ts_id}" />">
                    <input type = "submit" name = "submit_ts"
                           value = "<cf:GetPhrase phrase_id="848" lang_id="${lang}" />">
                </form>

                <hr noshade size = "1" color = "#000000">
                <br>
                <h4>

                <cf:GetPhrase phrase_id = "849" lang_id = "${lang}"/></h4><c:forEach var = "row" items = "${tr.rows}">
                    <form name = "tr_form" method = "post" action = "index.jsp?fuseaction=tsr_update">
                        <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/>

                        (MMM-dd-yyyy): <input type = "text"
                               name = "date"
                               size = "10"
                               value = "<fmt:formatDate pattern='MMM-dd-yyyy' value='${row.activity_date}'/>">
                        <input type = "hidden"
                               name = "date_required"
                               value = "<cf:GetPhrase phrase_id="868" lang_id="${lang}" />">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <cf:GetPhrase phrase_id = "850" lang_id = "${lang}"/>:
                        <input type = "text" name = "spent" size = "2" value = "<c:out value="${row.hours_spent}" />">
                        <input type = "hidden" name = "spent_required"
                               value = "<cf:GetPhrase phrase_id="869" lang_id="${lang}" />">

                        <br>
                        <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:

                        <textarea name = "comment" wrap = "VIRTUAL" cols = "50" rows = "3">
                            <c:out value = "${row.comments}"/>
                        </textarea>

                        <br>
                        <input type = "hidden" name = "act" value = "update">
                        <input type = "hidden" name = "tr" value = "<c:out value="${row.record_id}" />">
                        <input type = "submit" name = "update_tr"
                               value = "<cf:GetPhrase phrase_id="851" lang_id="${lang}" />">

                        <hr noshade size = "1" color = "#DDDDDD">
                    </form>

                    <c:set var = "hs" value = "${hs + row.hours_spent}"/>
                </c:forEach>

                <font size = "3" face = "Arial, Helvetica, sans-serif"><b><i>

                <cf:GetPhrase phrase_id = "850" lang_id = "${lang}"/>

                :

                <c:out value = "${hs}"/> </i></b></font>

                <br>
            </c:if>

            <br>
            <hr noshade size = "1" color = "#000000">
            <h4>

            <cf:GetPhrase phrase_id = "852" lang_id = "${lang}"/></h4>

            <form name = "add_tr_form" method = "post" action = "index.jsp?fuseaction=tsr_update">
                <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/>

                (MMM-dd-yyyy): <input type = "text" name = "date" size = "10"> <input type = "hidden"
                       name = "date_required"
                       value = "<cf:GetPhrase phrase_id="868" lang_id="${lang}" />">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <cf:GetPhrase phrase_id = "850" lang_id = "${lang}"/>: <input type = "text" name = "spent" size = "2">
                <input type = "hidden" name = "spent_required"
                       value = "<cf:GetPhrase phrase_id="869" lang_id="${lang}" />">

                <br>
                <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:

                <textarea name = "comment" wrap = "VIRTUAL" cols = "50" rows = "3">
                </textarea>

                <br>
                <input type = "hidden" name = "act" value = "add">
                <input type = "hidden" name = "ts" value = "<c:out value="${ts_id}" />">
                <input type = "submit" name = "add_tr" value = "<cf:GetPhrase phrase_id="852" lang_id="${lang}" />">
            </form>
        </c:when>

        <c:otherwise>
            <h4>

            <cf:GetPhrase phrase_id = "849" lang_id = "${lang}"/></h4>

            <c:forEach var = "row" items = "${tr.rows}">
                <p>
                <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/>:

                <fmt:formatDate pattern = 'dd-MMM-yyyy' value = '${row.activity_date}'/>

                <p>
                <cf:GetPhrase phrase_id = "850" lang_id = "${lang}"/>:

                <c:out value = "${row.hours_spent}"/><c:if test = "${ts.status_id == 3}">
                    <p>
                    <cf:GetPhrase phrase_id = "853" lang_id = "${lang}"/>:

                    <c:out value = "${row.hours_approved}"/>

                    <c:set var = "ha" value = "${ha + row.hours_approved}"/>
                </c:if>

                <p>
                <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:

                <cf:ParagraphFormat value = "${row.comments}"/>

                <hr noshade size = "1" color = "#DDDDDD">
                <c:set var = "hs" value = "${hs + row.hours_spent}"/>
            </c:forEach>

            <font size = "3" face = "Arial, Helvetica, sans-serif"><b><i>

            <cf:GetPhrase phrase_id = "850" lang_id = "${lang}"/>

            :

            <c:out value = "${hs}"/><c:if test = "${ts.status_id == 3}">
                <br>
                <cf:GetPhrase phrase_id = "853" lang_id = "${lang}"/>:

                <c:out value = "${ha}"/>
            </c:if>

            </i></b></font>

            <br>
        </c:otherwise>
    </c:choose>
</c:if>
