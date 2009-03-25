<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<h2>

<cf:GetPhrase phrase_id = "15" lang_id = "${lang}"/></h2>

<sql:query var = "faq">
    select * from faq
</sql:query>

<sql:query var = "coord_email">
    select coordinator_email from coordinators where receive_public_emails = 1
</sql:query>

<c:set var = "c_m" value = "${coord_email.rows[0].coordinator_email}"
       scope = "page"/>

<sql:query var = "i_name">
    select initiative_name from initiative_info where lang_id = 1
</sql:query>

<c:set var = "i_n" value = "${i_name.rows[0].initiative_name}" scope = "page"/>

<c:if test = "${!(empty c_m)}">
    <p>
    <a STYLE = "text-decoration: underline"
       href = "mailto:<c:out value="${c_m}" />?subject=<c:out value="${i_n}" /> FAQ">

    <cf:GetPhrase phrase_id = "107" lang_id = "${lang}"/>

    (

    <c:out value = "${c_m}"/>)</a>
</c:if>

<c:choose>
    <c:when test = "${empty faq.rows[0].faq_id}">
        <p>
        <cf:GetPhrase phrase_id = "108" lang_id = "${lang}"/>
    </c:when>

    <c:otherwise>
        <c:forEach items = "${faq.rows}" var = "row">
            <p>
            <b>

            <cf:GetPhrase phrase_id = "726" lang_id = "${lang}"/>:</b>

            <c:out value = "${row.faq_question}"/>

            <menu><b>

            <cf:GetPhrase phrase_id = "727" lang_id = "${lang}"/>:</b>

            <c:out value = "${row.faq_answer}"/></menu>
        </c:forEach>
    </c:otherwise>
</c:choose>
