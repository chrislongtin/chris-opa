<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--------------------- DISPLAY CONTRACTING AGENCIES -------------------------->

<c:set var = "contracting_agency" value = "${sessionScope.caid}" scope = "page"/>

<sql:query var = "contracting_agencies">
    select * from contracting_agencies where agency_id >= 0 order by agency_name
</sql:query>

<table border = "0" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "right">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=contractors">

            <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "978" lang_id = "${lang}"/>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=simple_contracting_agencies_list">

            <cf:GetPhrase phrase_id = "981" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <tr>
        <td colspan = "4">
            &nbsp;
        </td>
    </tr>

    <tr bgcolor = "EBEBEB">
        <td colspan = "4" align = "right">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=modify_contracting_agency&act=add">

            <cf:GetPhrase phrase_id = "975" lang_id = "${lang}"/>
            <!---  Add New Contracting Agency --->
            </p></font>
        </td>
    </tr>
    <!--- End Add Contracting Agency --->
    <c:forEach items = "${contracting_agencies.rows}" var = "row">
        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>

        <tr bgcolor = "E8E8E8">
            <td colspan = "2">
                <font face = "Arial"><b>

                <c:out value = "${row.agency_name}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "200" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.agency_contact}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.agency_email}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.agency_phone}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.agency_url}"/>
            </td>
        </tr>

        <c:if test = "${sessionScope.user=='coordinator' }">
            <tr>
                <td colspan = "2">
                    &nbsp;
                </td>

                <td colspan = "2" align = "right">
                    <font size = "-2" face = "Arial">
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=act_contracting_agency&act=delete&agency_id=<c:out value="${row.agency_id}" />">

                    <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=modify_contracting_agency&act=edit&agency_id=<c:out value="${row.agency_id}" />">

                    <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
                </td>
            </tr>
        </c:if>

        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>
    </c:forEach>
</table>
