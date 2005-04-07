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

<!--- OPA admin header --->
<sql:query var = "setup">
    select background_image, admin_header_background, multiple_cfps, use_initiative_criteria,
    application_name,application_directory,public_interface from initiative_setup
</sql:query>

<sql:query var = "initiative_images">
    select admin_image_title, image_toolbar from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<c:set var = "cfp_num">
    <c:out value = "${param.cfp_num}" default = "0"/>
</c:set>

<c:set var = "init_crit">
    <c:out value = "${param.init_crit}" default = "0"/>
</c:set>

<c:set var = "cfp_num" value = "${setup.rows[0].multiple_cfps}" scope = "page"/>

<c:set var = "init_crit" value = "${setup.rows[0].use_initiative_criteria}" scope = "page"/>

<c:set var = "REPORT_DIRECTORY" value = "${setup.rows[0].application_directory}" scope = "session"/>

<html>
    <title><cf:GetPhrase phrase_id = "939" lang_id = "${lang}"/></title>
<head>
<style type = "text/css">
<!--
        A:link,A:visited,A:active { text-decoration:none;color:#FF3333}
        A:hover { text-decoration:underline;color:#FF3333 }
-->
</style>
</head>
    <body leftmargin = 0                                                             topmargin = 0
          marginwidth = "0"                                                          marginheight = "0"
          background = "../docs/<c:out value="${setup.rows[0].background_image}" />" vlink = "800000"
          bgcolor = "BCBCBC"                                                         text = "000000"
          link = "000080">
        <!--
          <table width = "100%" border = "0" cellspacing = "0" cellpadding = "0" valign = "TOP">
              <tr>
                  <td background = "../docs/<c:out value="${setup.rows[0].admin_header_background}" />">
                      <img src = "../docs/<c:out value="${initiative_images.rows[0].admin_image_title}" />" border = 0
                           alt = ""></td>
              </tr>
              <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
              <tr>
                   <td align="center" bgcolor = "E8E8E8"><font face = "Arial" size = "3"><b><cf:GetPhrase phrase_id = "1039" lang_id = "${lang}"/></b></font></td>
              </tr>
          </table>
          -->
        <p></p>

        <p></p>

        <table border = "0" cellspacing = "0" cellpadding = "5" valign = "TOP">
            <tr>
                <td width = "120" valign = "TOP" bgcolor = "E8E8E8">
                    <font face = "Arial" size = "-2">

                    <center>
                        <a STYLE="text-decoration: underline"  href = "dsp_login_type.jsp" STYLE = "color:#000000;">

                        <cf:GetPhrase phrase_id = "923" lang_id = "${lang}"/></a> &nbsp;&nbsp;|&nbsp;&nbsp;
                        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=main" STYLE = "color:#000000;">

                        <cf:GetPhrase phrase_id = "1042" lang_id = "${lang}"/></a> &nbsp;&nbsp;|&nbsp;&nbsp;
                        <!--<a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=help"> -->
                        <a STYLE="text-decoration: underline"  href = "../help/help.jsp?lang=<c:out value="${lang}" />" target = "_new" STYLE = "color:#000000;">

                        <cf:GetPhrase phrase_id = "380" lang_id = "${lang}"/></a>

                        <c:set var = "reviewer_organizer">
                            <c:out value = "${param.reviewer_organizer}" default = "0"/>
                        </c:set>

                        <c:if test = "${sessionScope.user!='coordinator'}">
                            <!--- if user is reviewer, determine if user is review organizer --->
                            <c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

                            <sql:query var = "r_coord_check">
                                select reviewer_coordinator from reviewers where reviewer_id = ?

                                <sql:param value = "${reviewer}"/>
                            </sql:query>

                            <c:set var = "reviewer_organizer" value = "${r_coord_check.rows[0].reviewer_coordinator}"
                                   scope = "page"/>
                        </c:if>

                        <c:if test = "${sessionScope.user=='coordinator'}">

                            <!--- Worksite Setup --->
                            <font size = "-2">

                            <p>
                            <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=site_setup" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "1" lang_id = "${lang}"/></a></font>

                            <!--- Languages Setup --->
                            <p>
                            <font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=lang_main" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "9" lang_id = "${lang}"/></a></font>

                            <!--- View Funding Initiative Info --->
                            <p>
                            <font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=funding" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "2" lang_id = "${lang}"/></a></font>

                            <!--- modify funding initiative info --->
                            <br>
                            [ <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=modify_funding&act=add" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "10" lang_id = "${lang}"/></a> ]

                            <!--- view appraisal criteria --->
                            <c:if test = "${init_crit==1}">
                                <p>
                                <font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=criteria" STYLE = "color:#000000;">

                                <cf:GetPhrase phrase_id = "3" lang_id = "${lang}"/></a></font>

                                <!--- add new criteria --->
                                <br>
                                [ <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=criteria" STYLE = "color:#000000;">

                                <cf:GetPhrase phrase_id = "10" lang_id = "${lang}"/></a> ]
                            </c:if>

                            <!--- CFP List --->
                            <p>
                            <font size = "-2"> <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=list_cfp" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "5" lang_id = "${lang}"/></a></font>

                            <!--- add new CFP --->
                            <br>
                            [ <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=modify_cfp&act=add" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "10" lang_id = "${lang}"/></a> ]
                        </c:if>

                        <!--- proposals --->
                        <c:if test = "${(sessionScope.user=='coordinator') or (sessionScope.user=='reviewer')}">
                            <p>
                            <font size = "-2"> <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=proposals" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "6" lang_id = "${lang}"/></a></font>
                            </p>
                        </c:if>

                        <!--- proposal reports --->
                        <c:if test = "${(sessionScope.user=='coordinator') or (sessionScope.user=='reviewer')}">
                            <p>
                            <font size = "-2"> <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=reports" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "7" lang_id = "${lang}"/></a></font>
                            </p>
                        </c:if>

                        <!--- Reports --->
                        <!--
                                    <c:if test = "${(sessionScope.user=='coordinator') or (reviewer_organizer==1)}">
                                        <p><font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=mgt_reports">
            
                                        <cf:GetPhrase phrase_id = "1025" lang_id = "${lang}"/></a></font>
                                    </c:if>
                        -->
                        <!--- Coordinators & Reviewers list --->
                        <c:if test = "${(sessionScope.user=='coordinator') or (reviewer_organizer==1)}">
                            <p>
                            <font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=reviewers" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "4" lang_id = "${lang}"/></a></font>
                        </c:if>

                        <!--- Communication Center --->
                        <c:if test = "${sessionScope.user=='coordinator'}">
                            <p>
                            <font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_main" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "8" lang_id = "${lang}"/></a></font>
                        </c:if>

                        <!--- Timesheet management for Reviewers --->
                        <c:if test = "${sessionScope.user=='reviewer'}">
                            <p>
                            <font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=tsr_main" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "841" lang_id = "${lang}"/></a></font>
                        </c:if>

                        <!--- Timesheet management for Contractors --->
                        <c:if test = "${sessionScope.user=='contractor' }">
                            <p>
                            <font size = "-2"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=c_tsr_main" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "841" lang_id = "${lang}"/></a></font>
                        </c:if>

                        <c:if test = "${setup.rows[0].public_interface == 1}">
                            <!--- Link to public website --->
                            <p>
                            <font size = "-2"><a STYLE="text-decoration: underline"  href = "../index.jsp" target = "_new" STYLE = "color:#000000;">

                            <cf:GetPhrase phrase_id = "342" lang_id = "${lang}"/></a></font>
                            </p>
                        </c:if>

                        <sql:query var = "languages">
                            select * from languages order by language
                        </sql:query>

                        <!--- List of Languagues --->
                        <!--- Link reloads current page with new language --->

                        <c:set var = "fuseaction">
                            <c:out value = "${param.fuseaction}" default = "main"/>
                        </c:set>

                        <c:forEach items = "${languages.rows}" var = "row">
                            <c:if test = "${lang!=row.lang_id}">
                                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=<c:out value="${fuseaction}" />&lang=<c:out value="${row.lang_id}" />" STYLE = "color:#000000;">

                                <c:out value = "${row.language}"/></a>

                                <br>
                            </c:if>
                        </c:forEach>
                </td>

                <td width = "10">
                    &nbsp;
                </td>

                <td width = "465" valign = "TOP">
                    <font face = "Arial" size = "-1">
