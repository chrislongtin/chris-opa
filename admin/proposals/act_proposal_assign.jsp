<%@ page errorPage = "../dsp_error.jsp"%>

<%@include  file ="../../taglibs_declarations.jsp"%> 

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

<c:set var = "reviewer_id">
    <c:out value = "${param.reviewer_id}" default = ""/>
</c:set>

<c:set var = "proposal_asigned">
    <c:out value = "${param.proposal_assigned}" default = ""/>
</c:set>

<c:set var = "report_asigned">
    <c:out value = "${param.report_assigned}" default = ""/>
</c:set>

<!--------------------- Process ADD reviewers ----------------------------->

<c:forEach var = "current" items = "${param}">
    <c:if test = "${current.key == 'reviewer_id'}">
        <c:forEach items = "${paramValues[current.key]}" var = "reviewer">
            <c:set var = "assignment_id2">
                <c:out value = "${param.assignment_id2}" default = "1"/>
            </c:set>

            <!--- checking to insure reviewer has not already been assigned to this proposal --->

            <sql:query var = "r_assign_verify">
                select * from reviewer_assignment where reviewer_id = ? and
                cfp_code = ? and tracking_code = ?

                <sql:param value = "${reviewer}"/>

                <sql:param value = "${cfp_code}"/>

                <sql:param value = "${tracking_code}"/>
            </sql:query>

            <c:choose>
                <c:when test = "${r_assign_verify.rowCount!=0}">
                    <p><h4>

                    <cf:GetPhrase phrase_id = "459" lang_id = "${lang}"/>!<p>
                    <cf:GetPhrase phrase_id = "562" lang_id = "${lang}"/>!</h4>

                    <c:set var = "redirect" value = "no" scope = "page"/>
                </c:when>

                <c:otherwise>

                    <!--- retrieving coordinator's email address --->
                    <sql:query var = "coord_email">
                        select coordinator_admin_email from coordinators where
                        receive_admin_emails = 1
                    </sql:query>

                    <c:set var = "coordinator_email"
                           value = "${coord_email.rows[0].coordinator_admin_email}"
                           scope = "page"/>

                    <c:out value = "${coord_email.rows[0].coordinator_admin_email}"/>

                    <c:choose>
                        <c:when test = "${coord_email.rowCount==0}">
                            <p><h4>

                            <cf:GetPhrase phrase_id = "563"
                                          lang_id = "${lang}"/></h4>

                            <c:set var = "redirect" value = "no"
                                   scope = "page"/>
                        </c:when>

                        <c:otherwise>

                            <!--- retrieving next value from reviewer_assignment table id --->
                            <sql:query var = "lookup_value" maxRows = "1">
                                select assignment_id from reviewer_assignment
                                order by assignment_id desc
                            </sql:query>

                            <c:set var = "assignment_id2"
                                   value = "${lookup_value.rows[0].assignment_id + 1}"
                                   scope = "page"/>

                            <!--- adding reviewer assignment to database --->

                            <c:set var = "report" value = "0" scope = "page"/>

                            <c:if test = "${param.report_assigned=='R'}">
                                <c:set var = "report" value = "1"
                                       scope = "page"/>
                            </c:if>

                            <c:set var = "proposal" value = "0" scope = "page"/>

                            <c:if test = "${param.proposal_assigned=='P'}">
                                <c:set var = "proposal" value = "1"
                                       scope = "page"/>
                            </c:if>

                            <sql:update>
                                insert into reviewer_assignment (
                                assignment_id, reviewer_id, cfp_code,
                                tracking_code, report, proposal ) values ( ?,
                                ?, ?, ?, ?, ? )

                                <sql:param value = "${assignment_id2}"/>

                                <sql:param value = "${reviewer}"/>

                                <sql:param value = "${cfp_code}"/>

                                <sql:param value = "${tracking_code}"/>

                                <sql:param value = "${report}"/>

                                <sql:param value = "${proposal}"/>
                            </sql:update>

                            <!--- set proponent record status to under review --->
                            <sql:update>
                                update proponent_record set status_id = 4
                                where tracking_code = ?

                                <sql:param value = "${tracking_code}"/>
                            </sql:update>

                            <!--- retrieving reviewer's email address --->
                            <sql:query var = "reviewers_email">
                                select reviewer_email, reviewer_lastname,
                                reviewer_firstname, reviewer_login,
                                reviewer_password from reviewers where
                                reviewer_id = ?

                                <sql:param value = "${reviewer}"/>
                            </sql:query>

                            <c:set var = "re"
                                   value = "${reviewers_email.rows[0]}"
                                   scope = "page"/>

                            <c:set var = "reviewer_email"
                                   value = "${reviewers_email.rows[0].reviewer_email}"
                                   scope = "page"/>

                            <!--- retrieving proposal title --->
                            <sql:query var = "title">
                                select proposal_title from proponent_record
                                where tracking_code = ?

                                <sql:param value = "${tracking_code}"/>
                            </sql:query>

                            <c:set var = "proposal_title"
                                   value = "${title.rows[0].proposal_title}"
                                   scope = "page"/>

                            <!--- retrieving directory settings --->
                            <sql:query var = "directories">
                                select host_url from initiative_setup
                            </sql:query>

                            <c:set var = "host_url"
                                   value = "${directories.rows[0].host_url}"
                                   scope = "page"/>


			    <sm:Sendmail host = "leapfrogindex.com"  domain = "leapfrogindex.com" port = "25"
					    from = "${coordinator_email}"
					    to = "${reviewer_email}" debug = "true"            subject = "Proposal Assignment">
			       <cf:GetPhrase phrase_id = "461" lang_id = "${lang}"/> <c:out value = "${re.reviewer_firstname} ${re.reviewer_lastname}"/>
			       <cf:GetPhrase phrase_id = "564" lang_id = "${lang}"/>:
			       <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/>: <c:out value = "${proposal_title}"/>
			       <cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/> : <c:out value = "${cfp_code}"/>
			       <cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/> : <c:out value = "${tracking_code}"/>
			       <cf:GetPhrase phrase_id = "565" lang_id = "${lang}"/>: <c:out value = "${re.reviewer_login}"/>
			       <cf:GetPhrase phrase_id = "566" lang_id = "${lang}"/>: <c:out value = "${re.reviewer_password}"/>
			       <cf:GetPhrase phrase_id = "567" lang_id = "${lang}"/>
			       <c:out value = "${host_url}"/>
			       <cf:GetPhrase phrase_id = "568" lang_id = "${lang}"/> 
			    </sm:Sendmail>

				   
				   
				   
				   <%-- 
                            <!--- sending email message to reviewer --->
                            <mt:mail session = "java:/comp/env/mail/session">
                                <mt:from>
                                    <c:out value = "${coordinator_email}"/>
                                </mt:from>

                                <mt:setrecipient type = "to">
                                    <c:out value = "${reviewer_email}"/>
                                </mt:setrecipient>

                                <mt:subject>
                                    <cf:GetPhrase phrase_id = "942"
                                                  lang_id = "${lang}"/>
                                </mt:subject>

                                <mt:message>
                                    <cf:GetPhrase phrase_id = "461"
                                                  lang_id = "${lang}"/>

                                    <c:out value = "${re.reviewer_firstname} ${re.reviewer_lastname}"/>

                                    <cf:GetPhrase phrase_id = "564"
                                                  lang_id = "${lang}"/>:

                                    <cf:GetPhrase phrase_id = "151"
                                                  lang_id = "${lang}"/>:

                                    <c:out value = "${proposal_title}"/>

                                    <cf:GetPhrase phrase_id = "56"
                                                  lang_id = "${lang}"/>:

                                    <c:out value = "${cfp_code}"/>

                                    <cf:GetPhrase phrase_id = "57"
                                                  lang_id = "${lang}"/>:

                                    <c:out value = "${tracking_code}"/>

                                    <cf:GetPhrase phrase_id = "565"
                                                  lang_id = "${lang}"/>:

                                    <c:out value = "${re.reviewer_login}"/>

                                    <cf:GetPhrase phrase_id = "566"
                                                  lang_id = "${lang}"/>:

                                    <c:out value = "${re.reviewer_password}"/>

                                    <cf:GetPhrase phrase_id = "567"
                                                  lang_id = "${lang}"/>

                                    <c:out value = "${host_url}"/>

                                    <cf:GetPhrase phrase_id = "568"
                                                  lang_id = "${lang}"/>
                                </mt:message>

                                <mt:send/>
                            </mt:mail>
 --%>
                            <!--- adding notification information to communication center --->
                            <sql:query var = "sent_msg_num" maxRows = "1">
                                select sent_message_id from sent_messages
                                order by sent_message_id desc
                            </sql:query>

                            <c:set var = "sent_message_id" value = "1"
                                   scope = "page"/>

                            <c:if test = "${sent_msg_num.rowCount!=0}">
                                <c:set var = "sent_message_id"
                                       value = "${sent_msg_num.rows[0].sent_message_id + 1}"
                                       scope = "page"/>
                            </c:if>

                            <sql:update>
                                insert into sent_messages (sent_message_id,
                                tracking_code, letter_id, date_sent,
                                recipient1 ) values (?, ?, 99, CURDATE(), ? )

                                <sql:param value = "${sent_message_id}"/>

                                <sql:param value = "${tracking_code}"/>

                                <sql:param value = "${reviewer_email}"/>
                            </sql:update>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
</c:forEach>

<c:if test = "${redirect=='yes'}">
    <c:import url = "proposals/dsp_proposal_assign.jsp">
        <c:param name = "tracking_code" value = "${tracking_code}"/>

        <c:param name = "cfp_code" value = "${cfp_code}"/>

        <c:param name = "cfp_cat_id" value = "${cfp_cat_id}"/>
    </c:import>
</c:if>
