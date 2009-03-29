<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib uri = "http://jakarta.apache.org/taglibs/mailer-1.1" prefix = "mt"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ taglib prefix = "sm" uri = "http://www.servletsuite.com/servlets/sendmail"%>
<%@ page errorPage = "dsp_error.jsp"%>


<%@include  file ="../taglibs_declarations.jsp"%> 

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../guard_required_params.jsp"%>

<%
GuardRequiredParams guard = new GuardRequiredParams( request );

if (guard.isParameterMissed())
{
 out.write( guard.getSplashScreen() );
 return;
}
%>

<c:set var = "from">
 <c:out value = "${param.from}" default = ""/>
</c:set>

<c:if test = "${empty param.user_email}">
<center>
<font size = +2 color = "#FF0000">	 <c:out value = "No Email Address Entered. "/> </font>
</center>
 <%
 if (true)
  return;
 %>
</c:if>
<sql:query var = "org" maxRows = "1">
 select coordinator_login,coordinator_password from coordinators where coordinator_email = ?

 <sql:param value = "${param.user_email}"/>
</sql:query>

<c:if test = "${org.rowCount==0}">
<center>
<font size = +2 color = "#FF0000"> 	<c:out value = "Invalid Email Address Entered"/> </font>
</center>
 <%
 if (true)
  return;
 %>
</c:if>

<!--- retrieving coordinator's email address --->
<sql:query var = "coord_email" maxRows = "1">
 select coordinator_admin_email from coordinators where receive_admin_emails = 1
</sql:query>

<c:set var = "coordinator_email" value = "${coord_email.rows[0].coordinator_admin_email}" scope = "page"/>

<sm:Sendmail host = "127.0.0.1"
             domain = "127.0.0.1"
             port = "25"
             from = "${coordinator_email}"
             to = "${param.user_email}"
             debug = "true"
             subject = "Your Password">
<fmt:message key = "565" />: <c:out value = "${org.rows[0].coordinator_login}"/>
<fmt:message key = "566" />: <c:out value = "${org.rows[0].coordinator_password}"/>
</sm:Sendmail>

<center>
<font size = +2 color = "#FF0000">
 <c:out value = "Please check your email for your password"/>
</font>
</center>
<c:import url = "dsp_login_coordinator.jsp"/>


