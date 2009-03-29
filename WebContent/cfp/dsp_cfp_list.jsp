<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- current CFP list --->
<sql:query var = "cfp_current_list">
    select cfp_title, cfp_code from cfp_info where cfp_deadline >= CURDATE()
    and CURDATE() >= cfp_startdate order by cfp_code
</sql:query>

<h2>

<fmt:message key = "85" /></h2>

<hr size = "-1">
<c:choose>
    <c:when test = "${empty cfp_current_list.rows[0].cfp_code}">
        <p>
        <fmt:message key ="86" />
    </c:when>

    <c:otherwise>
        <ul>
            <c:forEach items = "${cfp_current_list.rows}" var = "row">
                <p>
                <li><b><a STYLE = "text-decoration: underline"
                          href = "index.jsp?fuseaction=cfp_info&cfp_code=<c:out value="${row.cfp_code}" />&lang=<c:out value="${lang}" />">(CFP-

                <c:out value = "${row.cfp_code}"/>

                )

                <c:out value = "${row.cfp_title}"/></a></b>
            </c:forEach>
        </ul>
    </c:otherwise>
</c:choose>
