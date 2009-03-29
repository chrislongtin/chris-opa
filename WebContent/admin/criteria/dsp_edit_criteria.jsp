<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
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

<fmt:message key = "195" /></h3>

<p>
<fmt:message key = "41" />
<c:forEach var = "row" items = "${criteria_info.rows}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_criteria'/>
<c:param name='act' value='edit'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <input type = "hidden" name = "i_criteria_id"
        value = "<c:out value='${row.i_criteria_id}'/>"> <input type = "hidden"
        name = "i_criteria_name_required"
        value = "<fmt:message key='450' />"> <input type = "hidden" name = "i_criteria_weight_required" value = "<fmt:message key='451' />">
        <input type = "hidden" name = "i_low_rank_required"
        value = "<fmt:message key='452' />"> <input type = "hidden"
        name = "i_high_rank_required"
        value = "<fmt:message key='453' />">

        <p>
        <font color = "FF0000">*

        <fmt:message key = "139" />

        :

        <br>
        <textarea name = "i_criteria_name" cols = "50" rows = "3" wrap>
            <c:out value = '${row.i_criteria_name}'/></textarea>
        <%-- <cf:ParagraphFormat value = "${row.i_criteria_name}"/> --%>

        </textarea>

        <p>
        *

        <fmt:message key = "142" />:
        <input type = "text" name = "i_low_rank" size = "10"
        value = "<c:out value='${row.i_low_rank}'/>"> *

        <fmt:message key = "141" />:
        <input type = "text" name = "i_high_rank" size = "10"
               value = "<c:out value='${row.i_high_rank}'/>">

        <p>
        *

        <fmt:message key = "140" />:
        <input type = "text"
               name = "i_criteria_weight"
               value = "<c:out value='${row.i_criteria_weight}'/>"
               size = "6"></font>

        <p>
        <input type = "submit"
               value = " <fmt:message key="456"  /> ">
    </form>
</c:forEach>
