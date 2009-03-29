<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- current CFP list --->

<sql:query var = "cfp_info">
    select * from cfp_info where cfp_code = ?

    <sql:param value = "${param.cfp_code}"/>
</sql:query>

<c:set var = "cfp" value = "${cfp_info.rows[0]}" scope = "page"/>

<sql:query var = "copyright">
    select copyright from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<c:set var = "cr" value = "${copyright.rows[0].copyright}" scope = "page"/>

<table border = "0" cellpadding = "5" cellspacing = "0">
    <tr>
        <td colspan = "2">
            <font face = "Arial"><h3>(

            <fmt:message key = "586" />

            -

            <c:out value = "${cfp.cfp_code}) ${cfp.cfp_title}"/></h3>
        </td>
    </tr>

    <tr>
        <td>
            <font face = "Arial" size = "-1"><b>

            <fmt:message key = "78" />:</b>
        </td>

        <td>
            <font face = "Arial" size = "-1">

            <fmt:formatDate value = "${cfp.cfp_startdate}"
                            pattern = "dd-MMM-yyyy"/>
        </td>
    </tr>

    <tr>
        <td>
            <font face = "Arial" size = "-1"><b>

            <fmt:message key = "79" />:</b>
        </td>

        <td>
            <font face = "Arial" size = "-1">

            <fmt:formatDate value = "${cfp.cfp_deadline}"
                            pattern = "dd-MMM-yyyy"/>
        </td>
    </tr>

    <c:if test = "${cfp.cfp_background!=''}">
        <tr>
            <td colspan = "2">
                <font face = "Arial" size = "-1"> <b>

                <fmt:message key = "80" />:</b>

                <p>
                <cf:ParagraphFormat value = "${cfp.cfp_background}"/>
            </td>
        </tr>
    </c:if>

    <c:if test = "${cfp.cfp_format!=''}">
        <tr>
            <td colspan = "2">
                <font face = "Arial" size = "-1"> <b>

                <fmt:message key = "63" />:</b>

                <p>
                <cf:ParagraphFormat value = "${cfp.cfp_format}"/>
            </td>
        </tr>
    </c:if>

    <tr>
        <td>
            <font face = "Arial" size = "-1"><b>

            <fmt:message key = "81" />:</b>
        </td>

        <td>
            <font face = "Arial" size = "-1"><b><font color = "FF0000">

            <fmt:message key = "586" />

            -

            <c:out value = "${cfp.cfp_code}"/></font></b>
        </td>
    </tr>

    <tr>
        <td colspan = "2">
            <font face = "Arial" size = "-1"><b>

            <fmt:message key = "82" />:</b>

            <fmt:formatNumber value = "${cfp.cfp_maxaward}" type = "currency"
                              currencySymbol = ""/>
        </td>
    </tr>

    <tr>
        <td colspan = "2">
            <font face = "Arial" size = "-1"><b>

            <fmt:message key = "83" />:</b>

            <fmt:formatNumber value = "${cfp.cfp_totalfunds}" type = "currency"
                              currencySymbol = ""/>
        </td>
    </tr>
</table>

<h4><a STYLE = "text-decoration: underline"
       href = "index.jsp?fuseaction=cfp_eligibility&cfp_code=<c:out value="${param.cfp_code}" />&lang=<c:out value="${lang}" />">

<fmt:message key = "84" /></a></h4>

<p>
<h3>

<fmt:message key = "19" />:</h3>

<cf:ParagraphFormat value = "${cr}"/>
