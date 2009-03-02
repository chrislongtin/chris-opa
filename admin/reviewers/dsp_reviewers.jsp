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
    select * from coordinators order by coordinator_lastname,
    coordinator_firstname
</sql:query>

<table border = "0" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "338" lang_id = "${lang}"/>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "1"
                  face = "Arial"><a STYLE = "text-decoration: underline"
                                    href = "index.jsp?fuseaction=simple_coordinators_list">

            <cf:GetPhrase phrase_id = "945" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <c:choose>
        <c:when test = "${sessionScope.user=='coordinator'}">
            <tr>
                <td colspan = "4" align = "right">
                    <font size = "-1" face = "Arial">
                    <a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=modify_coordinator&act=add">

                    <cf:GetPhrase phrase_id = "328" lang_id = "${lang}"/></a>

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

    <c:forEach items = "${coordinators.rows}" var = "row">
        <tr bgcolor = "E8E8E8">
            <td colspan = "2">
                <font face = "Arial"><b>

                <c:out value = "${row.coordinator_lastname}, ${row.coordinator_firstname}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.coordinator_login}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.coordinator_email}"/>
            </td>
        </tr>

        <c:if test = "${row.receive_public_emails==1}">
            <tr>
                <td>
                    <font size = "-1" face = "Arial" color = "FF0000"><b>

                    <cf:GetPhrase phrase_id = "713" lang_id = "${lang}"/>:
                </td>

                <td colspan = "3">
                    <font size = "-1" face = "Arial">

                    <c:out value = "${row.coordinator_public_email}"/>
                </td>
            </tr>
        </c:if>

        <c:if test = "${row.receive_admin_emails==1}">
            <tr>
                <td>
                    <font size = "-1" face = "Arial" color = "FF0000"><b>

                    <cf:GetPhrase phrase_id = "335" lang_id = "${lang}"/>:
                </td>

                <td colspan = "3">
                    <font size = "-1" face = "Arial">

                    <c:out value = "${row.coordinator_admin_email}"/>
                </td>
            </tr>
        </c:if>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.coordinator_phone}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.coordinator_fax}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.coordinator_address}"/>
            </td>
        </tr>

        <c:if test = "${sessionScope.user=='coordinator'}">
            <tr>
                <td colspan = "2">
                    &nbsp;
                </td>

                <td colspan = "2" align = "right">
                    <font size = "-2" face = "Arial">
                    <a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=act_coordinator&act=delete&coordinator_id=<c:out value="${row.coordinator_id}" />">

                    <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |
                    <a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=modify_coordinator&act=edit&coordinator_id=<c:out value="${row.coordinator_id}" />">

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

<!------------------------- REVIEWERS ------------------------------>
<c:set var = "reviewer_organizer">
    <c:out value = "${param.reviewer_organizer}" default = "0"/>
</c:set>

<c:set var = "reviewer_cfp_code">
    <c:out value = "${param.reviewer_cfp_code}" default = "0"/>
</c:set>

<c:set var = "reviewer_cfp_cat_id">
    <c:out value = "${param.reviewer_cfp_cat_id}" default = "0"/>
</c:set>

<c:if test = "${sessionScope.user!='coordinator'}">
    <c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

    <!--- check to see if reviewer is a reviewer coordinator --->
    <sql:query var = "r_coord_check">
        select reviewer_coordinator, cfp_code, cfp_cat_id from reviewers where
        reviewer_id = ?

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <c:set var = "reviewer_organizer"
           value = "${r_coord_check.rows[0].reviewer_coordinator}"
           scope = "page"/>

    <c:set var = "reviewer_cfp_code" value = "${r_coord_check.rows[0].cfp_code}"
           scope = "page"/>

    <c:set var = "reviewer_cfp_cat_id"
           value = "${r_coord_check.rows[0].cfp_cat_id}"
           scope = "page"/>

    <!--- if the reviewer is associated with a specific CFP, limit the information that is shown to the reviewer, and limit the options for setting up a new reviewer --->
    <c:if test = "${reviewer_cfp_code!=0}">
        <sql:query var = "r_cfp_title">
            select cfp_title from cfp_info where cfp_code = ?

            <sql:param value = "${reviewer_cfp_code}"/>
        </sql:query>

        <c:set var = "cfp_title" value = "${r_cfp_title.rows[0].cfp_title}"
               scope = "page"/>
    </c:if>
</c:if>

<sql:query var = "reviewers">
    select * from reviewers where reviewer_id > 0

    <c:if test = "${reviewer_cfp_code!=0}">
        and cfp_code = ?
    </c:if>

    <c:if test = "${reviewer_cfp_cat_id!=0}">
        and cfp_cat_id = ?
    </c:if>

    order by reviewer_lastname, reviewer_firstname

    <c:if test = "${reviewer_cfp_code!=0}">
        <sql:param value = "${reviewer_cfp_code}"/>
    </c:if>

    <c:if test = "${reviewer_cfp_cat_id!=0}">
        <sql:param value = "${reviewer_cfp_cat_id}"/>
    </c:if>
