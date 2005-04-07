<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib uri = "http://jakarta.apache.org/taglibs/mailer-1.1" prefix = "mt"%>

<c:if test = "${empty sessionScope.lang}">
    <sql:query var = "q" sql = "select default_lang from initiative_setup"/>

    <c:choose>
        <c:when test = "${(empty q.rows[0].default_lang) or (q.rows[0].default_lang==0)}">
            <c:set var = "lang" scope = "session" value = "1"/>
        </c:when>

        <c:otherwise>
            <c:set var = "lang" scope = "session" value = "${q.rows[0].default_lang}"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test = "${!empty param.lang}">
    <c:set var = "lang" value = "${param.lang}" scope = "session"/>
</c:if>

<!--- Main login page for OPA --->
<c:set var = "role" scope = "session" value = "public_contractor"/>

<c:set var = "user_email">
    <c:out value = "${param.user_email}" default = ""/>
</c:set>

<!--- OPA header --->
<sql:query var = "setup">
    select background_image, admin_header_background from initiative_setup
</sql:query>

<sql:query var = "initiative_images">
    select admin_image_title, image_toolbar from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<html>
    <body>
        <table border = "0" cellspacing = "5" cellpadding = "0" valign = "TOP">
            <tr>
                <td width = "120">
                    &nbsp;
                </td>

                <td colspan = "2" width = "475">
                </td>
            </tr>

            <tr>
                <td width = "120" valign = "TOP">
                </td>

                <td width = "10">
                    &nbsp;
                </td>

                <td width = "465" valign = "TOP">
                    <font face = "Arial" size = "-1">

                    <!--- send out user password in an email message --->

                    <!--- set coordinator admin email address --->
                    <sql:query var = "admin_email">
                        select coordinator_admin_email from coordinators where receive_admin_emails = 1
                    </sql:query>

                    <c:set var = "coordinator_admin_email" value = "${admin_email.rows[0].coordinator_admin_email}"
                           scope = "page"/>

                    <p>
                    <h3>

                    <cf:GetPhrase phrase_id = "436" lang_id = "${lang}"/></h3> </p>

                    <p>
                    <font size = +2 color = "#FF0000">

                    <cf:GetPhrase phrase_id = "922" lang_id = "${lang}"/></font></p>

                    <br>
                    <form action = "index.jsp?fuseaction=login" method = "post">
                        <input type = "hidden" name = "login_type" value = "public_contractor"> <b>

                        <cf:GetPhrase phrase_id = "438" lang_id = "${lang}"/>:</b>
                        <input type = "text" name = "contractor_login">

                        <br>
                        <b>

                        <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/>:</b>&nbsp;&nbsp;<input type = "password"
                                                                                                    name = "contractor_password">
                        <input type = "submit"
                               value = "<cf:GetPhrase phrase_id="923" lang_id="${lang}" />">
                    </form>

                    <form action = "index.jsp" method = "post">
                        <input type = "hidden" name = "role" value = "public_contractor">

                        <p>
                        <cf:GetPhrase phrase_id = "439" lang_id = "${lang}"/>?

                        <br>
                        <cf:GetPhrase phrase_id = "440" lang_id = "${lang}"/>:

                        <br>
                        <input type = "text" name = "user_email" size = "30">
                        <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
                        </p>
                    </form>
