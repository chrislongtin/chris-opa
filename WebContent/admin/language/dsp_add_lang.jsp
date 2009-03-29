<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- add language item --->

<h3>

<fmt:message key = "229" />:</h3>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_add_lang'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <fmt:message key = "206" />

    : <input type = "text" name = "language" size = "40">

    <br>
    (

    <fmt:message key = "230" />,

    <fmt:message key = "556" />)

    <br>
    <input type = "submit"
           value = " <fmt:message key="456"  /> ">
</form>
