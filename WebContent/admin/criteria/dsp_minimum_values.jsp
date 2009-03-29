<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- Modify or Add Funding Initiative Information --->

<sql:query var = "funding_initiative">
    select minimum_score, minimum_rank from initiative_setup where
    initiative_setup_id = 1
</sql:query>

<c:if test = "${funding_initiative.rowCount == 0}">
    <sql:update var = "add_initiative_id">
        insert into initiative_setup ( initiative_setup_id ) values (1)
    </sql:update>

    <c:import url = "funding/dsp_funding_modify.jsp?fuseaction=modify_funding&${user}"/>

    <%
    if (true)
        return;
    %>
</c:if>

<p>
<h3>

<fmt:message key = "510" />:</h3>

<p>
<fmt:message key = "511" /> <font color = "FF0000">

<fmt:message key = "512" /></font><cfoutput>
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_minimum_values'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
</cfoutput>

<input type = "hidden" name = "initiative_id" value = "1">
<input type = "hidden" name = "minimum_score_required"
value = "<fmt:message key='513' />"><c:forEach var = "row"
items = "${funding_initiative.rows}">
    <p>
    <font color = "FF0000"><b>*

    <fmt:message key = "509"
                  />:</b></font><input type = "number"
                                                          name = "minimum_score"
                                                          value = "<c:out value='${row.minimum_score}'/>"
                                                          size = "6">
</c:forEach>

<p>
<input type = "submit"
       value = " <fmt:message key="456"  /> ">

</form>
