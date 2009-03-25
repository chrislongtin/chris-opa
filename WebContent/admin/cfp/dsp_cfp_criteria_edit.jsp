<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "cfp_criteria">
    select * from cfp_criteria where cfp_criteria_id = ?

    <sql:param value = "${param.cfp_criteria_id}"/>
</sql:query>

<!--- cfp criteria edit --->

<p>
<h3>

<cf:GetPhrase phrase_id = "147" lang_id = "${lang}"/></h3>

<p>
<cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>
<c:forEach var = "row" items = "${cfp_criteria.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp_criteria'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "cfp_code"
        value = "<c:out value='${row.cfp_code}'/>">
        <input type = "hidden" name = "cfp_criteria_id"
        value = "<c:out value='${row.cfp_criteria_id}'/>"> <input type = "hidden"
        name = "act" value = "edit">
        <input type = "hidden" name = "cfp_criteria_name_required"
        value = "<cf:GetPhrase phrase_id='450' lang_id='${lang}'/>"> <input type = "hidden" name = "cfp_criteria_weight_required" value = "<cf:GetPhrase phrase_id='451' lang_id='${lang}'/>">
        <input type = "hidden" name = "cfp_low_rank_required"
        value = "<cf:GetPhrase phrase_id='452' lang_id='${lang}'/>"> <input type = "hidden"
        name = "cfp_high_rank_required"
        value = "<cf:GetPhrase phrase_id='453' lang_id='${lang}'/>">

        <p>
        <font color = "FF0000"><b>*

        <cf:GetPhrase phrase_id = "139" lang_id = "${lang}"/>:</b>

        <br>
        <textarea name = "cfp_criteria_name" cols = "30" rows = "2" wrap>
            <c:out value = '${row.cfp_criteria_name}'/>
        </textarea>

        <p>
        <b>*

        <cf:GetPhrase phrase_id = "142" lang_id = "${lang}"/>:</b>
        <input type = "text" name = "cfp_low_rank" size = "10"
        value = "<c:out value='${row.cfp_low_rank}'/>"> <b>*

        <cf:GetPhrase phrase_id = "141" lang_id = "${lang}"/>:</b>
        <input type = "text" name = "cfp_high_rank" size = "10"
               value = "<c:out value='${row.cfp_high_rank}'/>">

        <br>
        <b>*

        <cf:GetPhrase phrase_id = "140" lang_id = "${lang}"/>:</b>
        <input type = "number" name = "cfp_criteria_weight" size = "6"
        value = "<c:out value='${row.cfp_criteria_weight}'/>"></font> <input type = "Submit"
        value = "<cf:GetPhrase phrase_id="458" lang_id="${lang}" />">
    </form>
</c:forEach>
