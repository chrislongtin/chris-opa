<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "reviewer_coordinator">
    <c:out value = "${param.reviewer_coordinator}" default = "0"/>
</c:set>

<c:set var = "show_comments">
    <c:out value = "${param.show_comments}" default = "yes"/>
</c:set>

<c:set var = "proposal_hide">
    <c:out value = "${param.proposal_hide}" default = "0"/>
</c:set>

<c:if test = "${sessionScope.user!='coordinator'}">
    <c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

    <sql:query var = "r_coord_check">
        select reviewer_coordinator from reviewers where reviewer_id = ?

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <c:set var = "reviewer_coordinator" value = "${r_coord_check.rows[0].reviewer_coordinator}" scope = "page"/>
</c:if>

<!--- general information about the proposal --->
<sql:query var = "proposal_info">
    select p.cfp_code, p.tracking_code, p.proponent_institution, p.requested_amount, p.awarded_amount,
    p.proposal_title, p.proposal_hide, p.status_id, s.status_name from proponent_record p, record_status s where
    p.tracking_code = ? and p.status_id = s.status_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "pi" value = "${proposal_info.rows[0]}" scope = "page"/>

<c:set var = "cfp_code" value = "${pi.cfp_code}" scope = "page"/>

<c:set var = "proposal_hide" value = "${pi.proposal_hide}" scope = "page"/>

<c:set var = "status_id" value = "${pi.status_id}" scope = "page"/>

<c:set var = "status_name" value = "${pi.status_name}" scope = "page"/>

<!--- calculating number reviewers who have submitted reviews --->
<sql:query var = "reviewer_num">
    select distinct reviewer_id from proposal_appraisal where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "reviewer_sum" value = "${reviewer_num.rowCount}" scope = "page"/>

<!--- retrieving initiative criteria appraisal info --->
<sql:query var = "i_appraisal_info">
    select i_criteria_id, SUM(appraisal_score) as score_sum, SUM(appraisal_rank) as rank_sum from proposal_appraisal
    where tracking_code = ? group by i_criteria_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<!--- retrieving CFP criteria appraisal info --->
<sql:query var = "cfp_appraisal_info">
    select cfp_criteria_id, SUM(appraisal_score) as score_sum, SUM(appraisal_rank) as rank_sum from proposal_appraisal
    where tracking_code = ? group by cfp_criteria_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<!--- retrieving status information --->
<sql:query var = "status_info">
    select s.status_name, s.status_id from proponent_record p, record_status s where p.tracking_code = ? and
    p.status_id = s.status_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<!--- status options --->
<sql:query var = "status_options">
    select * from record_status order by status_id
</sql:query>

<!--- retrieving minimum values --->
<sql:query var = "minimums">
    select minimum_rank from initiative_setup
</sql:query>

<c:set var = "minimum_rank" value = "${minimums.rows[0].minimum_rank}" scope = "page"/>

<!--- proponent record summary --->

<h3>

<cf:GetPhrase phrase_id = "303" lang_id = "${lang}"/>:</h3>

<c:if test = "${(sessionScope.user!='coordinator') and (status_id > 3)}">
    <table width = "100%" border = "0" cellspacing = "0" cellpadding = "0">
        <tr>
            <td width = "200" rowspan = "3">
                &nbsp;
            </td>

            <!--- status options --->
            <sql:query var = "status_options">
                select * from record_status where status_id > 3 and status_id<> ?
order by status_id
	<sql:param value="${status_id}" />
</sql:query>

<form action="index.jsp?fuseaction=proposal_status" method="post">
<input type="hidden" name="cfp_code" value="<c:out value="${cfp_code}" />">
<input type="hidden" name="tracking_code" value="<c:out value="${tracking_code}" />">
<input type="hidden" name="redirect" value="<cf:GetPhrase phrase_id="673" lang_id="${lang}" />">

<td align="right" valign="bottom"><select name="status_id"><option value="<c:out value="${status_id}" />"><c:out value="${status_name}" />
<c:forEach items="${status_options.rows}" var="row">
	<option value="<c:out value="${row.status_id}" />"><c:out value="${row.status_name}" />
</c:forEach>
</select>
</td>
<td align="right"><input type="submit" value="<cf:GetPhrase phrase_id="613" lang_id="${lang}" />"></td>
</tr><tr>
	<td align="right"><font face="arial" size="-2"><cf:GetPhrase phrase_id="614" lang_id="${lang}" /></font>
  <input type="checkbox" name="proposal_hide" <c:if test="${proposal_hide==1}" ><c:out value="checked" /></c:if> value="1"></td>
	<td></td>
</form>
</tr></table>
</c:if>

<h4><c:out value="${pi.proposal_title}" /></h4>

<b><cf:GetPhrase phrase_id="56" lang_id="${lang}" />:</b> <cf:GetPhrase phrase_id="586" lang_id="${lang}" />-<c:out value="${cfp_code}" />
<br><b><cf:GetPhrase phrase_id="57" lang_id="${lang}" />:</b> P-<c:out value="${tracking_code}" />
<br><b><cf:GetPhrase phrase_id="60" lang_id="${lang}" />:</b> <c:out value="${pi.proponent_institution}" />

<c:choose>
	<c:when test="${reviewer_sum!=0}">

<ul>
<li><cf:GetPhrase phrase_id="304" lang_id="${lang}" /> <c:out value="${minimum_rank}" />
<li><cf:GetPhrase phrase_id="305" lang_id="${lang}" /></ul>

