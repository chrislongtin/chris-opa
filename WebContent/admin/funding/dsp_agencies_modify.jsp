<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- Edit funding agency information --->

<c:choose>
    <c:when test = "${param.act == 'edit'}">
        <sql:query var = "funding_agencies">
            select * from funding_agencies where agency_id = ?

            <sql:param value = "${param.agency_id}"/>
        </sql:query>

        <p>
        <h3>

        <fmt:message key = "196" />:</h3>

        <p>
        <fmt:message key = "41" />

        <hr size = "1">
        <c:forEach var = "row" items = "${funding_agencies.rows}">
            <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_funding_agencies'/>
<c:param name='${user}'/>
</c:url>"
                  method = "post">
                <input type = "hidden" name = "agency_id"
                value = "<c:out value='${row.agency_id}'/>"> <input type = "hidden"
                name = "act" value = "edit">
                <input type = "hidden" name = "agency_name_required"
                value = "<fmt:message key='519' />">

                <p>
                <font color = "FF0000">*

                <fmt:message key = "197" />:</font>

                <br>
                <input type = "text"
                       name = "agency_name"
                       value = "<c:out value='${row.agency_name}'/>"
                       size = "30">

                <p>
                <fmt:message key = "23" />:

                <br>
                <input type = "text" name = "agency_contact"
                       value = "<c:out value='${row.agency_contact}'/>">

                <p>
                <fmt:message key = "24" />:

                <br>
                <input type = "text" name = "agency_email"
                       value = "<c:out value='${row.agency_email}'/>">

                <p>
                <fmt:message key = "62" />:

                <br>
                <input type = "text" name = "agency_phone"
                       value = "<c:out value='${row.agency_phone}'/>">

                <p>
                <fmt:message key = "64" />:

                <br>
                <input type = "text" name = "agency_url"
                value = "<c:out value='${row.agency_url}'/>"> <input type = "submit"
                value = "Update Information">
            </form>

            <p>
            <h3>

            <fmt:message key = "198" />:</h3>

            <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_delete_agency'/>
<c:param name='${user}'/>
</c:url>"
                  method = "post">
                <input type = "hidden" name = "agency_id"
                value = "<c:out value='${row.agency_id}'/>"> <input type = "submit"
                value = "<fmt:message key="520"  />">
            </form>
        </c:forEach>

    <!--- Add funding agency information --->

    </c:when>

    <c:when test = "${param.act == 'add'}">

        <!--- define new agency_id number --->
        <sql:query var = "agency_num" maxRows = "1">
            select agency_id from funding_agencies order by agency_id desc
        </sql:query>

        <c:set var = "agency_id">
            <c:out value = "${param.agency_id}" default = "1"/>
        </c:set>

        <c:forEach var = "row" items = "${agency_num.rows}">
            <c:set var = "agency_id" value = "${row.agency_id + 1}"/>
        </c:forEach>

        <p>
        <h3>

        <fmt:message key = "199" />:</h3>

        <p>
        <fmt:message key = "41" />

        <hr size = "1">
        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_funding_agencies'/>
<c:param name='${user}'/>
</c:url>"
              method = "post">
            <input type = "hidden" name = "agency_id"
            value = "<c:out value='${agency_id}'/>">
            <input type = "hidden" name = "act" value = "add">
            <input type = "hidden" name = "agency_name_required"
            value = "<fmt:message key='519' />">

            <p>
            <font color = "FF0000">*

            <fmt:message key = "197" />:</font>

            <br>
            <input type = "text" name = "agency_name" size = "30">

            <p>
            <fmt:message key = "23" />:

            <br>
            <input type = "text" name = "agency_contact">

            <p>
            <fmt:message key = "24" />:

            <br>
            <input type = "text" name = "agency_email">

            <p>
            <fmt:message key = "62" />:

            <br>
            <input type = "text" name = "agency_phone">

            <p>
            <fmt:message key = "64" />:

            <br>
            <input type = "text" name = "agency_url"> <input type = "submit"
                   value = "<fmt:message key="522"  />">
        </form>
    </c:when>
</c:choose>
