<%@ page errorPage = "dsp_error.jsp"%>

<%@include  file ="../taglibs_declarations.jsp"%> 

<!--- check for required parameters --->

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

<sql:query var = "org">
 select reviewer_login,reviewer_password from reviewers where reviewer_email = ?

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

<!--- send password --->
<sm:Sendmail host = "leapfrogindex.com"
             domain = "leapfrogindex.com"
             port = "25"
             from = "${coordinator_email}"
             to = "${param.user_email}"
             debug = "true"
             subject = "Your Password">
<fmt:message key = "565" />: <c:out value = "${org.rows[0].reviewer_login}"/>
<fmt:message key = "566" />: <c:out value = "${org.rows[0].reviewer_password}"/>
</sm:Sendmail>

<!--- return to index page --->

<center>
<font size = +2 color = "#FF0000">
 <c:out value = "Please check your email for your password"/>
</font>
</center>
<c:import url = "dsp_login_reviewer.jsp"/>

