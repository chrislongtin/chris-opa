<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib uri = "http://jakarta.apache.org/taglibs/mailer-1.1" prefix = "mt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "actt">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "redirect">
    <c:out value = "${param.redirect}" default = "yes"/>
</c:set>

<c:choose>
    <c:when test = "${(actt=='delete') or (actt=='delete_confirm')}">
        <c:set var = "tracking_code">
            <c:out value = "${param.tracking_code}" default = ""/>
        </c:set>

        <c:set var = "cfp_code">
            <c:out value = "${param.cfp_code}" default = ""/>
        </c:set>

        <c:if test = "${actt=='delete'}">
            <p>
            <br>
            <h3>

            <cf:GetPhrase phrase_id = "584" lang_id = "${lang}"/>!</h3>

            <p>
            <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=act_proposal_submit&tracking_code=<c:out value="${tracking_code}" />&act=delete_confirm&cfp_code=<c:out value="${cfp_code}" />">

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/></a> |
            <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=proposal_submit&tracking_code=<c:out value="${tracking_code}" />&act=edit">

            <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/></a>

            <c:set var = "redirect" value = "no" scope = "page"/>
        </c:if>

        <c:if test = "${actt=='delete_confirm'}">
            <sql:update>
                delete from proponent_record where tracking_code = ?

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <sql:update>
                delete from documents where tracking_code = ?

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <sql:update>
                delete from researchers where tracking_code = ?

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <sql:update>
                delete from sent_messages where tracking_code = ?

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <sql:update>
                delete from reviewer_assignment where tracking_code = ?

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <sql:update>
                delete from proposal_appraisal where tracking_code = ?

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <sql:update>
                delete from public_comments where tracking_code = ?

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <c:import url = "proposals/dsp_proposal_main.jsp"/>

<%
            if (true)
                return;
%>
        </c:if>
    </c:when>

    <c:otherwise>
        <jsp:useBean id = "myUpload" scope = "page" class = "com.jspsmart.upload.SmartUpload"/>

<%
        myUpload.initialize(pageContext);

        try
            {
            myUpload.upload();
            }
        catch (Exception ex)
            {
            }

        Request myRequest         = myUpload.getRequest();
%>

        <%@ include file = "../../guard_required_params.jsp"%>

<%
        GuardRequiredParams guard = new GuardRequiredParams(myRequest);

        if (guard.isParameterMissed())
            {
            out.write(guard.getSplashScreen());
            return;
            }
%>

<%
        pageContext.setAttribute("act", myRequest.getParameter("act"));
        pageContext.setAttribute("tracking_code", myRequest.getParameter("tracking_code"));
        pageContext.setAttribute("proponent_password", myRequest.getParameter("proponent_password"));
        pageContext.setAttribute("proposal_title", myRequest.getParameter("proposal_title"));
        pageContext.setAttribute("previous_tracking_code", myRequest.getParameter("previous_tracking_code"));
        pageContext.setAttribute("cfp_code", myRequest.getParameter("cfp_code"));
        pageContext.setAttribute("proponent_institution", myRequest.getParameter("proponent_institution"));
        pageContext.setAttribute("proponent_address", myRequest.getParameter("proponent_address"));
        pageContext.setAttribute("proponent_phone", myRequest.getParameter("proponent_phone"));
        pageContext.setAttribute("proponent_fax", myRequest.getParameter("proponent_fax"));
        pageContext.setAttribute("proponent_email", myRequest.getParameter("proponent_email"));
        pageContext.setAttribute("proponent_url", myRequest.getParameter("proponent_url"));
        pageContext.setAttribute("proponent_leader_firstname", myRequest.getParameter("proponent_leader_firstname"));
        pageContext.setAttribute("proponent_leader_lastname", myRequest.getParameter("proponent_leader_lastname"));
        pageContext.setAttribute("proponent_leader_initial", myRequest.getParameter("proponent_leader_initial"));
        pageContext.setAttribute("proponent_leader_affiliation",
                                 myRequest.getParameter("proponent_leader_affiliation"));
        pageContext.setAttribute("proponent_leader_address", myRequest.getParameter("proponent_leader_address"));
        pageContext.setAttribute("proponent_leader_phone", myRequest.getParameter("proponent_leader_phone"));
        pageContext.setAttribute("proponent_leader_fax", myRequest.getParameter("proponent_leader_fax"));
        pageContext.setAttribute("proponent_leader_email", myRequest.getParameter("proponent_leader_email"));
        pageContext.setAttribute("proponent_residency", myRequest.getParameter("proponent_residency"));
        pageContext.setAttribute("proponent_citizenship", myRequest.getParameter("proponent_citizenship"));
        pageContext.setAttribute("requested_amount", myRequest.getParameter("requested_amount"));
        pageContext.setAttribute("project_country", myRequest.getParameter("project_country"));
        pageContext.setAttribute("project_date", myRequest.getParameter("project_date"));
        String cfp_cat_id = myRequest.getParameter("cfp_cat_id");
        pageContext.setAttribute("cfp_cat_id", (cfp_cat_id == null) ? "0" : cfp_cat_id);
