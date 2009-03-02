<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--- submit a proposal through the web --->

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "previous_tracking_code">
    <c:out value = "${param.previous_tracking_code}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = ""/>
</c:set>

<c:set var = "proponent_password">
    <c:out value = "${param.proponent_password}" default = ""/>
</c:set>

<c:set var = "proposal_title">
    <c:out value = "${param.proposal_title}" default = ""/>
</c:set>

<c:set var = "requested_amount">
    <c:out value = "${param.requested_amount}" default = ""/>
</c:set>

<c:set var = "proponent_institution">
    <c:out value = "${param.proponent_institution}" default = ""/>
</c:set>

<c:set var = "proponent_address">
    <c:out value = "${param.proponent_address}" default = ""/>
</c:set>

<c:set var = "proponent_phone">
    <c:out value = "${param.proponent_phone}" default = ""/>
</c:set>

<c:set var = "proponent_fax">
    <c:out value = "${param.proponent_fax}" default = ""/>
</c:set>

<c:set var = "proponent_email">
    <c:out value = "${param.proponent_email}" default = ""/>
</c:set>

<c:set var = "proponent_url">
    <c:out value = "${param.proponent_url}" default = ""/>
</c:set>

<c:set var = "proponent_leader_firstname">
    <c:out value = "${param.proponent_leader_firstname}" default = ""/>
</c:set>

<c:set var = "proponent_leader_lastname">
    <c:out value = "${param.proponent_leader_lastname}" default = ""/>
</c:set>

<c:set var = "proponent_leader_initial">
    <c:out value = "${param.proponent_leader_initial}" default = ""/>
</c:set>

<c:set var = "proponent_leader_affiliation">
    <c:out value = "${param.proponent_leader_affiliation}" default = ""/>
</c:set>

<c:set var = "proponent_leader_address">
    <c:out value = "${param.proponent_leader_address}" default = ""/>
</c:set>

<c:set var = "proponent_leader_phone">
    <c:out value = "${param.proponent_leader_phone}" default = ""/>
</c:set>

<c:set var = "proponent_leader_fax">
    <c:out value = "${param.proponent_leader_fax}" default = ""/>
</c:set>

<c:set var = "proponent_leader_email">
    <c:out value = "${param.proponent_leader_email}" default = ""/>
</c:set>

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<c:set var = "deadline_date">
    <c:out value = "${param.deadline_date}" default = "current"/>
</c:set>

<c:set var = "proponent_citizenship">
    <c:out value = "${param.proponent_citizenship}" default = ""/>
</c:set>

<c:set var = "proponent_residency">
    <c:out value = "${param.proponent_residency}" default = ""/>
</c:set>

<c:set var = "project_country">
    <c:out value = "${param.project_country}" default = ""/>
</c:set>

