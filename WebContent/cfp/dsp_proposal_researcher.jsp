<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- make sure that the user has logged in --->
<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "proponent_password">
    <c:out value = "${param.proponent_password}" default = ""/>
</c:set>

<c:if test = "${tracking_code==''}">
    <p>
    <br>
    <div align = "center">
        <b>

        <fmt:message key = "770" />

        <p>
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=proposal_edit">

        <fmt:message key = "733" /></a>

        <fmt:message key = "734" /></b>
    </div>

    <%
    if (true)
        return;
    %>
</c:if>

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<c:set var = "researcher_id">
    <c:out value = "${param.researcher_id}" default = ""/>
</c:set>

<c:set var = "researcher_firstname">
    <c:out value = "${param.researcher_firstname}" default = ""/>
</c:set>

<c:set var = "researcher_lastname">
    <c:out value = "${param.researcher_lastname}" default = ""/>
</c:set>

<c:set var = "researcher_initial">
    <c:out value = "${param.researcher_initial}" default = ""/>
</c:set>

<c:set var = "researcher_phone">
    <c:out value = "${param.researcher_phone}" default = ""/>
</c:set>

<c:set var = "researcher_fax">
    <c:out value = "${param.researcher_fax}" default = ""/>
</c:set>

<c:set var = "researcher_email">
    <c:out value = "${param.researcher_email}" default = ""/>
</c:set>

<c:set var = "researcher_citizenship">
    <c:out value = "${param.researcher_citizenship}" default = ""/>
</c:set>

<c:set var = "researcher_residency">
    <c:out value = "${param.researcher_residency}" default = ""/>
</c:set>

<c:set var = "researcher_org">
    <c:out value = "${param.researcher_org}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${act=='edit'}">
        <sql:query var = "researcher_edit">
            select * from researchers where researcher_id = ?

            <sql:param value = "${researcher_id}"/>
        </sql:query>

        <c:set var = "researcher_firstname"
               value = "${researcher_edit.rows[0].researcher_firstname}"
               scope = "page"/>

        <c:set var = "researcher_lastname"
               value = "${researcher_edit.rows[0].researcher_lastname}"
               scope = "page"/>

        <c:set var = "researcher_initial"
               value = "${researcher_edit.rows[0].researcher_initial}"
               scope = "page"/>

        <c:set var = "researcher_phone"
               value = "${researcher_edit.rows[0].researcher_phone}"
               scope = "page"/>

        <c:set var = "researcher_fax"
               value = "${researcher_edit.rows[0].researcher_fax}"
               scope = "page"/>

        <c:set var = "researcher_email"
               value = "${researcher_edit.rows[0].researcher_email}"
               scope = "page"/>

        <c:set var = "researcher_citizenship"
               value = "${researcher_edit.rows[0].researcher_citizenship}"
               scope = "page"/>

        <c:set var = "researcher_residency"
               value = "${researcher_edit.rows[0].researcher_residency}"
               scope = "page"/>

        <c:set var = "researcher_org"
               value = "${researcher_edit.rows[0].researcher_org}"
               scope = "page"/>

        <p>
        <h3>

        <fmt:message key = "649" /></h3>
    </c:when>

    <c:otherwise>
        <p>
        <h3>

        <fmt:message key = "650" /></h3>
    </c:otherwise>
</c:choose>

<fmt:message key = "41" />

<form action = "index.jsp?fuseaction=act_proposal_researcher" method = "post">
    <input type = "hidden" name = "tracking_code"
    value = "<c:out value="${tracking_code}" />">
    <input type = "hidden" name = "proponent_password"
    value = "<c:out value="${proponent_password}" />"> <input type = "hidden"
    name = "researcher_firstname_required"
    value = "<fmt:message key="651"  />"> <input type = "hidden"
    name = "researcher_lastname_required"
    value = "<fmt:message key="652"  />"> <input type = "hidden"
    name = "researcher_email_required"
    value = "<fmt:message key="653"  />"> <input type = "hidden"
    name = "researcher_citizenship_required"
    value = "<fmt:message key="654"  />"> <input type = "hidden"
    name = "researcher_residency_required"
    value = "<fmt:message key="655"  />"> <input type = "hidden"
    name = "researcher_org_required"
    value = "<fmt:message key="656"  />"> <input type = "hidden"
    name = "act" value = "<c:out value="${act}" />">
    <c:if test = "${act=='edit'}">
        <input type = "hidden" name = "researcher_id"
               value = "<c:out value="${researcher_id}" />">
    </c:if>

    <table>
        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <fmt:message key = "657" />:
            </td>

            <td>
                <input type = "text" name = "researcher_firstname" size = "15"
                value = "<c:out value="${researcher_firstname}" />"> <input type = "text"
                name = "researcher_initial" size = "3"
                value = "<c:out value="${researcher_initial}" />">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <fmt:message key = "329" />:
            </td>

            <td>
                <input type = "text" name = "researcher_lastname" size = "15"
                       value = "<c:out value="${researcher_lastname}" />">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "62" />:
            </td>

            <td>
                <input type = "text"
                       name = "researcher_phone"
                       value = "<c:out value="${researcher_phone}" />"
                       size = "10">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "29" />:
            </td>

            <td>
                <input type = "text"
                       name = "researcher_fax"
                       value = "<c:out value="${researcher_fax}" />"
                       size = "10">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <fmt:message key = "24" />:
            </td>

            <td>
                <input type = "text"
                       name = "researcher_email"
                       value = "<c:out value="${researcher_email}" />"
                       size = "20">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <fmt:message key = "621" />:
            </td>

            <td>
                <input type = "text"
                       name = "researcher_citizenship"
                       value = "<c:out value="${researcher_citizenship}" />"
                       size = "20">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <fmt:message key = "622" />:
            </td>

            <td>
                <input type = "text"
                       name = "researcher_residency"
                       value = "<c:out value="${researcher_residency}" />"
                       size = "20">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <fmt:message key = "628" />:
            </td>

            <td>
                <input type = "text"
                       name = "researcher_org"
                       value = "<c:out value="${researcher_org}" />"
                       size = "20">
            </td>
        </tr>

        <tr>
            <td colspan = "2" align = "center">
                <input type = "submit"
                       value = "   <fmt:message key="456"  />  ">
            </td>
        </tr>
    </table>
</form>
