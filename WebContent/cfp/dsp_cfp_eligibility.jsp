<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- display eligibility, process, criteria, & delivery of proposals --->

<sql:query var = "initiative_info">
    select eligibility, ia_name, ia_email, ia_address, ia_courier,
    ia_courier_inst, ia_fax, ia_phone from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<sql:query var = "initiative_criteria">
    select * from initiative_criteria order by i_criteria_id
</sql:query>

<sql:query var = "setup">
    select show_weights, use_initiative_criteria, use_cfp_criteria from
    initiative_setup
</sql:query>

<c:set var = "weights" value = "${setup.rows[0].show_weights}" scope = "page"/>

<c:set var = "init_crit" value = "${setup.rows[0].use_initiative_criteria}"
       scope = "page"/>

<c:set var = "cfp_crit" value = "${setup.rows[0].use_cfp_criteria}"
       scope = "page"/>

<sql:query var = "cfp_criteria">
    select * from cfp_criteria where cfp_code = ? order by cfp_criteria_id

    <sql:param value = "${param.cfp_code}"/>
</sql:query>

<sql:query var = "cfp_name">
    select cfp_title from cfp_info where cfp_code = ?

    <sql:param value = "${param.cfp_code}"/>
</sql:query>

<h3>(

<fmt:message key = "586" />

-

<c:out value = "${param.cfp_code}"/>

)

<c:out value = "${cfp_name.rows[0].cfp_title}"/></h3> <h4>

<fmt:message key = "17" />:</h4>

<p>
<c:out value = "${initiative_info.rows[0].eligibility}"/>
<c:if test = "${init_crit==1}">
    <h4>

    <fmt:message key = "72" />:</h4>

    <c:forEach items = "${initiative_criteria.rows}" var = "row">
        <p>
        <menu><cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>

        <c:if test = "${(weights == 'both') or (weights == 'public')}">
            <br>
            <font size = "-2"><b>

            <fmt:message key = "73" />:</b>

            <c:out value = "${row.i_criteria_weight}"/></font>
        </c:if>
    </c:forEach>
</c:if>

<c:if test = "${cfp_crit==1}">
    <h4>

    <fmt:message key = "74" />:</h4>

    <c:forEach items = "${cfp_criteria.rows}" var = "row">
        <p>
        <menu><cf:ParagraphFormat value = "${row.cfp_criteria_name}"/></menu>

        <c:if test = "${(weights == 'both') or (weights == 'public')}">
            <br>
            <font size = "-2"><b>

            <fmt:message key = "73" />:</b>

            <c:out value = "${row.cfp_criteria_weight}"/></font>
        </c:if>
    </c:forEach>
</c:if>

<p>
<font size = "+1"><a STYLE = "text-decoration: underline"
                     href = "index.jsp?fuseaction=cfp_proposal&cfp_code=<c:out value="${param.cfp_code}" />&lang=<c:out value="${lang}" />">

<fmt:message key = "75" /></a></font>

<p>
<fmt:message key = "76" />

<p>
<fmt:message key = "77" />:

<p>
<font size = "3"><a STYLE = "text-decoration: underline"
                    href = "cfp/dsp_plain_text_form.jsp"
                    target = "_blank">

<fmt:message key = "767" /></a></font>

<br>
<fmt:message key = "768" />.
<c:forEach items = "${initiative_info.rows}" var = "row">
    <center>
        <p>
        <b>

        <c:out value = "${row.ia_name}"/></b>

        <br>
        <fmt:message key = "24" />:
        <a STYLE = "text-decoration: underline"
           href = "mailto:<c:out value="${row.ia_email}" />">

        <c:out value = "${row.ia_email}"/></a>

        <br>
        <fmt:message key = "25" />:

        <c:out value = "${row.ia_address}"/>

        <br>
        <fmt:message key = "26" />:

        <c:out value = "${row.ia_courier}"/>

        <br>
        <fmt:message key = "27" />:

        <c:out value = "${row.ia_courier_inst}"/>

        <br>
        <fmt:message key = "28" />:

        <c:out value = "${row.ia_phone}"/> -

        <fmt:message key = "29" />:

        <c:out value = "${row.ia_fax}"/>
    </center>
</c:forEach>
