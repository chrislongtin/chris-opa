<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<h3>

<cf:GetPhrase phrase_id = "501" lang_id = "${lang}"/></h3>

<%
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());

    pageContext.setAttribute("discuss_date", sqldate.toString());
%>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_gen_doc'/>
<c:param name='${user}'/>
</c:url>" method = "post"
      ENCTYPE = "multipart/form-data">
    <input type = "hidden" name = "discuss_date" value = "<c:out value='${discuss_date}'/>">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "502" lang_id = "${lang}"/>:</b> <input type = "text" name = "doc_title">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "504" lang_id = "${lang}"/>:</b> <input type = "file" name = "doc_filename" size = "40">
    <h4>

    <cf:GetPhrase phrase_id = "503" lang_id = "${lang}"/></h4> <b>

    <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:</b> <input type = "text" name = "discuss_subject" size = "40">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "43" lang_id = "${lang}"/>:</b> <input type = "text" name = "discuss_author">

    <br>
    <b>

    <cf:GetPhrase phrase_id = "44" lang_id = "${lang}"/>:</b> <input type = "text" name = "discuss_email">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:</b>

    <br>
    <textarea name = "discuss_message" cols = "60" rows = "15" wrap>
    </textarea>

    <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
