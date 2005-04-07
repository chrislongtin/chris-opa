<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
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

            <cf:GetPhrase phrase_id = "569" lang_id = "${lang}"/>?</b>

            <table>
                <tr>
                    <td>
                        <form action = "index.jsp?fuseaction=act_proposal_doc" method = "post">
                            <input type = "hidden"
                                   name = "tracking_code"
                                   value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                                   name = "proponent_password"
                                   value = "<c:out value="${proponent_password}" />">
                            <input type = "hidden" name = "doc_id" value = "<c:out value="${doc_id}" />">
                            <input type = "hidden" name = "act" value = "delete">
                            <input type = "submit" value = "<cf:GetPhrase phrase_id="570" lang_id="${lang}" />">
                        </form>
                    </td>

                    <td>
                        <form action = "index.jsp?fuseaction=proposal_info" method = "post">
                            <input type = "hidden"
                                   name = "tracking_code"
                                   value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                                   name = "proponent_password"
                                   value = "<c:out value="${proponent_password}" />">
                            <input type = "submit" value = "<cf:GetPhrase phrase_id="543" lang_id="${lang}" />">
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

            <cf:GetPhrase phrase_id = "738" lang_id = "${lang}"/>!</h3>
        </c:if>
    </c:when>

    <c:otherwise>
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
        File proposal_doc = myUpload.getFiles().getFile(0);
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

<!--- process add document --->
<%
        String doc_id = myRequest.getParameter("doc_id");
        pageContext.setAttribute("doc_id", (doc_id == null) ? "1" : doc_id);
        pageContext.setAttribute("act", myRequest.getParameter("act"));
        pageContext.setAttribute("tracking_code", myRequest.getParameter("tracking_code"));
        pageContext.setAttribute("doc_title", myRequest.getParameter("doc_title"));
        pageContext.setAttribute("doc_abstract", myRequest.getParameter("doc_abstract"));
        pageContext.setAttribute("doc_type_id", myRequest.getParameter("doc_type_id"));
        pageContext.setAttribute("proponent_password", myRequest.getParameter("proponent_password"));
        pageContext.setAttribute("proposal_doc", proposal_doc.isMissing() ? null : "proposal_doc");
%>

<% /*<!--- process public comment submission --->*/
%>

        <sql:query var = "doc_dir_find">
            select host_doc_dir from initiative_setup
        </sql:query>

        <c:set var = "host_doc_dir" value = "${doc_dir_find.rows[0].host_doc_dir}"/>

<%
        if (!proposal_doc.isMissing())
            {
%>

            <c:set var = "DOCS_DIR" value = "${host_doc_dir}"/>

<%
            String path = (String)pageContext.getAttribute("DOCS_DIR");
            path = application.getRealPath(path);

            String filename = proposal_doc.getFileName().replaceAll("\\s", "");

            java.io.File f = new java.io.File(path, filename);

            // ensure uniqueness
            for (int i = 1; f.exists(); i++)
                {
                if (filename.matches(".*\\[\\d+\\]\\..*"))
                    filename = filename.replaceFirst("\\[\\d+\\]\\.", ".");

                filename = filename.replaceFirst("\\.(?=[^.]+$)", "[" + i + "].");

                f = new java.io.File(path, filename);
                }

            proposal_doc.saveAs(f.getPath());
            pageContext.setAttribute("file_name1", filename);
%>

<%
            }
%>

        <c:if test = "${act=='add'}">

            <!--- add a new doc --->

            <sql:query var = "doc_num" maxRows = "1">
                select doc_id from documents order by doc_id desc
            </sql:query>

            <c:if test = "${!(empty doc_num.rows[0].doc_id)}">
                <c:set var = "doc_id" value = "${doc_num.rows[0].doc_id + 1}" scope = "page"/>
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

            <cf:GetPhrase phrase_id = "735" lang_id = "${lang}"/>!</h3>
        </c:if>

        <c:if test = "${act=='edit'}">
            <sql:update>
                update documents set tracking_code = ?, doc_title = ?,

                <c:if test = "${!empty proposal_doc}">
                    doc_filename = ?,
                </c:if>

                doc_date = CURDATE(), doc_abstract = ?, doc_type_id = ? where doc_id = ?

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

            <cf:GetPhrase phrase_id = "736" lang_id = "${lang}"/>!</h3>
        </c:if>
    </c:otherwise>
</c:choose>

<p>
<table>
    <tr>
        <td>
            <form action = "index.jsp?fuseaction=proposal_info" method = "post">
                <input type = "hidden" name = "tracking_code" value = "<c:out value="${tracking_code}" />">
                <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                <input type = "submit" value = "<cf:GetPhrase phrase_id="739" lang_id="${lang}" />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=cfp_proposal" method = "post">
                <input type = "hidden" name = "tracking_code" value = "<c:out value="${tracking_code}" />">
                <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                <input type = "hidden" name = "act" value = "edit">
                <input type = "submit" value = "<cf:GetPhrase phrase_id="740" lang_id="${lang}" />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=proposal_doc" method = "post">
                <input type = "hidden" name = "tracking_code" value = "<c:out value="${tracking_code}" />">
                <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                <input type = "submit" value = "<cf:GetPhrase phrase_id="741" lang_id="${lang}" />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=proposal_researcher" method = "post">
                <input type = "hidden" name = "tracking_code" value = "<c:out value="${tracking_code}" />">
                <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                <input type = "submit" value = "<cf:GetPhrase phrase_id="742" lang_id="${lang}" />">
            </form>
        </td>
    </tr>
</table>
