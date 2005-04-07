<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
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

<cf:GetPhrase phrase_id = "1011" lang_id = "${lang}"/></h3>

<c:choose>
    <c:when test = "${titles.rowCount == 0}">
        <cf:GetPhrase phrase_id = "1012" lang_id = "${lang}"/>
    </c:when>

    <c:otherwise>
        <a STYLE="text-decoration: underline"  href = "#add">

        <cf:GetPhrase phrase_id = "1013" lang_id = "${lang}"/></a>
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
                <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_titles'/>
<c:param name='seq_no' value='${row.seq_no}'/>
<c:param name='act' value='Delete'/>
<c:param name='${user}'/>
</c:url>">

                <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a>
                <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='dsp_edit_titles'/>
<c:param name='seq_no' value='${row.seq_no}'/>
<c:param name='act' value='Edit'/>
<c:param name='${user}'/>
</c:url>">

                <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
            </td>
        </tr>
    </c:forEach>
</table>

<a name = "add"> <h4>

<cf:GetPhrase phrase_id = "1013" lang_id = "${lang}"/>:</h4>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_titles'/>
<c:param name='${user}'/>
</c:url>" method = "post">
    <input type = "hidden" name = "act" value = "Add">
    <input type = "hidden" name = "seq_no_required" value = "<cf:GetPhrase phrase_id='1014' lang_id='${lang}'/>">
    <input type = "hidden" name = "job_name_required" value = "<cf:GetPhrase phrase_id='1015' lang_id='${lang}'/>"> <b>

    <cf:GetPhrase phrase_id = "1016" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "seq_no" length = "4" value = " <c:out value="${next_no}" />">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "1017" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "job_name" length = "30">

    <p>
    <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