%>

        <c:choose>
            <c:when test = "${act=='add'}">
                <sql:query var = "track_code">
                    select tracking_code from proponent_record order by tracking_code desc
                </sql:query>

                <c:choose>
                    <c:when test = "${track_code.rowCount==0}">
                        <c:set var = "tracking_code" value = "1" scope = "page"/>
                    </c:when>

                    <c:otherwise>
                        <c:set var = "tracking_code" value = "${track_code.rows[0].tracking_code + 1}" scope = "page"/>
                    </c:otherwise>
                </c:choose>

<%
                File doc_filename = myUpload.getFiles().getFile(0);
                pageContext.setAttribute("doc_filename", doc_filename.isMissing() ? null : "doc_filename");
%>

                <sql:query var = "doc_dir_find">
                    select host_doc_dir from initiative_setup
                </sql:query>

                <c:set var = "host_doc_dir" value = "${doc_dir_find.rows[0].host_doc_dir}"/>

<%
                if (!doc_filename.isMissing())
                    {
%>

                    <c:set var = "DOCS_DIR" value = "${host_doc_dir}"/>

<%
    String path = (String)pageContext.getAttribute("DOCS_DIR");
    path = application.getRealPath(path);

    String filename = doc_filename.getFileName().replaceAll("\\s", "");

    java.io.File f = new java.io.File(path, filename);

    // ensure uniqueness
    for (int i = 1; f.exists(); i++)
        {
        if (filename.matches(".*\\[\\d+\\]\\..*"))
            filename = filename.replaceFirst("\\[\\d+\\]\\.", ".");

        filename = filename.replaceFirst("\\.(?=[^.]+$)", "[" + i + "].");

        f = new java.io.File(path, filename);
        }

    doc_filename.saveAs(f.getPath());
    pageContext.setAttribute("file_name1", filename);
%>

<%
                    }
%>
            </c:when>

            <c:otherwise>
<%
                pageContext.setAttribute("doc_filename", null);
