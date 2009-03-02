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

<cf:GetPhrase phrase_id = "19" lang_id = "${lang}"/>:</h4>

<menu><cf:ParagraphFormat value = "${copyright.rows[0].copyright}"/></menu>

<!--- output proponent info --->
<p>
<b>

<cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/>:</b> CFP-

<c:out value = "${pr.cfp_code}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:</b> P-

<c:out value = "${pr.tracking_code}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "58" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.status_name}"/>

<p>
<h4>

<cf:GetPhrase phrase_id = "59" lang_id = "${lang}"/></h4> <b>

<cf:GetPhrase phrase_id = "60" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_institution}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_address}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_phone}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_fax}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_email}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:</b>
<a STYLE = "text-decoration: underline"
   href = "<c:out value="${pr.proponent_url}" />">

<c:out value = "${pr.proponent_url}"/></a>

<p>
<h4>

<cf:GetPhrase phrase_id = "65" lang_id = "${lang}"/></h4> <b>

<cf:GetPhrase phrase_id = "66" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_leader_firstname} ${pr.proponent_leader_lastname}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "67" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_leader_affiliation}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_leader_address}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_leader_phone}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_leader_fax}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b>

<c:out value = "${pr.proponent_leader_email}"/>

<p>
<h4>

<cf:GetPhrase phrase_id = "68" lang_id = "${lang}"/></h4> <b>

<cf:GetPhrase phrase_id = "69" lang_id = "${lang}"/>:</b>

<fmt:formatNumber value = "${pr.requested_amount}" type = "currency"
currencySymbol = ""/><c:if test = "${!empty appraisal_info.rows[0].reviewer_lastname}">
    <br>
    <b>

    <cf:GetPhrase phrase_id = "70" lang_id = "${lang}"/>:</b>

    <fmt:formatNumber value = "${row.awarded_amount}" type = "currency"
                      currencySymbol = ""/>
</c:if>
