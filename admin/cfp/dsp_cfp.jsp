<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = "0"/>
</c:set>

<c:set var = "job_name">
    <c:out value = "${param.job_name}" default = ""/>
</c:set>

<!--- retrieve cfp info from database --->
<sql:query var = "dsp_cfp">
    select I.*, C.currency from cfp_info I, currency_code C where I.cfp_code =
    ? AND I.currency_id = C.currency_id order by I.cfp_startdate asc

    <sql:param value = "${cfp_code}"/>
</sql:query>

<!--- retrieve cfp criteria for this cfp from the database --->
<sql:query var = "cfp_criteria">
    select * from cfp_criteria where cfp_code = ?

    <sql:param value = "${cfp_code}"/>
</sql:query>
<!--- retrieve dkills for this cfp from the database --->

<sql:query var = "edit_cfp_skills">
    select a.skill_id,b.skill_name from cfp_skills a, professional_skills b
    where cfp_code = ? and a.skill_id = b.skill_id order by b.skill_name

    <sql:param value = "${cfp_code}"/>
</sql:query>

<sql:query var = "edit_cfp_agencies">
    select a.agency_id,b.agency_name from funding_agencies_cfp a,
    funding_agencies b where a.cfp_code = ? and a.agency_id= b.agency_id order
    by b.agency_name

    <sql:param value = "${cfp_code}"/>
</sql:query>

<!--- set the default review_active to no --->
<c:set var = "review_active">
    <c:out value = "${param.review_active}" default = "no"/>
</c:set>

<%
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());

    pageContext.setAttribute("Current_Date", sqldate.toString());
%>

<!--- check to see if a review process is active --->

<sql:query var = "check_review_status">
    select cfp_code from cfp_info where ? > cfp_deadline and
    cfp_proposal_review_deadline > ? and cfp_code = ?

    <sql:param value = "${Current_Date}"/>

    <sql:param value = "${Current_Date}"/>

    <sql:param value = "${cfp_code}"/>
</sql:query>

<!--- if a review process is active, set review_active to yes --->
<c:if test = "${check_review_status.rowCount != 0}">
    <c:set var = "review_active" value = "yes"/>
</c:if>

<sql:query var = "setup">
    select use_initiative_criteria, use_cfp_criteria from initiative_setup
</sql:query>

<c:forEach var = "row" items = "${setup.rows}">
    <c:set var = "use_cfp_crit" value = "${row.use_cfp_criteria}"/>
</c:forEach>

<!--- display cfp information to the user --->
<c:forEach var = "row" items = "${dsp_cfp.rows}">
    <p>
    <h3>

    <c:out value = "${row.cfp_title}"/></h3>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/>:</b> CFP-

    <c:out value = "${row.cfp_code}"/>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "80" lang_id = "${lang}"/>:</b>

    <br>
    <cf:ParagraphFormat value = "${row.cfp_background}"/>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "82" lang_id = "${lang}"/>:</b> (

    <c:out value = "${row.currency}"/>)

    <fmt:formatNumber value = "${row.cfp_maxaward}" type = "currency"
                      currencySymbol = ""/>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "83" lang_id = "${lang}"/>:</b> (

    <c:out value = "${row.currency}"/>)

    <fmt:formatNumber value = "${row.cfp_totalfunds}" type = "currency"
                      currencySymbol = ""/>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>:</b>
    <c:forEach items = "${edit_cfp_agencies.rows}" var = "rowag">
        <c:out value = "${rowag.agency_name}"/>
    </c:forEach>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "78" lang_id = "${lang}"/>:</b>

    <fmt:formatDate value = "${row.cfp_startdate}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "123" lang_id = "${lang}"/>:</b>

    <fmt:formatDate value = "${row.cfp_deadline}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "124" lang_id = "${lang}"/>:</b>

    <fmt:formatDate value = "${row.cfp_proposal_review_deadline}"
                    pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "125" lang_id = "${lang}"/>:</b>

    <fmt:formatDate value = "${row.first_reminder}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "126" lang_id = "${lang}"/>:</b>

    <fmt:formatDate value = "${row.second_reminder}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "127" lang_id = "${lang}"/>:</b>

    <fmt:formatDate value = "${row.cfp_report_deadline}"
                    pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "128" lang_id = "${lang}"/>:</b>

    <fmt:formatDate value = "${row.cfp_report_review_deadline}"
                    pattern = "dd-MMM-yyyy"/>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "129" lang_id = "${lang}"/>:</b>

    <br>
    <cf:ParagraphFormat value = "${row.cfp_format}"/>
