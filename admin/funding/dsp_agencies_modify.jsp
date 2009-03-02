<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
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

        <cf:GetPhrase phrase_id = "196" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

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
                value = "<cf:GetPhrase phrase_id='519' lang_id='${lang}'/>">

                <p>
                <font color = "FF0000">*

                <cf:GetPhrase phrase_id = "197" lang_id = "${lang}"/>:</font>

                <br>
                <input type = "text"
                       name = "agency_name"
                       value = "<c:out value='${row.agency_name}'/>"
                       size = "30">

                <p>
                <cf:GetPhrase phrase_id = "23" lang_id = "${lang}"/>:

                <br>
                <input type = "text" name = "agency_contact"
                       value = "<c:out value='${row.agency_contact}'/>">

                <p>
                <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:

                <br>
                <input type = "text" name = "agency_email"
                       value = "<c:out value='${row.agency_email}'/>">

                <p>
                <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:

                <br>
                <input type = "text" name = "agency_phone"
                       value = "<c:out value='${row.agency_phone}'/>">

                <p>
                <cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:

                <br>
                <input type = "text" name = "agency_url"
                value = "<c:out value='${row.agency_url}'/>"> <input type = "submit"
                value = "Update Information">
            </form>

            <p>
            <h3>

            <cf:GetPhrase phrase_id = "198" lang_id = "${lang}"/>:</h3>

            <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_delete_agency'/>
<c:param name='${user}'/>
</c:url>"
                  method = "post">
                <input type = "hidden" name = "agency_id"
                value = "<c:out value='${row.agency_id}'/>"> <input type = "submit"
                value = "<cf:GetPhrase phrase_id="520" lang_id="${lang}" />">
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

        <cf:GetPhrase phrase_id = "199" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

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
            value = "<cf:GetPhrase phrase_id='519' lang_id='${lang}'/>">

            <p>
            <font color = "FF0000">*

            <cf:GetPhrase phrase_id = "197" lang_id = "${lang}"/>:</font>

            <br>
            <input type = "text" name = "agency_name" size = "30">

            <p>
            <cf:GetPhrase phrase_id = "23" lang_id = "${lang}"/>:

            <br>
            <input type = "text" name = "agency_contact">

            <p>
            <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:

            <br>
            <input type = "text" name = "agency_email">

            <p>
            <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:

            <br>
            <input type = "text" name = "agency_phone">

            <p>
            <cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:

            <br>
            <input type = "text" name = "agency_url"> <input type = "submit"
                   value = "<cf:GetPhrase phrase_id="522" lang_id="${lang}" />">
        </form>
    </c:when>
</c:choose>
