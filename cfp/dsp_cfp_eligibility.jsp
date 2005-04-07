<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- display eligibility, process, criteria, & delivery of proposals --->

<sql:query var = "initiative_info">
    select eligibility, ia_name, ia_email, ia_address, ia_courier, ia_courier_inst, ia_fax, ia_phone from
    initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<sql:query var = "initiative_criteria">
    select * from initiative_criteria order by i_criteria_id
</sql:query>

<sql:query var = "setup">
    select show_weights, use_initiative_criteria, use_cfp_criteria from initiative_setup
</sql:query>

<c:set var = "weights" value = "${setup.rows[0].show_weights}" scope = "page"/>

<c:set var = "init_crit" value = "${setup.rows[0].use_initiative_criteria}" scope = "page"/>

<c:set var = "cfp_crit" value = "${setup.rows[0].use_cfp_criteria}" scope = "page"/>

<sql:query var = "cfp_criteria">
    select * from cfp_criteria where cfp_code = ? order by cfp_criteria_id

    <sql:param value = "${param.cfp_code}"/>
</sql:query>

<sql:query var = "cfp_name">
    select cfp_title from cfp_info where cfp_code = ?

    <sql:param value = "${param.cfp_code}"/>
</sql:query>

<h3>(

<cf:GetPhrase phrase_id = "586" lang_id = "${lang}"/>

-

<c:out value = "${param.cfp_code}"/>

)

<c:out value = "${cfp_name.rows[0].cfp_title}"/></h3> <h4>

<cf:GetPhrase phrase_id = "17" lang_id = "${lang}"/>:</h4>

<p>
<c:out value = "${initiative_info.rows[0].eligibility}"/><c:if test = "${init_crit==1}">
    <h4>

    <cf:GetPhrase phrase_id = "72" lang_id = "${lang}"/>:</h4>

    <c:forEach items = "${initiative_criteria.rows}" var = "row">
        <p>
        <menu><cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>

        <c:if test = "${(weights == 'both') or (weights == 'public')}">
            <br>
            <font size = "-2"><b>

            <cf:GetPhrase phrase_id = "73" lang_id = "${lang}"/>:</b>

            <c:out value = "${row.i_criteria_weight}"/></font>
        </c:if>
    </c:forEach>
</c:if>

<c:if test = "${cfp_crit==1}">
    <h4>

    <cf:GetPhrase phrase_id = "74" lang_id = "${lang}"/>:</h4>

    <c:forEach items = "${cfp_criteria.rows}" var = "row">
        <p>
        <menu><cf:ParagraphFormat value = "${row.cfp_criteria_name}"/></menu>

        <c:if test = "${(weights == 'both') or (weights == 'public')}">
            <br>
            <font size = "-2"><b>

            <cf:GetPhrase phrase_id = "73" lang_id = "${lang}"/>:</b>

            <c:out value = "${row.cfp_criteria_weight}"/></font>
        </c:if>
    </c:forEach>
</c:if>

<p>
<font size = "+1"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=cfp_proposal&cfp_code=<c:out value="${param.cfp_code}" />&lang=<c:out value="${lang}" />">

<cf:GetPhrase phrase_id = "75" lang_id = "${lang}"/></a></font>

<p>
<cf:GetPhrase phrase_id = "76" lang_id = "${lang}"/>

<p>
<cf:GetPhrase phrase_id = "77" lang_id = "${lang}"/>:

<p>
<font size = "3"><a STYLE="text-decoration: underline"  href = "cfp/dsp_plain_text_form.jsp" target = "_blank">

<cf:GetPhrase phrase_id = "767" lang_id = "${lang}"/></a></font>

<br>
<cf:GetPhrase phrase_id = "768" lang_id = "${lang}"/>.<c:forEach items = "${initiative_info.rows}" var = "row">
    <center>
        <p>
        <b>

        <c:out value = "${row.ia_name}"/></b>

        <br>
        <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>: <a STYLE="text-decoration: underline"  href = "mailto:<c:out value="${row.ia_email}" />">

        <c:out value = "${row.ia_email}"/></a>

        <br>
        <cf:GetPhrase phrase_id = "25" lang_id = "${lang}"/>:

        <c:out value = "${row.ia_address}"/>

        <br>
        <cf:GetPhrase phrase_id = "26" lang_id = "${lang}"/>:

        <c:out value = "${row.ia_courier}"/>

        <br>
        <cf:GetPhrase phrase_id = "27" lang_id = "${lang}"/>:

        <c:out value = "${row.ia_courier_inst}"/>

        <br>
        <cf:GetPhrase phrase_id = "28" lang_id = "${lang}"/>:

        <c:out value = "${row.ia_phone}"/> -

        <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:

        <c:out value = "${row.ia_fax}"/>
    </center>
</c:forEach>
