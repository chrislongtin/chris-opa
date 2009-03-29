<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<center>
    <h3>

    <fmt:message key = "319" /></h3>
</center>

<sql:query var = "report_appraisal">
    select ra.*,concat(r.reviewer_firstname,' ',r.reviewer_lastname) as
    reviewer_name, d.doc_title,d.doc_filename,pr.proposal_title from
    report_appraisal ra, reviewers r,documents d , proponent_record pr where
    ra.tracking_code = ? and ra.reviewer_id = r.reviewer_id and
    d.tracking_code = ra.tracking_code and d.doc_id = ra.doc_id and
    pr.tracking_code = ra.tracking_code order by ra.report_appraisal_id

    <sql:param value = "${param.tracking_code}"/>
</sql:query>

<c:if test = "${report_appraisal.rowCount==0}">
    <fmt:message key = "676" />
</c:if>

<br>
<c:forEach var = "row" items = "${report_appraisal.rows}">
    <font face = "arial">

    <fmt:message key = "57"
                  />:</font><b>&nbsp;&nbsp;P-

    <c:out value = "${row.tracking_code}"/></b>

    <br>
    <font face = "arial">

    <fmt:message key = "100"
                  />:</font><b>&nbsp;&nbsp;&nbsp;&nbsp;

    <c:out value = "${row.proposal_title}"/></b>

    <br>
    <font face = "arial">

    <fmt:message key = "114"
                  />:</font><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

    <c:out value = "${row.doc_title}"/></b>

    <br>
    <a STYLE = "text-decoration: underline"
       href = "../docs/<c:out value="${row.doc_filename}" />?ois=no"
       target = "new">

    <c:out value = "${row.doc_filename}"/></a>

    <br>
    <br>
    <font face = "arial" size = "+1">

    <fmt:message key = "437"
                  />:</font><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

    <c:out value = "${row.reviewer_name}"/> </b>

    <br>
    <form action = "<c:url value='index.jsp'>
        <c:param name='fuseaction' value='proposal_list'/>
        </c:url>"
          method = "post">
        <input type = "hidden" name = "tracking_code" value = "">
        <input type = "hidden" name = "report_appraisal_id"
        value = "<c:out value="${row.report_appraisal_id}" />"> <input type = "hidden"
        name = "proposal_title"
        value = "<c:out value="${row.proposal_title}" />"> <input type = "hidden"
        name = "doc_title" value = "<c:out value="${row.doc_title}" />">

        <br>
        <textarea name = "report_review" cols = "60" rows = "15" wrap>
            <c:out value = "${row.report_comments}"/>
        </textarea>

        <input type = "submit"
               value = " <fmt:message key="943"  /> ">
    </form>
</c:forEach>
