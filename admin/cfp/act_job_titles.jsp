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
        <sql:query var = "seq_num" maxRows = "1">
            select seq_no from standardjobnames order by job_name desc
        </sql:query>

        <c:set var = "seq_no" value = "${seq_num.rows[0].seq_no + 1}"/>

        <sql:update var = "title_add">
            insert into standardjobnames (seq_no, job_name) values ( ?, ? )

            <sql:param value = "${param.seq_no}"/>

            <sql:param value = "${param.job_name}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Delete'}">
        <sql:update var = "title_delete">
            delete from standardjobnames where seq_no = ?

            <sql:param value = "${param.seq_no}"/>
        </sql:update>
    </c:when>

    <c:when test = "${param.act == 'Edit'}">
        <sql:update var = "title_add2">
            update standardjobnames set seq_no = ?, job_name = ? where seq_no = ?

            <sql:param value = "${param.seq_no}"/>

            <sql:param value = "${param.job_name}"/>

            <sql:param value = "${param.seq_no}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "communication/dsp_job_titles.jsp?fuseaction=job_titles&${user}"/>
