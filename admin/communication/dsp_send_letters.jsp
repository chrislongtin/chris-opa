<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- select status information where default letters have been setup for that status --->

<sql:query var = "status_select">
    select RS.status_id, RS.status_name from record_status RS, default_letters DL where RS.status_id = DL.status_id
    order by RS.status_id
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "264" lang_id = "${lang}"/></h3>

<cf:GetPhrase phrase_id = "506" lang_id = "${lang}"/>

<c:choose>
    <c:when test = "${status_select.rowCount == 0}">
        <p>
        <cf:GetPhrase phrase_id = "507" lang_id = "${lang}"/> <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_default_letters">

        <cf:GetPhrase phrase_id = "508" lang_id = "${lang}"/>.</a>
    </c:when>

    <c:otherwise>
        <form action = "index.jsp?fuseaction=act_send_letters" method = "post">
            <select name = "status_id">
                <c:forEach var = "row" items = "${status_select.rows}">
                    <option value = "<c:out value='${row.status_id}'/>"><c:out value = '${row.status_name}'/>
                </c:forEach>
            </select>

            <input type = "submit" value = " <cf:GetPhrase phrase_id="264" lang_id="${lang}" /> ">
        </form>
    </c:otherwise>
</c:choose>
