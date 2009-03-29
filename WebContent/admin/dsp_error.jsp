<%@ page isErrorPage = "true"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- Error Processing page --->

<p>
<fmt:message key = "429" />:

<p>
<a STYLE = "text-decoration: underline" href = "index.jsp">

<fmt:message key = "430" /></a>

<p>
<font color = red><%= exception.getMessage() %></font></p>
