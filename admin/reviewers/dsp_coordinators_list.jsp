<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--------------------- DISPLAY COORDINATORS -------------------------->

<sql:query var = "coordinators">
    select * from coordinators order by coordinator_lastname, coordinator_firstname
</sql:query>

<table border = "1" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "3" align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "338" lang_id = "${lang}"/>
        </td>
    </tr>

    <c:choose>
        <c:when test = "${sessionScope.user=='coordinator'}">
            <tr>
                <td colspan = "3" align = "right">
                    <font size = "-1" face = "Arial"> <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=modify_coordinator&act=add">

                    <cf:GetPhrase phrase_id = "328" lang_id = "${lang}"/></a>

                    <p>
                </td>
            </tr>
        </c:when>

        <c:otherwise>
            <tr>
                <td colspan = "3">
                    &nbsp;
                </td>
            </tr>
        </c:otherwise>
    </c:choose>

    <c:forEach items = "${coordinators.rows}" var = "row">
        <tr bgcolor = "E8E8E8">
            <td>
                <font face = "Arial">

                <c:out value = "${row.coordinator_lastname}"/>
            </td>

            <td>
                <font face = "Arial">

                <c:out value = "${row.coordinator_firstname}"/>
            </td>

            <c:if test = "${sessionScope.user=='coordinator'}">
                <td>
                    <font face = "Arial" size = "1">
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=act_coordinator&act=delete&coordinator_id=<c:out value="${row.coordinator_id}" />">

                    <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |
                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=modify_coordinator&act=edit&coordinator_id=<c:out value="${row.coordinator_id}" />">

                    <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
                </td>
        </tr>

        </c:if>
    </c:forEach>
</table>
