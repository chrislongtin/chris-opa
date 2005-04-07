<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

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

    Request myRequest = myUpload.getRequest();
    File doc_filename = myUpload.getFiles().getFile(0);
%>

<%
    pageContext.setAttribute("doc_filename", doc_filename.isMissing() ? null : "doc_filename");
    pageContext.setAttribute("act", myRequest.getParameter("act"));
    pageContext.setAttribute("contractor_id", myRequest.getParameter("contractor_id"));
    pageContext.setAttribute("agency_id", myRequest.getParameter("agency_id"));
    pageContext.setAttribute("cfp_code", myRequest.getParameter("cfp_code"));
    pageContext.setAttribute("cfp_cat_id", myRequest.getParameter("cfp_cat_id"));
    pageContext.setAttribute("delete_confirm", myRequest.getParameter("delete_confirm"));
    pageContext.setAttribute("redirect", "yes");
    pageContext.setAttribute("resume_file_name", myRequest.getParameter("doc_filename"));
    pageContext.setAttribute("contractor_firstname", myRequest.getParameter("contractor_firstname"));
    pageContext.setAttribute("contractor_lastname", myRequest.getParameter("contractor_lastname"));
    pageContext.setAttribute("contractor_login", myRequest.getParameter("contractor_login"));
    pageContext.setAttribute("contractor_password", myRequest.getParameter("contractor_password"));
    pageContext.setAttribute("contractor_email", myRequest.getParameter("contractor_email"));
    pageContext.setAttribute("contractor_phone", myRequest.getParameter("contractor_phone"));
    pageContext.setAttribute("contractor_fax", myRequest.getParameter("contractor_fax"));
    pageContext.setAttribute("contractor_address", myRequest.getParameter("contractor_address"));
    pageContext.setAttribute("contractor_profile", myRequest.getParameter("contractor_profile"));
    pageContext.setAttribute("skill_id", myRequest.getParameterValues("skill_id"));
%>

<%@ include file = "../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
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
        pageContext.setAttribute("resume_file_name", filename);
%>

<%
        }
%>

<!----------ADD CONTRACTOR ----------------->

