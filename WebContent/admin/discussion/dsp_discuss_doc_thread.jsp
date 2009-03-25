<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "doc_id">
    <c:out value = "${param.doc_id}" default = "0"/>
</c:set>

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

<sql:query var = "disq">
    select * from admin_discussion where doc_id = ? and discuss_parent = ?
    order by discuss_date desc, discussion_id desc

    <sql:param value = "${doc_id}"/>

    <sql:param value = "${parent}"/>
</sql:query>

<ul>
    <c:forEach items = "${disq.rows}" var = "row">
        <p>
        <li><font size = "3"><a STYLE = "text-decoration: underline"
                                href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='gen_doc_comment'/>
<c:param name='doc_id' value='${doc_id}'/>
<c:param name='lang' value='${lang}'/>
<c:param name='show_msg' value='yes'/>
<c:param name='id_num' value='${row.discussion_id}'/>
</c:url>">

        <c:out value = "${row.discuss_subject}"/></a> <i><c:choose>
            <c:when test = "${!empty row.discuss_author}">
                <c:out value = "${row.discuss_author}"/>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
            </c:otherwise>
        </c:choose>

        </i></font>

        <c:if test = "${row.discussion_id == id_num && show_msg == 'yes'}">
            <table border = "0" cellspacing = "0" cellpadding = "5">
                <td bgcolor = "E1E1E1">
                    <font face = "Arial" size = "-2">

                    <fmt:formatDate value = "${row.discuss_date}"
                    pattern = "MMM dd, yyyy"/> | <a STYLE = "text-decoration: underline"
                    href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='gen_doc_comment'/>
<c:param name='doc_id' value='${doc_id}'/>
<c:param name='lang' value='${lang}'/>
<c:param name='act' value='add'/>
<c:param name='discuss_parent' value='${row.discussion_id}'/>
</c:url>">

                    <cf:GetPhrase phrase_id = "39"
                                  lang_id = "${lang}"/></a></font>

                    <p>
                    <font face = "Arial" size = "-1">

                    <cf:ParagraphFormat value = "${row.discuss_message}"/>

                    <br>
                    <a STYLE = "text-decoration: underline"
                       href = "../docs/<c:out value='${row.discuss_attachment}'/>?ois=no">

                    <c:out value = "${row.discuss_attachment}"/></a></font>
                </td>
            </table>

            <p>
        </c:if>

        <c:if test = "${row.discuss_replies != 0}">
            <c:set var = "parent" value = "${row.discussion_id}"/>

            <c:import url = "discussion/dsp_discuss_doc_thread.jsp?parent=${parent}"/>
        </c:if>
    </c:forEach>
</ul>
