<%@ page errorPage = "dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "source_chapter">
    <c:out value = "${param.source_chapter_id}" default = "1"/>
</c:set>

<sql:query var = "orginit">
    select max(organization_type_id) as initid from organization_types
</sql:query>

<c:forEach var = "rowx" items = "${orginit.rows}">
    <c:set var = "organization_type_id" value = "${rowx.initid}"/>
</c:forEach>


<!-- get source skills  -->
<sql:query var = "source_chapter_orgtypes">
    select * from organization_types where chapter_id = ?

    <sql:param value = "${source_chapter}"/>
</sql:query>


<!-- Insert new orgtypes for the chapter -->

<c:forEach var = "row" items = "${source_chapter_orgtypes.rows}">
    <c:set var = "organization_type_id" value = "${organization_type_id + 1}"/>

    <sql:update>
        insert into organization_types values (?,?,NOW(),?,NOW(),?,?)

        <sql:param value = "${organization_type_id}"/>

        <sql:param value = "${row.organization_type_name}"/>

        <sql:param value = "${sessionScope.user_id}"/>

        <sql:param value = "${sessionScope.user_id}"/>

        <sql:param value = "${sessionScope.chapter}"/>
    </sql:update>
</c:forEach>


<!-- Display new reports -->
<c:import url = 'organizations/dsp_organization_types.jsp'/>
