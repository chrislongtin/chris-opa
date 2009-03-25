<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<c:choose>
    <c:when test = "${act == 'add'}">
        <sql:query var = "lang_num" maxRows = "1">
            select lang_id from languages order by lang_id desc
        </sql:query>

        <c:forEach var = "row" items = "${lang_num.rows}">
            <c:set var = "lang_id" value = "${row.lang_id + 1}"/>
        </c:forEach>

        <sql:update var = "new_lang">
            insert into languages (lang_id, language) values ( ?, ? )

            <sql:param value = "${lang_id}"/>

            <sql:param value = "${param.language}"/>
        </sql:update>
    </c:when>

    <c:when test = "${act == 'delete'}">
        <sql:update var = "lang_delete">
            delete from languages where lang_id = ?

            <sql:param value = "${param.lang_id}"/>
        </sql:update>

        <sql:update var = "phrases_delete">
            delete from phrases where lang_id = ?

            <sql:param value = "${param.lang_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "language/dsp_lang_main.jsp?fuseaction=lang_main&${user}"/>
