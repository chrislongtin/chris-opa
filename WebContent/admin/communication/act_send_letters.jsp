<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "mt" uri = "http://jakarta.apache.org/taglibs/mailer-1.1"%>

<!--- set coordinator admin email address --->

<sql:query var = "admin_email">
    select coordinator_admin_email, coordinator_firstname,
    coordinator_lastname from coordinators where receive_admin_emails = 1
</sql:query>

<c:forEach var = "row" items = "${admin_email.rows}">
    <c:set var = "coordinator_admin_email"
           value = "${row.coordinator_admin_email}"/>

    <c:set var = "coordinator_firstname"
           value = "${row.coordinator_firstname}"/>

    <c:set var = "coordinator_lastname" value = "${row.coordinator_lastname}"/>
</c:forEach>

<!--- select the default letter parameters for the selected status --->
<sql:query var = "letter_param">
    select * from default_letters where status_id = ?

    <sql:param value = "${param.status_id}"/>
</sql:query>

<!--- set the parameters to be used in outgoing email messages --->
<c:forEach var = "row" items = "${letter_param.rows}">
    <c:set var = "letter_id" value = "${row.letter_id}"/>

    <c:set var = "letter_subject" value = "${row.letter_subject}"/>

    <c:set var = "letter_body" value = "${row.letter_body}"/>
</c:forEach>

<!--- generate a list of proponent records which have the same status --->
<sql:query var = "proponent_select">
    select proponent_leader_email, proponent_leader_firstname,
    proponent_leader_lastname, tracking_code from proponent_record where
    status_id = ?

    <sql:param value = "${param.status_id}"/>
</sql:query>

<c:forEach var = "row" items = "${proponent_select.rows}">

    <!--- determine if the proponent has already been sent a letter for that status --->
    <sql:query var = "proponents_notified">
        select tracking_code from sent_messages where letter_id = ? AND
        tracking_code = ?

        <sql:param value = "${letter_id}"/>

        <sql:param value = "${row.tracking_code}"/>
    </sql:query>

    <!--- if no, send the letter --->
    <c:choose>
        <c:when test = "${proponents_notified.rowCount == 0}">
            <mt:mail session = "java:/comp/env/mail/session">
                <mt:from>
                    <c:out value = "${coordinator_admin_email}"/>
                </mt:from>

                <mt:setrecipient type = "to">
                    <c:out value = "${row.proponent_leader_email}"/>
                </mt:setrecipient>

                <mt:subject>
                    <c:out value = "${letter_subject}"/>
                </mt:subject>

                <mt:message>
                    <fmt:message key = "461" />

                    <c:out value = "${row.proponent_leader_firstname}"/>

                    &nbsp;

                    <c:out value = "${row.proponent_leader_lastname}"/>

                    <c:out value = "${letter_body}"/>

                    <fmt:message key = "462" />

                    ,

                    <c:out value = "${coordinator_firstname}"/>

                    &nbsp;

                    <c:out value = "${coordinator_lastname}"/>
                </mt:message>

                <mt:send/>
            </mt:mail>

            <!--- add notification into sent messages table --->
            <sql:query var = "sent_message_num" maxRows = "1">
                select sent_message_id from sent_messages order by
                sent_message_id desc
            </sql:query>

            <c:set var = "sent_message_id"
                   value = "${sent_message_num.rows[0].sent_message_id + 1}"/>

            <%
            java.sql.Date sqldate = new java.sql.Date(new Date().getTime());

            pageContext.setAttribute("date_sent", sqldate.toString());
            %>

            <sql:update var = "message_sent">
                insert into sent_messages (sent_message_id, tracking_code,
                letter_id, date_sent, recipient1) values ( ?, ?, ?, ?, ? )

                <sql:param value = "${sent_message_id}"/>

                <sql:param value = "${row.tracking_code}"/>

                <sql:param value = "${letter_id}"/>

                <sql:param value = "${date_sent}"/>

                <sql:param value = "${row.proponent_leader_email}"/>
            </sql:update>

        <!--- if yes, do nothing --->
        </c:when>

        <c:otherwise>

            <!--- no letters were sent --->
            &nbsp;
        </c:otherwise>
    </c:choose>
</c:forEach>

<c:import url = "communication/dsp_view_sent.jsp?fuseaction=comm_view_sent"/>
