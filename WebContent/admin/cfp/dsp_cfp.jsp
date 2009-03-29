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

    <fmt:message key = "56" />:</b> CFP-

    <c:out value = "${row.cfp_code}"/>

    <p>
    <b>

    <fmt:message key = "80" />:</b>

    <br>
    <cf:ParagraphFormat value = "${row.cfp_background}"/>

    <p>
    <b>

    <fmt:message key = "82" />:</b> (

    <c:out value = "${row.currency}"/>)

    <fmt:formatNumber value = "${row.cfp_maxaward}" type = "currency"
                      currencySymbol = ""/>

    <p>
    <b>

    <fmt:message key = "83" />:</b> (

    <c:out value = "${row.currency}"/>)

    <fmt:formatNumber value = "${row.cfp_totalfunds}" type = "currency"
                      currencySymbol = ""/>

    <p>
    <b>

    <fmt:message key = "977" />:</b>
    <c:forEach items = "${edit_cfp_agencies.rows}" var = "rowag">
        <c:out value = "${rowag.agency_name}"/>
    </c:forEach>

    <p>
    <b>

    <fmt:message key = "78" />:</b>

    <fmt:formatDate value = "${row.cfp_startdate}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <fmt:message key = "123" />:</b>

    <fmt:formatDate value = "${row.cfp_deadline}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <fmt:message key = "124" />:</b>

    <fmt:formatDate value = "${row.cfp_proposal_review_deadline}"
                    pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <fmt:message key = "125" />:</b>

    <fmt:formatDate value = "${row.first_reminder}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <fmt:message key = "126" />:</b>

    <fmt:formatDate value = "${row.second_reminder}" pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <fmt:message key = "127" />:</b>

    <fmt:formatDate value = "${row.cfp_report_deadline}"
                    pattern = "dd-MMM-yyyy"/>

    <br>
    <b>

    <fmt:message key = "128" />:</b>

    <fmt:formatDate value = "${row.cfp_report_review_deadline}"
                    pattern = "dd-MMM-yyyy"/>

    <p>
    <b>

    <fmt:message key = "129" />:</b>

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

    <fmt:message key = "131" /></a>
    <!--- link for coordinator to delete cfp info --->
    | <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='delete_cfp'/>
<c:param name='act' value='confirm'/>
<c:param name='cfp_code' value='${cfp_code}'/>
<c:param name='${user}'/>
</c:url>">

    <fmt:message key = "132" /></a> <b>

    <fmt:message key = "130" /></b>
</c:if>

<h3>

<fmt:message key = "445" />:</h3>

<c:if test = "${user == 'coordinator'}">
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_category'/>
<c:param name='cfp_code' value='${cfp_code}'/>
</c:url>">

    <fmt:message key = "446" /></a>

    <p>
</c:if>

<sql:query var = "cfp_category_list">
    select cfp_cat_name, cfp_cat_id from cfp_category where cfp_code = ? order
    by cfp_cat_id

    <sql:param value = "${cfp_code}"/>
</sql:query>

<c:if test = "${cfp_category_list.rowCount == 0}">
    <p>
    <fmt:message key = "447" />
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

            <fmt:message key = "144" /></a> |
            <a STYLE = "text-decoration: underline"
               href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp_cat'/>
<c:param name='cfp_code' value='${cfp_code}'/>
<c:param name='cfp_cat_id' value='${row.cfp_cat_id}'/>
<c:param name='act' value='delete'/>
</c:url>">

            <fmt:message key = "143" /></a> ]
        </c:if>
    </c:forEach>
</ul>

<h3>

<fmt:message key = "3" /></h3>

<c:choose>
    <c:when test = "${user == 'coordinator' and review_active == 'no'}">
        <p>
        <fmt:message key = "133" />
    </c:when>

    <c:when test = "${user == 'coordinator' and review_active == 'yes'}">
        <p>
        <font color = "FF0000">

        <fmt:message key = "134" /></font>
    </c:when>
</c:choose>

<!--- link to general criteria for this initiative --->
<c:forEach var = "row" items = "${setup.rows}">
    <c:if test = "${row.use_initiative_criteria == 1}">
        <p>
        <h4><a STYLE = "text-decoration: underline"
               href = "index.jsp?fuseaction=criteria">

        <fmt:message key = "135" /></a></h4>
    </c:if>
