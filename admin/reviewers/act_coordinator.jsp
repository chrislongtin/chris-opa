<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<%@ include file = "../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "coordinator_id">
    <c:out value = "${param.coordinator_id}" default = "1"/>
</c:set>

<c:set var = "coordinator_firstname">
    <c:out value = "${param.coordinator_firstname}" default = ""/>
</c:set>

<c:set var = "coordinator_lastname">
    <c:out value = "${param.coordinator_lastname}" default = ""/>
</c:set>

<c:set var = "coordinator_login">
    <c:out value = "${param.coordinator_login}" default = ""/>
</c:set>

<c:set var = "coordinator_password">
    <c:out value = "${param.coordinator_password}" default = ""/>
</c:set>

<c:set var = "coordinator_email">
    <c:out value = "${param.coordinator_email}" default = ""/>
</c:set>

<c:set var = "coordinator_phone">
    <c:out value = "${param.coordinator_phone}" default = ""/>
</c:set>

<c:set var = "coordinator_fax">
    <c:out value = "${param.coordinator_fax}" default = ""/>
</c:set>

<c:set var = "coordinator_address">
    <c:out value = "${param.coordinator_address}" default = ""/>
</c:set>

<c:set var = "coordinator_admin_email">
    <c:out value = "${param.coordinator_admin_email}" default = ""/>
</c:set>

<c:set var = "coordinator_public_email">
    <c:out value = "${param.coordinator_public_email}" default = ""/>
</c:set>

<c:set var = "receive_public_emails">
    <c:out value = "${param.receive_public_emails}" default = "0"/>
</c:set>

<c:set var = "receive_admin_emails">
    <c:out value = "${param.receive_admin_emails}" default = "0"/>
</c:set>

<!--- process add, edit or delete coordinators --->

<c:choose>
    <c:when test = "${act=='delete'}">
        <sql:update>
            delete from coordinators where coordinator_id = ?

            <sql:param value = "${coordinator_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${act=='add'}">
        <sql:query var = "coord_num" maxRows = "1">
            select coordinator_id from coordinators order by coordinator_id desc
        </sql:query>

        <c:if test = "${coord_num.rowCount!=0}">
            <c:set var = "coordinator_id" value = "${coord_num.rows[0].coordinator_id + 1}" scope = "page"/>
        </c:if>

        <sql:update>
            insert into coordinators ( coordinator_id, coordinator_firstname, coordinator_lastname, coordinator_login,
            coordinator_password, coordinator_email, coordinator_phone,

            <c:if test = "${!empty coordinator_fax}">
                coordinator_fax,
            </c:if>

            <c:if test = "${!empty coordinator_address}">
                coordinator_address,
            </c:if>

            <c:if test = "${!empty coordinator_admin_email}">
                coordinator_admin_email,
            </c:if>

            <c:if test = "${!empty coordinator_public_email}">
                coordinator_public_email,
            </c:if>

            receive_public_emails, receive_admin_emails ) values ( ?, ?, ?, ?, ?, ?, ?,

            <c:if test = "${!empty coordinator_fax}">
                ?,
            </c:if>

            <c:if test = "${!empty coordinator_address}">
                ?,
            </c:if>

            <c:if test = "${!empty coordinator_admin_email}">
                ?,
            </c:if>

            <c:if test = "${!empty coordinator_public_email}">
                ?,
            </c:if>

            ?, ? )

            <sql:param value = "${coordinator_id}"/>

            <sql:param value = "${coordinator_firstname}"/>

            <sql:param value = "${coordinator_lastname}"/>

            <sql:param value = "${coordinator_login}"/>

            <sql:param value = "${coordinator_password}"/>

            <sql:param value = "${coordinator_email}"/>

            <sql:param value = "${coordinator_phone}"/>

            <c:if test = "${!empty coordinator_fax}">
                <sql:param value = "${coordinator_fax}"/>
            </c:if>

            <c:if test = "${!empty coordinator_address}">
                <sql:param value = "${coordinator_address}"/>
            </c:if>

            <c:if test = "${!empty coordinator_admin_email}">
                <sql:param value = "${coordinator_admin_email}"/>
            </c:if>

            <c:if test = "${!empty coordinator_public_email}">
                <sql:param value = "${coordinator_public_email}"/>
            </c:if>

            <sql:param value = "${receive_public_emails}"/>

            <sql:param value = "${receive_admin_emails}"/>
        </sql:update>
    </c:when>

    <c:when test = "${act=='edit'}">
        <sql:update>
            update coordinators set coordinator_lastname=?, coordinator_firstname=?, coordinator_login=?,
            coordinator_password=?, coordinator_email=?, coordinator_phone=?,

            <c:if test = "${!empty coordinator_fax}">
                coordinator_fax=?,
            </c:if>

            <c:if test = "${!empty coordinator_address}">
                coordinator_address=?,
            </c:if>

            <c:if test = "${!empty coordinator_admin_email}">
                coordinator_admin_email=?,
            </c:if>

            <c:if test = "${!empty coordinator_public_email}">
                coordinator_public_email=?,
            </c:if>

            receive_public_emails=?, receive_admin_emails=? where coordinator_id=?

            <sql:param value = "${coordinator_lastname}"/>

            <sql:param value = "${coordinator_firstname}"/>

            <sql:param value = "${coordinator_login}"/>

            <sql:param value = "${coordinator_password}"/>

            <sql:param value = "${coordinator_email}"/>

            <sql:param value = "${coordinator_phone}"/>

            <c:if test = "${!empty coordinator_fax}">
                <sql:param value = "${coordinator_fax}"/>
            </c:if>

            <c:if test = "${!empty coordinator_address}">
                <sql:param value = "${coordinator_address}"/>
            </c:if>

            <c:if test = "${!empty coordinator_admin_email}">
                <sql:param value = "${coordinator_admin_email}"/>
            </c:if>

            <c:if test = "${!empty coordinator_public_email}">
                <sql:param value = "${coordinator_public_email}"/>
            </c:if>

            <sql:param value = "${receive_public_emails}"/>

            <sql:param value = "${receive_admin_emails}"/>

            <sql:param value = "${coordinator_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "reviewers/dsp_reviewers.jsp"/>
