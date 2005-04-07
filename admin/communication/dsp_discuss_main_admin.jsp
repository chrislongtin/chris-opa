<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "messages">
    select discussion_id, discuss_subject, discuss_author, discuss_date from discussion order by discussion_id
</sql:query>

<h4>

<cf:GetPhrase phrase_id = "497" lang_id = "${lang}"/></h4> **

<cf:GetPhrase phrase_id = "498" lang_id = "${lang}"/>

<p>
<br>
<table border = "1" cellspacing = "0" cellpadding = "5">
    <tr bgcolor = "E1E1E1">
        <td>
            <font size = "-1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "499" lang_id = "${lang}"/>
        </td>

        <td>
            <font size = "-1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>
        </td>

        <td>
            <font size = "-1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "500" lang_id = "${lang}"/>
        </td>

        <td>
            <font size = "-1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "171" lang_id = "${lang}"/>
        </td>
    </tr>

    <c:forEach var = "row" items = "${messages.rows}">
        <tr>
            <td>
                <font size = "-1" face = "Arial">

                <c:out value = '${row.discussion_id}'/>
            </td>

            <td>
                <font size = "-1"
                      face = "Arial"><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='discuss_edit'/>
<c:param name='discussion_id' value='${row.discussion_id}'/>
<c:param name='${user}'/>
</c:url>">

                <c:out value = '${row.discuss_subject}'/></a>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = '${row.discuss_author}'/>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <fmt:formatDate pattern = 'MMM dd yyyy' value = '${row.discuss_date}'/>
            </td>
        </tr>
    </c:forEach>
</table>
