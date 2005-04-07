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
    select reviewer_lastname, reviewer_firstname from reviewers where reviewer_id = ?

    <sql:param value = "${reviewer}"/>
</sql:query>

<!--- retrieve proposal information --->
<sql:query var = "proposal_info">
    select * from proponent_record where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "pi" value = "${proposal_info.rows[0]}" scope = "page"/>

<!--- set cfp code associated with proposal --->
<c:set var = "cfp_code" value = "${pi.cfp_code}" scope = "page"/>

<!--- currency type --->
<sql:query var = "currency">
    select c.currency from currency_code c, cfp_info cf where cf.cfp_code = ? and cf.currency_id = c.currency_id

    <sql:param value = "$(cfp_code}"/>
</sql:query>

<c:set var = "currency" value = "${currency.rows[0].currency}" scope = "page"/>

<!--- determine what criteria are used --->
<sql:query var = "setup">
    select use_cfp_criteria, use_initiative_criteria, criteria_rankings, show_weights from initiative_setup
</sql:query>

<c:set var = "use_cfp_crit" value = "${setup.rows[0].use_cfp_criteria}" scope = "page"/>

<c:set var = "use_init_crit" value = "${setup.rows[0].use_initiative_criteria}" scope = "page"/>

<c:set var = "rankings" value = "${setup.rows[0].criteria_rankings}" scope = "page"/>

<c:set var = "weights" value = "${setup.rows[0].show_weights}" scope = "page"/>

<sql:query var = "cfp_appraisal_info">
    select pa.*, cfp_criteria_name, cfp_criteria_weight, cfp_low_rank, cfp_high_rank from proposal_appraisal pa,
    cfp_criteria c where pa.reviewer_id = ? and pa.tracking_code = ? and pa.i_criteria_id = 0 and pa.cfp_criteria_id =
    c.cfp_criteria_id

    <sql:param value = "${reviewer}"/>

    <sql:param value = "${tracking_code}"/>
</sql:query>

<sql:query var = "i_appraisal_info">
    select pa.*, i_criteria_name, i_criteria_weight, i_low_rank, i_high_rank from proposal_appraisal pa,
    initiative_criteria ic where pa.reviewer_id = ? and pa.tracking_code = ? and pa.cfp_criteria_id = 0 and
    pa.i_criteria_id = ic.i_criteria_id

    <sql:param value = "${reviewer}"/>

    <sql:param value = "${tracking_code}"/>
</sql:query>

<sql:query var = "doc_info">
    select * from documents where tracking_code = ? and doc_type_id =1

    <sql:param value = "${tracking_code}"/>
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "246" lang_id = "${lang}"/>

"

<c:out value = "${pi.proposal_title}"/>" </h3> <b>

<cf:GetPhrase phrase_id = "594" lang_id = "${lang}"/>:</b>

<c:out value = "${reviewer_name.rows[0].reviewer_firstname} ${reviewer_name.rows[0].reviewer_lastname}"/>

<!--- output proposal information --->
<br>
<b>

<cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:</b>

<c:out value = "${pi.tracking_code}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/>:</b>

<c:out value = "${pi.cfp_code}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "595" lang_id = "${lang}"/>:</b><c:choose>
    <c:when test = "${doc_info.rowCount==0}">
        <cf:GetPhrase phrase_id = "596" lang_id = "${lang}"/>

        .
    </c:when>

    <c:otherwise>
        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=proposal_docs_list&tracking_code=<c:out value="${tracking_code}" />&source=review_edit">

        <cf:GetPhrase phrase_id = "597" lang_id = "${lang}"/></a>
    </c:otherwise>
</c:choose>

<c:set var = "rank" value = "1" scope = "page"/>

