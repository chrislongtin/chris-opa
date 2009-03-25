<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "actt">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<!--- process document add, edit, delete --->

<c:choose>
    <c:when test = "${(actt=='delete') or (actt=='delete_unconfirmed')}">

        <!--------------------------- DELETE DOCUMENT ------------------------>

        <c:set var = "act" value = "${actt}" scope = "page"/>

        <c:set var = "doc_id">
            <c:out value = "${param.doc_id}" default = ""/>
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
                        <form action = "index.jsp?fuseaction=act_report_doc"
                              method = "post">
                            <input type = "hidden" name = "tracking_code"
                            value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "doc_id" value = "<c:out value="${doc_id}" />">
                            <input type = "hidden" name = "act" value = "delete">
                            <input type = "submit"
                            value = "<cf:GetPhrase phrase_id="570" lang_id="${lang}" />">
                        </form>
                    </td>

                    <td>
                        <form action = "index.jsp?fuseaction=report_info"
                              method = "post">
                            <input type = "hidden" name = "tracking_code"
                            value = "<c:out value="${tracking_code}" />"> <input type = "submit"
                            value = "<cf:GetPhrase phrase_id="543" lang_id="${lang}" />">
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
        </c:if>
    </c:when>

    <c:otherwise>
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

        Request myRequest = myUpload.getRequest();
        File doc_filename = myUpload.getFiles().getFile(0);
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

        <!--- process add document --->
        <%
        String doc_id = myRequest.getParameter("doc_id");
        pageContext.setAttribute("doc_id", (doc_id == null) ? "1" : doc_id);
        pageContext.setAttribute("act", myRequest.getParameter("act"));
        pageContext.setAttribute("tracking_code",
                                 myRequest.getParameter("tracking_code"));
        pageContext.setAttribute("doc_title",
                                 myRequest.getParameter("doc_title"));
        pageContext.setAttribute("doc_abstract",
                                 myRequest.getParameter("doc_abstract"));
        pageContext.setAttribute("doc_type_id",
                                 myRequest.getParameter("doc_type_id"));
        pageContext.setAttribute("doc_filename", doc_filename.isMissing() ? null
                                                     : "doc_filename");
        %>

        <% /*<!--- process public comment submission --->*/
        %>

        <c:if test = "${empty doc_type_id}">
            <c:set var = "doc_type_id" value = "0" scope = "page"/>
        </c:if>

        <sql:query var = "doc_dir_find">
            select host_doc_dir from initiative_setup
        </sql:query>

        <c:set var = "host_doc_dir"
               value = "${doc_dir_find.rows[0].host_doc_dir}"/>

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

                filename
                    = filename.replaceFirst("\\.(?=[^.]+$)", "[" + i + "].");

                f = new java.io.File(path, filename);
                }

            doc_filename.saveAs(f.getPath());
            pageContext.setAttribute("file_name1", filename);
        %>

        <%
            }
        %>

        <!--------------------------- ADD Report ------------------------>

        <c:if test = "${act=='add'}">

            <!--------------------------- De-Activate Older Reports ------------------------>

            <sql:query var = "reports_to_deactivate">
                select d.doc_id from documents d, document_types dt where
                d.tracking_code = ? and d.doc_type_id<> 0
and d.doc_type_id = dt.doc_type_id and
dt.doc_type_category = 'R'
<sql:param value="${tracking_code}" /> 
</sql:query>
<c:if test="${reports_to_deactivate.rowCount!=0}" >
	 <c:forEach items="${reports_to_deactivate.rows}" var="row">
	 <sql:update var="deact">
	     update documents
	     set doc_type_id = 0
	     where doc_id = ?
	 <sql:param value="${row.doc_id}" />
	 </sql:update>
     </c:forEach>
</c:if>
<sql:update var="deactrev">
	       update reviewer_assignment
	       set report_review_completed = 0
	       where
		   tracking_code = ?
		   <sql:param value="${tracking_code}" />
</sql:update>
  	
<!--- add a new doc --->


<sql:query var="doc_num">
select doc_id
from documents
order by doc_id desc
</sql:query>

<c:if test="${doc_num.rowCount!=0}" >
	<c:set var="doc_id" value="${doc_num.rows[0].doc_id + 1}" scope="page" />
</c:if>

<sql:update>
insert into documents
(doc_id, tracking_code, doc_title, 
<c:if test="${!empty doc_filename}" >
	doc_filename,
</c:if>
doc_date, doc_abstract, doc_type_id)
values
(?, ?, ?, 
<c:if test="${!empty doc_filename}" >
	?,
</c:if>
CURDATE(), ?, ?)
	<sql:param value="${doc_id}" />
  <sql:param value="${tracking_code}" />
  <sql:param value="${doc_title}" />
  <c:if test="${!empty doc_filename}" >
	  <sql:param value="${file_name1}" />
  </c:if>
  <sql:param value="${doc_abstract}" />
  <sql:param value="${doc_type_id}" />
</sql:update>

</c:if>

<!--------------------------- EDIT DOCUMENT ------------------------>
<c:if test="${act=='edit'}" >

<sql:update>
update documents
set tracking_code = ?,
	doc_title = ?,
  <c:if test="${!empty doc_filename}" >
  	doc_filename = ?,
  </c:if>
	doc_date = CURDATE(),
	doc_abstract = ?,
	doc_type_id = ?
where doc_id = ?
  <sql:param value="${tracking_code}" />
  <sql:param value="${doc_title}" />
  <c:if test="${!empty doc_filename}" >
	  <sql:param value="${file_name1}" />
  </c:if>
  <sql:param value="${doc_abstract}" />
  <sql:param value="${doc_type_id}" />
	<sql:param value="${doc_id}" />	
</sql:update>	

</c:if>



	
	</c:otherwise>
</c:choose>


<c:import url="proposals/dsp_report_main.jsp">
  <c:param name="tracking_code" value="${tracking_code}"/>
</c:import>






