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

<c:choose>
    <c:when test = "${param.act == 'Add'}">
        <sql:update var = "orgtype_add">
            insert into organization_types(organization_type_id,lang_id,
            organization_type_name,create_timestamp,created_by_userid,last_update_timestamp,last_updated_by_userid
            ) values ( ?, ?,?,NOW(),?,NOW(),?)

            <sql:param value = "${param.organization_type_id}"/>

            <sql:param value = "${sessionScope.lang}"/>

            <sql:param value = "${param.organization_type_name}"/>

            <sql:param value = "${sessionScope.user_id}"/>

            <sql:param value = "${sessionScope.user_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Delete'}">
        <sql:update var = "org_type_delete">
            delete from organization_types where organization_type_id = ?

            <sql:param value = "${param.organization_type_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Edit'}">
        <sql:update var = "organization_type_add2">
            update organization_types set organization_type_name =
            ?,last_update_timestamp = NOW(), last_updated_by_userid = ? where
            organization_type_id = ? and lang_id = ?

            <sql:param value = "${param.organization_type_name}"/>

            <sql:param value = "${sessionScope.user_id}"/>

            <sql:param value = "${param.organization_type_id}"/>

            <sql:param value = "${sessionScope.lang}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "organizations/dsp_organization_types.jsp"/>
