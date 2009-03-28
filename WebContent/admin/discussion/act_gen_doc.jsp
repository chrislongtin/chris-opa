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
    
    File doc_filename = uploadedFiles.get("doc_filename");
    if(doc_filename != null)
        pageContext.setAttribute("file_name1", doc_filename.getName());
%>

<%
    pageContext.setAttribute("doc_id", requestParams.get("doc_id"));
    pageContext.setAttribute("doc_title", requestParams.get("doc_title"));
    pageContext.setAttribute("discussion_id",
                             requestParams.get("discussion_id"));
    pageContext.setAttribute("discuss_level",
                             requestParams.get("discuss_level"));
    pageContext.setAttribute("discuss_parent",
                             requestParams.get("discuss_parent"));
    pageContext.setAttribute("discuss_author",
                             requestParams.get("discuss_author"));
    pageContext.setAttribute("discuss_email",
                             requestParams.get("discuss_email"));
    pageContext.setAttribute("discuss_subject",
                             requestParams.get("discuss_subject"));
    pageContext.setAttribute("discuss_date",
                             requestParams.get("discuss_date"));
    pageContext.setAttribute("discuss_message",
                             requestParams.get("discuss_message"));
%>

<!--- add a document for general discussion --->

<sql:query var = "doc_num" maxRows = "1">
    select doc_id from admin_documents order by doc_id desc
</sql:query>

<c:set var = "doc_id">
    <c:out value = "${doc_id}" default = "1"/>
</c:set>

<c:forEach var = "row" items = "${doc_num.rows}">
    <c:set var = "doc_id" value = "${row.doc_id + 1}"/>
</c:forEach>

<%
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());
    pageContext.setAttribute("doc_date", sqldate.toString());
%>

<sql:update var = "doc_add">
    insert into admin_documents (doc_id, tracking_code, doc_type_id,
    doc_title, doc_filename, doc_date) values ( ?, 0, 0, ?, ?, ? )

    <sql:param value = "${doc_id}"/>

    <sql:param value = "${doc_title}"/>

    <sql:param value = "${file_name1}"/>

    <sql:param value = "${doc_date}"/>
</sql:update>

<c:if test = "${!empty discuss_message}">
    <!--- discuss msg --->
    <sql:query var = "discuss_num" maxRows = "1">
        select discussion_id from admin_discussion order by discussion_id desc
    </sql:query>

    <c:set var = "discussion_id">
        <c:out value = "${discussion_id}" default = "1"/>
    </c:set>

    <c:forEach var = "row" items = "${discuss_num.rows}">
        <c:set var = "discussion_id" value = "${row.discussion_id + 1}"/>
    </c:forEach>

    <c:set var = "discuss_level">
        <c:out value = "${discuss_level}" default = "1"/>
    </c:set>

    <c:set var = "discuss_parent">
        <c:out value = "${discuss_parent}" default = "0"/>
    </c:set>

    <sql:update var = "message_add">
        insert into admin_discussion (discussion_id, doc_id, discuss_level,
        discuss_parent, discuss_subject, discuss_date, discuss_message

        <c:if test = "${!empty discuss_author}">
            , discuss_author
        </c:if>

        <c:if test = "${!empty discuss_email}">
            , discuss_email
        </c:if>

        , discuss_replies) values ( ?, ?, ?, ?, ?, ?, ?

        <c:if test = "${!empty discuss_author}">
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

        <sql:param value = "${discuss_date}"/>

        <sql:param value = "${discuss_message}"/>

        <c:if test = "${!empty discuss_author}">
            <sql:param value = "${discuss_author}"/>
        </c:if>

        <c:if test = "${!empty discuss_email}">
            <sql:param value = "${discuss_email}"/>
        </c:if>
    </sql:update>
</c:if>

<c:import url = "communication/dsp_comm_main.jsp?fuseaction=comm_main&${user}"/>
