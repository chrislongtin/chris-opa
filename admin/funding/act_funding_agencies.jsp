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

<!--- Modify Funding Initiative Information --->

<c:choose>
    <c:when test = "${param.act == 'edit'}">
        <sql:update var = "add_funding_initative">
            update funding_agencies set

            <c:if test = "${!empty param.agency_contact}">
                agency_contact='

                <c:out value = "${param.agency_contact}"/>

                ',
            </c:if>

            <c:if test = "${!empty param.agency_email}">
                agency_email='

                <c:out value = "${param.agency_email}"/>

                ',
            </c:if>

            <c:if test = "${!empty param.agency_phone}">
                agency_phone='

                <c:out value = "${param.agency_phone}"/>

                ',
            </c:if>

            <c:if test = "${!empty param.agency_url}">
                agency_url='

                <c:out value = "${param.agency_url}"/>

                ',
            </c:if>

            agency_name=? where agency_id=?

            <sql:param value = "${param.agency_name}"/>

            <sql:param value = "${param.agency_id}"/>
        </sql:update>

    <!--- Add Funding Initiative Information --->

    </c:when>

    <c:when test = "${param.act == 'add'}">
        <sql:update var = "add_funding_initative">
            insert into funding_agencies ( agency_id,

            <c:if test = "${!empty param.agency_contact}">
                agency_contact,
            </c:if>

            <c:if test = "${!empty param.agency_email}">
                agency_email,
            </c:if>

            <c:if test = "${!empty param.agency_phone}">
                agency_phone,
            </c:if>

            <c:if test = "${!empty param.agency_url}">
                agency_url,
            </c:if>

            Agency_Name ) values ( ?,

            <c:if test = "${!empty param.agency_contact}">
                '

                <c:out value = "${param.agency_contact}"/>

                ',
            </c:if>

            <c:if test = "${!empty param.agency_email}">
                '

                <c:out value = "${param.agency_email}"/>

                ',
            </c:if>

            <c:if test = "${!empty param.agency_phone}">
                '

                <c:out value = "${param.agency_phone}"/>

                ',
            </c:if>

            <c:if test = "${!empty param.agency_url}">
                '

                <c:out value = "${param.agency_url}"/>

                ',
            </c:if>

            ? )

            <sql:param value = "${param.agency_id}"/>

            <sql:param value = "${param.agency_name}"/>
        </sql:update>
    </c:when>
</c:choose>

<!--- redirect to main funding information page --->

<c:import url = "funding/dsp_funding.jsp?fuseaction=funding&${user}"/>
