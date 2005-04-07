<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

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

        <c:set var = "researcher_firstname" value = "${researcher_edit.rows[0].researcher_firstname}" scope = "page"/>

        <c:set var = "researcher_lastname" value = "${researcher_edit.rows[0].researcher_lastname}" scope = "page"/>

        <c:set var = "researcher_initial" value = "${researcher_edit.rows[0].researcher_initial}" scope = "page"/>

        <c:set var = "researcher_phone" value = "${researcher_edit.rows[0].researcher_phone}" scope = "page"/>

        <c:set var = "researcher_fax" value = "${researcher_edit.rows[0].researcher_fax}" scope = "page"/>

        <c:set var = "researcher_email" value = "${researcher_edit.rows[0].researcher_email}" scope = "page"/>

        <c:set var = "researcher_citizenship" value = "${researcher_edit.rows[0].researcher_citizenship}"
               scope = "page"/>

        <c:set var = "researcher_residency" value = "${researcher_edit.rows[0].researcher_residency}" scope = "page"/>

        <c:set var = "researcher_org" value = "${researcher_edit.rows[0].researcher_org}" scope = "page"/>

        <p>
        <h3>

        <cf:GetPhrase phrase_id = "649" lang_id = "${lang}"/></h3>
    </c:when>

    <c:otherwise>
        <p>
        <h3>

        <cf:GetPhrase phrase_id = "650" lang_id = "${lang}"/></h3>
    </c:otherwise>
</c:choose>

<cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

<form action = "index.jsp?fuseaction=act_proposal_researcher" method = "post">
    <input type = "hidden" name = "tracking_code" value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
           name = "researcher_firstname_required"
           value = "<cf:GetPhrase phrase_id="651" lang_id="${lang}" />"> <input type = "hidden"
           name = "researcher_lastname_required"
           value = "<cf:GetPhrase phrase_id="652" lang_id="${lang}" />"> <input type = "hidden"
           name = "researcher_email_required"
           value = "<cf:GetPhrase phrase_id="653" lang_id="${lang}" />"> <input type = "hidden"
           name = "researcher_citizenship_required"
           value = "<cf:GetPhrase phrase_id="654" lang_id="${lang}" />"> <input type = "hidden"
           name = "researcher_residency_required"
           value = "<cf:GetPhrase phrase_id="655" lang_id="${lang}" />"> <input type = "hidden"
           name = "researcher_org_required"
           value = "<cf:GetPhrase phrase_id="656" lang_id="${lang}" />">
    <input type = "hidden" name = "act" value = "<c:out value="${act}" />"><c:if test = "${act=='edit'}">
        <input type = "hidden" name = "researcher_id" value = "<c:out value="${researcher_id}" />">
    </c:if>

    <table>
        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <cf:GetPhrase phrase_id = "657" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text"
                       name = "researcher_firstname"
                       size = "15"
                       value = "<c:out value="${researcher_firstname}" />">
                <input type = "text" name = "researcher_initial" size = "3"
                       value = "<c:out value="${researcher_initial}" />">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <cf:GetPhrase phrase_id = "329" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text" name = "researcher_lastname" size = "15"
                       value = "<c:out value="${researcher_lastname}" />">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text" name = "researcher_phone" value = "<c:out value="${researcher_phone}" />"
                       size = "10">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text" name = "researcher_fax" value = "<c:out value="${researcher_fax}" />" size = "10">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text" name = "researcher_email" value = "<c:out value="${researcher_email}" />"
                       size = "20">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <cf:GetPhrase phrase_id = "621" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text"                                         name = "researcher_citizenship"
                       value = "<c:out value="${researcher_citizenship}" />" size = "20">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <cf:GetPhrase phrase_id = "622" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text" name = "researcher_residency" value = "<c:out value="${researcher_residency}" />"
                       size = "20">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <cf:GetPhrase phrase_id = "628" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text" name = "researcher_org" value = "<c:out value="${researcher_org}" />" size = "20">
            </td>
        </tr>

        <tr>
            <td colspan = "2" align = "center">
                <input type = "submit" value = "   <cf:GetPhrase phrase_id="456" lang_id="${lang}" />   ">
            </td>
        </tr>
    </table>
</form>
