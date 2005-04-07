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
        <sql:query var = "faq_num" maxRows = "1">
            select faq_id from faq order by faq_id desc
        </sql:query>

        <c:set var = "faq_id" value = "${faq_num.rows[0].faq_id + 1}"/>

        <sql:update var = "faq_add">
            insert into faq (faq_id, faq_question, faq_answer) values ( ?, ?, ? )

            <sql:param value = "${faq_id}"/>

            <sql:param value = "${param.faq_question}"/>

            <sql:param value = "${param.faq_answer}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Delete'}">
        <sql:update var = "faq_delete">
            delete from faq where faq_id = ?

            <sql:param value = "${param.faq_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Edit'}">
        <sql:update var = "faq_add2">
            update faq set faq_question = ?, faq_answer = ? where faq_id = ?

            <sql:param value = "${param.faq_question}"/>

            <sql:param value = "${param.faq_answer}"/>

            <sql:param value = "${param.faq_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "communication/dsp_comm_faq.jsp?fuseaction=comm_faq&${user}"/>
