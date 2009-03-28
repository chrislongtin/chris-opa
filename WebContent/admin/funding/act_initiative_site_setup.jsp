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

<%
    String uploadBaseDir = (String)request.getSession().getAttribute("DOCS_DIR");
    uploadBaseDir = application.getRealPath(uploadBaseDir);
    
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    List<FileItem> items = upload.parseRequest(request);
    
    Map<String, String> requestParams = Utils.gatherStrings(items);
    Map<String, File> uploadedFiles = Utils.gatherFiles(items, uploadBaseDir);

    File background_image = uploadedFiles.get("background_image");
    if(background_image != null)
        pageContext.setAttribute("file_name1", background_image.getName());
    
    File public_header_background  = uploadedFiles.get("public_header_background");
    if(public_header_background != null)
        pageContext.setAttribute("file_name2", public_header_background.getName());

    File admin_header_background  = uploadedFiles.get("admin_header_background");
    if(admin_header_background != null)
        pageContext.setAttribute("file_name3", admin_header_background.getName());
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

<sql:query var = "site_setup_num">
    select initiative_setup_id from initiative_setup
</sql:query>

<c:if test = "${site_setup_num.rowCount == 0}">
    <sql:update var = "site_setup_renum">
        insert into initiative_setup (initiative_setup_id) values (1)
    </sql:update>
</c:if>

<%
    pageContext.setAttribute("use_initiative_criteria",
                             requestParams.get("use_initiative_criteria"));
    pageContext.setAttribute("use_cfp_criteria",
                             requestParams.get("use_cfp_criteria"));
    pageContext.setAttribute("show_reviewers",
                             requestParams.get("show_reviewers"));
    pageContext.setAttribute("show_reviewers_summary",
                             requestParams.get("show_reviewers_summary"));
    pageContext.setAttribute("multiple_cfps",
                             requestParams.get("multiple_cfps"));
    pageContext.setAttribute("public_attachments",
                             requestParams.get("public_attachments"));
    pageContext.setAttribute("listname", requestParams.get("listname"));

    pageContext.setAttribute("host_doc_dir",
                             requestParams.get("host_doc_dir"));
    pageContext.setAttribute("host_url", requestParams.get("host_url"));
    pageContext.setAttribute("application_name",
                             requestParams.get("application_name"));
    pageContext.setAttribute("application_directory",
                             requestParams.get("application_directory"));
    pageContext.setAttribute("public_info",
                             requestParams.get("public_info"));
    pageContext.setAttribute("public_info_degree",
                             requestParams.get("public_info_degree"));
    pageContext.setAttribute("minimum_rank",
                             requestParams.get("minimum_rank"));
    pageContext.setAttribute("show_weights",
                             requestParams.get("show_weights"));
    pageContext.setAttribute("criteria_rankings",
                             requestParams.get("criteria_rankings"));
    pageContext.setAttribute("default_lang",
                             requestParams.get("default_lang"));
    pageContext.setAttribute("public_interface",
                             requestParams.get("public_interface"));
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

<sql:update var = "site_setup">
    update initiative_setup set host_url = ?, host_doc_dir = ?, public_info =
    ?, public_info_degree = ?, minimum_rank = ?, show_weights = ?,
    multiple_cfps = ?, listname = ?, use_initiative_criteria = ?,
    use_cfp_criteria = ?, show_reviewers = ?, show_reviewers_summary = ?,

    <%
    if (background_image != null && background_image.exists())
        {
    %>

        background_image = ?,

    <%
        }
    %>

    <%
    if (public_header_background != null && public_header_background.exists())
        {
    %>

        public_header_background = ?,

    <%
        }
    %>

    <%
    if (admin_header_background != null && admin_header_background.exists())
        {
    %>

        admin_header_background = ?,

    <%
        }
    %>

    criteria_rankings = ?, public_attachments = ?, default_lang = ?,
    application_name = ?, application_directory = ?, public_interface = ?
    where initiative_setup_id = 1

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
    if (background_image != null && background_image.exists())
        {
    %>

        <sql:param value = "${file_name1}"/>

    <%
        }
    %>

    <%
    if (public_header_background != null && public_header_background.exists())
        {
    %>

        <sql:param value = "${file_name2}"/>

    <%
        }
    %>

    <%
    if (admin_header_background != null && admin_header_background.exists())
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
