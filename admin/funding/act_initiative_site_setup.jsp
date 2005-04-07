<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

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
    File background_image         = myUpload.getFiles().getFile(0);
    File public_header_background = myUpload.getFiles().getFile(1);
    File admin_header_background  = myUpload.getFiles().getFile(2);
%>

<sql:query var = "site_setup_num">
    select initiative_setup_id from initiative_setup
</sql:query>

<c:if test = "${site_setup_num.rowCount == 0}">
    <sql:update var = "site_setup_renum">
        insert into initiative_setup (initiative_setup_id) values (1)
    </sql:update>
</c:if>

<%
    pageContext.setAttribute("use_initiative_criteria", myRequest.getParameter("use_initiative_criteria"));
    pageContext.setAttribute("use_cfp_criteria", myRequest.getParameter("use_cfp_criteria"));
    pageContext.setAttribute("show_reviewers", myRequest.getParameter("show_reviewers"));
    pageContext.setAttribute("show_reviewers_summary", myRequest.getParameter("show_reviewers_summary"));
    pageContext.setAttribute("multiple_cfps", myRequest.getParameter("multiple_cfps"));
    pageContext.setAttribute("public_attachments", myRequest.getParameter("public_attachments"));
    pageContext.setAttribute("listname", myRequest.getParameter("listname"));

    pageContext.setAttribute("host_doc_dir", myRequest.getParameter("host_doc_dir"));
    pageContext.setAttribute("host_url", myRequest.getParameter("host_url"));
    pageContext.setAttribute("application_name", myRequest.getParameter("application_name"));
    pageContext.setAttribute("application_directory", myRequest.getParameter("application_directory"));
    pageContext.setAttribute("public_info", myRequest.getParameter("public_info"));
    pageContext.setAttribute("public_info_degree", myRequest.getParameter("public_info_degree"));
    pageContext.setAttribute("minimum_rank", myRequest.getParameter("minimum_rank"));
    pageContext.setAttribute("show_weights", myRequest.getParameter("show_weights"));
    pageContext.setAttribute("criteria_rankings", myRequest.getParameter("criteria_rankings"));
    pageContext.setAttribute("default_lang", myRequest.getParameter("default_lang"));
    pageContext.setAttribute("public_interface", myRequest.getParameter("public_interface"));
%>

<c:set var = "use_initiative_criteria">
    <c:out value = "${use_initiative_criteria}" default = "0"/>
</c:set>

<c:set var = "use_cfp_criteria">
    <c:out value = "${use_cfp_criteria}" default = "0"/>
</c:set>

<c:set var = "show_reviewers">
    <c:out value = "${show_reviewers}" default = "0"/>
</c:set>

<c:set var = "show_reviewers_summary">
    <c:out value = "${show_reviewers_summary}" default = "0"/>
</c:set>

<c:set var = "multiple_cfps">
    <c:out value = "${multiple_cfps}" default = "0"/>
</c:set>

<c:set var = "public_interface">
    <c:out value = "${public_interface}" default = "0"/>
</c:set>

<c:set var = "public_attachments">
    <c:out value = "${public_attachments}" default = "0"/>
</c:set>

<c:set var = "listname">
    <c:out value = "${listname}" default = ""/>
</c:set>

<%@ include file = "../../file_upload.jsp"%>

<%
    FileUpload upload = new FileUpload();
    String path = myRequest.getParameter("host_doc_dir");

    if (!background_image.isMissing())
        {
        String filename = upload.saveFile(background_image, path, application);
        pageContext.setAttribute("file_name1", filename);
        }

    if (!public_header_background.isMissing())
        {
        String filename = upload.saveFile(public_header_background, path, application);
        pageContext.setAttribute("file_name2", filename);
        }

    if (!admin_header_background.isMissing())
        {
        String filename = upload.saveFile(admin_header_background, path, application);
        pageContext.setAttribute("file_name3", filename);
        }
%>

<sql:update var = "site_setup">
    update initiative_setup set host_url = ?, host_doc_dir = ?, public_info = ?, public_info_degree = ?, minimum_rank
    = ?, show_weights = ?, multiple_cfps = ?, listname = ?, use_initiative_criteria = ?, use_cfp_criteria = ?,
    show_reviewers = ?, show_reviewers_summary = ?,

<%
    if (!background_image.isMissing())
        {
%>

        background_image = ?,

<%
        }
%>

<%
    if (!public_header_background.isMissing())
        {
%>

        public_header_background = ?,

<%
        }
%>

<%
    if (!admin_header_background.isMissing())
        {
%>

        admin_header_background = ?,

<%
        }
%>

    criteria_rankings = ?, public_attachments = ?, default_lang = ?, application_name = ?, application_directory = ?,
    public_interface = ? where initiative_setup_id = 1

    <sql:param value = "${host_url}"/>

    <sql:param value = "${host_doc_dir}"/>

    <sql:param value = "${public_info}"/>

    <sql:param value = "${public_info_degree}"/>

    <sql:param value = "${minimum_rank}"/>

    <sql:param value = "${show_weights}"/>

    <sql:param value = "${multiple_cfps}"/>

    <sql:param value = "${listname}"/>

    <sql:param value = "${use_initiative_criteria}"/>

    <sql:param value = "${use_cfp_criteria}"/>

    <sql:param value = "${show_reviewers}"/>

    <sql:param value = "${show_reviewers_summary}"/>

<%
    if (!background_image.isMissing())
        {
%>

        <sql:param value = "${file_name1}"/>

<%
        }
%>

<%
    if (!public_header_background.isMissing())
        {
%>

        <sql:param value = "${file_name2}"/>

<%
        }
%>

<%
    if (!admin_header_background.isMissing())
        {
%>

        <sql:param value = "${file_name3}"/>

<%
        }
%>

    <sql:param value = "${criteria_rankings}"/>

    <sql:param value = "${public_attachments}"/>

    <sql:param value = "${default_lang}"/>

    <sql:param value = "${application_name}"/>

    <sql:param value = "${application_directory}"/>

    <sql:param value = "${public_interface}"/>
</sql:update>

<c:choose>
    <c:when test = "${public_interface == 0}">
        <sql:query var = "public">
            select * from person_role_types where role_name = 'Public'
        </sql:query>

        <c:if test = "${public.rowCount > 0}">
            <sql:update>
                delete from person_role_types where role_name='Public'
            </sql:update>
        </c:if>
    </c:when>

    <c:when test = "${public_interface == 1}">
        <sql:query var = "public">
            select * from person_role_types where role_name = 'Public'
        </sql:query>

        <c:if test = "${public.rowCount == 0}">
            <sql:update>
                insert into person_role_types values (99,1,'Public')
            </sql:update>
        </c:if>
    </c:when>
</c:choose>

<c:import url = "funding/dsp_initiative_site_setup.jsp?fuseaction=site_setup&${user}"/>
