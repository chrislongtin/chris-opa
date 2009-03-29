<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<!--- determine reviewer id number --->
<c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

<!--- retrieve reviewer name --->
<sql:query var = "reviewer_name">
    select reviewer_lastname, reviewer_firstname from reviewers where
    reviewer_id = ?

    <sql:param value = "${reviewer}"/>
</sql:query>

<!--- retrieve proposal information --->
<sql:query var = "proposal_info">
    select * from proponent_record where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "pi" value = "${proposal_info.rows[0]}" scope = "page"/>

<!--- set cfp code associated with proposal --->
<c:set var = "cfp_code" value = "${proposal_info.rows[0].cfp_code}"
       scope = "page"/>

<!--- currency type --->
<sql:query var = "currency">
    select c.currency from currency_code c, cfp_info cf where cf.cfp_code = ?
    and cf.currency_id = c.currency_id

    <sql:param value = "$(cfp_code}"/>
</sql:query>

<c:set var = "currency" value = "${currency.rows[0].currency}" scope = "page"/>

<!--- determine what criteria are used --->
<sql:query var = "setup">
    select use_cfp_criteria, use_initiative_criteria, criteria_rankings,
    show_weights from initiative_setup
</sql:query>

<c:set var = "use_cfp_crit" value = "${setup.rows[0].use_cfp_criteria}"
       scope = "page"/>

<c:set var = "use_init_crit" value = "${setup.rows[0].use_initiative_criteria}"
       scope = "page"/>

<c:set var = "rankings" value = "${setup.rows[0].criteria_rankings}"
       scope = "page"/>

<c:set var = "weights" value = "${setup.rows[0].show_weights}" scope = "page"/>

<!--- retrieve initiative criteria --->
<c:if test = "${use_init_crit==1}">
    <sql:query var = "initiative_criteria">
        select * from initiative_criteria
    </sql:query>
</c:if>

<!--- retrieve cfp specific criteria based on cfp code --->
<c:if test = "${use_cfp_crit==1}">
    <sql:query var = "cfp_criteria">
        select * from cfp_criteria where cfp_code = ?

        <sql:param value = "${cfp_code}"/>
    </sql:query>
</c:if>

<sql:query var = "doc_info">
    select * from documents where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<h3>

<fmt:message key = "246" />

"

<c:out value = "${pi.proposal_title}"/>"</h3> <b>

<fmt:message key = "594" />:</b>

<c:out value = "${reviewer_name.rows[0].reviewer_firstname} ${reviewer_name.rows[0].reviewer_lastname}"/>

<!--- output proposal information --->
<br>
<b>

<fmt:message key = "57" />:</b>

<c:out value = "${pi.tracking_code}"/>

<br>
<b>

<fmt:message key = "56" />:</b>

<c:out value = "${pi.cfp_code}"/>

<br>
<b>

<fmt:message key = "595" />:</b><c:choose>
    <c:when test = "${doc_info.rowCount==0}">
        <fmt:message key = "596" />

        .
    </c:when>

    <c:otherwise>
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=proposal_docs_list&tracking_code=<c:out value="${tracking_code}" />&source=review">

        <fmt:message key = "597" /></a>
    </c:otherwise>
</c:choose>

<c:set var = "rank" value = "1" scope = "page"/>