%>
            </c:otherwise>
        </c:choose>

        <c:if test = "${act=='add'}">

            <!--- adding the document --->

            <c:if test = "${!empty doc_filename}">
                <sql:query var = "doc_num">
                    select doc_id from documents order by doc_id desc
                </sql:query>

                <c:set var = "doc_id" value = "1" scope = "page"/>

                <c:if test = "${doc_num.rowCount!=0}">
                    <c:set var = "doc_id" value = "${doc_num.rows[0].doc_id + 1}" scope = "page"/>
                </c:if>

                <sql:update>
                    insert into documents (doc_id, tracking_code, doc_type_id, doc_title, doc_filename, doc_date)
                    values (?, ?, 1, ?, ?, CURDATE())

                    <sql:param value = "${doc_id}"/>

                    <sql:param value = "${tracking_code}"/>

                    <sql:param value = "${proposal_title}"/>

                    <sql:param value = "${file_name1}"/>
                </sql:update>
            </c:if>

            <sql:update>
                insert into proponent_record ( tracking_code,

                <c:if test = "${!empty previous_tracking_code}">
                    previous_tracking_code,
                </c:if>

                cfp_code, proponent_password, proposal_title, proponent_institution, proponent_address,
                proponent_phone, proponent_fax, proponent_email, proponent_url, proponent_leader_firstname,
                proponent_leader_lastname, proponent_leader_initial, proponent_leader_affiliation,
                proponent_leader_address, proponent_leader_phone, proponent_leader_fax, proponent_leader_email,
                proponent_residency, proponent_citizenship, requested_amount, status_id, date_submitted,
                date_last_updated, cfp_cat_id, project_country, project_date, proposal_hide) values ( ?,

                <c:if test = "${!empty previous_tracking_code}">
                    ?,
                </c:if>

                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, CURDATE(), CURDATE(), ?, ?, ?, 0)

                <sql:param value = "${tracking_code}"/>

                <c:if test = "${!empty previous_tracking_code}">
                    <sql:param value = "${previous_tracking_code}"/>
                </c:if>

                <sql:param value = "${cfp_code}"/>

                <sql:param value = "${proponent_password}"/>

                <sql:param value = "${proposal_title}"/>

                <sql:param value = "${proponent_institution}"/>

                <sql:param value = "${proponent_address}"/>

                <sql:param value = "${proponent_phone}"/>

                <sql:param value = "${proponent_fax}"/>

                <sql:param value = "${proponent_email}"/>

                <sql:param value = "${proponent_url}"/>

                <sql:param value = "${proponent_leader_firstname}"/>

                <sql:param value = "${proponent_leader_lastname}"/>

                <sql:param value = "${proponent_leader_initial}"/>

                <sql:param value = "${proponent_leader_affiliation}"/>

                <sql:param value = "${proponent_leader_address}"/>

                <sql:param value = "${proponent_leader_phone}"/>

                <sql:param value = "${proponent_leader_fax}"/>

                <sql:param value = "${proponent_leader_email}"/>

                <sql:param value = "${proponent_residency}"/>

                <sql:param value = "${proponent_citizenship}"/>

                <sql:param value = "${requested_amount}"/>

                <sql:param value = "${cfp_cat_id}"/>

                <sql:param value = "${project_country}"/>

                <sql:param value = "${project_date}"/>
            </sql:update>

            <!--- send email confirmation of proposal submission --->
            <c:if test = "${!empty proponent_leader_email}">

                <!--- set coordinator admin email address --->
                <sql:query var = "admin_email">
                    select coordinator_admin_email, coordinator_firstname, coordinator_lastname from coordinators
                    where receive_admin_emails = 1
                </sql:query>

                <c:set var = "coordinator_admin_email" value = "${admin_email.rows[0].coordinator_admin_email}"
                       scope = "page"/>

                <c:set var = "coordinator_firstname" value = "${admin_email.rows[0].coordinator_firstname}"
                       scope = "page"/>

                <c:set var = "coordinator_lastname" value = "${admin_email.rows[0].coordinator_lastname}"
                       scope = "page"/>

                <!--- get initiative information --->
                <sql:query var = "i_info">
                    select initiative_name from initiative_info where lang_id = 1
                </sql:query>

                <c:set var = "initiative_name" value = "${i_info.rows[0].initiative_name}" scope = "page"/>

                <mt:mail session = "java:/comp/env/mail/session">
                    <mt:from>
                        <c:out value = "${coordinator_admin_email}"/>
                    </mt:from>

                    <mt:setrecipient type = "to">
                        <c:out value = "${proponent_leader_email}"/>
                    </mt:setrecipient>

                    <mt:subject>
                        Proposal Confirmation
                    </mt:subject>

                    <mt:message>
                        <cf:GetPhrase phrase_id = "461" lang_id = "${lang}"/>

                        <c:out value = "${proponent_leader_firstname} ${proponent_leader_lastname}"/>

                        ,

                        <cf:GetPhrase phrase_id = "578" lang_id = "${lang}"/>

                        <c:out value = "${proposal_title}"/>

                        <cf:GetPhrase phrase_id = "579" lang_id = "${lang}"/>

                        <c:out value = "${initiative_name}"/>

                        .

                        <cf:GetPhrase phrase_id = "580" lang_id = "${lang}"/>

                        :

                        <cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>

                        :&nbsp;

                        <c:out value = "${tracking_code}"/>

                        <cf:GetPhrase phrase_id = "566" lang_id = "${lang}"/>

                        :&nbsp;

                        <c:out value = "${proponent_password}"/>

                        <cf:GetPhrase phrase_id = "583" lang_id = "${lang}"/>

                        .

                        <cf:GetPhrase phrase_id = "462" lang_id = "${lang}"/>

                        ,

                        <c:out value = "${coordinator_firstname} ${coordinator_lastname}"/>
                    </mt:message>

                    <mt:send/>
                </mt:mail>
            </c:if>
        </c:if>

        <c:if test = "${act=='edit'}">
            <sql:update>
                update proponent_record set cfp_code = ?, proposal_title = ?, proponent_institution = ?,
                proponent_address = ?, proponent_phone = ?, proponent_fax = ?, proponent_email = ?, proponent_url = ?,
                proponent_leader_firstname = ?, proponent_leader_lastname = ?, proponent_leader_initial = ?,
                proponent_leader_affiliation = ?, proponent_leader_address = ?, proponent_leader_phone = ?,
                proponent_leader_fax = ?, proponent_leader_email = ?, proponent_citizenship = ?, proponent_residency =
                ?, requested_amount = ?, date_last_updated = CURDATE(), cfp_cat_id = ?, project_country = ?,
                project_date = ? where tracking_code = ?

                <sql:param value = "${cfp_code}"/>

                <sql:param value = "${proposal_title}"/>

                <sql:param value = "${proponent_institution}"/>

                <sql:param value = "${proponent_address}"/>

                <sql:param value = "${proponent_phone}"/>

                <sql:param value = "${proponent_fax}"/>

                <sql:param value = "${proponent_email}"/>

                <sql:param value = "${proponent_url}"/>

                <sql:param value = "${proponent_leader_firstname}"/>

                <sql:param value = "${proponent_leader_lastname}"/>

                <sql:param value = "${proponent_leader_initial}"/>

                <sql:param value = "${proponent_leader_affiliation}"/>

                <sql:param value = "${proponent_leader_address}"/>

                <sql:param value = "${proponent_leader_phone}"/>

                <sql:param value = "${proponent_leader_fax}"/>

                <sql:param value = "${proponent_leader_email}"/>

                <sql:param value = "${proponent_citizenship}"/>

                <sql:param value = "${proponent_residency}"/>

                <sql:param value = "${requested_amount}"/>

                <sql:param value = "${cfp_cat_id}"/>

                <sql:param value = "${project_country}"/>

                <sql:param value = "${project_date}"/>

                <sql:param value = "${tracking_code}"/>
            </sql:update>

            <c:if test = "${!empty doc_filename}">
                <sql:update>
                    update documents set doc_title = ?, doc_filename = ?, doc_date = CURDATE() where tracking_code = ?
                    and doc_type_id = 1

                    <sql:param value = "${proposal_title}"/>

                    <sql:param value = "${file_name1}"/>

                    <sql:param value = "${tracking_code}"/>
                </sql:update>
            </c:if>
        </c:if>
    </c:otherwise>
</c:choose>

<c:if test = "${redirect=='yes'}">
    <c:import url = "proposals/dsp_proposal_list.jsp">
        <c:param name = "cfp_code" value = "${cfp_code}"/>
    </c:import>
</c:if>
