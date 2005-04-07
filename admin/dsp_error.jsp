<%@ page isErrorPage = "true"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- Error Processing page --->

<p>
<cf:GetPhrase phrase_id = "429" lang_id = "${lang}"/>:

<p>
<a STYLE="text-decoration: underline"  href = "index.jsp">

<cf:GetPhrase phrase_id = "430" lang_id = "${lang}"/></a>

<p>
<font color = red><%= exception.getMessage() %></font></p>
