<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<sql:query var = "messages">
    select * from discussion where doc_id = ? and discuss_parent = ? order by discuss_date desc

    <sql:param value = "${param.doc_id}"/>

    <sql:param value = "${param.parent}"/>
</sql:query>

<%
    String id_num = request.getParameter("id_num");

    pageContext.setAttribute("id_num", (id_num == null) ? "0" : id_num);
    String show_msg = request.getParameter("show_msg");
    pageContext.setAttribute("show_msg", (show_msg == null) ? "no" : show_msg);
    String parent = request.getParameter("parent");
    pageContext.setAttribute("parent", (parent == null) ? "0" : parent);
    String level = request.getParameter("level");
    pageContext.setAttribute("level", (level == null) ? "1" : level);
%>

<ul>
    <c:forEach items = "${messages.rows}" var = "row">
        <li>
        <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
  <c:param name='fuseaction' value='archive_comment'/>
  <c:param name='doc_id' value='${param.doc_id}'/>
  <c:param name='lang' value='${lang}'/>
  <c:param name='show_msg' value='yes'/>
  <c:param name='id_num' value='${row.discussion_id}'/>
  </c:url>">

        <c:out value = "${row.discuss_subject}"/></a> <i><c:choose>
            <c:when test = "${row.discuss_author != ''}">
                <c:out value = "${row.discuss_author}"/>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
            </c:otherwise>
        </c:choose>

        </i> <b>

        <cf:GetPhrase phrase_id = "518" lang_id = "${lang}"/></b>
    </c:forEach>
</ul>
