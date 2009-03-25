<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- if adding new category get next cfp_cat_id --->

<c:choose>
    <c:when test = "${param.act == 'add'}">
        <sql:query var = "cat_num" maxRows = "1">
            select cfp_cat_id from cfp_category order by cfp_cat_id desc
        </sql:query>

        <c:set var = "cfp_cat_id">
            <c:out value = "${param.cfp_cat_id}" default = "1"/>
        </c:set>

        <c:forEach var = "row" items = "${cat_num.rows}">
            <c:set var = "cfp_cat_id" value = "${row.cfp_cat_id + 1}"/>
        </c:forEach>

        <sql:update var = "cat_add">
            insert into cfp_category (cfp_cat_id, cfp_code, cfp_cat_name)
            values (?, ?, ?)

            <sql:param value = "${cfp_cat_id}"/>

            <sql:param value = "${param.cfp_code}"/>

            <sql:param value = "${param.cfp_cat_name}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'edit'}">
        <sql:update var = "cat_edit">
            update cfp_category set cfp_code = ?, cfp_cat_name = ? where
            cfp_cat_id = ?

            <sql:param value = "${param.cfp_code}"/>

            <sql:param value = "${param.cfp_cat_name}"/>

            <sql:param value = "${param.cfp_cat_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'delete'}">
        <sql:update var = "cat_delete">
            delete from cfp_category where cfp_cat_id = ?

            <sql:param value = "${param.cfp_cat_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "cfp/dsp_cfp.jsp?fuseaction=show_cfp&cfp_code=${param.cfp_code}"/>
