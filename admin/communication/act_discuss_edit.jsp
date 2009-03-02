<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "discuss_author">
    <c:out value = "${param.discuss_author}" default = ""/>
</c:set>

<c:set var = "discuss_email">
    <c:out value = "${param.discuss_email}" default = ""/>
</c:set>

<fmt:parseDate var = 'discuss_date' pattern = 'dd-MMM-yy'
               value = '${param.discuss_date}'/>

<fmt:formatDate var = 'discuss_date' pattern = 'yyyy-MM-dd'
                value = '${discuss_date}'/>

<sql:query var = "doc_dir_find">
    select host_doc_dir from initiative_setup
</sql:query>

<c:forEach var = "row" items = "${doc_dir_find.rows}">
    <c:set var = "host_doc_dir" value = "${row.host_doc_dir}"/>
</c:forEach>

<c:choose>
    <c:when test = "${param.act == 'edit'}">
        <sql:update var = "edit_msg">
            update discussion set discuss_subject = ?, discuss_author = ?,
            discuss_date = ?, discuss_email = ?, discuss_message = ? where
            discussion_id = ?

            <sql:param value = "${param.discuss_subject}"/>

            <sql:param value = "${discuss_author}"/>

            <sql:param value = "${discuss_date}"/>

            <sql:param value = "${discuss_email}"/>

            <sql:param value = "${param.discuss_message}"/>

            <sql:param value = "${param.discussion_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'delete'}">
        <sql:update var = "msg_delete">
            delete from discussion where discussion_id = ?

            <sql:param value = "${param.discussion_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "communication/dsp_discuss_main.jsp?fuseaction=discuss_main&${user}"/>
