<!--- Session.user tag check --->
<!--- Prevents illegal access of pages --->
<!--- Error generated if Session.user is not defined, redirecting user back to main login page --->

<c:if test = "${(empty sessionScope.user) or (sessionScope.user=='')}">
    <c:redirect url = "../index.jsp"/>

    <%
    if (true)
        return;
    %>
</c:if>
