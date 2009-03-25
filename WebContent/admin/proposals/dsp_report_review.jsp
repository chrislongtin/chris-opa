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

<font face = "arial" size = "+1">

<cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:</font>

<c:out value = "${param.tracking_code}"/>

<br>
<font face = "arial" size = "+1">

<cf:GetPhrase phrase_id = "100" lang_id = "${lang}"/>:</font>

<c:out value = "${param.proposal_title}"/>

<br>
<font face = "arial" size = "+1">

<cf:GetPhrase phrase_id = "114" lang_id = "${lang}"/>:</font>

<c:out value = "${param.doc_title}"/>

<br>
<font face = "arial" size = "+1">

<cf:GetPhrase phrase_id = "319" lang_id = "${lang}"/>

:

<br>
<a STYLE = "text-decoration: underline"
   href = "../docs/<c:out value="${param.doc_filename}" />?ois=no"
   target = "new">

<c:out value = "${param.doc_filename}"/></a>
<c:if test = "${param.act == 'add'}">
    <form action = "<c:url value='index.jsp'>
     <c:param name='fuseaction' value='act_report_review'/>
     </c:url>"
          method = "post">
        <input type = "hidden" name = "act" value = "add">
        <input type = "hidden" name = "tracking_code"
        value = "<c:out value="${param.tracking_code}" />"> <input type = "hidden"
        name = "doc_id" value = "<c:out value="${param.doc_id}" />">
        <input type = "hidden" name = "proposal_title"
        value = "<c:out value="${param.proposal_title}" />"> <input type = "hidden"
        name = "doc_title" value = "<c:out value="${param.doc_title}" />">

        <br>
        <textarea name = "report_review" cols = "60" rows = "15" wrap>
        </textarea>

        <input type = "submit"
               value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
    </form>
</c:if>
