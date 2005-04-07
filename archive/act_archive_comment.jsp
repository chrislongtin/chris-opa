<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- process public comment submission --->

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

    Request myRequest       = myUpload.getRequest();
    File discuss_attachment = myUpload.getFiles().getFile(0);
%>

<%@ include file = "../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(myRequest);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<% /*<!--- process public comment submission --->*/
%>

<sql:query var = "doc_dir_find">
    select host_doc_dir from initiative_setup
</sql:query>

<c:set var = "host_doc_dir" value = "${doc_dir_find.rows[0].host_doc_dir}"/>

<%
    if (!discuss_attachment.isMissing())
        {
%>

        <c:set var = "DOCS_DIR" value = "${host_doc_dir}"/>

<%
        String path = (String)pageContext.getAttribute("DOCS_DIR");
        path = application.getRealPath(path);

        String filename = discuss_attachment.getFileName().replaceAll("\\s", "");

        java.io.File f = new java.io.File(path, filename);

        // ensure uniqueness
        for (int i = 1; f.exists(); i++)
            {
            if (filename.matches(".*\\[\\d+\\]\\..*"))
                filename = filename.replaceFirst("\\[\\d+\\]\\.", ".");

            filename = filename.replaceFirst("\\.(?=[^.]+$)", "[" + i + "].");

            f = new java.io.File(path, filename);
            }

        discuss_attachment.saveAs(f.getPath());
        pageContext.setAttribute("file_name1", filename);
%>

<%
        }
%>

<%
    pageContext.setAttribute("discuss_attachment", discuss_attachment.isMissing() ? null : "discuss_attachment");
    pageContext.setAttribute("discuss_author", myRequest.getParameter("discuss_author"));
    pageContext.setAttribute("doc_id", myRequest.getParameter("doc_id"));
    pageContext.setAttribute("discuss_level", myRequest.getParameter("discuss_level"));
    pageContext.setAttribute("discuss_parent", myRequest.getParameter("discuss_parent"));
    pageContext.setAttribute("discuss_subject", myRequest.getParameter("discuss_subject"));
    pageContext.setAttribute("discuss_message", myRequest.getParameter("discuss_message"));
    pageContext.setAttribute("discuss_author", myRequest.getParameter("discuss_author"));
    pageContext.setAttribute("discuss_email", myRequest.getParameter("discuss_email"));
%>
<!--- retrieving next discussion identifier number --->

<sql:query var = "discuss_num">
    select discussion_id from discussion order by discussion_id desc
</sql:query>

<c:set var = "discussion_id" value = "${discuss_num.rows[0].discussion_id + 1}" scope = "page"/>

<!--- adding the message to the database --->
<sql:update>
    insert into discussion (discussion_id, doc_id, discuss_level, discuss_parent, discuss_subject, discuss_date,
    discuss_message

    <c:if test = "${!empty discuss_author}">
        , discuss_author
    </c:if>

    <c:if test = "${!empty discuss_attachment}">
        , discuss_attachment
    </c:if>

    <c:if test = "${!empty discuss_email}">
        , discuss_email
    </c:if>

    , discuss_replies) values (?, ?, ?, ?, ?, CURDATE(), ?

    <c:if test = "${!empty discuss_author}">
        , ?
    </c:if>

    <c:if test = "${!empty discuss_attachment}">
        , ?
    </c:if>

    <c:if test = "${!empty discuss_email}">
        , ?
    </c:if>

    , 0)

    <sql:param value = "${discussion_id}"/>

    <sql:param value = "${doc_id}"/>

    <sql:param value = "${discuss_level}"/>

    <sql:param value = "${discuss_parent}"/>

    <sql:param value = "${discuss_subject}"/>

    <sql:param value = "${discuss_message}"/>

    <c:if test = "${!empty discuss_author}">
        <sql:param value = "${discuss_author}"/>
    </c:if>

    <c:if test = "${!empty discuss_attachment}">
        <sql:param value = "${file_name1}"/>
    </c:if>

    <c:if test = "${!empty discuss_email}">
        <sql:param value = "${discuss_email}"/>
    </c:if>
</sql:update>

<!--- if the message is a reply --->
<c:if test = "${discuss_parent!=0}">

    <!--- recalculate the number of replies to the original message --->
    <sql:query var = "renum_replies">
        select discuss_replies, discussion_id from discussion where discussion_id = ?

        <sql:param value = "${discuss_parent}"/>
    </sql:query>

    <c:set var = "discuss_replies" value = "${renum_replies.rows[0].discuss_replies + 1}" scope = "page"/>

    <!--- update the number of replies count --->
    <sql:update>
        update discussion set discuss_replies = ? where discussion_id = ?

        <sql:param value = "${discuss_replies}"/>

        <sql:param value = "${discuss_parent}"/>
    </sql:update>
</c:if>

<!--- redirect the user to the main archive page --->
<c:import url = "archive/dsp_archive_comment.jsp">
    <c:param name = "doc_id" value = "${doc_id}"/>
</c:import>
