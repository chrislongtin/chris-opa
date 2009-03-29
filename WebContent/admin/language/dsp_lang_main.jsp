<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<h3>

<fmt:message key = "9" /></h3> <b>

<fmt:message key = "239" />.</b>

<p>
<h4>

<fmt:message key = "240" />:</h4>
<sql:query var = "langs">
    select * from languages
</sql:query>

<c:forEach var = "row" items = "${langs.rows}">
    <a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_add_lang'/>
<c:param name='act' value='delete'/>
<c:param name='lang_id' value='${row.lang_id}'/>
<c:param name='${user}'/>
</c:url>">

    <fmt:message key = "143" /></a> |

    <c:out value = '${row.language}'/>

    <br>
</c:forEach>

<p>
<h4><a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='add_lang'/>
<c:param name='${user}'/>
</c:url>">

<fmt:message key = "241" /></a></h4> <h4>

<fmt:message key = "242" /></h4>

<p>
<table>
    <td>
        <font face = "Arial" size = "-1">

        <fmt:message key = "242" />
    </td>

    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='add_phrase'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <td>
            <font face = "Arial" size = "-1">

            <select name = "lang_id">
                <c:forEach var = "row" items = "${langs.rows}">
                    <option value = "<c:out value='${row.lang_id}'/>">
                    <c:out value = '${row.language}'/>
                </c:forEach>
            </select>

            <input type = "submit"
                   value = "<fmt:message key="487"  />">
        </td>
    </form>
</table>

<h4>

<fmt:message key = "243" /></h4>

<p>
<table>
    <td>
        <font face = "Arial" size = "-1">

        <fmt:message key = "237" />
    </td>

    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='lang_convert'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <td>
            <font face = "Arial" size = "-1">

            <select name = "lang_id1">
                <c:forEach var = "row" items = "${langs.rows}">
                    <option value = "<c:out value='${row.lang_id}'/>">
                    <c:out value = '${row.language}'/>
                </c:forEach>
            </select>
        </td>

        <td>
            <font face = "Arial" size = "-1">

            <fmt:message key = "244" />

            <select name = "lang_id2">
                <c:forEach var = "row" items = "${langs.rows}">
                    <option value = "<c:out value='${row.lang_id}'/>">
                    <c:out value = '${row.language}'/>
                </c:forEach>
            </select>

            <input type = "submit"
                   value = " <fmt:message key="558"  /> ">
        </td>
    </form>
</table>
