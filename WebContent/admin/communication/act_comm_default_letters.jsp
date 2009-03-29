<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

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
    <c:when test = "${param.act == 'add'}">
        <sql:query var = "status_check">
            select letter_id from default_letters where status_id = ?

            <sql:param value = "${param.status_id}"/>
        </sql:query>

        <c:choose>
            <c:when test = "${status_check.rowCount != 0}">
                <p>
                <h3>

                <fmt:message key = "459" />!</h3>

                <p>
                <b>

                <fmt:message key = "460" />.</b>
            </c:when>

            <c:otherwise>
                <sql:query var = "letter_num" maxRows = "1">
                    select letter_id from default_letters order by letter_id
                    desc
                </sql:query>

                <c:set var = "letter_id"
                       value = "${letter_num.rows[0].letter_id + 1}"/>

                <sql:update var = "letter_add">
                    insert into default_letters (letter_id, letter_subject,
                    letter_body, status_id) values ( ?, ?, ?, ? )

                    <sql:param value = "${letter_id}"/>

                    <sql:param value = "${param.letter_subject}"/>

                    <sql:param value = "${param.letter_body}"/>

                    <sql:param value = "${param.status_id}"/>
                </sql:update>

                <c:import url = "communication/dsp_comm_default_letters.jsp?fuseaction=comm_default_letters&${user}"/>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test = "${param.act == 'edit'}">

        <!--- edit default letter --->

        <sql:query var = "status_check">
            select letter_id from default_letters where status_id = ? AND
            (letter_id < ? OR
		letter_id  > ?)
<sql:param value="${param.status_id}"/>
<sql:param value="${param.letter_id}"/>
<sql:param value="${param.letter_id}"/>
</sql:query>

<c:choose>
<c:when test="${status_check.rowCount != 0}">

<p><h3><fmt:message key="459" />!</h3>

<p><b><fmt:message key="460" />.</b>

</c:when>
<c:otherwise>

<sql:update var="update_letter">
update default_letters
set	letter_subject = ?,
	letter_body = ?,
	status_id = ?
where letter_id = ?
<sql:param value="${param.letter_subject}"/>
<sql:param value="${param.letter_body}"/>
<sql:param value="${param.status_id}"/>
<sql:param value="${param.letter_id}"/>
</sql:update>

<c:import url="communication/dsp_comm_default_letters.jsp?fuseaction=comm_default_letters&${user}"/>

</c:otherwise>
</c:choose>

</c:when>
<c:when test="${param.act == 'delete'}">

<sql:update var="letter_del">
delete
from default_letters
where letter_id = ?
<sql:param value="${param.letter_id}"/>
</sql:update>

<c:import url="communication/dsp_comm_default_letters.jsp?fuseaction=comm_default_letters&${user}"/>

</c:when>
</c:choose>






