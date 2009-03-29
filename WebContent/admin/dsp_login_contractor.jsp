<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
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
            <c:set var = "lang" scope = "session"
                   value = "${q.rows[0].default_lang}"/>
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
    select admin_image_title, image_toolbar from initiative_info where lang_id
    = ?

    <sql:param value = "${lang}"/>
</sql:query>

<html>
    <body leftmargin = 0
          topmargin = 0
          marginwidth = "0"
          marginheight = "0"
          background = "../docs/<c:out value="${setup.rows[0].background_image}" />">
        <table width = "600" border = "0" cellspacing = "0" cellpadding = "0"
               valign = "TOP">
            <tr>
                <td background = "../docs/<c:out value="${setup.rows[0].admin_header_background}" />">
                    <img src = "../docs/<c:out value="${initiative_images.rows[0].admin_image_title}" />"
                         border = 0
                         alt = ""></td>
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
                        select coordinator_admin_email from coordinators where
                        receive_admin_emails = 1
                    </sql:query>

                    <c:set var = "coordinator_admin_email"
                    value = "${admin_email.rows[0].coordinator_admin_email}"
                    scope = "page"/><c:choose>
                        <c:when test = "${role=='coordinator'}">
                            <sql:query var = "get_password">
                                select coordinator_password, coordinator_login
                                from coordinators where coordinator_email = ?

                                <sql:param value = "${user_email}"/>
                            </sql:query>

                            <c:if test = "${empty get_password.rows[0].coordinator_login}">
                                <fmt:message key = "431"
                                              />

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
                                    <fmt:message key = "937"
                                                  />
                                </mt:subject>

                                <mt:message>
                                    <fmt:message key = "432"
                                                  />

                                    <c:out value = "${get_password.rows[0].coordinator_password}"/>

                                    <fmt:message key = "433"
                                                  />

                                    <c:out value = "${get_password.rows[0].coordinator_login}"/>
                                </mt:message>

                                <mt:send/>
                            </mt:mail>

                            <h3>

                            <fmt:message key = "434"
                                          />

                            <c:out value = "${user_email}"/>.</h3>
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp">

                            <fmt:message key = "435"
                                          /></a>
                        </c:when>

                        <c:when test = "${role=='contractor'}">
                            <sql:query var = "get_password">
                                select contractor_password, contractor_login
                                from contractors where contractor_email = ?

                                <sql:param value = "${user_email}"/>
                            </sql:query>

                            <c:if test = "${empty get_password.rows[0].contractor_login}">
                                <fmt:message key = "431"
                                              />

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
                                    <fmt:message key = "937"
                                                  />
                                </mt:subject>

                                <mt:message>
                                    <fmt:message key = "432"
                                                  />

                                    <c:out value = "${get_password.rows[0].contractor_password}"/>

                                    <fmt:message key = "433"
                                                  />

                                    <c:out value = "${get_password.rows[0].contractor_login}"/>
                                </mt:message>

                                <mt:send/>
                            </mt:mail>

                            <h3>

                            <fmt:message key = "434"
                                          />

                            <c:out value = "${user_email}"/>.</h3>
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp">

                            <fmt:message key = "435"
                                          /></a>
                        </c:when>

                        <c:otherwise>
                            <p>
                            <h3>

                            <fmt:message key = "436"
                                          /></h3> </p>

                            <p>
                            <font size = +2 color = "#FF0000">

                            <fmt:message key = "922"
                                          /></font></p>

                            <br>
                            <form action = "index.jsp?fuseaction=login"
                                  method = "post">
                                <input type = "hidden" name = "login_type"
                                value = "contractor"> <b>

                                <fmt:message key = "438"
                                />:</b> <input type = "text"
                                name = "contractor_login">

                                <br>
                                <b>

                                <fmt:message key = "92"
                                />:</b>&nbsp;&nbsp;<input type = "password" name = "contractor_password">
                                <input type = "submit"
                                value = "<fmt:message key="923"  />">
                            </form>

                            <form action = "index.jsp" method = "post">
                                <input type = "hidden" name = "role"
                                       value = "contractor">

                                <p>
                                <fmt:message key = "439"
                                              />?

                                <br>
                                <fmt:message key = "440"
                                              />:

                                <br>
                                <input type = "text" name = "user_email" size = "30">
                                <input type = "submit"
                                value = " <fmt:message key="456"  /> ">
                                </p>
                            </form>
                        </c:otherwise>
                    </c:choose>

                    <%@ include file = "footer.jsp"%>
