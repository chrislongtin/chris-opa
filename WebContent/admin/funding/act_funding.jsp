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

    File public_image_title = uploadedFiles.get("public_image_title");
    if(public_image_title != null)
        pageContext.setAttribute("file_name1", public_image_title.getName());
    
    File admin_image_title  = uploadedFiles.get("admin_image_title");
    if(admin_image_title != null)
        pageContext.setAttribute("file_name2", admin_image_title.getName());
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

<!--- Modify or Add Funding Initiative Information --->

<%
    pageContext.setAttribute("act", requestParams.get("act"));
    pageContext.setAttribute("ia_url", requestParams.get("ia_url"));
    pageContext.setAttribute("background",
                             requestParams.get("background"));
    pageContext.setAttribute("initiative_name",
                             requestParams.get("initiative_name"));
    pageContext.setAttribute("initiative_id",
                             requestParams.get("initiative_id"));
    pageContext.setAttribute("eligibility",
                             requestParams.get("eligibility"));
    pageContext.setAttribute("review_process",
                             requestParams.get("review_process"));
    pageContext.setAttribute("proposal_format",
                             requestParams.get("proposal_format"));
    pageContext.setAttribute("copyright", requestParams.get("copyright"));
    pageContext.setAttribute("record_lifecycle",
                             requestParams.get("record_lifecycle"));
    pageContext.setAttribute("about_submitting",
                             requestParams.get("about_submitting"));
    pageContext.setAttribute("ia_name", requestParams.get("ia_name"));
    pageContext.setAttribute("ia_email", requestParams.get("ia_email"));
    pageContext.setAttribute("ia_address",
                             requestParams.get("ia_address"));
    pageContext.setAttribute("ia_courier",
                             requestParams.get("ia_courier"));
    pageContext.setAttribute("ia_phone", requestParams.get("ia_phone"));
    pageContext.setAttribute("ia_fax", requestParams.get("ia_fax"));
    pageContext.setAttribute("ia_courier_inst",
                             requestParams.get("ia_courier_inst"));
    pageContext.setAttribute("ia_url", requestParams.get("ia_url"));
    pageContext.setAttribute("image_toolbar",
                             requestParams.get("image_toolbar"));
    pageContext.setAttribute("lang_id", requestParams.get("lang_id"));
    pageContext.setAttribute("ia_contact",
                             requestParams.get("ia_contact"));
%>

<c:choose>
    <c:when test = "${act=='edit'}">
        <sql:update var = "edit_initative">
            update initiative_info set initiative_name=?, background=?,
            eligibility=?, review_process=?, copyright=?, proposal_format=?,
            about_submitting=?, ia_name=?, ia_contact=?, ia_email=?,
            ia_address=?, ia_courier=?, ia_phone=?, ia_fax=?, ia_courier_inst=?,

            <%
            if (public_image_title != null && public_image_title.exists())
                {
            %>

                public_image_title=?,

            <%
                }
            %>

            <%
            if (admin_image_title != null && admin_image_title.exists())
                {
            %>

                admin_image_title=?,

            <%
                }
            %>

            ia_url=?, lang_id=? where initiative_id = ?

            <sql:param value = "${initiative_name}"/>

            <sql:param value = "${background}"/>

            <sql:param value = "${eligibility}"/>

            <sql:param value = "${review_process}"/>

            <sql:param value = "${copyright}"/>

            <sql:param value = "${proposal_format}"/>

            <sql:param value = "${about_submitting}"/>

            <sql:param value = "${ia_name}"/>

            <sql:param value = "${ia_contact}"/>

            <sql:param value = "${ia_email}"/>

            <sql:param value = "${ia_address}"/>

            <sql:param value = "${ia_courier}"/>

            <sql:param value = "${ia_phone}"/>

            <sql:param value = "${ia_fax}"/>

            <sql:param value = "${ia_courier_inst}"/>

            <%
            if (public_image_title != null && public_image_title.exists())
                {
            %>

                <sql:param value = "${file_name1}"/>

            <%
                }
            %>

            <%
            if (admin_image_title != null && admin_image_title.exists())
                {
            %>

                <sql:param value = "${file_name2}"/>

            <%
                }
            %>

            <sql:param value = "${ia_url}"/>

            <sql:param value = "${lang_id}"/>

            <sql:param value = "${initiative_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${act == 'add'}">
        <sql:update var = "add_initative">
            insert into initiative_info ( initiative_id, initiative_name,
            background, eligibility, review_process, copyright,
            proposal_format, about_submitting, ia_name, ia_contact, ia_email,
            ia_address, ia_courier, ia_phone, ia_fax, ia_courier_inst, ia_url,

            <%
            if (public_image_title != null && public_image_title.exists())
                {
            %>

                public_image_title,

            <%
                }
            %>

            <%
            if (admin_image_title != null && admin_image_title.exists())
                {
            %>

                admin_image_title,

            <%
                }
            %>

            lang_id ) values ( ?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?, ?,

            <%
            if (public_image_title != null && public_image_title.exists())
                {
            %>

                ?,

            <%
                }
            %>

            <%
            if (admin_image_title != null && admin_image_title.exists())
                {
            %>

                ?,

            <%
                }
            %>

            ? )

            <sql:param value = "${initiative_id}"/>

            <sql:param value = "${initiative_name}"/>

            <sql:param value = "${background}"/>

            <sql:param value = "${eligibility}"/>

            <sql:param value = "${review_process}"/>

            <sql:param value = "${copyright}"/>

            <sql:param value = "${proposal_format}"/>

            <sql:param value = "${about_submitting}"/>

            <sql:param value = "${ia_name}"/>

            <sql:param value = "${ia_contact}"/>

            <sql:param value = "${ia_email}"/>

            <sql:param value = "${ia_address}"/>

            <sql:param value = "${ia_courier}"/>

            <sql:param value = "${ia_phone}"/>

            <sql:param value = "${ia_fax}"/>

            <sql:param value = "${ia_courier_inst}"/>

            <sql:param value = "${ia_url}"/>

            <%
            if (public_image_title != null && public_image_title.exists())
                {
            %>

                <sql:param value = "${file_name1}"/>

            <%
                }
            %>

            <%
            if (admin_image_title != null && admin_image_title.exists())
                {
            %>

                <sql:param value = "${file_name2}"/>

            <%
                }
            %>

            <sql:param value = "${lang_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<!--- redirect to main funding information page --->
<c:import url = "funding/dsp_funding.jsp?fuseaction=funding&${user}"/>
