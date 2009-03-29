<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<!--- archive record details --->

<!--- retrieve proponent info --->
<sql:query var = "proponent_record">
    select p.*, s.status_name from proponent_record p, record_status s where
    tracking_code = ? and p.status_id = s.status_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "pr" value = "${proponent_record.rows[0]}" scope = "page"/>

<!--- retrieve copyright info --->
<sql:query var = "copyright">
    select copyright from initiative_info where lang_id = 1
</sql:query>

<!--- retrieve proposal appraisal info --->
<sql:query var = "appraisal_info">
    select p.*, r.reviewer_lastname, r.reviewer_firstname from
    proposal_appraisal p, reviewers r where p.tracking_code = ? and
    p.reviewer_id = r.reviewer_id order by appraisal_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<h3>

<c:out value = "${pr.proposal_title}"/></h3> <h4>

<fmt:message key = "19" />:</h4>

<menu><cf:ParagraphFormat value = "${copyright.rows[0].copyright}"/></menu>

<!--- output proponent info --->
<p>
<b>

<fmt:message key = "56" />:</b> CFP-

<c:out value = "${pr.cfp_code}"/>

<br>
<b>

<fmt:message key = "57" />:</b> P-

<c:out value = "${pr.tracking_code}"/>

<br>
<b>

<fmt:message key = "58" />:</b>

<c:out value = "${pr.status_name}"/>

<p>
<h4>

<fmt:message key = "59" /></h4> <b>

<fmt:message key = "60" />:</b>

<c:out value = "${pr.proponent_institution}"/>

<br>
<b>

<fmt:message key = "61" />:</b>

<c:out value = "${pr.proponent_address}"/>

<br>
<b>

<fmt:message key = "62" />:</b>

<c:out value = "${pr.proponent_phone}"/>

<br>
<b>

<fmt:message key = "29" />:</b>

<c:out value = "${pr.proponent_fax}"/>

<br>
<b>

<fmt:message key = "24" />:</b>

<c:out value = "${pr.proponent_email}"/>

<br>
<b>

<fmt:message key = "64" />:</b>
<a STYLE = "text-decoration: underline"
   href = "<c:out value="${pr.proponent_url}" />">

<c:out value = "${pr.proponent_url}"/></a>

<p>
<h4>

<fmt:message key = "65" /></h4> <b>

<fmt:message key = "66" />:</b>

<c:out value = "${pr.proponent_leader_firstname} ${pr.proponent_leader_lastname}"/>

<br>
<b>

<fmt:message key = "67" />:</b>

<c:out value = "${pr.proponent_leader_affiliation}"/>

<br>
<b>

<fmt:message key = "61" />:</b>

<c:out value = "${pr.proponent_leader_address}"/>

<br>
<b>

<fmt:message key = "62" />:</b>

<c:out value = "${pr.proponent_leader_phone}"/>

<br>
<b>

<fmt:message key = "29" />:</b>

<c:out value = "${pr.proponent_leader_fax}"/>

<br>
<b>

<fmt:message key = "24" />:</b>

<c:out value = "${pr.proponent_leader_email}"/>

<p>
<h4>

<fmt:message key = "68" /></h4> <b>

<fmt:message key = "69" />:</b>

<fmt:formatNumber value = "${pr.requested_amount}" type = "currency"
currencySymbol = ""/><c:if test = "${!empty appraisal_info.rows[0].reviewer_lastname}">
    <br>
    <b>

    <fmt:message key = "70" />:</b>

    <fmt:formatNumber value = "${row.awarded_amount}" type = "currency"
                      currencySymbol = ""/>
</c:if>