</sql:query>

<table border = "0" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "252" lang_id = "${lang}"/>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td colspan = "4" align = "center">
            <font size = "1"
                  face = "Arial"><a STYLE = "text-decoration: underline"
                                    href = "index.jsp?fuseaction=simple_reviewers_list">

            <cf:GetPhrase phrase_id = "946" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <c:if test = "${(sessionScope.user=='coordinator') or (reviewer_organizer==1)}">
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

                <cf:GetPhrase phrase_id = "715" lang_id = "${lang}"/>:
            </td>
        </tr>

        <form action = "index.jsp?fuseaction=modify_reviewer" method = "post">
            <input type = "hidden" name = "act" value = "add">

            <tr bgcolor = "EBEBEB">
                <td colspan = "4" align = "center">
                    <font size = "-1" face = "Arial">

                    <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>

                    :<c:choose>
                        <c:when test = "${reviewer_cfp_code==0}">
                            <select name = "cfp_code">
                                <option value = "0">
                                <cf:GetPhrase phrase_id = "641"
                                              lang_id = "${lang}"/>

                                <c:forEach items = "${cfp_list.rows}"
                                           var = "row">
                                    <option value = "<c:out value="${row.cfp_code}" />"><c:out value = "${row.cfp_title}"/>
                                </c:forEach>
                            </select>
                        </c:when>

                        <c:otherwise>
                            <input type = "hidden"
                                   name = "cfp_code"
                                   value = "<c:out value="${reviewer_cfp_code}" />">

                            <c:out value = "${cfp_title}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <td colspan = "4" align = "center">
                    <input type = "submit"
                           value = "<cf:GetPhrase phrase_id="716" lang_id="${lang}" />">
                </td>
            </tr>
        </form>
    </c:if>

    <c:forEach items = "${reviewers.rows}" var = "row">
        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>

        <tr bgcolor = "E8E8E8">
            <td colspan = "2">
                <font face = "Arial"><b>

                <c:out value = "${row.reviewer_lastname}, ${row.reviewer_firstname}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.reviewer_login}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.reviewer_email}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.reviewer_phone}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.reviewer_fax}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.reviewer_address}"/>
            </td>
        </tr>

        <tr>
            <td valign = "TOP">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "704" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.reviewer_profile}"/>
            </td>
        </tr>

        <tr>
            <td valign = "TOP">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "1022" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "3">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.payment_rate}"/>
            </td>
        </tr>

        <c:if test = "${row.reviewer_coordinator==1}">
            <tr>
                <td colspan = "4">
                    <font size = "-1" face = "Arial" color = "FF0000">

                    <cf:GetPhrase phrase_id = "717" lang_id = "${lang}"/>
                </td>
            </tr>
        </c:if>

        <c:if test = "${row.cfp_code!=0}">
            <sql:query var = "cfp_info">
                select cfp_code, cfp_title from cfp_info where cfp_code = ?

                <sql:param value = "${row.cfp_code}"/>
            </sql:query>

            <tr>
                <td>
                    <font face = "Arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "586" lang_id = "${lang}"/>:
                </td>

                <td colspan = "3">
                    <font face = "Arial" size = "-1">

                    <c:out value = "${cfp_info.rows[0].cfp_title}"/>
                </td>
            </tr>
        </c:if>

        <c:if test = "${row.cfp_cat_id!=0}">
            <sql:query var = "cfp_cat_info">
                select cfp_cat_id, cfp_cat_name from cfp_category where
                cfp_cat_id = ?

                <sql:param value = "${row.cfp_cat_id}"/>
            </sql:query>

            <tr>
                <td>
                    <font face = "Arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "630" lang_id = "${lang}"/>:
                </td>

                <td colspan = "3">
                    <font face = "Arial" size = "-1">

                    <c:out value = "${cfp_cat_info.rows[0].cfp_cat_name}"/>
                </td>
            </tr>
        </c:if>

        <c:if test = "${(sessionScope.user=='coordinator') or (reviewer==row.reviewer_id) or (reviewer_organizer==1)}">
            <tr>
                <td colspan = "2">
                    &nbsp;
                </td>

                <td colspan = "2" align = "right">
                    <font size = "-2" face = "Arial"><c:choose>
                        <c:when test = "${(sessionScope.user=='coordinator') or (reviewer_organizer==1)}">
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp?fuseaction=act_reviewer&act=delete&reviewer_id=<c:out value="${row.reviewer_id}" />">

                            <cf:GetPhrase phrase_id = "143"
                            lang_id = "${lang}"/></a> |
                        </c:when>

                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>

                    <a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=modify_reviewer&act=edit&reviewer_id=<c:out value="${row.reviewer_id}" />">

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
