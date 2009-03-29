<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${param.lang}" scope = "page"/>

<c:set var = "act" value = "${param.act}" scope = "page"/>

<!--- edit proposal information --->

<h3>

<fmt:message key = "913" /></h3>

<fmt:message key = "914" />

:

<p>
<table width = "100%" bgcolor = "EBEBEB">
    <td align = "center">
        <font face = "arial" size = "-1">

        <p>
        <br>
        <form action = "index.jsp?fuseaction=report_add&lang=<c:out value="${lang}" />"
              method = "post">
            <input type = "hidden" name = "tracking_code_required"
            value = "<fmt:message key="686"  />"> <input type = "hidden" name = "proponent_password_required" value = "<fmt:message key="687"  />">
            <input type = "hidden" name = "act"
            value = "<c:out value="${param.act}" />">

            <p>
            <b>

            <fmt:message key = "57" />:</b>
            P-<input type = "text" name = "tracking_code" size = "3"> <b>

            <fmt:message key = "92" />:</b>
            <input type = "password" name = "proponent_password" size = "10">
            <input type = "submit"
                   value = " <fmt:message key="456"  /> ">
        </form>
    </td>
</table>

<form action = "index.jsp?fuseaction=act_proposal_submit" method = "post">
    <input type = "hidden" name = "act" value = "password">

    <p>
    <fmt:message key = "771" />:
    <input type = "text" name = "proponent_leader_email" size = "30">
    <input type = "submit"
           value = "<fmt:message key="772"  />">
</form>
