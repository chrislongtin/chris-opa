<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<h3>

<cf:GetPhrase phrase_id = "9" lang_id = "${lang}"/></h3> <b>

<cf:GetPhrase phrase_id = "239" lang_id = "${lang}"/>.</b>

<p>
<h4>

<cf:GetPhrase phrase_id = "240" lang_id = "${lang}"/>:</h4>
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

    <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a> |

    <c:out value = '${row.language}'/>

    <br>
</c:forEach>

<p>
<h4><a STYLE = "text-decoration: underline"
       href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='add_lang'/>
<c:param name='${user}'/>
</c:url>">

<cf:GetPhrase phrase_id = "241" lang_id = "${lang}"/></a></h4> <h4>

<cf:GetPhrase phrase_id = "242" lang_id = "${lang}"/></h4>

<p>
<table>
    <td>
        <font face = "Arial" size = "-1">

        <cf:GetPhrase phrase_id = "242" lang_id = "${lang}"/>
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
                   value = "<cf:GetPhrase phrase_id="487" lang_id="${lang}" />">
        </td>
    </form>
</table>

<h4>

<cf:GetPhrase phrase_id = "243" lang_id = "${lang}"/></h4>

<p>
<table>
    <td>
        <font face = "Arial" size = "-1">

        <cf:GetPhrase phrase_id = "237" lang_id = "${lang}"/>
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

            <cf:GetPhrase phrase_id = "244" lang_id = "${lang}"/>

            <select name = "lang_id2">
                <c:forEach var = "row" items = "${langs.rows}">
                    <option value = "<c:out value='${row.lang_id}'/>">
                    <c:out value = '${row.language}'/>
                </c:forEach>
            </select>

            <input type = "submit"
                   value = " <cf:GetPhrase phrase_id="558" lang_id="${lang}" /> ">
        </td>
    </form>
</table>
