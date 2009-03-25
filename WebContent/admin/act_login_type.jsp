<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:if test = "${empty sessionScope.lang}">
    <sql:query var = "q" sql = "select default_lang from initiative_setup"/>

    <c:choose>
        <c:when test = "${(empty q.rows[0].default_lang) or (q.rows[0].default_lang==0)}">
            <c:set var = "lang" scope = "session" value = "1"/>
        </c:when>

        <c:otherwise>
            <c:set var = "lang" scope = "session"
                   value = "${q.rows[0].default_lang}"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:set var = "bypass" scope = "session" value = "set"/>

<!--- Processing User login information --->
<c:set var = "login_type">
    <c:out value = "${param.login_type}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${login_type=='coordinator'}">
        <c:import url = "dsp_login_coordinator.jsp"/>
    </c:when>

    <c:when test = "${login_type=='reviewer'}">
        <c:import url = "dsp_login_reviewer.jsp"/>
    </c:when>

    <c:when test = "${login_type=='contractor'}">
        <c:import url = "dsp_login_contractor.jsp"/>
    </c:when>

    <c:when test = "${login_type=='public'}">
        <c:redirect url = "../index.jsp?fuseaction=main"/>
    </c:when>
</c:choose>
