<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
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

        <fmt:message key = "770" />

        <p>
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=proposal_edit">

        <fmt:message key = "733" /></a>

        <fmt:message key = "734" /></b>
    </div>

    <%
    if (true)
        return;
    %>
</c:if>
