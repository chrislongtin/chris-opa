<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "titles">
    select * from standardjobnames order by seq_no
</sql:query>

<sql:query var = "last_seq">
    select max(seq_no)+1 as next_seq_no from standardjobnames
</sql:query>

<c:set var = "next_no" value = "${last_seq.rows[0].next_seq_no}"/>

<h3>

<fmt:message key = "1011" /></h3>

<c:choose>
    <c:when test = "${titles.rowCount == 0}">
        <fmt:message key = "1012" />
    </c:when>

    <c:otherwise>
        <a STYLE = "text-decoration: underline" href = "#add">

        <fmt:message key = "1013" /></a>
    </c:otherwise>
</c:choose>

<p>
<table>
    <c:forEach var = "row" items = "${titles.rows}">
        <tr>
            <td valign = "top" align = "right">
                <c:out value = '${row.seq_no}'/>
            </td>

            <td valign = "top">
                <c:out value = '${row.job_name}'/>
            </td>

            <td valign = "top">
                <a STYLE = "text-decoration: underline"
                   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_titles'/>
<c:param name='seq_no' value='${row.seq_no}'/>
<c:param name='act' value='Delete'/>
<c:param name='${user}'/>
</c:url>">

                <fmt:message key = "143" /></a>
                <a STYLE = "text-decoration: underline"
                   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='dsp_edit_titles'/>
<c:param name='seq_no' value='${row.seq_no}'/>
<c:param name='act' value='Edit'/>
<c:param name='${user}'/>
</c:url>">

                <fmt:message key = "144" /></a>
            </td>
        </tr>
    </c:forEach>
</table>

<a name = "add"> <h4>

<fmt:message key = "1013" />:</h4>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_titles'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "act" value = "Add">
    <input type = "hidden" name = "seq_no_required"
    value = "<fmt:message key='1014' />"> <input type = "hidden"
    name = "job_name_required"
    value = "<fmt:message key='1015' />"> <b>

    <fmt:message key = "1016" />:</b>

    <br>
    <input type = "text" name = "seq_no" length = "4"
           value = " <c:out value="${next_no}" />">

    <p>
    <b>

    <fmt:message key = "1017" />:</b>

    <br>
    <input type = "text" name = "job_name" length = "30">

    <p>
    <input type = "submit"
           value = " <fmt:message key="456"  /> ">
</form>
