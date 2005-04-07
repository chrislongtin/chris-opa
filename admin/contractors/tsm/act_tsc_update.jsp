<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "mt" uri = "http://jakarta.apache.org/taglibs/mailer-1.1"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../../act_session_check_sub.jsp"%>
<%@ include file = "../../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:if test = "${sessionScope.user == 'coordinator'}">
    <c:set var = "ts_id">
        <c:out value = "${param.ts}" default = "0"/>
    </c:set>

    <c:set var = "tr_id">
        <c:out value = "${param.tr}" default = "0"/>
    </c:set>

    <c:set var = "app">
        <c:out value = "${param.approved}" default = "0"/>
    </c:set>

    <c:set var = "act">
        <c:out value = "${param.act}" default = ""/>
    </c:set>

    <c:if test = "${act == 'approve_h'}">
        <sql:query var = "timerecord">
            select * from contractor_timerecords where record_id = ?

            <sql:param value = "${tr_id}"/>
        </sql:query>

        <c:set var = "tr" value = "${timerecord.rows[0]}"/>

        <c:set var = "ts_id" value = "${tr.timesheet_id}"/>
    </c:if>

    <sql:query var = "timesheet">
        select * from contractor_timesheets where timesheet_id = ?

        <sql:param value = "${ts_id}"/>
    </sql:query>

    <c:set var = "ts" value = "${timesheet.rows[0]}"/>

    <c:choose>
        <c:when test = "${act == 'approve_ts'}">
            <c:choose>
                <c:when test = "${ts.status_id == 2}">
                    <p>
                    <cf:GetPhrase phrase_id = "879" lang_id = "${lang}"/>?

                    <p>
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=c_tsc_update&act=doapprove_ts&ts=<c:out value="${ts_id}" />">[

                    <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/> ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=c_tsc_view&ts=<c:out value="${ts_id}" />">[

                    <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/> ]</a>
                </c:when>

                <c:otherwise>
                    <cf:GetPhrase phrase_id = "878" lang_id = "${lang}"/>

                    !
                </c:otherwise>
            </c:choose>
        </c:when>

        <c:when test = "${act == 'doapprove_ts'}">
            <c:choose>
                <c:when test = "${ts.status_id == 2}">
                    <sql:update>
                        update contractor_timesheets set status_id = 3 where timesheet_id = ?

                        <sql:param value = "${ts_id}"/>
                    </sql:update>

                    <sql:query var = "r">
                        select contractors.contractor_lastname, contractors.contractor_firstname,
                        contractors.contractor_email from contractors, contractor_timesheets where
                        contractor_timesheets.timesheet_id = ? and contractor_timesheets.contractor_id =
                        contractors.contractor_id

                        <sql:param value = "${ts_id}"/>
                    </sql:query>

                    <sql:query var = "dir">
                        select host_url from initiative_setup
                    </sql:query>

                    <c:set var = "host_url" value = "${dir.rows[0].host_url}" scope = "page"/>

                    <sql:query var = "coord_email">
                        select coordinator_admin_email from coordinators where receive_admin_emails = 1
                    </sql:query>

                    <c:set var = "coordinator_email" value = "${coord_email.rows[0].coordinator_admin_email}"
                           scope = "page"/>

                    <mt:mail session = "java:/comp/env/mail/session">
                        <mt:from>
                            <c:out value = "${coordinator_email}"/>
                        </mt:from>

                        <mt:setrecipient type = "to">
                            <c:out value = "${r.rows[0].contractor_email}"/>
                        </mt:setrecipient>

                        <mt:subject>
                            <cf:GetPhrase phrase_id = "970" lang_id = "${lang}"/>

                            -

                            <cf:GetPhrase phrase_id = "845" lang_id = "${lang}"/>
                        </mt:subject>

                        <mt:message>
                            <cf:GetPhrase phrase_id = "880" lang_id = "${lang}"/>

                            <c:out value = "${r.rows[0].contractor_firstname} ${r.rows[0].contractor_lastname}"/>

                            ,

                            <cf:GetPhrase phrase_id = "881" lang_id = "${lang}"/>

                            --

                            <c:out value = "${host_url}"/>
                        </mt:message>

                        <mt:send/>
                    </mt:mail>

                    <c:import url = "contractors/tsm/dsp_tsc_main.jsp?tracking_code=${ts.tracking_code}"/>
                </c:when>

                <c:otherwise>
                    <cf:GetPhrase phrase_id = "878" lang_id = "${lang}"/>

                    !
                </c:otherwise>
            </c:choose>
        </c:when>

        <c:when test = "${act == 'approve_h'}">
            <c:choose>
                <c:when test = "${ts.status_id == 2}">
                    <sql:update>
                        update contractor_timerecords set hours_approved = ? where record_id = ?

                        <sql:param value = "${app}"/>

                        <sql:param value = "${tr_id}"/>
                    </sql:update>

                    <c:import url = "contractors/tsm/dsp_tsc_view.jsp?ts=${ts.timesheet_id}"/>
                </c:when>

                <c:otherwise>
                    <cf:GetPhrase phrase_id = "878" lang_id = "${lang}"/>

                    !
                </c:otherwise>
            </c:choose>
        </c:when>
    </c:choose>
</c:if>
