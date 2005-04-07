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
<c:set var = "role">
    <c:out value = "${param.role}" default = ""/>
</c:set>

<c:set var = "user_email">
    <c:out value = "${param.user_email}" default = ""/>
</c:set>

<!--- OPA header --->
<sql:query var = "setup">
    select background_image, admin_header_background from initiative_setup
</sql:query>

<sql:query var = "initiative_images">
    select admin_image_title, image_toolbar from initiative_info where lang_id = 1
</sql:query>

<html>
    <body leftmargin = 0 topmargin = 0 marginwidth = "0" marginheight = "0"
          background = "../docs/<c:out value="${setup.rows[0].background_image}" />">
        <table width = "100%" border = "0" cellspacing = "0" cellpadding = "0" valign = "TOP">
            <tr>
                <td background = "../docs/<c:out value="${setup.rows[0].admin_header_background}" />">
                    <img src = "../docs/<c:out value="${initiative_images.rows[0].admin_image_title}" />" border = 0
                         alt = "">
                </td>
            </tr>
        </table>

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
                           scope = "page"/><c:choose>
                        <c:when test = "${role=='coordinator'}">
                            <sql:query var = "get_password">
                                select coordinator_password, coordinator_login from coordinators where
                                coordinator_email = ?

                                <sql:param value = "${user_email}"/>
                            </sql:query>

                            <c:if test = "${empty get_password.rows[0].coordinator_login}">
                                <cf:GetPhrase phrase_id = "431" lang_id = "${lang}"/>

                                .

<%
                                if (true)
                                    return;
%>
                            </c:if>

                            <mt:mail session = "java:/comp/env/mail/session">
                                <mt:from>
                                    <c:out value = "${coordinator_admin_email}"/>
                                </mt:from>

                                <mt:setrecipient type = "to">
                                    <c:out value = "${user_email}"/>
                                </mt:setrecipient>

                                <mt:subject>
                                    <cf:GetPhrase phrase_id = "937" lang_id = "${lang}"/>
                                </mt:subject>

                                <mt:message>
                                    <cf:GetPhrase phrase_id = "432" lang_id = "${lang}"/>

                                    <c:out value = "${get_password.rows[0].coordinator_password}"/>

                                    <cf:GetPhrase phrase_id = "433" lang_id = "${lang}"/>

                                    <c:out value = "${get_password.rows[0].coordinator_login}"/>
                                </mt:message>

                                <mt:send/>
                            </mt:mail>

                            <h3>

                            <cf:GetPhrase phrase_id = "434" lang_id = "${lang}"/>

                            <c:out value = "${user_email}"/>.</h3> <a STYLE="text-decoration: underline"  href = "index.jsp">

                            <cf:GetPhrase phrase_id = "435" lang_id = "${lang}"/></a>
                        </c:when>

                        <c:when test = "${role=='reviewer'}">
                            <sql:query var = "get_password">
                                select reviewer_password, reviewer_login from reviewers where reviewer_email = ?

                                <sql:param value = "${user_email}"/>
                            </sql:query>

                            <c:if test = "${empty get_password.rows[0].reviewer_login}">
                                <cf:GetPhrase phrase_id = "431" lang_id = "${lang}"/>

                                .

<%
                                if (true)
                                    return;
%>
                            </c:if>

                            <mt:mail session = "java:/comp/env/mail/session">
                                <mt:from>
                                    <c:out value = "${coordinator_admin_email}"/>
                                </mt:from>

                                <mt:setrecipient type = "to">
                                    <c:out value = "${user_email}"/>
                                </mt:setrecipient>

                                <mt:subject>
                                    <cf:GetPhrase phrase_id = "937" lang_id = "${lang}"/>
                                </mt:subject>

                                <mt:message>
                                    <cf:GetPhrase phrase_id = "432" lang_id = "${lang}"/>

                                    <c:out value = "${get_password.rows[0].reviewer_password}"/>

                                    <cf:GetPhrase phrase_id = "433" lang_id = "${lang}"/>

                                    <c:out value = "${get_password.rows[0].reviewer_login}"/>
                                </mt:message>

                                <mt:send/>
                            </mt:mail>

                            <h3>

                            <cf:GetPhrase phrase_id = "434" lang_id = "${lang}"/>

                            <c:out value = "${user_email}"/>.</h3> <a STYLE="text-decoration: underline"  href = "index.jsp">

                            <cf:GetPhrase phrase_id = "435" lang_id = "${lang}"/></a>
                        </c:when>

                        <c:otherwise>
                            <p>
                            <h2>

                            <center>
                                <cf:GetPhrase phrase_id = "436" lang_id = "${lang}"/>

                                :
                            </center>

                            </h2>

                            <p>
                            <br>
                            <h3>

                            <cf:GetPhrase phrase_id = "437" lang_id = "${lang}"/>:</h3>

                            <form action = "index.jsp?fuseaction=login" method = "post">
                                <input type = "hidden" name = "login_type" value = "reviewer"> <b>

                                <cf:GetPhrase phrase_id = "438" lang_id = "${lang}"/>:</b>
                                <input type = "text" name = "reviewer_login">

                                <br>
                                <b>

                                <cf:GetPhrase phrase_id = "92"
                                              lang_id = "${lang}"/>:</b>&nbsp;&nbsp;<input type = "password"
                                                                                           name = "reviewer_password">
                                <input type = "submit"
                                       value = "<cf:GetPhrase phrase_id="923" lang_id="${lang}" />">
                            </form>

                            <form action = "index.jsp" method = "post">
                                <input type = "hidden" name = "role" value = "reviewer">

                                <p>
                                <cf:GetPhrase phrase_id = "439" lang_id = "${lang}"/>?

                                <br>
                                <cf:GetPhrase phrase_id = "440" lang_id = "${lang}"/>:

                                <br>
                                <input type = "text" name = "user_email" size = "30">
                                <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
                            </form>

                            <p>
                            <h3>

                            <cf:GetPhrase phrase_id = "921" lang_id = "${lang}"/>:</h3>

                            <form action = "index.jsp?fuseaction=login" method = "post">
                                <input type = "hidden" name = "login_type" value = "coordinator"> <b>

                                <cf:GetPhrase phrase_id = "438" lang_id = "${lang}"/>:</b>
                                <input type = "text" name = "coordinator_login">

                                <br>
                                <b>

                                <cf:GetPhrase phrase_id = "92"
                                              lang_id = "${lang}"/>:</b>&nbsp;&nbsp;<input type = "password"
                                                                                           name = "coordinator_password">
                                <input type = "submit"
                                       value = "<cf:GetPhrase phrase_id="923" lang_id="${lang}" />">
                            </form>

                            <form action = "index.jsp" method = "post">
                                <input type = "hidden" name = "role" value = "coordinator">

                                <p>
                                <cf:GetPhrase phrase_id = "439" lang_id = "${lang}"/>?

                                <br>
                                <cf:GetPhrase phrase_id = "440" lang_id = "${lang}"/>:

                                <br>
                                <input type = "text" name = "user_email" size = "30">
                                <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
                            </form>
                        </c:otherwise>
                    </c:choose>
