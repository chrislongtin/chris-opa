<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--------------------- DISPLAY ORGANIZATIONS -------------------------->

<sql:query var = "organizations">
    select a.*,b.organization_type_name from organizations a,
    organization_types b where a.chapter_id = ? and a.organization_type_id =
    b.organization_type_id and b.lang_id = ? order by organization_name

    <sql:param value = "${sessionScope.chapter}"/>

    <sql:param value = "${sessionScope.lang}"/>
</sql:query>

<table border = "0" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "+1" face = "Arial"><b>

            <fmt:message key = "1113" />
        </td>
    </tr>

    <c:choose>
        <c:when test = "${sessionScope.user=='coordinator'}">
            <tr>
                <td colspan = "4" align = "right">
                    <font size = "-1" face = "Arial">
                    <a href = "index.jsp?fuseaction=modify_organization&act=add">

                    <fmt:message key = "1118" /></a>

                    <p>
                </td>
            </tr>
        </c:when>

        <c:otherwise>
            <tr>
                <td colspan = "4">
                    &nbsp;
                </td>
            </tr>
        </c:otherwise>
    </c:choose>

    <c:forEach items = "${organizations.rows}" var = "row">
        <tr bgcolor = "E8E8E8">
            <td colspan = "2">
                <font face = "Arial"><b>

                <c:out value = "${row.organization_name}"/>
            </td>

            <td>
            </td>

            <td>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "1119" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_type_name}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "61" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_address_line_1}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "61" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_address_line_2}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "1058" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_city}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "1059" />:</b>
            </td>

            <td colspan = "1">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_prov_state_cd}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "1060" />:</b>
            </td>

            <td colspan = "2">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_prov_state_name}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "1061" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_postal_zip_code}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "62" />:
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_phone}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "29" />:
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_fax}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "24" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_email}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "64" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_url}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "23" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_contact_lastname},${row.organization_contact_firstname} "/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <fmt:message key = "24" />:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.organization_contact_email}"/>
            </td>
        </tr>

        <c:if test = "${sessionScope.user=='coordinator'}">
            <tr>
                <td colspan = "2">
                    &nbsp;
                </td>

                <td colspan = "2" align = "right">
                    <font size = "-2" face = "Arial">
                    <a href = "index.jsp?fuseaction=act_organization&act=delete&organization_id=<c:out value="${row.organization_id}" />">

                    <fmt:message key = "143" /></a> |
                    <a href = "index.jsp?fuseaction=modify_organization&act=edit&organization_id=<c:out value="${row.organization_id}" />">

                    <fmt:message key = "144" /></a>
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
