<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<%@ include file = "../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "proponent_password">
    <c:out value = "${param.proponent_password}" default = ""/>
</c:set>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "researcher_id">
    <c:out value = "${param.researcher_id}" default = "1"/>
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

<!--- process add researcher profile --->
<c:choose>
    <c:when test = "${act=='add'}">

        <!--- add a new researcher --->
        <sql:query var = "researcher_num" maxRows = "1">
            select researcher_id from researchers order by researcher_id desc
        </sql:query>

        <c:set var = "researcher_id"
               value = "${researcher_num.rows[0].researcher_id + 1}"
               scope = "page"/>

        <sql:update>
            insert into researchers (researcher_id, tracking_code,
            researcher_firstname, researcher_lastname, researcher_initial,
            researcher_phone, researcher_fax, researcher_email,
            researcher_citizenship, researcher_residency, researcher_org)
            values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)

            <sql:param value = "${researcher_id}"/>

            <sql:param value = "${tracking_code}"/>

            <sql:param value = "${researcher_firstname}"/>

            <sql:param value = "${researcher_lastname}"/>

            <sql:param value = "${researcher_initial}"/>

            <sql:param value = "${researcher_phone}"/>

            <sql:param value = "${researcher_fax}"/>

            <sql:param value = "${researcher_email}"/>

            <sql:param value = "${researcher_citizenship}"/>

            <sql:param value = "${researcher_residency}"/>

            <sql:param value = "${researcher_org}"/>
        </sql:update>

        <h3>

        <cf:GetPhrase phrase_id = "743" lang_id = "${lang}"/>!</h3>
    </c:when>

    <c:when test = "${act=='edit'}">
        <sql:update>
            update researchers set researcher_firstname = ?,
            researcher_lastname = ?, researcher_initial = ?, researcher_phone
            = ?, researcher_fax = ?, researcher_email = ?,
            researcher_citizenship = ?, researcher_residency = ?,
            researcher_org = ? where researcher_id = ?

            <sql:param value = "${researcher_firstname}"/>

            <sql:param value = "${researcher_lastname}"/>

            <sql:param value = "${researcher_initial}"/>

            <sql:param value = "${researcher_phone}"/>

            <sql:param value = "${researcher_fax}"/>

            <sql:param value = "${researcher_email}"/>

            <sql:param value = "${researcher_citizenship}"/>

            <sql:param value = "${researcher_residency}"/>

            <sql:param value = "${researcher_org}"/>

            <sql:param value = "${researcher_id}"/>
        </sql:update>

        <h3>

        <cf:GetPhrase phrase_id = "743" lang_id = "${lang}"/>!</h3>
    </c:when>

    <c:when test = "${act=='delete_unconfirmed'}">
        <p>
        <br>
        <b>

        <cf:GetPhrase phrase_id = "577" lang_id = "${lang}"/>?</b>

        <table>
            <tr>
                <td>
                    <form action = "index.jsp?fuseaction=act_proposal_researcher"
                          method = "post">
                        <input type = "hidden" name = "tracking_code"
                        value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                        <input type = "hidden" name = "researcher_id"
                        value = "<c:out value="${researcher_id}" />"> <input type = "hidden" name = "act" value = "delete">
                        <input type = "submit"
                        value = "<cf:GetPhrase phrase_id="570" lang_id="${lang}" />">
                    </form>
                </td>

                <td>
                    <form action = "index.jsp?fuseaction=proposal_info"
                          method = "post">
                        <input type = "hidden" name = "tracking_code"
                        value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                        <input type = "submit"
                        value = "<cf:GetPhrase phrase_id="543" lang_id="${lang}" />">
                    </form>
                </td>
        </table>

        <%
        if (true)
            return;
        %>
    </c:when>

    <c:when test = "${act=='delete'}">
        <sql:update>
            delete from researchers where researcher_id = ?

            <sql:param value = "${researcher_id}"/>
        </sql:update>

        <h3>

        <cf:GetPhrase phrase_id = "744" lang_id = "${lang}"/>!</h3>
    </c:when>
</c:choose>

<p>
<table>
    <tr>
        <td>
            <form action = "index.jsp?fuseaction=proposal_info" method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                value = "<cf:GetPhrase phrase_id="739" lang_id="${lang}" />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=cfp_proposal" method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "hidden" name = "act" value = "edit">
                <input type = "submit"
                value = "<cf:GetPhrase phrase_id="740" lang_id="${lang}" />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=proposal_doc" method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                value = "<cf:GetPhrase phrase_id="741" lang_id="${lang}" />">
            </form>
        </td>

        <td>
            <form action = "index.jsp?fuseaction=proposal_researcher"
                  method = "post">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                value = "<cf:GetPhrase phrase_id="742" lang_id="${lang}" />">
            </form>
        </td>
    </tr>
</table>
