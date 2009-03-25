<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<jsp:useBean id = "myUpload" scope = "page"
             class = "com.jspsmart.upload.SmartUpload"/>

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
    File admin_image_title  = myUpload.getFiles().getFile(0);
    File public_image_title = myUpload.getFiles().getFile(1);
%>

<!--- Modify or Add Funding Initiative Information --->

<sql:query var = "doc_dir">
    select host_doc_dir from initiative_setup
</sql:query>

<%@ include file = "../../file_upload.jsp"%>

<%
    FileUpload upload       = new FileUpload();

    if (!public_image_title.isMissing())
        {
%>

        <c:forEach var = "row" items = "${doc_dir.rows}">
            <c:set var = "docs_dir" value = "${row.host_doc_dir}"/>
        </c:forEach>

    <%
        String path     = (String)pageContext.getAttribute("docs_dir");
        String filename = upload.saveFile(public_image_title, path,
                                          application);
        pageContext.setAttribute("file_name1", filename);
        }

    if (!admin_image_title.isMissing())
        {
    %>

        <c:forEach var = "row" items = "${doc_dir.rows}">
            <c:set var = "docs_dir" value = "${row.host_doc_dir}"/>
        </c:forEach>

    <%
        String path     = (String)pageContext.getAttribute("docs_dir");
        String filename = upload.saveFile(admin_image_title, path, application);
        pageContext.setAttribute("file_name2", filename);
        }
    %>

<%
    pageContext.setAttribute("act", myRequest.getParameter("act"));
    pageContext.setAttribute("ia_url", myRequest.getParameter("ia_url"));
    pageContext.setAttribute("background",
                             myRequest.getParameter("background"));
    pageContext.setAttribute("initiative_name",
                             myRequest.getParameter("initiative_name"));
    pageContext.setAttribute("initiative_id",
                             myRequest.getParameter("initiative_id"));
    pageContext.setAttribute("eligibility",
                             myRequest.getParameter("eligibility"));
    pageContext.setAttribute("review_process",
                             myRequest.getParameter("review_process"));
    pageContext.setAttribute("proposal_format",
                             myRequest.getParameter("proposal_format"));
    pageContext.setAttribute("copyright", myRequest.getParameter("copyright"));
    pageContext.setAttribute("record_lifecycle",
                             myRequest.getParameter("record_lifecycle"));
    pageContext.setAttribute("about_submitting",
                             myRequest.getParameter("about_submitting"));
    pageContext.setAttribute("ia_name", myRequest.getParameter("ia_name"));
    pageContext.setAttribute("ia_email", myRequest.getParameter("ia_email"));
    pageContext.setAttribute("ia_address",
                             myRequest.getParameter("ia_address"));
    pageContext.setAttribute("ia_courier",
                             myRequest.getParameter("ia_courier"));
    pageContext.setAttribute("ia_phone", myRequest.getParameter("ia_phone"));
    pageContext.setAttribute("ia_fax", myRequest.getParameter("ia_fax"));
    pageContext.setAttribute("ia_courier_inst",
                             myRequest.getParameter("ia_courier_inst"));
    pageContext.setAttribute("ia_url", myRequest.getParameter("ia_url"));
    pageContext.setAttribute("image_toolbar",
                             myRequest.getParameter("image_toolbar"));
    pageContext.setAttribute("lang_id", myRequest.getParameter("lang_id"));
    pageContext.setAttribute("ia_contact",
                             myRequest.getParameter("ia_contact"));
%>

<c:choose>
    <c:when test = "${act=='edit'}">
        <sql:update var = "edit_initative">
            update initiative_info set initiative_name=?, background=?,
            eligibility=?, review_process=?, copyright=?, proposal_format=?,
            about_submitting=?, ia_name=?, ia_contact=?, ia_email=?,
            ia_address=?, ia_courier=?, ia_phone=?, ia_fax=?, ia_courier_inst=?,

            <%
            if (!public_image_title.isMissing())
                {
            %>

                public_image_title=?,

            <%
                }
            %>

            <%
            if (!admin_image_title.isMissing())
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
            if (!public_image_title.isMissing())
                {
            %>

                <sql:param value = "${file_name1}"/>

            <%
                }
            %>

            <%
            if (!admin_image_title.isMissing())
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
            if (!public_image_title.isMissing())
                {
            %>

                public_image_title,

            <%
                }
            %>

            <%
            if (!admin_image_title.isMissing())
                {
            %>

                admin_image_title,

            <%
                }
            %>

            lang_id ) values ( ?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?, ?,

            <%
            if (!public_image_title.isMissing())
                {
            %>

                ?,

            <%
                }
            %>

            <%
            if (!admin_image_title.isMissing())
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
            if (!public_image_title.isMissing())
                {
            %>

                <sql:param value = "${file_name1}"/>

            <%
                }
            %>

            <%
            if (!admin_image_title.isMissing())
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
