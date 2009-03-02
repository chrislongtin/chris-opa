<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- edit proposal information --->

<h3>

<cf:GetPhrase phrase_id = "12" lang_id = "${lang}"/></h3>

<cf:GetPhrase phrase_id = "770" lang_id = "${lang}"/>

:

<p>
<table width = "100%" bgcolor = "EBEBEB">
    <td align = "center">
        <font face = "arial" size = "-1">

        <p>
        <br>
        <form action = "index.jsp?fuseaction=proposal_info&lang=<c:out value="${lang}" />"
              method = "post">
            <input type = "hidden" name = "tracking_code_required"
            value = "<cf:GetPhrase phrase_id="686" lang_id="${lang}" />"> <input type = "hidden" name = "proponent_password_required" value = "<cf:GetPhrase phrase_id="687" lang_id="${lang}" />">
            <input type = "hidden" name = "act" value = "edit">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:</b>
            P-<input type = "text" name = "tracking_code" size = "3"> <b>

            <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/>:</b>
            <input type = "password" name = "proponent_password" size = "10">
            <input type = "submit"
                   value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </td>
</table>

<form action = "index.jsp?fuseaction=act_send_proposal_password" method = "post">
    <input type = "hidden" name = "act" value = "password">

    <p>
    <cf:GetPhrase phrase_id = "771" lang_id = "${lang}"/>:
    <input type = "text" name = "proponent_leader_email" size = "30">
    <input type = "submit"
           value = "<cf:GetPhrase phrase_id="772" lang_id="${lang}" />">
</form>
