<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="cf" uri="http://archer-soft.com/taglibs/cf" %>

<c:set var="lang" value="${sessionScope.lang}" scope="page" />

<!--- Public site default page --->
<!--- contains funding intitiative information --->

<!--- retrieve funding initiative information --->
<sql:query var="funding_initiative">
  select *
  from initiative_info
  where lang_id = ?
  <sql:param value="${lang}" />
</sql:query>

<sql:query var="funding_agencies">
  select *
  from funding_agencies
  order by agency_name
</sql:query>
<!--- retrieve funding agencies information --->

<!--- display funding initiative information --->
<c:forEach items="${funding_initiative.rows}" var="fi">
	

<p><h2><c:out value="${fi.initiative_name}" /></h2>

<table border="0" cellpadding="5" bgcolor="E1E1E1"><td>
<font face="Arial" size="-1"><b><fmt:message key="344" />:</b>
<ol><li><fmt:message key="345" />
<li><fmt:message key="346" />
<li><fmt:message key="347" />"
<li><fmt:message key="348" />"
</ol></font>
</td></table>

<p><b><fmt:message key="16" />:</b>
<br><menu><cf:ParagraphFormat value="${fi.background}"/></menu>
<p><b><fmt:message key="17" />:</b>
<br><menu><cf:ParagraphFormat value="${fi.eligibility}" /></menu>
<p><b><fmt:message key="18" />:</b>
<br><menu><cf:ParagraphFormat value="${fi.review_process}" /></menu>
<p><b><fmt:message key="19" />:</b>
<br><menu><cf:ParagraphFormat value="${fi.copyright}" /></menu>
<p><b><fmt:message key="20" />:</b>
<br><menu><cf:ParagraphFormat value="${fi.proposal_format}" /></menu>
<p><b><fmt:message key="21" />:</b>
<br><menu><cf:ParagraphFormat value="${fi.about_submitting}" /></menu>

<center>
<hr size="1 width="100">

<!--- Implementing Agency information --->
<h3><fmt:message key="22" />:</h3>
<b><c:out value="${fi.ia_name}" /></b>
<br><fmt:message key="23" />: <c:out value="${fi.ia_contact}" />
<br><fmt:message key="24" />: <c:out value="${fi.ia_email}" />
<br><fmt:message key="25" />: <c:out value="${fi.ia_address}" />
<br><fmt:message key="26" />: <c:out value="${fi.ia_courier}" />
<c:if test="${fi.ia_courier_inst!=''}"><br><fmt:message key="27" />: <c:out value="${fi.ia_courier_inst}" /></c:if>
<br><fmt:message key="28" />: <c:out value="${fi.ia_phone}" /> - <fmt:message key="29" />: <c:out value="${fi.ia_fax}" />
`
<br><a href="<c:out value="${fi.ia_url}" />"><c:out value="${fi.ia_url}" /></a>
</c:forEach>

<p><hr size="1 width="100">

<!--- provide a link to view reviewer profiles --->
<h3><a href="index.jsp?fuseaction=dsp_reviewers&lang=1"><fmt:message key="349" /></a></h3>

<p><hr size="1 width="100">

<!--- display funding agency information --->
<c:if test="${!(empty funding_agencies.rows[0].agency_id)}" >
<h3><fmt:message key="30" />:</h3>
  <c:forEach items="${funding_agencies.rows}" var="row">
    <p><b><c:out value="${row.agency_name}" /></b>
    <br><fmt:message key="23" />: <c:out value="${row.agency_contact}" />
    <br><fmt:message key="24" />: <a href="mailto:<c:out value="${row.agency_email}" />"><c:out value="${row.agency_email}" /></a>
    <br><fmt:message key="28" />: <c:out value="${row.agency_phone}" />
    <br><a href="<c:out value="${row.agency_url}" />"><c:out value="${row.agency_url}" /></a>
  </c:forEach>	
</c:if>




</center>