<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!------------------------- Organizations ------------------------------>

<sql:query var = "organizations">
    select * from organizations where chapter_id = ? order by organization_name

    <sql:param value = "${sessionScope.chapter}"/>
</sql:query>

<table border = "1" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "3" align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "1113" lang_id = "${lang}"/>
        </td>
    </tr>

    <c:if test = "${sessionScope.user=='coordinator'}">
        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>

        <%--         <tr bgcolor = "D7D7D7">
                    <td colspan = "4">
                        <font size = "-1" face = "Arial"><b>
        
                        <cf:GetPhrase phrase_id = "1118" lang_id = "${lang}"/>:
                    </td>
                </tr>
         --%>

        <form action = "index.jsp?fuseaction=modify_organization"
              method = "post">
            <input type = "hidden" name = "act" value = "add">

            <tr>
                <td colspan = "4" align = "center">
                    <input type = "submit"
                           value = "<cf:GetPhrase phrase_id="1118" lang_id="${lang}" />">
                </td>
            </tr>
        </form>
    </c:if>

    <c:forEach items = "${organizations.rows}" var = "row">
        <tr>
            <td>
                <font face = "Arial">

                <c:out value = "${row.organization_name}"/>
            </td>

            <td>
                <font face = "Arial">

                <c:out value = "${row.organization_city}"/>
            </td>

            <td>
                <font face = "Arial" size = "1"><c:choose>
                    <c:when test = "${sessionScope.user=='coordinator'}">
                        <a href = "index.jsp?fuseaction=act_organization&act=delete&organization_id=<c:out value="${row.organization_id}" />">

                        <cf:GetPhrase phrase_id = "143"
                                      lang_id = "${lang}"/></a> |
                    </c:when>

                    <c:otherwise>
                        &nbsp;
                    </c:otherwise>
                </c:choose>

                <a href = "index.jsp?fuseaction=modify_organization&act=edit&organization_id=<c:out value="${row.organization_id}" />">

                <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
            </td>

            </td>
        </tr>
    </c:forEach>
</table>
