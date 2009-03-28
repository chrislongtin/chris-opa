<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.File"%>
<%@ page import = "org.apache.commons.io.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.util.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "opa.*" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib uri = "http://jakarta.apache.org/taglibs/mailer-1.1" prefix = "mt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

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
            <a STYLE = "text-decoration: underline"
               href = "index.jsp?fuseaction=act_proposal_submit&tracking_code=<c:out value="${tracking_code}" />&act=delete_confirm&cfp_code=<c:out value="${cfp_code}" />">

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/></a> |
            <a STYLE = "text-decoration: underline"
               href = "index.jsp?fuseaction=proposal_submit&tracking_code=<c:out value="${tracking_code}" />&act=edit">

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
<%
        String uploadBaseDir = (String)request.getSession().getAttribute("DOCS_DIR");
        uploadBaseDir = application.getRealPath(uploadBaseDir);
        
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(request);
        
        Map<String, String> requestParams = Utils.gatherStrings(items);
        Map<String, File> uploadedFiles = Utils.gatherFiles(items, uploadBaseDir);
        
        File doc_filename = uploadedFiles.get("doc_filename");
        if(doc_filename != null)
            pageContext.setAttribute("file_name1", doc_filename.getName());
%>
        <%@ include file = "../../guard_required_params.jsp"%>

        <%
        GuardRequiredParams guard = new GuardRequiredParams(requestParams);

        if (guard.isParameterMissed())
            {
            out.write(guard.getSplashScreen());
            return;
            }
        %>

        <%
        pageContext.setAttribute("act", requestParams.get("act"));
        pageContext.setAttribute("tracking_code",
                                 requestParams.get("tracking_code"));
        pageContext.setAttribute("proponent_password",
                                 requestParams.get("proponent_password"));
        pageContext.setAttribute("proposal_title",
                                 requestParams.get("proposal_title"));
        pageContext.setAttribute("previous_tracking_code",
                                 requestParams.get("previous_tracking_code"));
        pageContext.setAttribute("cfp_code",
                                 requestParams.get("cfp_code"));
        pageContext.setAttribute("proponent_institution",
                                 requestParams.get("proponent_institution"));
        pageContext.setAttribute("proponent_address",
                                 requestParams.get("proponent_address"));
        pageContext.setAttribute("proponent_phone",
                                 requestParams.get("proponent_phone"));
        pageContext.setAttribute("proponent_fax",
                                 requestParams.get("proponent_fax"));
        pageContext.setAttribute("proponent_email",
                                 requestParams.get("proponent_email"));
        pageContext.setAttribute("proponent_url",
                                 requestParams.get("proponent_url"));
        pageContext.setAttribute("proponent_leader_firstname",
                                 requestParams.get("proponent_leader_firstname"));
        pageContext.setAttribute("proponent_leader_lastname",
                                 requestParams.get("proponent_leader_lastname"));
        pageContext.setAttribute("proponent_leader_initial",
                                 requestParams.get("proponent_leader_initial"));
        pageContext.setAttribute("proponent_leader_affiliation",
                                 requestParams.get("proponent_leader_affiliation"));
        pageContext.setAttribute("proponent_leader_address",
                                 requestParams.get("proponent_leader_address"));
        pageContext.setAttribute("proponent_leader_phone",
                                 requestParams.get("proponent_leader_phone"));
        pageContext.setAttribute("proponent_leader_fax",
                                 requestParams.get("proponent_leader_fax"));
        pageContext.setAttribute("proponent_leader_email",
                                 requestParams.get("proponent_leader_email"));
        pageContext.setAttribute("proponent_residency",
                                 requestParams.get("proponent_residency"));
        pageContext.setAttribute("proponent_citizenship",
                                 requestParams.get("proponent_citizenship"));
        pageContext.setAttribute("requested_amount",
                                 requestParams.get("requested_amount"));
        pageContext.setAttribute("project_country",
                                 requestParams.get("project_country"));
        pageContext.setAttribute("project_date",
                                 requestParams.get("project_date"));
        String cfp_cat_id = requestParams.get("cfp_cat_id");
        pageContext.setAttribute("cfp_cat_id", (cfp_cat_id == null)
                                                   ? "0" : cfp_cat_id);
        %>

        <c:choose>
            <c:when test = "${act=='add'}">
                <sql:query var = "track_code">
                    select tracking_code from proponent_record order by
                    tracking_code desc
                </sql:query>

                <c:choose>
                    <c:when test = "${track_code.rowCount==0}">
                        <c:set var = "tracking_code" value = "1"
                               scope = "page"/>
                    </c:when>

                    <c:otherwise>
                        <c:set var = "tracking_code"
                               value = "${track_code.rows[0].tracking_code + 1}"
                               scope = "page"/>
                    </c:otherwise>
                </c:choose>

                <%
                pageContext.setAttribute("doc_filename",
                                         (doc_filename == null || !doc_filename.exists())
                                             ? null : "doc_filename");
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
                    <c:set var = "doc_id"
                           value = "${doc_num.rows[0].doc_id + 1}"
                           scope = "page"/>
                </c:if>

                <sql:update>
                    insert into documents (doc_id, tracking_code, doc_type_id,
                    doc_title, doc_filename, doc_date) values (?, ?, 1, ?, ?,
                    CURDATE())

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

                cfp_code, proponent_password, proposal_title,
                proponent_institution, proponent_address, proponent_phone,
                proponent_fax, proponent_email, proponent_url,
                proponent_leader_firstname, proponent_leader_lastname,
                proponent_leader_initial, proponent_leader_affiliation,
                proponent_leader_address, proponent_leader_phone,
                proponent_leader_fax, proponent_leader_email,
                proponent_residency, proponent_citizenship, requested_amount,
                status_id, date_submitted, date_last_updated, cfp_cat_id,
                project_country, project_date, proposal_hide) values ( ?,

                <c:if test = "${!empty previous_tracking_code}">
                    ?,
                </c:if>

                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1,
                CURDATE(), CURDATE(), ?, ?, ?, 0)

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
                    select coordinator_admin_email, coordinator_firstname,
                    coordinator_lastname from coordinators where
                    receive_admin_emails = 1
                </sql:query>

                <c:set var = "coordinator_admin_email"
                       value = "${admin_email.rows[0].coordinator_admin_email}"
                       scope = "page"/>

                <c:set var = "coordinator_firstname"
                       value = "${admin_email.rows[0].coordinator_firstname}"
                       scope = "page"/>

                <c:set var = "coordinator_lastname"
                       value = "${admin_email.rows[0].coordinator_lastname}"
                       scope = "page"/>

                <!--- get initiative information --->
                <sql:query var = "i_info">
                    select initiative_name from initiative_info where lang_id
                    = 1
                </sql:query>

                <c:set var = "initiative_name"
                       value = "${i_info.rows[0].initiative_name}"
                       scope = "page"/>

                <mt:mail session = "java:/comp/env/mail/session">
                    <mt:from>
                        <c:out value = "${coordinator_admin_email}"/>
                    </mt:from>

                    <mt:setrecipient type = "to">
                        <c:out value = "${proponent_leader_email}"/>
                    </mt:setrecipient>

                    <mt:subject>
                        <cf:GetPhrase phrase_id = "936" lang_id = "${lang}"/>
                    </mt:subject>

                    <mt:message>
                        <cf:GetPhrase phrase_id = "461" lang_id = "${lang}"/>

                        <c:out value = "${proponent_leader_firstname} ${proponent_leader_lastname}"/>,

                        <cf:GetPhrase phrase_id = "578" lang_id = "${lang}"/>:

                        <c:out value = "${proposal_title}"/>

                        <cf:GetPhrase phrase_id = "579" lang_id = "${lang}"/>:

                        <c:out value = "${initiative_name}"/>.

                        <cf:GetPhrase phrase_id = "580" lang_id = "${lang}"/>

                        <cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:

                        <c:out value = "${tracking_code}"/>

                        <cf:GetPhrase phrase_id = "566" lang_id = "${lang}"/>:

                        <c:out value = "${proposal_password}"/>

                        <cf:GetPhrase phrase_id = "583" lang_id = "${lang}"/>.

                        <cf:GetPhrase phrase_id = "462" lang_id = "${lang}"/>,

                        <c:out value = "${coordinator_firstname} ${coordinator_lastname}"/>
                    </mt:message>

                    <mt:send/>
                </mt:mail>

                
            </c:if>
        </c:if>

        <c:if test = "${act=='edit'}">
            <sql:update>
                update proponent_record set cfp_code = ?, proposal_title = ?,
                proponent_institution = ?, proponent_address = ?,
                proponent_phone = ?, proponent_fax = ?, proponent_email = ?,
                proponent_url = ?, proponent_leader_firstname = ?,
                proponent_leader_lastname = ?, proponent_leader_initial = ?,
                proponent_leader_affiliation = ?, proponent_leader_address =
                ?, proponent_leader_phone = ?, proponent_leader_fax = ?,
                proponent_leader_email = ?, proponent_citizenship = ?,
                proponent_residency = ?, requested_amount = ?,
                date_last_updated = CURDATE(), cfp_cat_id = ?, project_country
                = ?, project_date = ? where tracking_code = ?

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
                    update documents set doc_title = ?, doc_filename = ?,
                    doc_date = CURDATE() where tracking_code = ? and
                    doc_type_id = 1

                    <sql:param value = "${proposal_title}"/>

                    <sql:param value = "${file_name1}"/>

                    <sql:param value = "${tracking_code}"/>
                </sql:update>
            </c:if>
        </c:if>
    </c:otherwise>
</c:choose>

<c:import url = "cfp/dsp_proposal_info.jsp">
    <c:param name = "tracking_code" value = "${tracking_code}"/>

    <c:param name = "proponent_password" value = "${proponent_password}"/>

    <c:param name = "act" value = 'edit'/>
</c:import>
