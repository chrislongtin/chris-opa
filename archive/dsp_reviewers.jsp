<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- reviewer profiles --->

<!--- select reviewer info --->
<sql:query var = "reviewer_profiles">
    select reviewer_profile, reviewer_lastname, reviewer_firstname from
    reviewers where reviewer_profile<> ''
order by reviewer_lastname
</sql:query>

<h3><cf:GetPhrase phrase_id="731" lang_id="${lang}" /></h3>

<c:choose>
	<c:when test="${empty reviewer_profiles.rows[0].reviewer_lastname}">
    <cf:GetPhrase phrase_id="732" lang_id="${lang}" />		
	</c:when>
	<c:otherwise>

<!--- show reviewer info --->
<c:forEach items="${reviewer_profiles.rows}" var="row">
<p><font size="3"><b><c:out value="${row.reviewer_firstname} ${row.reviewer_lastname}" /></b></font>
<menu><c:out value="${row.reviewer_profile}" /></menu>
</c:forEach>
	</c:otherwise>
</c:choose>