<c:choose>
	<c:when test="${show_comments=='yes'}">
		<p><a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=proposal_summary&show_comments=no&tracking_code=<c:out value="${tracking_code}" />"><cf:GetPhrase phrase_id="674" lang_id="${lang}" /></a>
	</c:when>
	<c:otherwise>
    <p><a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=proposal_summary&tracking_code=<c:out value="${tracking_code}" />"><cf:GetPhrase phrase_id="675" lang_id="${lang}" /></a>	
	</c:otherwise>
</c:choose>

<p><table border="1" cellspacing="0" cellpadding="3">
<tr bgcolor="E3E3E3">
	<td><font size="-1" face="Arial"><b><cf:GetPhrase phrase_id="306" lang_id="${lang}" /></td>
	<td><font size="-1" face="Arial"><b><cf:GetPhrase phrase_id="271" lang_id="${lang}" /></td>
</tr>

<c:forEach items="${i_appraisal_info.rows}" var="row">

<c:if test="${row.i_criteria_id!=0}" >

<sql:query var="cr_i">
	select i_criteria_name, i_criteria_weight
  from initiative_criteria
  where i_criteria_id = ?
  <sql:param value="${row.i_criteria_id}" />
</sql:query>

<tr>
<!--	<td><font face="Times New Roman" size="-1">I <font face="Arial">-<c:out value="${row.i_criteria_id} ${cr_i.rows[0].i_criteria_name} (${cr_i.rows[0].i_criteria_weight})" /></td> --> -->
	<td><font face="Times New Roman" size="-1">I <font face="Arial">-<menu><cf:ParagraphFormat value="${row.i_criteria_id} ${cr_i.rows[0].i_criteria_name} (${cr_i.rows[0].i_criteria_weight})" /></menu></td>

<c:set var="avg_score" value="${row.score_sum / reviewer_sum}" scope="page" />
<c:set var="avg_rank" value="${row.rank_sum / reviewer_sum}" scope="page" />

<c:choose>
	<c:when test="${avg_rank < minimum_rank}">
		<td bgcolor="FFFF00"><center><b>(<font size="-1" face="Arial"><c:out value="${avg_score}" /> )
	</c:when>
	<c:otherwise>
	  <td><center><font size="-1" face="Arial"><c:out value="${avg_score}" />
	</c:otherwise>
</c:choose>
</td>

</tr>

<c:if test="${show_comments=='yes'}" >
<tr>

	<td colspan="2"><font size="-1" face="Arial">
<sql:query var="cr_comms">
  select p.*, r.reviewer_lastname, r.reviewer_firstname
  from proposal_appraisal p, reviewers r
  where
  p.reviewer_id = r.reviewer_id and
  p.i_criteria_id = ?
<sql:param value="${row.i_criteria_id}" />  
</sql:query>
<ul>
<c:forEach items="${cr_comms.rows}" var="cs">
	<c:if test="${!empty cs.appraisal_comment}" >
  	<li><c:out value="${cs.reviewer_firstname} ${cs.reviewer_lastname}: ${cs.appraisal_comment}" />
	</c:if>
</c:forEach>
</ul>
</td></tr>
</c:if>

</c:if>
</c:forEach>







<c:forEach items="${cfp_appraisal_info.rows}" var="row">

<c:if test="${row.cfp_criteria_id!=0}" >

<sql:query var="cr_i">
	select cfp_criteria_name, cfp_criteria_weight
  from cfp_criteria
  where cfp_criteria_id = ?
  <sql:param value="${row.cfp_criteria_id}" />
</sql:query>

<tr>
	<td><font face="Times New Roman" size="-1">C- <font face="Arial">-<menu><cf:ParagraphFormat value="${row.cfp_criteria_id} ${cr_i.rows[0].cfp_criteria_name} (${cr_i.rows[0].cfp_criteria_weight})" /></menu></td>

<c:set var="avg_score" value="${row.score_sum / reviewer_sum}" scope="page" />
<c:set var="avg_rank" value="${row.rank_sum / reviewer_sum}" scope="page" />

<c:choose>
	<c:when test="${avg_rank < minimum_rank}">
		<td bgcolor="FFFF00"><center><b>(<font size="-1" face="Arial"><c:out value="${avg_score}" /> )
	</c:when>
	<c:otherwise>
	  <td><center><font size="-1" face="Arial"><c:out value="${avg_score}" />
	</c:otherwise>
</c:choose>
</td>

</tr>

<c:if test="${show_comments=='yes'}" >
<tr>

	<td colspan="2"><font size="-1" face="Arial">
<sql:query var="cr_comms">
  select p.*, r.reviewer_lastname, r.reviewer_firstname
  from proposal_appraisal p, reviewers r
  where
  p.reviewer_id = r.reviewer_id and
  p.cfp_criteria_id = ?
<sql:param value="${row.cfp_criteria_id}" />  
</sql:query>
<ul>
<c:forEach items="${cr_comms.rows}" var="cs">
	<c:if test="${!empty cs.appraisal_comment}" >
  	<li><c:out value="${cs.reviewer_firstname} ${cs.reviewer_lastname}: ${cs.appraisal_comment}" />
	</c:if>
</c:forEach>
</ul>
</td></tr>
</c:if>

</c:if>
</c:forEach>




</table>

		
	</c:when>
	<c:otherwise>

<h3><cf:GetPhrase phrase_id="676" lang_id="${lang}" />.</h3>	

	</c:otherwise>
</c:choose>




