<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

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

<sql:query var = "messages">
    select * from admin_discussion where doc_id = ? AND discuss_parent = ? order by discuss_date desc, discussion_id
    desc

    <sql:param value = "${doc_id}"/>

    <sql:param value = "${parent}"/>
</sql:query>

<ul>
    <c:forEach var = "row" items = "${messages.rows}">
        <li><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='archive_comment'/>
<c:param name='doc_id' value='${row.doc_id}'/>
<c:param name='${lang}'/>
<c:param name='show_msg' value='yes'/>
<c:param name='id_num' value='${row.discussion_id}'/>
</c:url>">

        <c:out value = '${row.discuss_subject}'/></a> <i><c:choose>
            <c:when test = "${!empty row.discuss_author}">
                <c:out value = '${row.discuss_author}'/>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
            </c:otherwise>
        </c:choose>

        </i> <b>

        <cf:GetPhrase phrase_id = "518" lang_id = "${lang}"/></b>
    </c:forEach>
</ul>