<c:set var = "project_date">
    <c:out value = "${param.project_date}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${act=='edit'}">
        <h3>

        <cf:GetPhrase phrase_id = "662" lang_id = "${lang}"/></h3>

        <sql:query var = "edit_proposal">
            select p.*, c.cfp_title from proponent_record p, cfp_info c where
            p.tracking_code = ? and p.cfp_code = c.cfp_code

            <sql:param value = "${tracking_code}"/>
        </sql:query>

        <c:set var = "ep" value = "${edit_proposal.rows[0]}" scope = "page"/>

        <c:set var = "previous_tracking_code"
               value = "${ep.previous_tracking_code}"
               scope = "page"/>

        <c:set var = "tracking_code" value = "${ep.tracking_code}"
               scope = "page"/>

        <c:set var = "cfp_code" value = "${ep.cfp_code}" scope = "page"/>

        <c:set var = "cfp_title" value = "${ep.cfp_title}" scope = "page"/>

        <c:set var = "cfp_cat_id" value = "${ep.cfp_cat_id}" scope = "page"/>

        <c:set var = "proponent_password" value = "${ep.proponent_password}"
               scope = "page"/>

        <c:set var = "proposal_title" value = "${ep.proposal_title}"
               scope = "page"/>

        <c:set var = "requested_amount" value = "${ep.requested_amount}"
               scope = "page"/>

        <c:set var = "proponent_institution"
               value = "${ep.proponent_institution}"
               scope = "page"/>

        <c:set var = "proponent_address" value = "${ep.proponent_address}"
               scope = "page"/>

        <c:set var = "proponent_phone" value = "${ep.proponent_phone}"
               scope = "page"/>

        <c:set var = "proponent_fax" value = "${ep.proponent_fax}"
               scope = "page"/>

        <c:set var = "proponent_email" value = "${ep.proponent_email}"
               scope = "page"/>

        <c:set var = "proponent_url" value = "${ep.proponent_url}"
               scope = "page"/>

        <c:set var = "proponent_leader_firstname"
               value = "${ep.proponent_leader_firstname}"
               scope = "page"/>

        <c:set var = "proponent_leader_lastname"
               value = "${ep.proponent_leader_lastname}"
               scope = "page"/>

        <c:set var = "proponent_leader_initial"
               value = "${ep.proponent_leader_initial}"
               scope = "page"/>

        <c:set var = "proponent_leader_affiliation"
               value = "${ep.proponent_leader_affiliation}"
               scope = "page"/>

        <c:set var = "proponent_leader_address"
               value = "${ep.proponent_leader_address}"
               scope = "page"/>

        <c:set var = "proponent_leader_phone"
               value = "${ep.proponent_leader_phone}"
               scope = "page"/>

        <c:set var = "proponent_leader_fax" value = "${ep.proponent_leader_fax}"
               scope = "page"/>

        <c:set var = "proponent_leader_email"
               value = "${ep.proponent_leader_email}"
               scope = "page"/>

        <c:set var = "proponent_citizenship"
               value = "${ep.proponent_citizenship}"
               scope = "page"/>

        <c:set var = "proponent_residency" value = "${ep.proponent_residency}"
               scope = "page"/>

        <c:set var = "project_country" value = "${ep.project_country}"
               scope = "page"/>

        <c:set var = "project_date" value = "${ep.project_date}"
               scope = "page"/>

        <c:set var = "act" value = "edit" scope = "page"/>

        <sql:query var = "old_cfp_code">
            select cfp_code as cfp_old_code from cfp_category where cfp_cat_id
            = ?

            <sql:param value = "${cfp_cat_id}"/>
        </sql:query>

        <c:set var = "cfp_old_code"
               value = "${old_cfp_code.rows[0].cfp_old_code}"
               scope = "page"/>

        <!--- verify that cfp is still active --->
        <sql:query var = "cfp_current_list">
            select cfp_title from cfp_info where cfp_code = ? and cfp_deadline
            >= CURDATE()

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <c:if test = "${cfp_current_list.rowCount==0}">
            <c:set var = "deadline_date" value = "passed" scope = "page"/>
        </c:if>

        <!--- get the cfp category name if associated with one --->
        <sql:query var = "cfp_cat_info">
            select * from cfp_category where cfp_cat_id = ?

            <sql:param value = "${cfp_cat_id}"/>
        </sql:query>

        <c:set var = "cfp_cat_name"
               value = "${cfp_cat_info.rows[0].cfp_cat_name}"
               scope = "page"/>
    </c:when>

    <c:otherwise>
        <h3>

        <cf:GetPhrase phrase_id = "93" lang_id = "${lang}"/></h3>
    </c:otherwise>
</c:choose>

<sql:query var = "currency_type">
    select c.currency_id, c.currency from cfp_info cf, currency_code c where
    cf.cfp_code = ? and cf.currency_id = c.currency_id

    <sql:param value = "${cfp_code}"/>
</sql:query>

<c:set var = "currency" value = "${currency_type.rows[0].currency}"
       scope = "page"/>

<cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

