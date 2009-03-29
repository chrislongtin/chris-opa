<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<!--- add, or edit coordinators --->

<c:choose>
    <c:when test = "${act=='add'}">
        <h3>

        <fmt:message key = "328" />:</h3>

        <p>
        <fmt:message key = "41" />

        <form action = "index.jsp?fuseaction=act_coordinator" method = "post">
            <input type = "hidden" name = "act" value = "add">
            <input type = "hidden" name = "coordinator_lastname_required"
            value = "<fmt:message key="697"  />"> <input type = "hidden" name = "coordinator_firstname_required" value = "<fmt:message key="698"  />">
            <input type = "hidden" name = "coordinator_login_required"
            value = "<fmt:message key="699"  />"> <input type = "hidden" name = "coordinator_email_required" value = "<fmt:message key="702"  />">
            <input type = "hidden" name = "coordinator_password_required"
            value = "<fmt:message key="701"  />"> <input type = "hidden"
            name = "coordinator_phone_required"
            value = "<fmt:message key="703"  />">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "330" />:</b></font>

            <br>
            <input type = "text" name = "coordinator_firstname" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "329" />:</b></font>

            <br>
            <input type = "text" name = "coordinator_lastname" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "331" />:</b></font>

            <br>
            <input type = "text" name = "coordinator_login" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "92" />:</b></font>

            <br>
            <input type = "text" name = "coordinator_password" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "24" />:</b></font>

            <br>
            <input type = "text" name = "coordinator_email" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "62" />:</b></font>

            <br>
            <input type = "text" name = "coordinator_phone" size = "30">

            <p>
            <b>

            <fmt:message key = "29" />:</b>

            <br>
            <input type = "text" name = "coordinator_fax" size = "30">

            <p>
            <b>

            <fmt:message key = "61" />:</b>

            <br>
            <input type = "text" name = "coordinator_address" size = "30">

            <p>
            <b>

            <fmt:message key = "332" />:</b>
            <input type = "checkbox" name = "receive_public_emails" value = "1">

            <p>
            <b>

            <fmt:message key = "333" />:</b>

            <br>
            <input type = "text" name = "coordinator_public_email" size = "30">

            <p>
            <b>

            <fmt:message key = "334" />:</b>
            <input type = "checkbox" name = "receive_admin_emails" value = "1">

            <p>
            <b>

            <fmt:message key = "335" />:</b>

            <br>
            <input type = "text" name = "coordinator_admin_email" size = "30">

            <p>
            <input type = "submit"
                   value = " <fmt:message key="456"  /> ">
        </form>
    </c:when>

    <c:when test = "${act=='edit'}">
        <c:set var = "coordinator_id">
            <c:out value = "${param.coordinator_id}" default = ""/>
        </c:set>

        <sql:query var = "edit_coord">
            select * from coordinators where coordinator_id = ?

            <sql:param value = "${coordinator_id}"/>
        </sql:query>

        <c:set var = "ec" value = "${edit_coord.rows[0]}" scope = "page"/>

        <h3>

        <fmt:message key = "336" />:</h3>

        <p>
        <fmt:message key = "41" />

        <form action = "index.jsp?fuseaction=act_coordinator" method = "post">
            <input type = "hidden" name = "coordinator_id"
            value = "<c:out value="${ec.coordinator_id}" />"> <input type = "hidden"
            name = "act" value = "edit">
            <input type = "hidden" name = "coordinator_lastname_required"
            value = "<fmt:message key="697"  />"> <input type = "hidden" name = "coordinator_firstname_required" value = "<fmt:message key="698"  />">
            <input type = "hidden" name = "coordinator_login_required"
            value = "Y<fmt:message key="699"  />"> <input type = "hidden" name = "coordinator_email_required" value = "<fmt:message key="702"  />">
            <input type = "hidden" name = "coordinator_password_required"
            value = "<fmt:message key="701"  />"> <input type = "hidden"
            name = "coordinator_phone_required"
            value = "<fmt:message key="703"  />">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "330" />:</b></font>

            <br>
            <input type = "text"
                   name = "coordinator_firstname"
                   value = "<c:out value="${ec.coordinator_firstname}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "329" />:</b></font>

            <br>
            <input type = "text"
                   name = "coordinator_lastname"
                   value = "<c:out value="${ec.coordinator_lastname}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "331" />:</b></font>

            <br>
            <input type = "text"
                   name = "coordinator_login"
                   value = "<c:out value="${ec.coordinator_login}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "92" />:</b></font>

            <br>
            <input type = "password"
                   name = "coordinator_password"
                   value = "<c:out value="${ec.coordinator_password}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "24" />:</b></font>

            <br>
            <input type = "text"
                   name = "coordinator_email"
                   value = "<c:out value="${ec.coordinator_email}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "62" />:</b></font>

            <br>
            <input type = "text"
                   name = "coordinator_phone"
                   value = "<c:out value="${ec.coordinator_phone}" />"
                   size = "30">

            <p>
            <b>

            <fmt:message key = "29" />:</b>

            <br>
            <input type = "text"
                   name = "coordinator_fax"
                   value = "<c:out value="${ec.coordinator_fax}" />"
                   size = "30">

            <p>
            <b>

            <fmt:message key = "61" />:</b>

            <br>
            <input type = "text"
                   name = "coordinator_address"
                   value = "<c:out value="${ec.coordinator_address}" />"
                   size = "30">

            <p>
            <b>

            <fmt:message key = "332" />:</b>
            <input type = "checkbox" name = "receive_public_emails" value = "1"
            <c:if test = "${ec.receive_public_emails==1}"> checked

            </c:if>

            >

            <p>
            <b>

            <fmt:message key = "333" />:</b>

            <br>
            <input type = "text"
                   name = "coordinator_public_email"
                   value = "<c:out value="${ec.coordinator_public_email}" />"
                   size = "30">

            <p>
            <b>

            <fmt:message key = "334" />:</b>
            <input type = "checkbox" name = "receive_admin_emails" value = "1"
            <c:if test = "${ec.receive_admin_emails==1}"> checked

            </c:if>

            >

            <p>
            <b>

            <fmt:message key = "335" />:</b>

            <br>
            <input type = "text"
                   name = "coordinator_admin_email"
                   value = "<c:out value="${ec.coordinator_admin_email}" />"
                   size = "30">

            <p>
            <input type = "submit"
                   value = " <fmt:message key="456"  /> ">
        </form>
    </c:when>
</c:choose>
