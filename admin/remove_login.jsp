<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- remove the generic username and password from the system --->
<!--- run this file once, and ensure that you have already setup a coordinator login --->

<sql:update>
    delete from coordinators where coordinator_login = 'coordinator' and coordinator_password = 'guest'
</sql:update>

<h2>Generic Username and Password successfully removed!</h2> <h3><a STYLE="text-decoration: underline"  href = "index.jsp">Return to Login</a></h3>
