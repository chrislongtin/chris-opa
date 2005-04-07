<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!------------------------- CONTRACTORS ------------------------------>

<c:set var = "contractor_cfp_code">
    <c:out value = "${param.contractor_cfp_code}" default = "0"/>
</c:set>

<c:set var = "contractor_cfp_cat_id">
    <c:out value = "${param.contractor_cfp_cat_id}" default = "0"/>
</c:set>

<sql:query var = "contractors">
    select * from contractors where contractor_id > 0

    <c:if test = "${contractor_cfp_code!=0}">
        and cfp_code = ?
    </c:if>

    <c:if test = "${contractor_cfp_cat_id!=0}">
        and cfp_cat_id = ?
    </c:if>

    order by contractor_lastname, contractor_firstname

    <c:if test = "${contractor_cfp_code!=0}">
        <sql:param value = "${contractor_cfp_code}"/>
    </c:if>

    <c:if test = "${contractor_cfp_cat_id!=0}">
        <sql:param value = "${contractor_cfp_cat_id}"/>
    </c:if>
</sql:query>

<sql:query var = "contracting_agencies">
    select * from contracting_agencies order by agency_name
</sql:query>

<table border = "1" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "right">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=contracting_agencies">

            <cf:GetPhrase phrase_id = "978" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/>
        </td>
    </tr>

    <c:if test = "${sessionScope.user=='coordinator'}">
        <sql:query var = "cfp_list">
            select cfp_code, cfp_title from cfp_info order by cfp_title
        </sql:query>

        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>

        <tr bgcolor = "D7D7D7">
            <td colspan = "4">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "959" lang_id = "${lang}"/>:
            </td>
        </tr>

        <form action = "index.jsp?fuseaction=modify_contractor" method = "post">
            <input type = "hidden" name = "act" value = "add">

            <tr bgcolor = "EBEBEB">
                <td colspan = "4" align = "center">
                    <font size = "-1" face = "Arial">

                    <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>

                    :<c:choose>
                        <c:when test = "${contractor_cfp_code==0}">
                            <select name = "cfp_code">
                                <option value = "0"><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                                <c:forEach items = "${cfp_list.rows}" var = "row">
                                    <option value = "<c:out value="${row.cfp_code}" />">
                                    <c:out value = "${row.cfp_title}"/>
                                </c:forEach>
                            </select>
                        </c:when>

                        <c:otherwise>
                            <input type = "hidden" name = "cfp_code" value = "<c:out value="${contractor_cfp_code}" />">

                            <c:out value = "${cfp_title}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <td colspan = "4" align = "center">
                    <font size = "-1" face = "Arial">

                    <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>

                    :

                    <select name = "agency_id">
                        <option value = "0"><cf:GetPhrase phrase_id = "550" lang_id = "${lang}"/>

                        <c:forEach items = "${contracting_agencies.rows}" var = "row">
                            <option value = "<c:out value="${row.agency_id}" />"><c:out value = "${row.agency_name}"/>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td colspan = "4" align = "center">
                    <input type = "submit" value = "<cf:GetPhrase phrase_id="959" lang_id="${lang}" />">
                </td>
            </tr>
        </form>
    </c:if>

    <c:forEach items = "${contractors.rows}" var = "row">
        <c:if test = "${sessionScope.user=='coordinator' }">
            <tr>
                <td valign = "top">
                    <font face = "Arial">

                    <c:out value = "${row.contractor_lastname}"/>
                </td>

                <td valign = "top">
                    <font face = "Arial">

                    <c:out value = "${row.contractor_firstname}"/>
                </td>

                <c:choose>
                    <c:when test = "${sessionScope.user=='coordinator'}">
                        <td valign = "top">
                            <font face = "Arial" size = "1">

                            <form action = "index.jsp?fuseaction=act_contractor_del" method = "post">
                                <input type = "hidden" name = "act" value = "delete"> <input type = "hidden"
                                       name = "contractor_id"
                                       value = "<c:out value="${row.contractor_id}" />"> <input type = "hidden"
                                       name = "delete_confirm"
                                       value = "<cf:GetPhrase phrase_id="543" lang_id="${lang}" />">
                                <input type = "submit" value = "<cf:GetPhrase phrase_id="143" lang_id="${lang}" />">
                            </form>
                        </td>
                    </c:when>
                </c:choose>

                <td valign = "top">
                    <font face = "Arial" size = "1">

                    <form action = "index.jsp?fuseaction=modify_contractor" method = "post">
                        <input type = "hidden" name = "act" value = "edit"> <input type = "hidden"
                               name = "contractor_id"
                               value = "<c:out value="${row.contractor_id}" />">
                        <input type = "submit" value = "<cf:GetPhrase phrase_id="144" lang_id="${lang}" />">
                    </form>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</table>