<c:choose>
    <c:when test = "${act=='add'}">

        <!------------- ADD CONTRACTOR ----------------->
        <sql:query var = "contractor_num" maxRows = "1">
            select contractor_id from contractors order by contractor_id desc
        </sql:query>

        <c:choose>
            <c:when test = "${contractor_num.rowCount==0}">
                <c:set var = "contractor_id" value = "1" scope = "page"/>
            </c:when>

            <c:otherwise>
                <c:set var = "contractor_id" value = "${contractor_num.rows[0].contractor_id + 1}" scope = "page"/>
            </c:otherwise>
        </c:choose>

        <sql:update>
            insert into contractors ( contractor_id, contractor_firstname, contractor_lastname, contractor_login,
            contractor_password, contractor_email, contractor_phone,

            <c:if test = "${!empty contractor_fax}">
                contractor_fax,
            </c:if>

            <c:if test = "${!empty contractor_address}">
                contractor_address,
            </c:if>

            <c:if test = "${!empty contractor_profile}">
                contractor_profile,
            </c:if>

            <c:if test = "${!empty resume_file_name}">
                resume_file_name,
            </c:if>

            cfp_code, cfp_cat_id,agency_id) values ( ?, ?, ?, ?, ?, ?, ?,

            <c:if test = "${!empty contractor_fax}">
                ?,
            </c:if>

            <c:if test = "${!empty contractor_address}">
                ?,
            </c:if>

            <c:if test = "${!empty contractor_profile}">
                ?,
            </c:if>

            <c:if test = "${!empty resume_file_name}">
                ?,
            </c:if>

            ?, ?,?)

            <sql:param value = "${contractor_id}"/>

            <sql:param value = "${contractor_firstname}"/>

            <sql:param value = "${contractor_lastname}"/>

            <sql:param value = "${contractor_login}"/>

            <sql:param value = "${contractor_password}"/>

            <sql:param value = "${contractor_email}"/>

            <sql:param value = "${contractor_phone}"/>

            <c:if test = "${!empty contractor_fax}">
                <sql:param value = "${contractor_fax}"/>
            </c:if>

            <c:if test = "${!empty contractor_address}">
                <sql:param value = "${contractor_address}"/>
            </c:if>

            <c:if test = "${!empty contractor_profile}">
                <sql:param value = "${contractor_profile}"/>
            </c:if>

            <c:if test = "${!empty resume_file_name}">
                <sql:param value = "${resume_file_name}"/>
            </c:if>

            <sql:param value = "${cfp_code}"/>

            <sql:param value = "${cfp_cat_id}"/>

            <sql:param value = "${agency_id}"/>
        </sql:update>

        <sql:update>
            delete from contractor_skills where contractor_id = ?

            <sql:param value = "${contractor_id}"/>
        </sql:update>

        <c:forEach var = "aVal" items = "${skill_id}">
            <sql:update>
                insert into contractor_skills values (?,?)

                <sql:param value = "${contractor_id}"/>

                <sql:param value = "${aVal}"/>
            </sql:update>
        </c:forEach>

        </c:if>

        </c:forEach>
    </c:when>

    <c:when test = "${act=='edit'}">

        <!------------------------- EDIT REVIEWER ----------------------------->
        <sql:query var = "cfp_cat_check">
            select cfp_cat_id from cfp_category where cfp_code = ?

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <c:if test = "${cfp_cat_check.rowCount==0}">
            <c:set var = "cfp_cat_id" value = "0" scope = "page"/>
        </c:if>

        <sql:update>
            update contractors set contractor_lastname=?, contractor_firstname=?, contractor_login=?,
            contractor_password=?, contractor_email=?, contractor_phone=?,

            <c:if test = "${!empty contractor_fax}">
                contractor_fax=?,
            </c:if>

            <c:if test = "${!empty contractor_address}">
                contractor_address=?,
            </c:if>

            <c:if test = "${!empty contractor_profile}">
                contractor_profile=?,
            </c:if>

            <c:if test = "${!empty resume_file_name}">
                resume_file_name=?,
            </c:if>

            cfp_code = ?, cfp_cat_id = ?, agency_id = ? where contractor_id=?

            <sql:param value = "${contractor_lastname}"/>

            <sql:param value = "${contractor_firstname}"/>

            <sql:param value = "${contractor_login}"/>

            <sql:param value = "${contractor_password}"/>

            <sql:param value = "${contractor_email}"/>

            <sql:param value = "${contractor_phone}"/>

            <c:if test = "${!empty contractor_fax}">
                <sql:param value = "${contractor_fax}"/>
            </c:if>

            <c:if test = "${!empty contractor_address}">
                <sql:param value = "${contractor_address}"/>
            </c:if>

            <c:if test = "${!empty contractor_profile}">
                <sql:param value = "${contractor_profile}"/>
            </c:if>

            <c:if test = "${!empty resume_file_name}">
                <sql:param value = "${resume_file_name}"/>
            </c:if>

            <sql:param value = "${cfp_code}"/>

            <sql:param value = "${cfp_cat_id}"/>

            <sql:param value = "${agency_id}"/>

            <sql:param value = "${contractor_id}"/>
        </sql:update>

        <sql:update>
            delete from contractor_skills where contractor_id = ?

            <sql:param value = "${contractor_id}"/>
        </sql:update>

        <c:forEach var = "aVal" items = "${skill_id}">
            <sql:update>
                insert into contractor_skills values (?,?)

                <sql:param value = "${contractor_id}"/>

                <sql:param value = "${aVal}"/>
            </sql:update>
        </c:forEach>
    </c:when>
</c:choose>

<c:import url = "default.jsp"/>