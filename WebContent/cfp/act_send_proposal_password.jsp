<%@ page errorPage = "admin/dsp_error.jsp"%>

<%@include  file ="../taglibs_declarations.jsp"%>  

<%-- 
<%@ page import = "javax.mail.*"%>
<%@ page import = "javax.naming.*"%>
 --%>
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

<c:if test = "${empty param.proponent_leader_email}">
<center>
<font size = +2 color = "#FF0000"> 	<c:out value = "<fmt:message key = '1109' lang_id = '${lang}'/>"/> </font>
</center>
 <%
 if (true)
  return;
 %>
</c:if>

<sql:query var = "org">
 select proposal_title,proponent_password from proponent_record where proponent_leader_email = ?  
 <sql:param value = "${param.proponent_leader_email}"/>
</sql:query>


<c:if test = "${org.rowCount==0}">
<center>
<font size = +2 color = "#FF0000"> 	<c:out value = "<fmt:message key = '1110' lang_id = '${lang}'/> "/> </font>
</center>
 <%
 if (true)
  return;
 %>
</c:if>



<!--- retrieving coordinator's email address --->

<sm:Sendmail host = "leapfrogindex.com"
             domain = "leapfrogindex.com"
             port = "25"
             from = "${from}"
             to = "${param.proponent_leader_email}"
             debug = "true"
             subject = "Your Password"
             content = "This is your current password: '${org.rows[0].proponent_password}' ">
</sm:Sendmail>

<p>
<fmt:message key = '434' lang_id = '${lang}'/>:

<c:out value = "${param.proponent_leader_email}"/></p>


<%@ include file="dsp_proposal_edit.jsp" %>