</c:forEach>

<!--- provide a link for the coordinator to edit cfp info --->
<c:if test = "${user == 'coordinator'}">
    <p>
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_cfp'/>
<c:param name='act' value='edit'/>
<c:param name='cfp_code' value='${cfp_code}'/>
<c:param name='${user}'/>
</c:url>">

    <cf:GetPhrase phrase_id = "131" lang_id = "${lang}"/></a>
    <!--- link for coordinator to delete cfp info --->
    | <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='delete_cfp'/>
<c:param name='act' value='confirm'/>
<c:param name='cfp_code' value='${cfp_code}'/>
<c:param name='${user}'/>
</c:url>">

    <cf:GetPhrase phrase_id = "132" lang_id = "${lang}"/></a> <b>

    <cf:GetPhrase phrase_id = "130" lang_id = "${lang}"/></b>
</c:if>

<h3>

<cf:GetPhrase phrase_id = "445" lang_id = "${lang}"/>:</h3>

<c:if test = "${user == 'coordinator'}">
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_category'/>
<c:param name='cfp_code' value='${cfp_code}'/>
</c:url>">

    <cf:GetPhrase phrase_id = "446" lang_id = "${lang}"/></a>

    <p>
</c:if>

<sql:query var = "cfp_category_list">
    select cfp_cat_name, cfp_cat_id from cfp_category where cfp_code = ? order
    by cfp_cat_id

    <sql:param value = "${cfp_code}"/>
</sql:query>

<c:if test = "${cfp_category_list.rowCount == 0}">
    <p>
    <cf:GetPhrase phrase_id = "447" lang_id = "${lang}"/>
</c:if>

<ul>
    <c:forEach var = "row" items = "${cfp_category_list.rows}">
        <li><c:out value = "${row.cfp_cat_name}"/>

        <c:if test = "${user == 'coordinator'}">
            [<a STYLE = "text-decoration: underline"
                href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_category'/>
<c:param name='cfp_code' value='${cfp_code}'/>
<c:param name='cfp_cat_id' value='${row.cfp_cat_id}'/>
<c:param name='act' value='edit'/>
</c:url>">

            <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a> |
            <a STYLE = "text-decoration: underline"
               href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp_cat'/>
<c:param name='cfp_code' value='${cfp_code}'/>
<c:param name='cfp_cat_id' value='${row.cfp_cat_id}'/>
<c:param name='act' value='delete'/>
</c:url>">

            <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> ]
        </c:if>
    </c:forEach>
</ul>

<h3>

<cf:GetPhrase phrase_id = "3" lang_id = "${lang}"/></h3>

<c:choose>
    <c:when test = "${user == 'coordinator' and review_active == 'no'}">
        <p>
        <cf:GetPhrase phrase_id = "133" lang_id = "${lang}"/>
    </c:when>

    <c:when test = "${user == 'coordinator' and review_active == 'yes'}">
        <p>
        <font color = "FF0000">

        <cf:GetPhrase phrase_id = "134" lang_id = "${lang}"/></font>
    </c:when>
</c:choose>

<!--- link to general criteria for this initiative --->
<c:forEach var = "row" items = "${setup.rows}">
    <c:if test = "${row.use_initiative_criteria == 1}">
        <p>
        <h4><a STYLE = "text-decoration: underline"
               href = "index.jsp?fuseaction=criteria">

        <cf:GetPhrase phrase_id = "135" lang_id = "${lang}"/></a></h4>
    </c:if>
</c:forEach>

<c:if test = "${use_cfp_crit == 1}">
    <p>
    <h4>

    <cf:GetPhrase phrase_id = "136" lang_id = "${lang}"/></h4>
    <c:if test = "${cfp_criteria.rowCount == 0}">
        <cf:GetPhrase phrase_id = "137" lang_id = "${lang}"/>
    </c:if>

    <!--- display criteria for this cfp --->
    <c:forEach var = "row" items = "${cfp_criteria.rows}">
        <p>
        <b>

        <cf:GetPhrase phrase_id = "138" lang_id = "${lang}"/>:</b> C-

        <c:out value = "${row.cfp_criteria_id}"/>

        <br>
        <b>

        <cf:GetPhrase phrase_id = "139" lang_id = "${lang}"/>:</b>

        <menu><cf:ParagraphFormat value = "${row.cfp_criteria_name}"/></menu>

        <br>
        <b>

        <cf:GetPhrase phrase_id = "140" lang_id = "${lang}"/>:</b>

        <c:out value = "${row.cfp_criteria_weight}"/>

        <br>
        <b>

        <cf:GetPhrase phrase_id = "141" lang_id = "${lang}"/>:</b>

        <c:out value = "${row.cfp_high_rank}"/>

        <br>
        <b>

        <cf:GetPhrase phrase_id = "142" lang_id = "${lang}"/>:</b>

        <c:out value = "${row.cfp_low_rank}"/>

        <!--- option for coordinator to remove the criteria --->
        <c:if test = "${user == 'coordinator' and review_active == 'no'}">
            <br>
            <a STYLE = "text-decoration: underline"
               href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp_criteria'/>
