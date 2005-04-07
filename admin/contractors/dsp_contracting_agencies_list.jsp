<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!------------------------- CONTRACTING AGENCIES ------------------------------>

<sql:query var = "contracting_agencies">
    select * from contracting_agencies where agency_id >= 0 order by agency_name
</sql:query>

<table border = "1" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "right">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=contractors">

            <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td colspan = "3" align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "978" lang_id = "${lang}"/>
        </td>
    </tr>

    <c:if test = "${sessionScope.user=='coordinator'}">
        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>

        <form action = "index.jsp?fuseaction=modify_contracting_agency" method = "post">
            <input type = "hidden" name = "act" value = "add">

            <tr>
                <td colspan = "4" align = "center">
                    <input type = "submit" value = "<cf:GetPhrase phrase_id="975" lang_id="${lang}" />">
                </td>
            </tr>
        </form>
    </c:if>

    <c:forEach items = "${contracting_agencies.rows}" var = "row">
        <c:if test = "${sessionScope.user=='coordinator' }">
            <tr>
                <td>
                    <font face = "Arial">

                    <c:out value = "${row.agency_name}"/>
                </td>

                <td>
                    <font face = "Arial" size = "1"><c:choose>
                        <c:when test = "${sessionScope.user=='coordinator'}">
                            <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=act_contracting_agency&act=delete&agency_id=<c:out value="${row.agency_id}" />">

                            <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |
                        </c:when>

                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>

                    <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=modify_contracting_agency&act=edit&agency_id=<c:out value="${row.agency_id}" />">

                    <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
                </td>

                </td>
            </tr>
        </c:if>
    </c:forEach>
</table>
