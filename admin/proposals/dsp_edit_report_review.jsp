<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<center>
    <h3>

    <cf:GetPhrase phrase_id = "319" lang_id = "${lang}"/></h3>
</center>

<!--- Get the selected review --->

<c:set var = "report_review">
    <c:out value = "${report_review}" default = ""/>
</c:set>

<c:set var = "report_appraisal_id">
    <c:out value = "${report_appraisal_id}" default = ""/>
</c:set>

<sql:query var = "report_appraisal">
    select ra.*, d.doc_title, pr.proposal_title,d.doc_filename from
    report_appraisal ra, documents d, document_types dt, proponent_record pr
    where ra.reviewer_id = ? and ra.tracking_code = ? and d.doc_id = ra.doc_id
    and d.doc_type_id = dt.doc_type_id and ra.tracking_code = pr.tracking_code
    order by ra.report_appraisal_id

    <sql:param value = "${rid}"/>

    <sql:param value = "${param.tracking_code}"/>
</sql:query>

<c:forEach var = "row" items = "${report_appraisal.rows}">
    <c:set var = "report_appraisal_id" value = "${row.report_appraisal_id}"/>

    <c:set var = "report_review" value = "${row.report_comments}"/>

    <font face = "arial">

    <cf:GetPhrase phrase_id = "57"
                  lang_id = "${lang}"/>:</font><b>&nbsp;&nbsp;P-

    <c:out value = "${row.tracking_code}"/> </b>

    <br>
    <font face = "arial">

    <cf:GetPhrase phrase_id = "100"
                  lang_id = "${lang}"/>:</font><b>&nbsp;&nbsp;&nbsp;

    <c:out value = "${row.proposal_title}"/></b>

    <br>
    <font face = "arial">

    <cf:GetPhrase phrase_id = "114"
                  lang_id = "${lang}"/>:</font><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

    <c:out value = "${row.doc_title}"/></b>

    <br>
    <a STYLE = "text-decoration: underline"
       href = "../docs/<c:out value="${row.doc_filename}" />?ois=no"
       target = "new">

    <c:out value = "${row.doc_filename}"/></a>

    <form action = "<c:url value='index.jsp'>
     <c:param name='fuseaction' value='act_report_edit_review'/>
     </c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "chg">
        <input type = "hidden" name = "tracking_code"
        value = "<c:out value="${row.tracking_code}" />"> <input type = "hidden"
        name = "report_appraisal_id"
        value = "<c:out value="${row.report_appraisal_id}" />"> <input type = "hidden"
        name = "proposal_title"
        value = "<c:out value="${row.proposal_title}" />"> <input type = "hidden"
        name = "doc_title" value = "<c:out value="${row.doc_title}" />">

        <br>
        <textarea name = "report_review" cols = "60" rows = "15" wrap>
            <c:out value = "${report_review}"/>
        </textarea>

        <input type = "submit"
               value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
    </form>
</c:forEach>
