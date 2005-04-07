<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:if test = "${tracking_code==''}">
    <p>
    <br>
    <div align = "center">
        <b>

        <cf:GetPhrase phrase_id = "770" lang_id = "${lang}"/>

        <p>
        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=proposal_edit">

        <cf:GetPhrase phrase_id = "733" lang_id = "${lang}"/></a>

        <cf:GetPhrase phrase_id = "734" lang_id = "${lang}"/></b>
    </div>

<%
    if (true)
        return;
%>
</c:if>
