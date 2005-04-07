<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib uri = "http://jakarta.apache.org/taglibs/mailer-1.1" prefix = "mt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<%@ include file = "../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = ""/>
</c:set>

<c:set var = "cfp_cat_id">
    <c:out value = "${param.cfp_cat_id}" default = ""/>
</c:set>

<c:set var = "redirect">
    <c:out value = "${param.redirect}" default = "yes"/>
</c:set>

<c:set var = "contractor_id">
    <c:out value = "${param.contractor_id}" default = ""/>
</c:set>

<c:set var = "proposal_asigned">
    <c:out value = "${param.proposal_assigned}" default = ""/>
</c:set>

<c:set var = "report_asigned">
    <c:out value = "${param.report_assigned}" default = ""/>
</c:set>

<!--------------------- Process ADD contractors ----------------------------->
<c:forEach var = "current" items = "${param}">
    <c:if test = "${current.key == 'contractor_id'}">
        <c:forEach items = "${paramValues[current.key]}" var = "contractor">
            <c:set var = "assignment_id2">
                <c:out value = "${param.assignment_id2}" default = "1"/>
            </c:set>

            <!--- checking to insure contractor has not already been assigned to this proposal --->

            <sql:query var = "r_assign_verify">
                select * from contractor_assignment where contractor_id = ? and cfp_code = ? and tracking_code = ?

                <sql:param value = "${contractor}"/>

                <sql:param value = "${cfp_code}"/>

                <sql:param value = "${tracking_code}"/>
            </sql:query>

            <c:choose>
                <c:when test = "${r_assign_verify.rowCount!=0}">
                    <p>
                    <h4>

                    <cf:GetPhrase phrase_id = "459" lang_id = "${lang}"/>

                    !

                    <p>
                    <cf:GetPhrase phrase_id = "562" lang_id = "${lang}"/>!</h4>

                    <c:set var = "redirect" value = "no" scope = "page"/>
                </c:when>

                <c:otherwise>

                    <!--- retrieving coordinator's email address --->
                    <sql:query var = "coord_email">
                        select coordinator_admin_email from coordinators where receive_admin_emails = 1
                    </sql:query>

                    <c:set var = "coordinator_email" value = "${coord_email.rows[0].coordinator_admin_email}"
                           scope = "page"/>

                    <c:out value = "${coord_email.rows[0].coordinator_admin_email}"/>

                    <c:choose>
                        <c:when test = "${coord_email.rowCount==0}">
                            <p>
                            <h4>

                            <cf:GetPhrase phrase_id = "563" lang_id = "${lang}"/></h4>

                            <c:set var = "redirect" value = "no" scope = "page"/>
                        </c:when>

                        <c:otherwise>

                            <!--- retrieving next value from contractor_assignment table id --->
                            <sql:query var = "lookup_value" maxRows = "1">
                                select assignment_id from contractor_assignment order by assignment_id desc
                            </sql:query>

                            <c:set var = "assignment_id2" value = "${lookup_value.rows[0].assignment_id + 1}"
                                   scope = "page"/>

                            <!--- adding contractor assignment to database --->

                            <sql:update>
                                insert into contractor_assignment ( assignment_id, contractor_id, cfp_code,
                                tracking_code ) values ( ?, ?, ?, ? )

                                <sql:param value = "${assignment_id2}"/>

                                <sql:param value = "${contractor}"/>

                                <sql:param value = "${cfp_code}"/>

                                <sql:param value = "${tracking_code}"/>
                            </sql:update>

                            <!--- retrieving contractor's email address --->
                            <sql:query var = "contractors_email">
                                select contractor_email, contractor_lastname, contractor_firstname, contractor_login,
                                contractor_password from contractors where contractor_id = ?

                                <sql:param value = "${contractor}"/>
                            </sql:query>

                            <c:set var = "re" value = "${contractors_email.rows[0]}" scope = "page"/>

                            <c:set var = "contractor_email" value = "${contractors_email.rows[0].contractor_email}"
                                   scope = "page"/>

                            <!--- retrieving proposal title --->
                            <sql:query var = "title">
                                select proposal_title from proponent_record where tracking_code = ?

                                <sql:param value = "${tracking_code}"/>
                            </sql:query>

                            <c:set var = "proposal_title" value = "${title.rows[0].proposal_title}" scope = "page"/>

                            <!--- retrieving directory settings --->
                            <sql:query var = "directories">
                                select host_url from initiative_setup
                            </sql:query>

                            <c:set var = "host_url" value = "${directories.rows[0].host_url}" scope = "page"/>

                            <!--- sending email message to contractor --->
                            <mt:mail session = "java:/comp/env/mail/session">
                                <mt:from>
                                    <c:out value = "${coordinator_email}"/>
                                </mt:from>

                                <mt:setrecipient type = "to">
                                    <c:out value = "${contractor_email}"/>
                                </mt:setrecipient>

                                <mt:subject>
                                    <cf:GetPhrase phrase_id = "942" lang_id = "${lang}"/>
                                </mt:subject>

                                <mt:message>
                                    <cf:GetPhrase phrase_id = "461" lang_id = "${lang}"/>

                                    <c:out value = "${re.contractor_firstname} ${re.contractor_lastname}"/>

                                    <cf:GetPhrase phrase_id = "1038" lang_id = "${lang}"/>

                                    :

                                    <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/>

                                    :

                                    <c:out value = "${proposal_title}"/>

                                    <cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/>

                                    :

                                    <c:out value = "${cfp_code}"/>

                                    <cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>

                                    :&nbsp;

                                    <c:out value = "${tracking_code}"/>

                                    <cf:GetPhrase phrase_id = "565" lang_id = "${lang}"/>

                                    :&nbsp;

                                    <c:out value = "${re.contractor_login}"/>

                                    <cf:GetPhrase phrase_id = "566" lang_id = "${lang}"/>

                                    :&nbsp;

                                    <c:out value = "${re.contractor_password}"/>

                                    <cf:GetPhrase phrase_id = "567" lang_id = "${lang}"/>

                                    <c:out value = "${host_url}"/>

                                    <cf:GetPhrase phrase_id = "568" lang_id = "${lang}"/>
                                </mt:message>

                                <mt:send/>
                            </mt:mail>

                            <!--- adding notification information to communication center --->
                            <sql:query var = "sent_msg_num" maxRows = "1">
                                select sent_message_id from sent_messages order by sent_message_id desc
                            </sql:query>

                            <c:set var = "sent_message_id" value = "1" scope = "page"/>

                            <c:if test = "${sent_msg_num.rowCount!=0}">
                                <c:set var = "sent_message_id" value = "${sent_msg_num.rows[0].sent_message_id + 1}"
                                       scope = "page"/>
                            </c:if>

                            <sql:update>
                                insert into sent_messages (sent_message_id, tracking_code, letter_id, date_sent,
                                recipient1 ) values (?, ?, 99, CURDATE(), ? )

                                <sql:param value = "${sent_message_id}"/>

                                <sql:param value = "${tracking_code}"/>

                                <sql:param value = "${contractor_email}"/>
                            </sql:update>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
</c:forEach>

<c:if test = "${redirect=='yes'}">
    <c:import url = "contractors/dsp_contractor_assign.jsp">
        <c:param name = "tracking_code" value = "${tracking_code}"/>

        <c:param name = "cfp_code" value = "${cfp_code}"/>

        <c:param name = "cfp_cat_id" value = "${cfp_cat_id}"/>
    </c:import>
</c:if>
