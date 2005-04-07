<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- display criteria information --->

<c:set var = "review_active">
    <c:out value = "${param.review_active}" default = "no"/>
</c:set>

<%
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());

    pageContext.setAttribute("Current_Date", sqldate.toString());
%>

<sql:query var = "check_review_status">
    select cfp_code from cfp_info where ? > cfp_deadline and cfp_proposal_review_deadline > ?

    <sql:param value = "${Current_Date}"/>

    <sql:param value = "${Current_Date}"/>
</sql:query>

<c:if test = "${check_review_status.rowCount != 0}">
    <c:set var = "review_active" value = "yes"/>
</c:if>

<sql:query var = "list_criteria">
    select * from initiative_criteria order by i_criteria_id
</sql:query>

<sql:query var = "minimums">
    select minimum_score, minimum_rank from initiative_setup where initiative_setup_id = 1
</sql:query>

<!--- Main initiative criteria setup --->

<p>
<h3>

<cf:GetPhrase phrase_id = "72" lang_id = "${lang}"/></h3>
<c:if test = "${user == 'coordinator' and review_active == 'no'}">
    <a STYLE="text-decoration: underline"  href = "#add">

    <cf:GetPhrase phrase_id = "190" lang_id = "${lang}"/></a>
</c:if>

<c:if test = "${list_criteria.rowCount == 0}">
    <p>
    <cf:GetPhrase phrase_id = "191" lang_id = "${lang}"/>
</c:if>

<c:choose>
    <c:when test = "${user == 'coordinator' and review_active == 'no'}">
        <p>
        <cf:GetPhrase phrase_id = "133" lang_id = "${lang}"/>
    </c:when>

    <c:when test = "${user == 'coordinator' and review_active == 'yes'}">
        <p>
        <font color = "FF0000">

        <cf:GetPhrase phrase_id = "134" lang_id = "${lang}"/></font>
    </c:when>
</c:choose>

<c:forEach var = "row" items = "${list_criteria.rows}">
    <p>
    <b>

    <cf:GetPhrase phrase_id = "138" lang_id = "${lang}"/>:</b> <font face = "Times New Roman">I</font>-

    <c:out value = "${row.i_criteria_id}"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "139" lang_id = "${lang}"/>:</b>

    <menu><cf:ParagraphFormat value = "${row.i_criteria_name}"/></menu>
    <!--<c:out value = "${row.i_criteria_name}"/>  -->

    <br>
    <b>

    <cf:GetPhrase phrase_id = "140" lang_id = "${lang}"/>:</b>

    <c:out value = "${row.i_criteria_weight}"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "142" lang_id = "${lang}"/>:</b>

    <c:out value = "${row.i_low_rank}"/>

    <br>
    <b>

    <cf:GetPhrase phrase_id = "141" lang_id = "${lang}"/>:</b>

    <c:out value = "${row.i_high_rank}"/><c:if test = "${user == 'coordinator' and review_active == 'no'}">
        <br>
        <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_criteria'/>
<c:param name='i_criteria_id' value='${row.i_criteria_id}'/>
<c:param name='act' value='del_criteria'/>
<c:param name='${user}'/>
</c:url>">

        <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |
        <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='edit_criteria'/>
<c:param name='i_criteria_id' value='${row.i_criteria_id}'/>
<c:param name='${user}'/>
</c:url>">

        <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
    </c:if>
</c:forEach>

<a name = "minimums"><c:forEach var = "row" items = "${minimums.rows}">
    <h3>

    <cf:GetPhrase phrase_id = "194" lang_id = "${lang}"/>

    :

    <c:out value = "${row.minimum_rank}"/></h3>
</c:forEach>

<!--- Add new criteria --->

<c:if test = "${user == 'coordinator' and review_active == 'no'}">
    <a name = "add">

    <p>
    <h3>

    <cf:GetPhrase phrase_id = "190" lang_id = "${lang}"/></h3>

    <p>
    <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_criteria'/>
<c:param name='act' value='add'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
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
        <font face = "" color = "FF0000">*

        <cf:GetPhrase phrase_id = "139" lang_id = "${lang}"/>

        :

        <br>
        <textarea name = "i_criteria_name" cols = "50" rows = "3" wrap>
        </textarea>

        <p>
        *

        <cf:GetPhrase phrase_id = "142" lang_id = "${lang}"/>:
        <input type = "text" name = "i_low_rank" size = "10" value = "low"> *

        <cf:GetPhrase phrase_id = "141" lang_id = "${lang}"/>:
        <input type = "text" name = "i_high_rank" size = "10" value = "high">

        <p>
        *

        <cf:GetPhrase phrase_id = "140" lang_id = "${lang}"/>:
        <input type = "text" name = "i_criteria_weight" size = "6"> <input type = "submit" value = " Submit "></font>
    </form>
</c:if>
