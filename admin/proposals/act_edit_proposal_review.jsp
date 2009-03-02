<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--- process edit reviews --->

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "reviewer_id">
    <c:out value = "${param.reviewer_id}" default = ""/>
</c:set>

<c:set var = "maxrank">
    <c:out value = "${param.maxrank}" default = ""/>
</c:set>

<!--- loop from 1 to the maximum rank number --->
<c:forEach begin = "0" end = "${maxrank-1}" var = "row">
    <c:set var = "rank" value = "rank${row+1}" scope = "page"/>

    <c:set var = "appraisal_comment"
           value = "${paramValues.appraisal_comment[row]}"
           scope = "page"/>

    <!--- calculating the score based on rank & weight --->
    <c:choose>
        <c:when test = "${paramValues.i_criteria_id[row]!=0}">
            <c:set var = "appraisal_score"
                   value = "${paramValues.i_criteria_weight[row] * param[rank]}"
                   scope = "page"/>
        </c:when>

        <c:otherwise>
            <c:if test = "${paramValues.cfp_criteria_id[row]!=0}">
                <c:set var = "appraisal_score"
                       value = "${paramValues.cfp_criteria_weight[row] * param[rank]}"
                       scope = "page"/>
            </c:if>
        </c:otherwise>
    </c:choose>

    <!--- inserting the rank and score for each criteria --->
    <sql:update>
        update proposal_appraisal set appraisal_rank = ?, appraisal_score = ?,
        appraisal_comment = ? where appraisal_id = ?

        <sql:param value = "${param[rank]}"/>

        <sql:param value = "${appraisal_score}"/>

        <sql:param value = "${appraisal_comment}"/>

        <sql:param value = "${paramValues.appraisal_id[row]}"/>
    </sql:update>
</c:forEach>

<sql:query var = "sum">
    select SUM(appraisal_score) as score_sum, SUM(appraisal_rank) as rank_sum
    from proposal_appraisal where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "score_sum2" value = "${sum.rows[0].score_sum}" scope = "page"/>

<c:set var = "rank_sum2" value = "${sum.rows[0].rank_sum}" scope = "page"/>

<p>
<cf:GetPhrase phrase_id = "269" lang_id = "${lang}"/>:

<c:out value = "${score_sum2}"/>, Rank

<cf:GetPhrase phrase_id = "561" lang_id = "${lang}"/>:

<c:out value = "${rank_sum2}"/>

<!--- setting the total scores in the proponents record --->
<sql:update>
    update proponent_record set proposal_score_sum = ?, proposal_rank = ?
    where tracking_code = ?

    <sql:param value = "${score_sum2}"/>

    <sql:param value = "${rank_sum2}"/>

    <sql:param value = "${tracking_code}"/>
</sql:update>

<!--- redirecting the user to the main proposals page --->
<c:import url = "proposals/dsp_proposal_main.jsp"/>
