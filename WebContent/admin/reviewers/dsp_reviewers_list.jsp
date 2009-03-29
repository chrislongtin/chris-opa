<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

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

<table border = "1" cellspacing = "0" cellpadding = "2" width = "100%">
    <tr bgcolor = "BCBCBC">
        <td colspan = "3" align = "center">
            <font size = "+1" face = "Arial"><b>

            <fmt:message key = "252" />
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

                <fmt:message key = "715" />:
            </td>
        </tr>

        <form action = "index.jsp?fuseaction=modify_reviewer" method = "post">
            <input type = "hidden" name = "act" value = "add">

            <tr bgcolor = "EBEBEB">
                <td colspan = "4" align = "center">
                    <font size = "-1" face = "Arial">

                    <fmt:message key = "706" />

                    :<c:choose>
                        <c:when test = "${reviewer_cfp_code==0}">
                            <select name = "cfp_code">
                                <option value = "0">
                                <fmt:message key = "641"
                                              />

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
                           value = "<fmt:message key="716"  />">
                </td>
            </tr>
        </form>
    </c:if>

    <c:forEach items = "${reviewers.rows}" var = "row">
        <c:if test = "${(sessionScope.user=='coordinator') or (reviewer==row.reviewer_id) or (reviewer_organizer==1)}">
            <tr>
                <td>
                    <font face = "Arial">

                    <c:out value = "${row.reviewer_lastname}"/>
                </td>

                <td>
                    <font face = "Arial">

                    <c:out value = "${row.reviewer_firstname}"/>
                </td>

                <td>
                    <font face = "Arial" size = "1"><c:choose>
                        <c:when test = "${(sessionScope.user=='coordinator') or (reviewer_organizer==1)}">
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp?fuseaction=act_reviewer&act=delete&reviewer_id=<c:out value="${row.reviewer_id}" />">

                            <fmt:message key = "143"
                            /></a> |
                        </c:when>

                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>

                    <a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=modify_reviewer&act=edit&reviewer_id=<c:out value="${row.reviewer_id}" />">

                    <fmt:message key = "144" /></a>
                </td>

                </td>
            </tr>
        </c:if>
    </c:forEach>
</table>
