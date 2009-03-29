<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- add language item --->

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<c:set var = "phrase_edit">
    <c:out value = "${param.phrase_edit}" default = ""/>
</c:set>

<c:set var = "lang_id">
    <c:out value = "${param.lang_id}"/>
</c:set>

<c:set var = "phrase_id">
    <c:out value = "${param.phrase_id}" default = "1"/>
</c:set>

<c:choose>
    <c:when test = "${act == 'add'}">
        <sql:query var = "phrase_num" maxRows = "1">
            select phrase_id from phrases order by phrase_id desc
        </sql:query>

        <c:forEach var = "row" items = "${phrase_num.rows}">
            <c:set var = "phrase_id" value = "${row.phrase_id + 1}"/>
        </c:forEach>

        <h3>

        <fmt:message key = "231" />:</h3>
    </c:when>

    <c:when test = "${act == 'edit'}">
        <sql:query var = "phrase_edit">
            select phrase, phrase_id, lang_id from phrases where phrase_id = ?
            and lang_id = ?

            <sql:param value = "${phrase_id}"/>

            <sql:param value = "${lang_id}"/>
        </sql:query>

        <c:forEach var = "row" items = "${phrase_edit.rows}">
            <c:set var = "phrase_edit" value = "${row.phrase}"/>

            <c:set var = "phrase_id" value = "${row.phrase_id}"/>

            <c:set var = "lang_id" value = "${row.lang_id}"/>
        </c:forEach>

        <h3>

        <fmt:message key = "232" />:</h3>
    </c:when>
</c:choose>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_add_phrase'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "phrase_id"
    value = "<c:out value='${phrase_id}'/>"> <input type = "hidden" name = "act"
    value = "<c:out value='${act}'/>"> <input type = "hidden" name = "lang_id"
    value = "<c:out value='${lang_id}'/>">

    <fmt:message key = "233" />: <b>

    <c:out value = '${phrase_id}'/></b>
    <input type = "text" name = "phrase" size = "40"
           value = "<c:out value='${phrase_edit}'/>">

    <br>
    <input type = "submit"
           value = "  <fmt:message key="456"  />  ">
</form>

<p>
<b>

<fmt:message key = "234" />:</b>
<sql:query var = "phrases">
    select phrase, phrase_id, lang_id from phrases where lang_id = ? order by
    phrase

    <sql:param value = "${lang_id}"/>
</sql:query>

<p>
**

<fmt:message key = "235" />

<p>
<table border = "0" cellspacing = "0" cellpadding = "3">
    <tr>
        <td>
            <font face = "Arial" size = "-1"><b>

            <fmt:message key = "233" />
        </td>
    </tr>

    <c:forEach var = "row" items = "${phrases.rows}">
        <tr>
            <td>
                <font face = "Arial" size = "-1">

                <li><a STYLE = "text-decoration: underline"
                       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='add_phrase'/>
<c:param name='${user}'/>
<c:param name='act' value='edit'/>
<c:param name='phrase_id' value='${row.phrase_id}'/>
<c:param name='lang_id' value='${row.lang_id}'/>
</c:url>">

                <c:out value = '${row.phrase}'/>

                &nbsp; (

                <c:out value = '${row.phrase_id}'/>)</a>
            </td>
        </tr>
    </c:forEach>
</table>
