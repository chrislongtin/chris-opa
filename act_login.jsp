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
            <c:set var = "lang" scope = "session" value = "${q.rows[0].default_lang}"/>
        </c:otherwise>
    </c:choose>
</c:if>

<!--- Processing User login information --->
<c:set var = "login_type">
    <c:out value = "${param.login_type}" default = ""/>
</c:set>

<c:set var = "contractor_login">
    <c:out value = "${param.contractor_login}" default = ""/>
</c:set>

<c:set var = "contractor_password">
    <c:out value = "${param.contractor_password}" default = ""/>
</c:set>

<sql:query var = "vlr">
    select contractor_login, contractor_id from contractors where contractor_login = ? and contractor_password = ?

    <sql:param value = "${contractor_login}"/>

    <sql:param value = "${contractor_password}"/>
</sql:query>

<c:if test = "${empty vlr.rows[0].contractor_login}">
    <cf:GetPhrase phrase_id = "381" lang_id = "${lang}"/>

    .

    <cf:GetPhrase phrase_id = "382" lang_id = "${lang}"/>

    <a STYLE="text-decoration: underline"  href = "dsp_login_contractor.jsp">

    <cf:GetPhrase phrase_id = "383" lang_id = "${lang}"/></a>.

<%
    if (true)
        return;
%>
</c:if>

<c:set var = "user" value = "contractor" scope = "session"/>

<c:set var = "ctid" value = "${vlr.rows[0].contractor_id}" scope = "session"/>

<c:import url = "contractors/dsp_edit_resume.jsp"/>