</c:forEach>

<c:if test = "${use_cfp_crit == 1}">
    <p>
    <h4>

    <fmt:message key = "136" /></h4>
    <c:if test = "${cfp_criteria.rowCount == 0}">
        <fmt:message key = "137" />
    </c:if>

    <!--- display criteria for this cfp --->
    <c:forEach var = "row" items = "${cfp_criteria.rows}">
        <p>
        <b>

        <fmt:message key = "138" />:</b> C-

        <c:out value = "${row.cfp_criteria_id}"/>

        <br>
        <b>

        <fmt:message key = "139" />:</b>

        <menu><cf:ParagraphFormat value = "${row.cfp_criteria_name}"/></menu>

        <br>
        <b>

        <fmt:message key = "140" />:</b>

        <c:out value = "${row.cfp_criteria_weight}"/>

        <br>
        <b>

        <fmt:message key = "141" />:</b>

        <c:out value = "${row.cfp_high_rank}"/>

        <br>
        <b>

        <fmt:message key = "142" />:</b>

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

            <fmt:message key = "143" /></a> |
            <a STYLE = "text-decoration: underline"
               href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_edit_criteria'/>
<c:param name='cfp_criteria_id' value='${row.cfp_criteria_id}'/>
<c:param name='cfp_code' value='${row.cfp_code}'/>
<c:param name='${user}'/>
</c:url>">

            <fmt:message key = "144" /></a>
        </c:if>
    </c:forEach>

    <!--- coordinator can add criteria for this cfp using following form --->

    <c:if test = "${user == 'coordinator' and review_active == 'no'}">
        <p>
        <h3>

        <fmt:message key = "145" /></h3>

        <p>
        <fmt:message key = "41" />

        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp_criteria'/>
<c:param name='${user}'/>
</c:url>"
              method = "post">
            <input type = "hidden" name = "cfp_code"
            value = "<c:out value='${cfp_code}'/>">
            <input type = "hidden" name = "act" value = "add">
            <input type = "hidden" name = "cfp_criteria_name_required"
            value = "<fmt:message key='450' />"> <input type = "hidden" name = "cfp_criteria_weight_required" value = "<fmt:message key='451' />">
            <input type = "hidden" name = "cfp_low_rank_required"
            value = "<fmt:message key='452' />"> <input type = "hidden"
            name = "cfp_high_rank_required"
            value = "<fmt:message key='453' />">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "139" />:</b>

            <br>
            <textarea name = "cfp_criteria_name" cols = "30" rows = "2" wrap>
            </textarea>

            <p>
            <b>*

            <fmt:message key = "142" />:</b>
            <input type = "text" name = "cfp_low_rank" size = "10"
            value = "<fmt:message key='465' />"> <b>*

            <fmt:message key = "141" />:</b>
            <input type = "text" name = "cfp_high_rank" size = "10"
                   value = "<fmt:message key='466' />">

            <br>
            <b>*

            <fmt:message key = "140" />:</b>
            <input type = "number" name = "cfp_criteria_weight" size = "6"></font>
            <input type = "Submit"
            value = "<fmt:message key="145"  />">
        </form>

        <sql:query var = "source_cfp_criteria">
            select distinct C.cfp_title, C.cfp_code from cfp_info C,
            cfp_criteria CR where C.cfp_code<> ? AND
		CR.cfp_code = C.cfp_code
order by cfp_title
<sql:param value="${cfp_code}"/>
</sql:query>

<c:if test="${source_cfp_criteria.rowCount != 0}">

<p><h4><fmt:message key="146" /></h4>


<form action="<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_criteria_import'/>
<c:param name='${user}'/>
</c:url>" method="post">
<input type="hidden" name="cfp_code" value="<c:out value='${cfp_code}'/>">

<select name="source_cfp_code">
<c:forEach var="row" items="${source_cfp_criteria.rows}">
<option value="<c:out value='${row.cfp_code}'/>"><c:out value='${row.cfp_title}'/></c:forEach>
</select>

<input type="submit" value=" <fmt:message key="523"  /> ">
</form>

</c:if>

</c:if>

</c:if>