<form action = "index.jsp?fuseaction=act_proposal_submit" method = "post"
      ENCTYPE = "multipart/form-data">
    <input type = "hidden" name = "act" value = "<c:out value="${act}" />">
    <c:choose>
        <c:when test = "${act=='add'}">
            <input type = "hidden" name = "cfp_code"
            value = "<c:out value="${cfp_code}" />">
            <input type = "hidden" name = "proponent_password_required"
            value = "<cf:GetPhrase phrase_id="663" lang_id="${lang}" />">
        </c:when>

        <c:otherwise>
            <input type = "hidden" name = "tracking_code"
                   value = "<c:out value="${tracking_code}" />">
        </c:otherwise>
    </c:choose>

    <input type = "hidden" name = "proposal_title_required"
    value = "<cf:GetPhrase phrase_id="664" lang_id="${lang}" />"> <input type = "hidden"
    name = "requested_amount_float"
    value = "<cf:GetPhrase phrase_id="778" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_institution_required"
    value = "<cf:GetPhrase phrase_id="666" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_address_required"
    value = "<cf:GetPhrase phrase_id="667" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_phone_required"
    value = "<cf:GetPhrase phrase_id="668" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_leader_affiliation_required"
    value = "<cf:GetPhrase phrase_id="669" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_leader_address_required"
    value = "<cf:GetPhrase phrase_id="670" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_leader_phone_required"
    value = "<cf:GetPhrase phrase_id="671" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_leader_firstname_required"
    value = "<cf:GetPhrase phrase_id="698" lang_id="${lang}" />"> <input type = "hidden"
    name = "proponent_leader_lastname_required"
    value = "<cf:GetPhrase phrase_id="697" lang_id="${lang}" />">

    <table width = "100%" cellpadding = "3">
        <tr bgcolor = "CFCFCF">
            <td colspan = "2">
                <font face = "arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "617" lang_id = "${lang}"/>
            </td>
        </tr>

        <c:if test = "${act=='add'}">
            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <cf:GetPhrase phrase_id = "299" lang_id = "${lang}"/>

                    <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/></font>
                </td>

                <td>
                    <input type = "password" name = "proponent_password"
                           size = "10">
                </td>
            </tr>

            <tr>
                <td colspan = "2">
                    <font face = "arial" size = "-2">

                    <cf:GetPhrase phrase_id = "99" lang_id = "${lang}"/>
                </td>
            </tr>
        </c:if>

        <c:if test = "${act=='edit'}">
            <sql:query var = "cfp_list">
                select cfp_code, cfp_title from cfp_info where cfp_code<> ?
order by cfp_title
	<sql:param value="${cfp_code}" />
</sql:query>

<tr>

	<td><font face="arial" size="-1" color="FF0000">* CFP</font></td>
	<td><select name="cfp_code"><option value="<c:out value="${cfp_code}" />"><c:out value="${cfp_title} (CFP: ${cfp_code})" />
  <c:forEach items="${cfp_list.rows}" var="row">
  	<option value="<c:out value="${row.cfp_code}" />"><c:out value="${row.cfp_title} (CFP: ${row.cfp_code})" />
  </c:forEach>
  </select></td>

</tr>
</c:if>

<!--- if cfp categories exist list them here --->
<sql:query var="cfp_category">
select *
from cfp_category
where cfp_code = ?
order by cfp_cat_id
	<sql:param value="${cfp_code}" />
</sql:query>

<c:if test="${cfp_category.rowCount!=0}" >
<tr>
	<td><font face="arial" size="-1"><font color="FF0000">* Theme</font></td>
	<td><select name="cfp_cat_id">
  <c:if test="${(act=='edit') and (cfp_cat_info.rowCount!=0)}" >
    <option value="<c:out value="${cfp_cat_id}" />"><c:out value="${cfp_cat_name} (CFP: ${cfp_old_code})" />
  </c:if>
  <c:forEach items="${cfp_category.rows}" var="row">
  	<option value="<c:out value="${row.cfp_cat_id}" />"><c:out value="${row.cfp_cat_name} (CFP: ${row.cfp_code})" />
  </c:forEach>
  </select></td>
</tr>
</c:if>

<tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="100" lang_id="${lang}" /></font></td>
	<td><input type="text" name="proposal_title" size="40" value="<c:out value="${proposal_title}" />"></td>
	
</tr>

<c:if test="${(deadline_date=='current') and act!='edit'}" >
<tr>

	<td valign="top"><font face="Arial" size="-1"><cf:GetPhrase phrase_id="101" lang_id="${lang}" /></td>
	<td><font face="Arial" size="-1">
	<font face="Arial" size="-2"><input type="file" name="doc_filename" size="30"></td>
	
</tr><tr>

	<td colspan="2"><font face="Arial" size="-2">
	<cf:GetPhrase phrase_id="48" lang_id="${lang}" />
</td>

</tr>
</c:if>


<tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="69" lang_id="${lang}" /></font></td>
	<td><font face="arial" size="-1">(<c:out value="${currency}" />) <input type="number" name="requested_amount" size="10" value="<fmt:formatNumber value="${requested_amount}" type="currency" currencySymbol=""/>"></td>

