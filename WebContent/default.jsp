<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
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
<font face="Arial" size="-1"><b><cf:GetPhrase phrase_id="344" lang_id="${lang}"/>:</b>
<ol><li><cf:GetPhrase phrase_id="345" lang_id="${lang}"/>
<li><cf:GetPhrase phrase_id="346" lang_id="${lang}"/>
<li><cf:GetPhrase phrase_id="347" lang_id="${lang}"/>"
<li><cf:GetPhrase phrase_id="348" lang_id="${lang}"/>"
</ol></font>
</td></table>

<p><b><cf:GetPhrase phrase_id="16" lang_id="${lang}"/>:</b>
<br><menu><cf:ParagraphFormat value="${fi.background}"/></menu>
<p><b><cf:GetPhrase phrase_id="17" lang_id="${lang}"/>:</b>
<br><menu><cf:ParagraphFormat value="${fi.eligibility}" /></menu>
<p><b><cf:GetPhrase phrase_id="18" lang_id="${lang}"/>:</b>
<br><menu><cf:ParagraphFormat value="${fi.review_process}" /></menu>
<p><b><cf:GetPhrase phrase_id="19" lang_id="${lang}"/>:</b>
<br><menu><cf:ParagraphFormat value="${fi.copyright}" /></menu>
<p><b><cf:GetPhrase phrase_id="20" lang_id="${lang}"/>:</b>
<br><menu><cf:ParagraphFormat value="${fi.proposal_format}" /></menu>
<p><b><cf:GetPhrase phrase_id="21" lang_id="${lang}"/>:</b>
<br><menu><cf:ParagraphFormat value="${fi.about_submitting}" /></menu>

<center>
<hr size="1 width="100">

<!--- Implementing Agency information --->
<h3><cf:GetPhrase phrase_id="22" lang_id="${lang}"/>:</h3>
<b><c:out value="${fi.ia_name}" /></b>
<br><cf:GetPhrase phrase_id="23" lang_id="${lang}"/>: <c:out value="${fi.ia_contact}" />
<br><cf:GetPhrase phrase_id="24" lang_id="${lang}"/>: <c:out value="${fi.ia_email}" />
<br><cf:GetPhrase phrase_id="25" lang_id="${lang}"/>: <c:out value="${fi.ia_address}" />
<br><cf:GetPhrase phrase_id="26" lang_id="${lang}"/>: <c:out value="${fi.ia_courier}" />
<c:if test="${fi.ia_courier_inst!=''}"><br><cf:GetPhrase phrase_id="27" lang_id="${lang}"/>: <c:out value="${fi.ia_courier_inst}" /></c:if>
<br><cf:GetPhrase phrase_id="28" lang_id="${lang}"/>: <c:out value="${fi.ia_phone}" /> - <cf:GetPhrase phrase_id="29" lang_id="${lang}"/>: <c:out value="${fi.ia_fax}" />
`
<br><a href="<c:out value="${fi.ia_url}" />"><c:out value="${fi.ia_url}" /></a>
</c:forEach>

<p><hr size="1 width="100">

<!--- provide a link to view reviewer profiles --->
<h3><a href="index.jsp?fuseaction=dsp_reviewers&lang=1"><cf:GetPhrase phrase_id="349" lang_id="${lang}"/></a></h3>

<p><hr size="1 width="100">

<!--- display funding agency information --->
<c:if test="${!(empty funding_agencies.rows[0].agency_id)}" >
<h3><cf:GetPhrase phrase_id="30" lang_id="${lang}"/>:</h3>
  <c:forEach items="${funding_agencies.rows}" var="row">
    <p><b><c:out value="${row.agency_name}" /></b>
    <br><cf:GetPhrase phrase_id="23" lang_id="${lang}"/>: <c:out value="${row.agency_contact}" />
    <br><cf:GetPhrase phrase_id="24" lang_id="${lang}"/>: <a href="mailto:<c:out value="${row.agency_email}" />"><c:out value="${row.agency_email}" /></a>
    <br><cf:GetPhrase phrase_id="28" lang_id="${lang}"/>: <c:out value="${row.agency_phone}" />
    <br><a href="<c:out value="${row.agency_url}" />"><c:out value="${row.agency_url}" /></a>
  </c:forEach>	
</c:if>




</center>