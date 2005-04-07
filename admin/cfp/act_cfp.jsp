<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

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

<!--- Modify Funding Initiative Information --->

<c:set var = "background">
    <c:out value = "${param.background}" default = " "/>
</c:set>

<fmt:parseDate var = 'cfp_startdate' pattern = 'MMM-dd-yy' value = '${param.cfp_startdate}'/>

<fmt:parseDate var = 'cfp_deadline' pattern = 'MMM-dd-yy' value = '${param.cfp_deadline}'/>

<fmt:parseDate var = 'cfp_proposal_review_deadline' pattern = 'MMM-dd-yy'
               value = '${param.cfp_proposal_review_deadline}'/>

<fmt:parseDate var = 'cfp_report_review_deadline' pattern = 'MMM-dd-yy' value = '${param.cfp_report_review_deadline}'/>

<fmt:parseDate var = 'first_reminder' pattern = 'MMM-dd-yy' value = '${param.first_reminder}'/>

<fmt:parseDate var = 'second_reminder' pattern = 'MMM-dd-yy' value = '${param.second_reminder}'/>

<fmt:parseDate var = 'cfp_report_deadline' pattern = 'MMM-dd-yy' value = '${param.cfp_report_deadline}'/>

<fmt:formatDate var = 'cfp_startdate' pattern = 'yyyy-MM-dd' value = '${cfp_startdate}'/>

<fmt:formatDate var = 'cfp_deadline' pattern = 'yyyy-MM-dd' value = '${cfp_deadline}'/>

<fmt:formatDate var = 'cfp_proposal_review_deadline' pattern = 'yyyy-MM-dd' value = '${cfp_proposal_review_deadline}'/>

<fmt:formatDate var = 'cfp_report_review_deadline' pattern = 'yyyy-MM-dd' value = '${cfp_report_review_deadline}'/>

<fmt:formatDate var = 'first_reminder' pattern = 'yyyy-MM-dd' value = '${first_reminder}'/>

<fmt:formatDate var = 'second_reminder' pattern = 'yyyy-MM-dd' value = '${second_reminder}'/>

<fmt:formatDate var = 'cfp_report_deadline' pattern = 'yyyy-MM-dd' value = '${cfp_report_deadline}'/>

