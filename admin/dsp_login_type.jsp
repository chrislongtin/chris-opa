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
    select admin_image_title, image_toolbar from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<sql:query var = "roles">
    select role_name,lower(role_name) as lower_role_name from person_role_types where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<html>
    <body leftmargin = 0 topmargin = 0 marginwidth = "0" marginheight = "0"
          background = "../docs/<c:out value="${setup.rows[0].background_image}" />">

        <%@ include file = "header_site.jsp"%>


        <!--	
            <table width = "100%" border = "0" cellspacing = "0" cellpadding = "0" valign = "TOP">
                    <tr>
                        <td background = "../docs/<c:out value="${setup.rows[0].admin_header_background}" />">
                            <img src = "../docs/<c:out value="${initiative_images.rows[0].admin_image_title}" />" border = 0
                                 alt = ""></td>
                    </tr>
                </table>
        -->

        <br>
        <br>
        <table width = "600" border = "0" cellspacing = "0" cellpadding = "0">
            <th width = "150">
            </th>

            <th bgcolor = "#CCCCFF" colspan = 1 width = "450">
                <font size = 2>

                <cf:GetPhrase phrase_id = "1041" lang_id = "${lang}"/></font>
            </th>
        </table>

        <br>
        <br>
        <table width = "600" border = "0" cellspacing = "0" cellpadding = "0">
            <tr>
                <td width = "150">
                </td>

                <td valign = "top" colspan = 2 align = "center">
                    <form action = "act_login_type.jsp" method = "post">
                        <select name = "login_type" size = "1">
                            <c:forEach items = "${roles.rows}" var = "row">
                                <option value = "<c:out value="${row.lower_role_name}" />">
                                <c:out value = "${row.role_name}"/>
                            </c:forEach>
                        </select>

                        <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
                    </form>
                </td>
            </tr>
        </table>

        <br>
        <br>
        <br>
