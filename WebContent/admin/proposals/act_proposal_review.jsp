<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "reviewer_id">
    <c:out value = "${param.reviewer_id}" default = ""/>
</c:set>

<c:set var = "maxrank">
    <c:out value = "${param.maxrank}" default = ""/>
</c:set>

<!--- autonumbering next appraisal_id --->
<sql:query var = "appraisal_iden" maxRows = "1">
    select appraisal_id from proposal_appraisal order by appraisal_id desc
</sql:query>

<!--- set appraisal id so it can be used later --->
<c:set var = "appraisal_id" value = "1" scope = "page"/>

<c:if test = "${appraisal_iden.rowCount!=0}">
    <c:set var = "appraisal_id"
           value = "${appraisal_iden.rows[0].appraisal_id + 1}"
           scope = "page"/>
</c:if>

<!--- loop from 1 to the maximum rank number --->
<c:forEach begin = "0" end = "${maxrank-1}" var = "row">

    <!--- set the rank equal to the rank plus row number, example rank4 --->
    <!--- evaluate(rank4) will return the value entered on the previous page for that criteria --->
    <!--- the same applies for comments --->
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
        insert into proposal_appraisal (appraisal_id, reviewer_id,
        tracking_code, appraisal_score, appraisal_rank, appraisal_comment,
        i_criteria_id, cfp_criteria_id) values (?, ?, ?, ?, ?, ?, ?, ?)

        <sql:param value = "${appraisal_id}"/>

        <sql:param value = "${reviewer_id}"/>

        <sql:param value = "${tracking_code}"/>

        <sql:param value = "${appraisal_score}"/>

        <sql:param value = "${param[rank]}"/>

        <sql:param value = "${appraisal_comment}"/>

        <sql:param value = "${paramValues.i_criteria_id[row]}"/>

        <sql:param value = "${paramValues.cfp_criteria_id[row]}"/>
    </sql:update>

    <c:set var = "appraisal_id" value = "${appraisal_id + 1}" scope = "page"/>
</c:forEach>

<!--- set status to review completed for reviewer --->
<sql:update>
    update reviewer_assignment set proposal_review_completed = 1 where
    tracking_code = ? and reviewer_id = ?

    <sql:param value = "${tracking_code}"/>

    <sql:param value = "${reviewer_id}"/>
</sql:update>

<!--- calculating the total scores and ranks for this proposal --->
<sql:query var = "sum">
    select SUM(appraisal_score) as score_sum, SUM(appraisal_rank) as rank_sum
    from proposal_appraisal where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "score_sum2" value = "${sum.rows[0].score_sum}" scope = "page"/>

<c:set var = "rank_sum2" value = "${sum.rows[0].rank_sum}" scope = "page"/>

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
