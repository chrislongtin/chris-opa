<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

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

<!--- selecting information to control the appearance of the website --->
<sql:query var = "setup">
    select background_image, public_header_background, multiple_cfps, use_initiative_criteria,
    public_info,application_name,application_directory from initiative_setup
</sql:query>

<sql:query var = "info">
    select public_image_title, image_toolbar from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<html>
    <title><cf:GetPhrase phrase_id = "378" lang_id = "${lang}"/></title>

    <body leftmargin = 0     topmargin = 0                                                           marginwidth = "0"
          marginheight = "0" background = "docs/<c:out value="${setup.rows[0].background_image}" />" vlink = "800000"
          bgcolor = "BCBCBC" text = "000000"                                                         link = "000080">
 <!--
       <table width = "100%" border = "0" cellspacing = "0" cellpadding = "0" valign = "TOP">
            <tr>
                <td background = "docs/<c:out value="${setup.rows[0].public_header_background}" />"><img src = "docs/<c:out value="${info.rows[0].public_image_title}" />"
                                                                                                         border = 0
                                                                                                         alt = ""></td>
            </tr>
            <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
            <tr>
                 <td align="center" bgcolor = "E8E8E8"><font face = "Arial" size = "3"><b><cf:GetPhrase phrase_id = "1039" lang_id = "${lang}"/></b></font></td>
            </tr>
        </table>
-->


        <p>
        <table border = "0" cellspacing = "0" cellpadding = "0" valign = "TOP">
            <tr>
                <td width = "120" valign = "TOP" bgcolor = "E8E8E8"><font face = "Arial" size = "-1">

                    <center>
                         <p><font size = "-2"><a STYLE="text-decoration: underline"  href = "admin/dsp_login_type.jsp"  >                   
			 <cf:GetPhrase phrase_id = "923" lang_id = "${lang}"/></a> &nbsp;|&nbsp;
			
                        <a STYLE="text-decoration: underline"  href="https://salt.cose.gc.ca/site/index.html"  >
                        <cf:GetPhrase phrase_id = "379" lang_id = "${lang}"/></a> &nbsp;|&nbsp;
			
                        <!--<a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=help&lang=<c:out value="${lang}" />"> -->
			<a STYLE="text-decoration: underline"  href = "help/help.jsp?lang=<c:out value="${lang}" />" target="_new"  >
                        <cf:GetPhrase phrase_id = "380" lang_id = "${lang}"/></a></font>


                        <p><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=cfp_list&lang=<c:out value="${lang}" />" >
                        <!--- Current Calls for Proposals --->
                        <cf:GetPhrase phrase_id = "11" lang_id = "${lang}"/></a>

                        <p><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=proposal_edit&lang=<c:out value="${lang}" />" >
                        <!--- Edit Proposal Information --->
                        <cf:GetPhrase phrase_id = "12" lang_id = "${lang}"/> </a>

                        <p><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=cfp_search&lang=<c:out value="${lang}" />" >
                        <!--- Search --->
                        <cf:GetPhrase phrase_id = "982" lang_id = "${lang}"/></a>

                        <p><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=report_login&lang=<c:out value="${lang}" />" >
                        <!--- Submit Reports --->
                        <cf:GetPhrase phrase_id = "13" lang_id = "${lang}"/> </a>

                        <p><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=discuss_comment&lang=<c:out value="${lang}" />" >
                        <!--- General Discussion --->
                        <cf:GetPhrase phrase_id = "31" lang_id = "${lang}"/></a>
                        <c:if test = "${!empty setup.rows[0].public_info}">
                            <p><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=archive_main&lang=<c:out value="${lang}" />" >
                            <!--- Discussion & Documents --->
                            <cf:GetPhrase phrase_id = "14" lang_id = "${lang}"/></a>
                        </c:if>

                        <p><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=faq&lang=<c:out value="${lang}" />" >
                        <!--- Frequently Asked Questions --->
                        <cf:GetPhrase phrase_id = "15" lang_id = "${lang}"/></a><sql:query var = "languages">
                            select * from languages order by language
                        </sql:query>

                        <p>
                        <c:forEach items = "${languages.rows}" var = "row">
                            <c:if test = "${sessionScope.lang!=row.lang_id}">
                                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=main&lang=<c:out value="${row.lang_id}"/>" >

                                <c:out value = "${row.language}"/></a>

                                <br>
                            </c:if>
                        </c:forEach>
                    </center>

                    </font></td>

                <td width = "10">&nbsp;</td>

                <td width = "465" valign = "top" bgcolor = "FFFFFF"><font face = "Arial" size = "-1">
