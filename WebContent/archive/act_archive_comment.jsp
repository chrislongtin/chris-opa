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

    File discuss_attachment = uploadedFiles.get("discuss_attachment");
    if(discuss_attachment != null)
        pageContext.setAttribute("file_name1", discuss_attachment.getName());
%>

<%@ include file = "../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(requestParams);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<% /*<!--- process public comment submission --->*/
%>

<%
    pageContext.setAttribute("discuss_attachment",
                             (discuss_attachment == null || !discuss_attachment.exists())
                                 ? null : "discuss_attachment");
    pageContext.setAttribute("discuss_author",
                             requestParams.get("discuss_author"));
    pageContext.setAttribute("doc_id", requestParams.get("doc_id"));
    pageContext.setAttribute("discuss_level",
                             requestParams.get("discuss_level"));
    pageContext.setAttribute("discuss_parent",
                             requestParams.get("discuss_parent"));
    pageContext.setAttribute("discuss_subject",
                             requestParams.get("discuss_subject"));
    pageContext.setAttribute("discuss_message",
                             requestParams.get("discuss_message"));
    pageContext.setAttribute("discuss_author",
                             requestParams.get("discuss_author"));
    pageContext.setAttribute("discuss_email",
                             requestParams.get("discuss_email"));
%>
<!--- retrieving next discussion identifier number --->

<sql:query var = "discuss_num">
    select discussion_id from discussion order by discussion_id desc
</sql:query>

<c:set var = "discussion_id" value = "${discuss_num.rows[0].discussion_id + 1}"
       scope = "page"/>

<!--- adding the message to the database --->
<sql:update>
    insert into discussion (discussion_id, doc_id, discuss_level,
    discuss_parent, discuss_subject, discuss_date, discuss_message

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
        select discuss_replies, discussion_id from discussion where
        discussion_id = ?

        <sql:param value = "${discuss_parent}"/>
    </sql:query>

    <c:set var = "discuss_replies"
           value = "${renum_replies.rows[0].discuss_replies + 1}"
           scope = "page"/>

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
