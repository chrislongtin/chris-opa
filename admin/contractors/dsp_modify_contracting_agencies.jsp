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

<c:set var = "agency_id">
    <c:out value = "${param.agency_id}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${act=='add'}">

        <!-------------------------- ADD NEW CONTRACTING AGENCY -------------------------------->

        <h3>

        <cf:GetPhrase phrase_id = "975" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

        <form action = "index.jsp?fuseaction=act_contracting_agency&act=add" method = "post">
            <input type = "hidden" name = "agency_name_required"
                   value = "<cf:GetPhrase phrase_id="519" lang_id="${lang}" />">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "197" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_name" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "200" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_contact" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_email" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_phone" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_url" size = "30">

            <p>
            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>

    <c:when test = "${act=='edit'}">

        <!-------------------------- EDIT CONTRACTOR -------------------------------->

        <sql:query var = "edit_contracting_agency">
            select * from contracting_agencies where agency_id = ?

            <sql:param value = "${agency_id}"/>
        </sql:query>

        <c:set var = "er" value = "${edit_contracting_agency.rows[0]}" scope = "page"/>

        <form action = "index.jsp?fuseaction=act_contracting_agency" method = "post">
            <input type = "hidden" name = "act" value = "edit">
            <input type = "hidden" name = "agency_id" value = "<c:out value="${er.agency_id}" />">
            <input type = "hidden" name = "agency_name_required"
                   value = "<cf:GetPhrase phrase_id="697" lang_id="${lang}" />">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "197" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_name" value = "<c:out value="${er.agency_name}" />" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "200" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_contact" value = "<c:out value="${er.agency_contact}" />" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_email" value = "<c:out value="${er.agency_email}" />" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_phone" value = "<c:out value="${er.agency_phone}" />" size = "30">

            <p>
            <font color = "FF0000"><b>

            <cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "agency_url" value = "<c:out value="${er.agency_url}" />" size = "30">

            <p>
            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>
</c:choose>
