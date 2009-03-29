<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

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

<!--- selecting information to control the appearance of the website --->
<sql:query var = "setup">
    select background_image, public_header_background, multiple_cfps, use_initiative_criteria,
    public_info,application_name,host_doc_dir,application_directory from initiative_setup
</sql:query>

<sql:query var = "info">
    select public_image_title, image_toolbar from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<html>
    <title><fmt:message key = "378" /></title>

    <body leftmargin = 0
          topmargin = 0
          marginwidth = "0"
          marginheight = "0"
          vlink = "800000"
          bgcolor = "BCBCBC"
          text = "000000"
          link = "000080">
        <table width = "600" border = "0" cellspacing = "0" cellpadding = "0"
               valign = "TOP">
            <tr>
                <td background = "<c:out value="${setup.rows[0].host_doc_dir}" />/<c:out value="${setup.rows[0].public_header_background}" />">
                    <img src = "<c:out value="${setup.rows[0].host_doc_dir}" />/<c:out value="${info.rows[0].public_image_title}" />"
                         border = 0 alt = "">
                </td>                                                                                                         
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
            </tr>

            <tr>
                <td align = "center"
                    bgcolor = "E8E8E8"><font face = "Arial" size = "3"><b>

                    <fmt:message key = "378"
                                  /></b></font></td>
            </tr>
        </table>

        <p>
        <table border = "0" cellspacing = "0" cellpadding = "0" valign = "TOP">
            <tr>
                <td width = "120" valign = "TOP"
                    bgcolor = "E8E8E8"><font face = "Arial" size = "-1">

                    <center>
                        <font size = "-2"><p>
                        <a href = "admin/dsp_login_type.jsp">

                        <fmt:message key = "923"
                        /></a> &nbsp;|&nbsp; <a href = "index.jsp?fuseaction=main&lang=<c:out value="${lang}" />">

                        <fmt:message key = "379"
                        /></a> &nbsp;|&nbsp; <a href="http://wikis.bellanet.org/harambee/index.php?title=OPA_Help" target="_new">

                        <fmt:message key = "380"
                                      /></a></font>

                        <p><a href = "index.jsp?fuseaction=cfp_list&lang=<c:out value="${lang}" />">
                        <!--- Current Calls for Proposals --->
                        <fmt:message key = "11" /></a>

                        <p><a href = "index.jsp?fuseaction=proposal_edit&lang=<c:out value="${lang}" />">
                        <!--- Edit Proposal Information --->
                        <fmt:message key = "12"
                                      /> </a>

                        <p><a href = "index.jsp?fuseaction=cfp_search&lang=<c:out value="${lang}" />">
                        <!--- Search --->
                        <fmt:message key = "982"
                                      /></a>

                        <p><a href = "index.jsp?fuseaction=report_login&lang=<c:out value="${lang}" />">
                        <!--- Submit Reports --->
                        <fmt:message key = "13"
                                      /> </a>

                        <p><a href = "index.jsp?fuseaction=discuss_comment&lang=<c:out value="${lang}" />">
                        <!--- General Discussion --->
                        <fmt:message key = "31" /></a>
                        <c:if test = "${!empty setup.rows[0].public_info}">
                            <p><a href = "index.jsp?fuseaction=archive_main&lang=<c:out value="${lang}" />">
                            <!--- Discussion & Documents --->
                            <fmt:message key = "14"
                                          /></a>
                        </c:if>

                        <p><a href = "index.jsp?fuseaction=faq&lang=<c:out value="${lang}" />">
                        <!--- Frequently Asked Questions --->
                        <fmt:message key = "15" /></a>
                        <sql:query var = "languages">
                            select * from languages order by language
                        </sql:query>

                        <p>
                        <c:forEach items = "${languages.rows}" var = "row">
                            <c:if test = "${sessionScope.lang!=row.lang_id}">
                                <a href = "index.jsp?fuseaction=main&lang=<c:out value="${row.lang_id}"/>">

                                <c:out value = "${row.language}"/></a>

                                <br>
                            </c:if>
                        </c:forEach>
                    </center>

                    </font></td>

                <td width = "10">&nbsp;</td>

                <td width = "465" valign = "top"
                    bgcolor = "FFFFFF"><font face = "Arial" size = "-1">