</tr><tr>

	<td colspan="2"><font face="arial" size="-1"><cf:GetPhrase phrase_id="298" lang_id="${lang}" />
<input type="number" name="previous_tracking_code" size="2" value="<c:out value="${previous_tracking_code}" />"></td>

</tr><tr bgcolor="CFCFCF">

	<td colspan="2"><font face="arial" size="-1"><b><cf:GetPhrase phrase_id="65" lang_id="${lang}" /></b></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="330" lang_id="${lang}" /></td>
	<td><input type="text" name="proponent_leader_firstname" value="<c:out value="${proponent_leader_firstname}" />" size="10"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="619" lang_id="${lang}" /></td>
	<td><input type="text" name="proponent_leader_initial" value="<c:out value="${proponent_leader_initial}" />" size="2"></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="620" lang_id="${lang}" /></td>
	<td><input type="text" name="proponent_leader_lastname" value="<c:out value="${proponent_leader_lastname}" />" size="10"></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="300" lang_id="${lang}" /></font></td>
	<td><input type="text" name="proponent_leader_affiliation" value="<c:out value="${proponent_leader_affiliation}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="61" lang_id="${lang}" /></font></td>
	<td><input type="text" name="proponent_leader_address" value="<c:out value="${proponent_leader_address}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="62" lang_id="${lang}" /></font></td>
	<td><input type="text" name="proponent_leader_phone" size="10" value="<c:out value="${proponent_leader_phone}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="29" lang_id="${lang}" /></td>	
	<td><input type="text" name="proponent_leader_fax" size="10" value="<c:out value="${proponent_leader_fax}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="24" lang_id="${lang}" /></td>	
	<td><input type="text" name="proponent_leader_email" value="<c:out value="${proponent_leader_email}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="621" lang_id="${lang}" /></td>	
	<td><input type="text" name="proponent_citizenship" value="<c:out value="${proponent_citizenship}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="622" lang_id="${lang}" /></td>	
	<td><input type="text" name="proponent_residency" value="<c:out value="${proponent_residency}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="623" lang_id="${lang}" /></td>	
	<td><input type="text" name="project_country" value="<c:out value="${project_country}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="624" lang_id="${lang}" /></td>	
	<td><input type="text" name="project_date" value="<c:out value="${project_date}" />"></td>

</tr><tr bgcolor="CFCFCF">

	<td colspan="2"><font face="arial" size="-1"><b><cf:GetPhrase phrase_id="103" lang_id="${lang}" /></b></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="60" lang_id="${lang}" /></font></td>	
	<td><input type="text" name="proponent_institution" value="<c:out value="${proponent_institution}" />" size="40"></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="25" lang_id="${lang}" /></font></td>	
	<td><input type="text" name="proponent_address" value="<c:out value="${proponent_address}" />" size="40"></td>

</tr><tr>

	<td><font face="arial" size="-1" color="FF0000">* <cf:GetPhrase phrase_id="104" lang_id="${lang}" /></font></td>	
	<td><input type="text" name="proponent_phone" size="10" value="<c:out value="${proponent_phone}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="105" lang_id="${lang}" /></td>	
	<td><input type="text" name="proponent_fax" size="10" value="<c:out value="${proponent_fax}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="106" lang_id="${lang}" /></td>	
	<td><input type="text" name="proponent_email" value="<c:out value="${proponent_email}" />"></td>

</tr><tr>

	<td><font face="arial" size="-1"><cf:GetPhrase phrase_id="64" lang_id="${lang}" /></td>	
	<td><input type="text" name="proponent_url" value="<c:out value="${proponent_url}" />"></td>

</tr><tr bgcolor="CFCFCF">

	<td colspan="2" align="center"><input type="submit" value=" Submit Proposal "></td>

</form>
	
</tr></table>

<!--- option to delete the proposal record --->
<c:if test="${act=='edit'}" >
<h3><cf:GetPhrase phrase_id="301" lang_id="${lang}" /></h3>

<form action="index.jsp?fuseaction=act_proposal_submit" method="post">
<input type="hidden" name="tracking_code" value="<c:out value="${tracking_code}" />">
<input type="hidden" name="cfp_code" value="<c:out value="${cfp_code}" />">
<input type="hidden" name="act" value="delete">
<cf:GetPhrase phrase_id="130" lang_id="${lang}" />

<br><input type="submit" value=" Delete ">
</form>
</c:if>





