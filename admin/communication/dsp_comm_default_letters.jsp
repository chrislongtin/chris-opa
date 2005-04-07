<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "letter_info">
    select L.letter_id, L.letter_subject, S.status_name from default_letters L, record_status S where L.status_id =
    S.status_id
</sql:query>

<sql:query var = "status">
    select * from record_status
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "164" lang_id = "${lang}"/></h3>

<c:if test = "${letter_info.rowCount != 0}">
    <cf:GetPhrase phrase_id = "165" lang_id = "${lang}"/>
</c:if>

<c:forEach var = "row" items = "${letter_info.rows}">
    <p>
    <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:
    <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='comm_default_letter_body'/>
<c:param name='letter_id' value='${row.letter_id}'/>
<c:param name='${user}'/>
</c:url>">

    <c:out value = '${row.letter_subject}'/></a>

    <br>
    <cf:GetPhrase phrase_id = "58" lang_id = "${lang}"/>:

    <c:out value = '${row.status_name}'/>

    <br>
    <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_letters'/>
<c:param name='act' value='delete'/>
<c:param name='letter_id' value='${row.letter_id}'/>
<c:param name='${user}'/>
</c:url>">

    <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |
    <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='edit_letter'/>
<c:param name='letter_id' value='${row.letter_id}'/>
<c:param name='${user}'/>
</c:url>">

    <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
</c:forEach>

<h3>

<cf:GetPhrase phrase_id = "166" lang_id = "${lang}"/></h3>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_letters'/>
<c:param name='${user}'/>
</c:url>" method = "post">
    <input type = "hidden" name = "act" value = "add"> <input type = "hidden"
           name = "letter_subject_required"
           value = "<cf:GetPhrase phrase_id='481' lang_id='${lang}'/>">
    <input type = "hidden" name = "letter_body_required" value = "<cf:GetPhrase phrase_id='482' lang_id='${lang}'/>">

    <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>

    :

    <br>
    <input type = "text" name = "letter_subject" size = "40">

    <p>
    <cf:GetPhrase phrase_id = "167" lang_id = "${lang}"/>:

    <br>
    <textarea name = "letter_body" cols = "40" rows = "5" wrap>
    </textarea>

    <p>
    <cf:GetPhrase phrase_id = "58" lang_id = "${lang}"/>:

    <br>
    <select name = "status_id">
        <c:forEach var = "row" items = "${status.rows}">
            <option value = "<c:out value='${row.status_id}'/>"><c:out value = '${row.status_name}'/>

            (

            <c:out value = '${row.status_id}'/>

            )
        </c:forEach>
    </select>

    <p>
    <input type = "submit" value = "<cf:GetPhrase phrase_id="166" lang_id="${lang}" />">
</form>
