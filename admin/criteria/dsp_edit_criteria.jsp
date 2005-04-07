<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "criteria_info">
    select * from initiative_criteria where i_criteria_id = ?

    <sql:param value = "${param.i_criteria_id}"/>
</sql:query>

<p>
<h3>

<cf:GetPhrase phrase_id = "195" lang_id = "${lang}"/></h3>

<p>
<cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/><c:forEach var = "row" items = "${criteria_info.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_criteria'/>
<c:param name='act' value='edit'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "i_criteria_id" value = "<c:out value='${row.i_criteria_id}'/>">
        <input type = "hidden"
               name = "i_criteria_name_required"
               value = "<cf:GetPhrase phrase_id='450' lang_id='${lang}'/>"> <input type = "hidden"
               name = "i_criteria_weight_required"
               value = "<cf:GetPhrase phrase_id='451' lang_id='${lang}'/>"> <input type = "hidden"
               name = "i_low_rank_required"
               value = "<cf:GetPhrase phrase_id='452' lang_id='${lang}'/>">
        <input type = "hidden" name = "i_high_rank_required"
               value = "<cf:GetPhrase phrase_id='453' lang_id='${lang}'/>">

        <p>
        <font color = "FF0000">*

        <cf:GetPhrase phrase_id = "139" lang_id = "${lang}"/>

        :

        <br>
        <textarea name = "i_criteria_name" cols = "50" rows = "3" wrap>
            <!--<c:out value = '${row.i_criteria_name}'/></textarea> -->
            -->

            <menu><cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>
        </textarea>

        <p>
        *

        <cf:GetPhrase phrase_id = "142" lang_id = "${lang}"/>:
        <input type = "text" name = "i_low_rank" size = "10" value = "<c:out value='${row.i_low_rank}'/>"> *

        <cf:GetPhrase phrase_id = "141" lang_id = "${lang}"/>:
        <input type = "text" name = "i_high_rank" size = "10" value = "<c:out value='${row.i_high_rank}'/>">

        <p>
        *

        <cf:GetPhrase phrase_id = "140" lang_id = "${lang}"/>:
        <input type = "text" name = "i_criteria_weight" value = "<c:out value='${row.i_criteria_weight}'/>"
               size = "6"></font>

        <p>
        <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
    </form>
</c:forEach>