<c:param name='cfp_criteria_id' value='${row.cfp_criteria_id}'/>
<c:param name='act' value='delete'/>
<c:param name='cfp_code' value='${row.cfp_code}'/>
<c:param name='${user}'/>
</c:url>">

            <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |
            <a STYLE = "text-decoration: underline"
               href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_edit_criteria'/>
<c:param name='cfp_criteria_id' value='${row.cfp_criteria_id}'/>
<c:param name='cfp_code' value='${row.cfp_code}'/>
<c:param name='${user}'/>
</c:url>">

            <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
        </c:if>
    </c:forEach>

    <!--- coordinator can add criteria for this cfp using following form --->

    <c:if test = "${user == 'coordinator' and review_active == 'no'}">
        <p>
        <h3>

        <cf:GetPhrase phrase_id = "145" lang_id = "${lang}"/></h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp_criteria'/>
<c:param name='${user}'/>
</c:url>"
              method = "post">
            <input type = "hidden" name = "cfp_code"
            value = "<c:out value='${cfp_code}'/>">
            <input type = "hidden" name = "act" value = "add">
            <input type = "hidden" name = "cfp_criteria_name_required"
            value = "<cf:GetPhrase phrase_id='450' lang_id='${lang}'/>"> <input type = "hidden" name = "cfp_criteria_weight_required" value = "<cf:GetPhrase phrase_id='451' lang_id='${lang}'/>">
            <input type = "hidden" name = "cfp_low_rank_required"
            value = "<cf:GetPhrase phrase_id='452' lang_id='${lang}'/>"> <input type = "hidden"
            name = "cfp_high_rank_required"
            value = "<cf:GetPhrase phrase_id='453' lang_id='${lang}'/>">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "139" lang_id = "${lang}"/>:</b>

            <br>
            <textarea name = "cfp_criteria_name" cols = "30" rows = "2" wrap>
            </textarea>

            <p>
            <b>*

            <cf:GetPhrase phrase_id = "142" lang_id = "${lang}"/>:</b>
            <input type = "text" name = "cfp_low_rank" size = "10"
            value = "<cf:GetPhrase phrase_id='465' lang_id='${lang}'/>"> <b>*

            <cf:GetPhrase phrase_id = "141" lang_id = "${lang}"/>:</b>
            <input type = "text" name = "cfp_high_rank" size = "10"
                   value = "<cf:GetPhrase phrase_id='466' lang_id='${lang}'/>">

            <br>
            <b>*

            <cf:GetPhrase phrase_id = "140" lang_id = "${lang}"/>:</b>
            <input type = "number" name = "cfp_criteria_weight" size = "6"></font>
            <input type = "Submit"
            value = "<cf:GetPhrase phrase_id="145" lang_id="${lang}" />">
        </form>

        <sql:query var = "source_cfp_criteria">
            select distinct C.cfp_title, C.cfp_code from cfp_info C,
            cfp_criteria CR where C.cfp_code<> ? AND
		CR.cfp_code = C.cfp_code
order by cfp_title
<sql:param value="${cfp_code}"/>
</sql:query>

<c:if test="${source_cfp_criteria.rowCount != 0}">

<p><h4><cf:GetPhrase phrase_id="146" lang_id="${lang}"/></h4>


<form action="<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_criteria_import'/>
<c:param name='${user}'/>
</c:url>" method="post">
<input type="hidden" name="cfp_code" value="<c:out value='${cfp_code}'/>">

<select name="source_cfp_code">
<c:forEach var="row" items="${source_cfp_criteria.rows}">
<option value="<c:out value='${row.cfp_code}'/>"><c:out value='${row.cfp_title}'/></c:forEach>
</select>

<input type="submit" value=" <cf:GetPhrase phrase_id="523" lang_id="${lang}" /> ">
</form>

</c:if>

</c:if>

</c:if>


