<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "comm_sent">
    select SM.tracking_code, SM.date_sent, SM.letter_id, RS.status_name from sent_messages SM, record_status RS,
    default_letters DL where SM.letter_id = DL.letter_id AND DL.status_id = RS.status_id order by tracking_code
</sql:query>

<c:choose>
    <c:when test = "${comm_sent.rowCount == 0}">
        <cf:GetPhrase phrase_id = "187" lang_id = "${lang}"/>
    </c:when>

    <c:otherwise>
        <p>
        <table border = "1" cellspacing = "0" cellpadding = "3">
            <tr bgcolor = "E8E8E8">
                <td>
                    <font size = "-1" face = "Arial">

                    <cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>
                </td>

                <td>
                    <font size = "-1" face = "Arial">

                    <cf:GetPhrase phrase_id = "188" lang_id = "${lang}"/>
                </td>

                <td>
                    <font size = "-1" face = "Arial">

                    <cf:GetPhrase phrase_id = "58" lang_id = "${lang}"/>
                </td>
            </tr>

            <c:forEach var = "row" items = "${comm_sent.rows}">
                <tr>
                    <td>
                        <font size = "-1" face = "Arial">

                        <c:out value = '${row.tracking_code}'/>
                    </td>

                    <td>
                        <font size = "-1" face = "Arial">

                        <fmt:formatDate pattern = 'dd-MMM-yyyy' value = '${row.date_sent}'/>
                    </td>

                    <td>
                        <font size = "-1"
                              face = "Arial"><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_message_type'/>
<c:param name='letter_id' value='${row.letter_id}'/>
<c:param name='${user}'/>
</c:url>">

                        <c:out value = '${row.status_name}'/></a>
                    </td>
                </tr>
            </c:forEach>

            <table>
    </c:otherwise>
</c:choose>
