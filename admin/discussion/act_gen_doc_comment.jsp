<%@ page errorPage = "../dsp_error.jsp"%>

<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

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

<!--- process public comment submission --->

<%@ include file = "../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(myRequest);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<!--- identify the host document directory --->

<sql:query var = "doc_dir_find">
    select host_doc_dir from initiative_setup
</sql:query>

<c:set var = "host_doc_dir" value = "${doc_dir_find.rows[0].host_doc_dir}"/>

<!--- uploading document attachment to the server --->

<%@ include file = "../../file_upload.jsp"%>

<%
    FileUpload upload = new FileUpload();

    if (!discuss_attachment.isMissing())
        {
        String path     = (String)pageContext.getAttribute("host_doc_dir");
        String filename = upload.saveFile(discuss_attachment, path, application);
        pageContext.setAttribute("file_name1", filename);
        }
%>

<%
    String discuss_date   = myRequest.getParameter("discuss_date");
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());
    pageContext.setAttribute("discuss_date", (discuss_date == null) ? sqldate.toString() : discuss_date);
    String discussion_id = myRequest.getParameter("discussion_id");
    pageContext.setAttribute("discussion_id", (discussion_id == null) ? "1" : discussion_id);

    pageContext.setAttribute("discuss_author", myRequest.getParameter("discuss_author"));
    pageContext.setAttribute("discuss_attachment", discuss_attachment.isMissing() ? null : "discuss_attachment");
    pageContext.setAttribute("discuss_email", myRequest.getParameter("discuss_email"));
    pageContext.setAttribute("doc_id", myRequest.getParameter("doc_id"));
    pageContext.setAttribute("discuss_level", myRequest.getParameter("discuss_level"));
    pageContext.setAttribute("discuss_parent", myRequest.getParameter("discuss_parent"));
    pageContext.setAttribute("discuss_subject", myRequest.getParameter("discuss_subject"));
    pageContext.setAttribute("discuss_message", myRequest.getParameter("discuss_message"));
%>

<!--- retrieving next discussion identifier number --->

<sql:query var = "discuss_num" maxRows = "1">
    select discussion_id from admin_discussion order by discussion_id desc
</sql:query>

<c:forEach var = "row" items = "${discuss_num.rows}">
    <c:set var = "discussion_id" value = "${row.discussion_id + 1}"/>
</c:forEach>

<!--- adding the message to the database --->
<sql:update var = "message_add">
    insert into admin_discussion (discussion_id, doc_id, discuss_level, discuss_parent, discuss_subject, discuss_date,
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

    , discuss_replies ) values ( ?, ?, ?, ?, ?, ?, ?

    <c:if test = "${!empty discuss_author}">
        , ?
    </c:if>

    <c:if test = "${!empty discuss_attachment}">
        , ?
    </c:if>

    <c:if test = "${!empty discuss_email}">
        , ?
    </c:if>

    , 0 )

    <sql:param value = "${discussion_id}"/>

    <sql:param value = "${doc_id}"/>

    <sql:param value = "${discuss_level}"/>

    <sql:param value = "${discuss_parent}"/>

    <sql:param value = "${discuss_subject}"/>

    <sql:param value = "${discuss_date}"/>

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
<c:if test = "${discuss_parent != 0}">

    <!--- recalculate the number of replies to the original message --->
    <sql:query var = "renum_replies">
        select discuss_replies, discussion_id from admin_discussion where discussion_id = ?

        <sql:param value = "${discuss_parent}"/>
    </sql:query>

    <c:set var = "discuss_replies" value = "${renum_replies.rows[0].discuss_replies + 1}"/>

    <!--- update the number of replies count --->
    <sql:update var = "addnum_replies">
        update admin_discussion set discuss_replies = ? where discussion_id = ?

        <sql:param value = "${discuss_replies}"/>

        <sql:param value = "${discuss_parent}"/>
    </sql:update>
</c:if>

<!--- redirect the user to the main archive page --->
<c:import url = "discussion/dsp_gen_doc_comment.jsp?fuseaction=gen_doc_comment&doc_id=${doc_id}"/>