<c:choose>
    <c:when test = "${param.act == 'edit'}">
        <c:set var = "cfp_code" value = "${param.cfp_code}"/>

        <sql:update var = "update_cfp">
            update cfp_info set cfp_title=?, cfp_background=?, cfp_maxaward=?, cfp_totalfunds=?,

            cfp_startdate=?, cfp_deadline=?, cfp_proposal_review_deadline=?,

            cfp_report_review_deadline=?, first_reminder=?, second_reminder=?,

            cfp_format=?, currency_id=?, cfp_report_deadline=? where cfp_code=?

            <sql:param value = "${param.cfp_title}"/>

            <sql:param value = "${param.cfp_background}"/>

            <sql:param value = "${param.cfp_maxaward}"/>

            <sql:param value = "${param.cfp_totalfunds}"/>

            <sql:param value = '${cfp_startdate}'/>

            <sql:param value = '${cfp_deadline}'/>

            <sql:param value = '${cfp_proposal_review_deadline}'/>

            <sql:param value = '${cfp_report_review_deadline}'/>

            <sql:param value = '${first_reminder}'/>

            <sql:param value = '${second_reminder}'/>

            <sql:param value = "${param.cfp_format}"/>

            <sql:param value = "${param.currency_id}"/>

            <sql:param value = '${cfp_report_deadline}'/>

            <sql:param value = "${cfp_code}"/>
        </sql:update>

        <sql:update>
            delete from funding_agencies_cfp where agency_id = ? and cfp_code = ?

            <sql:param value = "${param.agency_id}"/>

            <sql:param value = "${cfp_code}"/>
        </sql:update>

        <sql:update>
            update funding_agencies_cfp set agency_id = ? where cfp_code = ?

            <sql:param value = "${param.agency_id}"/>

            <sql:param value = "${cfp_code}"/>
        </sql:update>

        <sql:update>
            delete from cfp_skills where cfp_code = ?

            <sql:param value = "${cfp_code}"/>
        </sql:update>

        <c:forEach var = "current" items = "${param}">
            <c:if test = "${current.key == 'skill_id'}">
                <c:forEach var = "aVal" items = "${paramValues[current.key]}">
                    <c:if test = "${aVal > 0}">
                        <sql:update>
                            insert into cfp_skills values (?,?)

                            <sql:param value = "${cfp_code}"/>

                            <sql:param value = "${aVal}"/>
                        </sql:update>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:forEach>
    </c:when>

    <c:when test = "${param.act == 'add'}">

        <!--- Add Funding Initiative Information --->

        <sql:query var = "next_code" maxRows = "1">
            select cfp_code from cfp_info order by cfp_code desc
        </sql:query>

        <c:set var = "cfp_code">
            <c:out value = "${next_code.rows[0].cfp_code + 1}" default = "1"/>
        </c:set>

        <sql:update var = "add_funding_initative">
            insert into cfp_info ( cfp_code, cfp_title, cfp_background, cfp_maxaward, cfp_totalfunds, cfp_format,
            currency_id, cfp_startdate, cfp_deadline, cfp_report_deadline, cfp_proposal_review_deadline,
            cfp_report_review_deadline, first_reminder, second_reminder ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
            ?, ? )

            <sql:param value = "${cfp_code}"/>

            <sql:param value = "${param.cfp_title}"/>

            <sql:param value = "${param.cfp_background}"/>

            <sql:param value = "${param.cfp_maxaward}"/>

            <sql:param value = "${param.cfp_totalfunds}"/>

            <sql:param value = "${param.cfp_format}"/>

            <sql:param value = "${param.currency_id}"/>

            <sql:param value = '${cfp_startdate}'/>

            <sql:param value = '${cfp_deadline}'/>

            <sql:param value = '${cfp_report_deadline}'/>

            <sql:param value = '${cfp_proposal_review_deadline}'/>

            <sql:param value = '${cfp_report_review_deadline}'/>

            <sql:param value = '${first_reminder}'/>

            <sql:param value = '${second_reminder}'/>
        </sql:update>

        <c:if test = "${param.agency_id > 0}">
            <sql:update>
                insert into funding_agencies_cfp values (?,?)

                <sql:param value = "${param.agency_id}"/>

                <sql:param value = "${cfp_code}"/>
            </sql:update>
        </c:if>

        <c:if test = "${param.agency_id == 0}">
            <sql:update>
                insert into funding_agencies_cfp values (0,?)

                <sql:param value = "${cfp_code}"/>
            </sql:update>
        </c:if>

        <sql:update>
            delete from cfp_skills where cfp_code = ?

            <sql:param value = "${cfp_code}"/>
        </sql:update>

        <c:forEach var = "current" items = "${param}">
            <c:if test = "${current.key == 'skill_id'}">
                <c:forEach var = "aVal" items = "${paramValues[current.key]}">
                    <c:if test = "${aVal > 0}">
                        <sql:update>
                            insert into cfp_skills values (?,?)

                            <sql:param value = "${cfp_code}"/>

                            <sql:param value = "${aVal}"/>
                        </sql:update>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:forEach>

        <c:if test = "${param.agency_id > 0}">
            <sql:query var = "agc">
                select agency_name from funding_agencies where agency_id = ?

                <sql:param value = "${param.agency_id}"/>
            </sql:query>

            <c:set var = "agc_nm">
                <c:out value = "${agc.rows[0].agency_name}"/>
            </c:set>

            <sql:update>
                update cfp_info set cfp_focus = ? where cfp_code = ?

                <sql:param value = "${agc_nm}"/>

                <sql:param value = "${cfp_code}"/>
            </sql:update>
        </c:if>
    </c:when>
</c:choose>


<!--- redirect to main funding information page --->

<c:import url = "cfp/dsp_cfp.jsp?fuseaction=show_cfp&cfp_code=${cfp_code}&${user}"/>
