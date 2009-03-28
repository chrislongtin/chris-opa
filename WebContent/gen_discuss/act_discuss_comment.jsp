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
    String discuss_date   = requestParams.get("discuss_date");
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());
    pageContext.setAttribute("discuss_date", (discuss_date == null)
                                                 ? sqldate.toString()
                                                 : discuss_date);
    String discussion_id = requestParams.get("discussion_id");
    pageContext.setAttribute("discussion_id", (discussion_id == null)
                                                  ? "1" : discussion_id);

    pageContext.setAttribute("discuss_author",
                             requestParams.get("discuss_author"));
    pageContext.setAttribute("discuss_attachment",
                             (discuss_attachment == null || !discuss_attachment.exists())
                                 ? null : "discuss_attachment");
    pageContext.setAttribute("discuss_email",
                             requestParams.get("discuss_email"));
    pageContext.setAttribute("doc_id", requestParams.get("doc_id"));
    pageContext.setAttribute("discuss_level",
                             requestParams.get("discuss_level"));
    pageContext.setAttribute("discuss_parent",
                             requestParams.get("discuss_parent"));
    pageContext.setAttribute("discuss_subject",
                             requestParams.get("discuss_subject"));
    pageContext.setAttribute("discuss_message",
                             requestParams.get("discuss_message"));
%>

<sql:query var = "discuss_num" maxRows = "1">
    select discussion_id from discussion order by discussion_id desc
</sql:query>

<c:forEach var = "row" items = "${discuss_num.rows}">
    <c:set var = "discussion_id" value = "${row.discussion_id + 1}"/>
</c:forEach>

<sql:update var = "message_add">
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

<c:if test = "${discuss_parent != 0}">
    <sql:query var = "renum_replies">
        select discuss_replies, discussion_id from discussion where
        discussion_id = ?

        <sql:param value = "${discuss_parent}"/>
    </sql:query>

    <c:set var = "discuss_replies"
           value = "${renum_replies.rows[0].discuss_replies + 1}"/>

    <sql:update var = "addnum_replies">
        update discussion set discuss_replies = ? where discussion_id = ?

        <sql:param value = "${discuss_replies}"/>

        <sql:param value = "${discuss_parent}"/>
    </sql:update>
</c:if>

<% /*<c:redirect url="/opav/index.jsp?fuseaction=discuss_comment"/>*/
%>

<c:import url = "gen_discuss/dsp_discuss_comment.jsp"/>
