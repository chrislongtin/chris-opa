<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "doc_id">
    <c:out value = "${param.doc_id}" default = ""/>
</c:set>

<c:set var = "parent">
    <c:out value = "${param.parent}" default = ""/>
</c:set>

<sql:query var = "messages">
    select * from discussion where doc_id = ? and discuss_parent = ? order by discuss_date desc

    <sql:param value = "${doc_id}"/>

    <sql:param value = "${parent}"/>
</sql:query>

<c:set var = "id_num">
    <c:out value = "${param.id_num}" default = "0"/>
</c:set>

<c:set var = "show_msg">
    <c:out value = "${param.show_msg}" default = "no"/>
</c:set>

<c:set var = "parent">
    <c:out value = "${param.parent}" default = "0"/>
</c:set>

<c:set var = "level">
    <c:out value = "${param.level}" default = "1"/>
</c:set>

<ul>
    <c:forEach items = "${messages.rows}" var = "row">
        <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=archive_comment&doc_id=<c:out value="${row.doc_id}" />&lang=<c:out value="${lang}" />&show_msg=yes&id_num=<c:out value="${row.discussion_id}" />">

        <c:out value = "${row.discuss_subject}"/></a> <i><c:choose>
            <c:when test = "${row.discuss_author!=''}">
                <c:out value = "${row.discuss_author}"/>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
            </c:otherwise>
        </c:choose>

        </i> <b>sub msg</b>
    </c:forEach>
</ul>
