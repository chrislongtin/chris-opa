<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "doc_id">
    <c:out value = "${param.doc_id}" default = "0"/>
</c:set>

<c:set var = "parent">
    <c:out value = "${param.parent}" default = "0"/>
</c:set>

<c:set var = "thelevel">
    <c:out value = "${param.thelevel}" default = "1"/>
</c:set>

<!--- this page controls the display of all replies and level 2 or greater messages --->

<c:set var = "thelevel" value = "${thelevel+1}" scope = "page"/>

<sql:query var = "qn">
    select * from discussion where doc_id = ? and discuss_parent = ? order by
    discuss_date desc

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
    <c:forEach items = "${qn.rows}" var = "row">
        <li><a STYLE = "text-decoration: underline"
               href = "index.jsp?fuseaction=archive_comment&doc_id=<c:out value="${doc_id}" />&lang=<c:out value="${lang}" />&show_msg=yes&id_num=<c:out value="${row.discussion_id}" />">

        <c:out value = "${row.discuss_subject}"/></a> <i><c:choose>
            <c:when test = "${row.discuss_author!=''}">
                <c:out value = "${row.discuss_author}"/>
            </c:when>

            <c:otherwise>
                <fmt:message key = "38" />
            </c:otherwise>
        </c:choose>

        </i>

        <c:if test = "${(row.discussion_id==id_num) and (show_msg=='yes')}">
            <table border = "0" cellspacing = "0" cellpadding = "5">
                <td bgcolor = "E1E1E1">
                    <font face = "Arial" size = "-2">

                    <fmt:formatDate value = "${row.discuss_date}"
                    pattern = "MMM dd, yyyy"/> | <a STYLE = "text-decoration: underline"
                    href = "index.jsp?fuseaction=archive_comment&doc_id=<c:out value="${doc_id}" />&lang=<c:out value="${lang}" />&act=add&discuss_parent=<c:out value="${row.discussion_id}" />">

                    <fmt:message key = "39"
                                  /></a></font>

                    <p>
                    <font face = "Arial" size = "-1">

                    <cf:ParagraphFormat value = "${row.discuss_message}"/>

                    <br>
                    <a STYLE = "text-decoration: underline"
                       href = "docs/<c:out value="${row.discuss_attachment}" />?ois=no">

                    <c:out value = "${row.discuss_attachment}"/></a></font>
                </td>
            </table>

            <p>
        </c:if>

        <c:if test = "${row.discuss_replies!=0}">
            <c:set var = "parent" value = "${row.discussion_id}"/>

            <c:import url = "archive/dsp_archive_thread.jsp?parent=${parent}"/>
        </c:if>
    </c:forEach>
</ul>
