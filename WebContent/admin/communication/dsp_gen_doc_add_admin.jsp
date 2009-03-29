<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<h3>

<fmt:message key = "501" /></h3>

<%
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());

    pageContext.setAttribute("discuss_date", sqldate.toString());
%>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_gen_doc'/>
<c:param name='${user}'/>
</c:url>"
      method = "post"
      ENCTYPE = "multipart/form-data">
    <input type = "hidden" name = "discuss_date"
           value = "<c:out value='${discuss_date}'/>">

    <p>
    <b>

    <fmt:message key = "502" />:</b>
    <input type = "text" name = "doc_title">

    <p>
    <b>

    <fmt:message key = "504" />:</b>
    <input type = "file" name = "doc_filename" size = "40"> <h4>

    <fmt:message key = "503" /></h4> <b>

    <fmt:message key = "42" />:</b>
    <input type = "text" name = "discuss_subject" size = "40">

    <p>
    <b>

    <fmt:message key = "43" />:</b>
    <input type = "text" name = "discuss_author">

    <br>
    <b>

    <fmt:message key = "44" />:</b>
    <input type = "text" name = "discuss_email">

    <p>
    <b>

    <fmt:message key = "46" />:</b>

    <br>
    <textarea name = "discuss_message" cols = "60" rows = "15" wrap>
    </textarea>

    <input type = "submit"
           value = " <fmt:message key="456"  /> ">
</form>
