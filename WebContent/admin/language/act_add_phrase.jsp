<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:choose>
    <c:when test = "${param.act == 'add'}">
        <sql:update var = "add_lang">
            insert into phrases (phrase_id, lang_id, phrase) values ( ?, ?, ? )

            <sql:param value = "${param.phrase_id}"/>

            <sql:param value = "${param.lang_id}"/>

            <sql:param value = "${param.phrase}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'edit'}">
        <sql:update var = "edit_phrase">
            update phrases set phrase = ? where phrase_id = ? and lang_id = ?

            <sql:param value = "${param.phrase}"/>

            <sql:param value = "${param.phrase_id}"/>

            <sql:param value = "${param.lang_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "language/dsp_add_phrase.jsp?fuseaction=add_phrase&${user}&lang_id=${param.lang_id}"/>