<p>
<table border = "0" cellspacing = "0" cellpadding = "2">

    <!--- review submission form --->
    <form action = "index.jsp?fuseaction=act_proposal_review" method = "post">
        <input type = "hidden" name = "reviewer_id"
        value = "<c:out value="${reviewer}" />">
        <input type = "hidden" name = "tracking_code"
        value = "<c:out value="${tracking_code}" />"><c:if test = "${use_init_crit==1}">
            <tr>
                <td colspan = "2">
                    <h4>

                    <fmt:message key = "72" />:</h4>
                </td>
            </tr>

            <c:forEach items = "${initiative_criteria.rows}" var = "row">
                <tr>
                    <td colspan = "2">
                        <font face = "Arial" size = "-1"> <b>

                        <menu>
                        <cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>

                        </b>
                    </td>
                </tr>

                <tr>
                    <td align = "LEFT">
                        <font face = "Arial" size = "-1">(

                        <c:out value = "${row.i_low_rank}"/>)
                    </td>

                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1">(

                        <c:out value = "${row.i_high_rank}"/>)
                    </td>
                </tr>

                <tr>
                    <td colspan = "2" bgcolor = "E5E5E5">
                        <center>
                            <c:if test = "${rankings > 0}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "1">1
                            </c:if>

                            <c:if test = "${rankings > 1}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "2">2
                            </c:if>

                            <c:if test = "${rankings > 2}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "3">3
                            </c:if>

                            <c:if test = "${rankings > 3}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "4">4
                            </c:if>

                            <c:if test = "${rankings > 4}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "5">5
                            </c:if>

                            <c:if test = "${rankings > 5}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "6">6
                            </c:if>

                            <c:if test = "${rankings > 6}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "7">7
                            </c:if>

                            <c:if test = "${rankings > 7}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "8">8
                            </c:if>

                            <c:if test = "${rankings > 8}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "9">9
                            </c:if>

                            <c:if test = "${rankings > 9}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "10">10
                            </c:if>

                            <input type = "hidden"
                                   name = "rank<c:out value="${rank}" />_required"
                                   value = "<fmt:message key="660"  />">
                    </td>
                </tr>

                <tr>
                    <td colspan = "2">
                        <center>
                            <textarea name = "appraisal_comment" cols = "70"
                                      rows = "5"                 wrap = "yes">
                            </textarea>

                            <p>
                            <br>
                    </td>
                </tr>

                <input type = "hidden" name = "i_criteria_id"
                value = "<c:out value="${row.i_criteria_id}" />"> <input type = "hidden"
                name = "cfp_criteria_id" value = "0"> <input type = "hidden"
                name = "i_criteria_weight"
                value = "<c:out value="${row.i_criteria_weight}" />"> <input type = "hidden"
                name = "cfp_criteria_weight" value = "0">

                <c:set var = "rank" value = "${rank + 1}" scope = "page"/>
            </c:forEach>
        </c:if>

        <c:if test = "${use_cfp_crit==1}">
            <tr>
                <td colspan = "2">
                    <h4>

                    <fmt:message key = "74" />:</h4>
                </td>
            </tr>

            <c:forEach items = "${cfp_criteria.rows}" var = "row">
                <tr>
                    <td colspan = "2">
                        <font face = "Arial" size = "-1"> <b>

                        <menu>
                        <cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>

                        </b>
                    </td>
                </tr>

                <tr>
                    <td align = "LEFT">
                        <font face = "Arial" size = "-1">(

                        <c:out value = "${row.cfp_low_rank}"/>)
                    </td>

                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1">(

                        <c:out value = "${row.cfp_high_rank}"/>)
                    </td>
                </tr>

                <tr>
                    <td colspan = "2" bgcolor = "E5E5E5">
                        <center>
                            <c:if test = "${rankings > 0}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "1">1
                            </c:if>

                            <c:if test = "${rankings > 1}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "2">2
                            </c:if>

                            <c:if test = "${rankings > 2}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "3">3
                            </c:if>

                            <c:if test = "${rankings > 3}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "4">4
                            </c:if>

                            <c:if test = "${rankings > 4}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "5">5
                            </c:if>

                            <c:if test = "${rankings > 5}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "6">6
                            </c:if>

                            <c:if test = "${rankings > 6}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "7">7
                            </c:if>

                            <c:if test = "${rankings > 7}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "8">8
                            </c:if>

                            <c:if test = "${rankings > 8}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "9">9
                            </c:if>

                            <c:if test = "${rankings > 9}">
                                <input type = "radio"
                                       name = "rank<c:out value="${rank}" />"
                                       value = "10">10
                            </c:if>

                            <input type = "hidden"
                                   name = "rank<c:out value="${rank}" />_required"
                                   value = "<fmt:message key="660"  />">
                    </td>
                </tr>

                <tr>
                    <td colspan = "2">
                        <center>
                            <textarea name = "appraisal_comment" cols = "70"
                                      rows = "5"                 wrap = "yes">
                            </textarea>

                            <p>
                            <br>
                    </td>
                </tr>

                <input type = "hidden" name = "cfp_criteria_id"
                value = "<c:out value="${row.cfp_criteria_id}" />"> <input type = "hidden" name = "i_criteria_id" value = "0">
                <input type = "hidden" name = "cfp_criteria_weight"
                value = "<c:out value="${row.cfp_criteria_weight}" />"> <input type = "hidden"
                name = "i_criteria_weight" value = "0">

                <c:set var = "rank" value = "${rank + 1}" scope = "page"/>
            </c:forEach>
        </c:if>

        <c:set var = "maxrank" value = "${rank - 1}" scope = "page"/>
        <input type = "hidden" name = "maxrank"
        value = "<c:out value="${maxrank}" />"><sql:query var = "deadline">
            select cfp_proposal_review_deadline from cfp_info where cfp_code = ?

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <tr>
            <td colspan = "2">
                <font face = "Arial" size = "-1">

                <center>
                    <p>
                    <font color = "FF0000"><b>

                    <fmt:message key = "249" />

                    <fmt:formatDate value = "${deadline.rows[0].cfp_proposal_review_deadline}"
                                    pattern = "MMM dd, yyyy"/></b></font>

                    <p>
                    <input type = "submit"
                           value = " <fmt:message key="598"  /> ">
            </td>
        </tr>
    </form>
</table>
