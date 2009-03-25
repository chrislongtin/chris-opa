<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- add language item --->

<h3>

<cf:GetPhrase phrase_id = "229" lang_id = "${lang}"/>:</h3>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_add_lang'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <cf:GetPhrase phrase_id = "206" lang_id = "${lang}"/>

    : <input type = "text" name = "language" size = "40">

    <br>
    (

    <cf:GetPhrase phrase_id = "230" lang_id = "${lang}"/>,

    <cf:GetPhrase phrase_id = "556" lang_id = "${lang}"/>)

    <br>
    <input type = "submit"
           value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