<p>
<table border = "0" cellspacing = "0" cellpadding = "2">
    <form action = "index.jsp?fuseaction=act_proposal_edit_review" method = "post">
        <input type = "hidden" name = "reviewer_id" value = "<c:out value="${reviewer}" />">
        <input type = "hidden" name = "tracking_code" value = "<c:out value="${tracking_code}" />">
        <c:if test = "${use_init_crit==1}">
            <tr>
                <td colspan = "2">
                    <h4>

                    <cf:GetPhrase phrase_id = "72" lang_id = "${lang}"/>:</h4>
                </td>
            </tr>

            <c:forEach items = "${i_appraisal_info.rows}" var = "row">
                <tr>
                    <td colspan = "2">
                        <font face = "Arial" size = "-1"> <b>

                        <menu><cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>

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
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "1" <c:if
                                       test = "${row.appraisal_rank==1}">checked
                            </c:if>

                            >1
            </c:if>

            <c:if test = "${rankings > 1}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "2" <c:if
                       test = "${row.appraisal_rank==2}">checked
            </c:if>

            >2

            </c:if>

            <c:if test = "${rankings > 2}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "3" <c:if
                       test = "${row.appraisal_rank==3}">checked
            </c:if>

            >3

            </c:if>

            <c:if test = "${rankings > 3}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "4" <c:if
                       test = "${row.appraisal_rank==4}">checked
            </c:if>

            >4

            </c:if>

            <c:if test = "${rankings > 4}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "5" <c:if
                       test = "${row.appraisal_rank==5}">checked
            </c:if>

            >5

            </c:if>

            <c:if test = "${rankings > 5}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "6" <c:if
                       test = "${row.appraisal_rank==6}">checked
            </c:if>

            >6

            </c:if>

            <c:if test = "${rankings > 6}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "7" <c:if
                       test = "${row.appraisal_rank==7}">checked
            </c:if>

            >7

            </c:if>

            <c:if test = "${rankings > 7}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "8" <c:if
                       test = "${row.appraisal_rank==8}">checked
            </c:if>

            >8

            </c:if>

            <c:if test = "${rankings > 8}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "9" <c:if
                       test = "${row.appraisal_rank==9}">checked
            </c:if>

            >9

            </c:if>

            <c:if test = "${rankings > 9}">
                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "10" <c:if
                       test = "${row.appraisal_rank==10}">checked
            </c:if>

            >10

            </c:if>

            </td>

            </tr>

            <tr>
                <td colspan = "2">
                    <center>
                        <textarea name = "appraisal_comment" cols = "70" rows = "5" wrap = "yes">
                            <c:out value = "${row.appraisal_comment}"/>
                        </textarea>

                        <p>
                        <br>
                </td>
            </tr>

            <input type = "hidden" name = "i_criteria_id" value = "<c:out value="${row.i_criteria_id}" />">
            <input type = "hidden" name = "cfp_criteria_id" value = "0">
            <input type = "hidden" name = "i_criteria_weight" value = "<c:out value="${row.i_criteria_weight}" />">
            <input type = "hidden" name = "cfp_criteria_weight" value = "0">
            <input type = "hidden" name = "appraisal_id" value = "<c:out value="${row.appraisal_id}" />">

            <c:set var = "rank" value = "${rank + 1}" scope = "page"/>

            </c:forEach>

            </c:if>

            <tr>
                <td colspan = "2">
                    <h4>

                    <cf:GetPhrase phrase_id = "74" lang_id = "${lang}"/>:</h4>
                </td>
            </tr>

            <c:forEach items = "${cfp_appraisal_info.rows}" var = "row">
                <tr>
                    <td colspan = "2">
                        <font face = "Arial" size = "-1"> <b>

                        <menu><cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>

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
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "1" <c:if
                                       test = "${row.appraisal_rank==1}">checked
                            </c:if>

                            >1

                            </c:if>

                            <c:if test = "${rankings > 1}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "2" <c:if
                                       test = "${row.appraisal_rank==2}">checked
                            </c:if>

                            >2

                            </c:if>

                            <c:if test = "${rankings > 2}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "3" <c:if
                                       test = "${row.appraisal_rank==3}">checked
                            </c:if>

                            >3

                            </c:if>

                            <c:if test = "${rankings > 3}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "4" <c:if
                                       test = "${row.appraisal_rank==4}">checked
                            </c:if>

                            >4

                            </c:if>

                            <c:if test = "${rankings > 4}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "5" <c:if
                                       test = "${row.appraisal_rank==5}">checked
                            </c:if>

                            >5

                            </c:if>

                            <c:if test = "${rankings > 5}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "6" <c:if
                                       test = "${row.appraisal_rank==6}">checked
                            </c:if>

                            >6

                            </c:if>

                            <c:if test = "${rankings > 6}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "7" <c:if
                                       test = "${row.appraisal_rank==7}">checked
                            </c:if>

                            >7

                            </c:if>

                            <c:if test = "${rankings > 7}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "8" <c:if
                                       test = "${row.appraisal_rank==8}">checked
                            </c:if>

                            >8

                            </c:if>

                            <c:if test = "${rankings > 8}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "9" <c:if
                                       test = "${row.appraisal_rank==9}">checked
                            </c:if>

                            >9

                            </c:if>

                            <c:if test = "${rankings > 9}">
                                <input type = "radio" name = "rank<c:out value="${rank}" />" value = "10" <c:if
                                       test = "${row.appraisal_rank==10}">checked
                            </c:if>

                            >10

                            </c:if>
                    </td>
                </tr>

                <tr>
                    <td colspan = "2">
                        <center>
                            <textarea name = "appraisal_comment" cols = "70" rows = "5" wrap = "yes">
                                <c:out value = "${row.appraisal_comment}"/>
                            </textarea>

                            <p>
                            <br>
                    </td>
                </tr>

                <input type = "hidden" name = "cfp_criteria_id" value = "<c:out value="${row.cfp_criteria_id}" />">
                <input type = "hidden" name = "i_criteria_id" value = "0"> <input type = "hidden"
                       name = "cfp_criteria_weight"
                       value = "<c:out value="${row.cfp_criteria_weight}" />">
                <input type = "hidden" name = "i_criteria_weight" value = "0">
                <input type = "hidden" name = "appraisal_id" value = "<c:out value="${row.appraisal_id}" />">

                <c:set var = "rank" value = "${rank + 1}" scope = "page"/>
            </c:forEach>

            <c:set var = "maxrank" value = "${rank - 1}" scope = "page"/>
            <input type = "hidden" name = "maxrank" value = "<c:out value="${maxrank}" />"><sql:query var = "deadline">
                select cfp_proposal_review_deadline from cfp_info where cfp_code = ?

                <sql:param value = "${cfp_code}"/>
            </sql:query>

            <tr>
                <td colspan = "2">
                    <font face = "Arial" size = "-1">

                    <center>
                        <p>
                        <font color = "FF0000"><b>

                        <cf:GetPhrase phrase_id = "249" lang_id = "${lang}"/>

                        <fmt:formatDate value = "${deadline.rows[0].cfp_proposal_review_deadline}"
                                        pattern = "MMM dd, yyyy"/></b></font>

                        <p>
                        <input type = "submit" value = " <cf:GetPhrase phrase_id="598" lang_id="${lang}" /> ">
                </td>
            </tr>
    </form>
</table>
