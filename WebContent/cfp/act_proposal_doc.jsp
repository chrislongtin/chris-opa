<%@ page import = "java.util.*"%>
<%@ page import = "java.io.File"%>
<%@ page import = "org.apache.commons.io.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.util.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "opa.*" %>
<%@ page import = "opa.model.*" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "actt">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${(actt=='delete') or (actt=='delete_unconfirmed')}">
        <c:set var = "act" value = "${actt}" scope = "page"/>

        <c:set var = "doc_id">
            <c:out value = "${param.doc_id}" default = ""/>
        </c:set>

        <c:set var = "proponent_password">
            <c:out value = "${param.proponent_password}" default = ""/>
        </c:set>

        <c:set var = "tracking_code">
            <c:out value = "${param.tracking_code}" default = ""/>
        </c:set>

        <c:if test = "${act=='delete_unconfirmed'}">
            <p>
            <br>
            <b>

            <fmt:message key = "569" />?</b>

            <table>
                <tr>
                    <td>
                        <form action = "index.jsp?fuseaction=act_proposal_doc"
                              method = "post">
                            <input type = "hidden" name = "tracking_code"
                            value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                            <input type = "hidden" name = "doc_id"
                            value = "<c:out value="${doc_id}" />"> <input type = "hidden"
                            name = "act" value = "delete">
                            <input type = "submit"
                            value = "<fmt:message key="570"  />">
                        </form>
                    </td>

                    <td>
                        <form action = "index.jsp?fuseaction=proposal_info"
                              method = "post">
                            <input type = "hidden" name = "tracking_code"
                            value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                            <input type = "submit"
                            value = "<fmt:message key="543"  />">
                        </form>
                    </td>
            </table>

            <%
            if (true)
                return;
            %>
        </c:if>

        <c:if test = "${act=='delete'}">
            <sql:update>
                delete from documents where doc_id = ?

                <sql:param value = "${doc_id}"/>
            </sql:update>

            <h3>

            <fmt:message key = "738" />!</h3>
        </c:if>
    </c:when>

    <c:otherwise>
<%
        InitiativeSetup setup  = 
            (InitiativeSetup)request.getSession().getAttribute("initiativeSetup");
        
        String uploadBaseDir = application.getRealPath(setup.getHost_doc_dir());
        
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(request);
        
        Map<String, String> requestParams = Utils.gatherStrings(items);
        Map<String, File> uploadedFiles = Utils.gatherFiles(items, uploadBaseDir);
        
        File proposal_doc = uploadedFiles.get("proposal_doc");
        if(proposal_doc != null)
            pageContext.setAttribute("file_name1", proposal_doc.getName());
%>

        <!--- process add document --->
        <%
        String doc_id = requestParams.get("doc_id");
        pageContext.setAttribute("doc_id", (doc_id == null) ? "1" : doc_id);
        pageContext.setAttribute("act", requestParams.get("act"));
        pageContext.setAttribute("tracking_code",
                                 requestParams.get("tracking_code"));
        pageContext.setAttribute("doc_title",
                                 requestParams.get("doc_title"));
        pageContext.setAttribute("doc_abstract",
                                 requestParams.get("doc_abstract"));
        pageContext.setAttribute("doc_type_id",
                                 requestParams.get("doc_type_id"));
        pageContext.setAttribute("proponent_password",
                                 requestParams.get("proponent_password"));
        pageContext.setAttribute("proposal_doc", 
                proposal_doc == null || !proposal_doc.exists() ? null : "proposal_doc");
        %>

        <% /*<!--- process public comment submission --->*/
        %>

        <c:if test = "${act=='add'}">

            <!--- add a new doc --->

            <sql:query var = "doc_num" maxRows = "1">
                select doc_id from documents order by doc_id desc
            </sql:query>

            <c:if test = "${!(empty doc_num.rows[0].doc_id)}">
                <c:set var = "doc_id" value = "${doc_num.rows[0].doc_id + 1}"
                       scope = "page"/>
            </c:if>

            <sql:update>
                insert into documents (doc_id, tracking_code, doc_title,

                <c:if test = "${!empty proposal_doc}">
                    doc_filename,
                </c:if>

                doc_date, doc_abstract, doc_type_id) values (?, ?, ?,

                <c:if test = "${!empty proposal_doc}">
                    ?,
                </c:if>

                CURDATE(), ?, ?)

                <sql:param value = "${doc_id}"/>

                <sql:param value = "${tracking_code}"/>

                <sql:param value = "${doc_title}"/>

                <c:if test = "${!empty proposal_doc}">
                    <sql:param value = "${file_name1}"/>
                </c:if>

                <sql:param value = "${doc_abstract}"/>

                <sql:param value = "${doc_type_id}"/>
            </sql:update>

            <h3>

            <fmt:message key = "735" />!</h3>
        </c:if>

        <c:if test = "${act=='edit'}">
            <sql:update>
                update documents set tracking_code = ?, doc_title = ?,

                <c:if test = "${!empty proposal_doc}">
                    doc_filename = ?,
                </c:if>

                doc_date = CURDATE(), doc_abstract = ?, doc_type_id = ? where
                doc_id = ?

                <sql:param value = "${tracking_code}"/>

                <sql:param value = "${doc_title}"/>

                <c:if test = "${!empty proposal_doc}">
                    <sql:param value = "${file_name1}"/>
                </c:if>

                <sql:param value = "${doc_abstract}"/>

                <sql:param value = "${doc_type_id}"/>

                <sql:param value = "${doc_id}"/>
            </sql:update>

            <h3>

            <fmt:message key = "736" />!</h3>
        </c:if>
    </c:otherwise>
</c:choose>

<p>
<table>
    <tr>
        <td>
            <form action = "index.jsp?fuseaction=proposal_info" method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                value = "<fmt:message key="739"  />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=cfp_proposal" method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "hidden" name = "act" value = "edit">
                <input type = "submit"
                value = "<fmt:message key="740"  />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=proposal_doc" method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                value = "<fmt:message key="741"  />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=proposal_researcher"
                  method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                value = "<fmt:message key="742"  />">
            </form>
        </td>
    </tr>
</table>
