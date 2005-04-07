<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--------------------- DISPLAY CONTRACTOR -------------------------->

<c:set var = "contractor_cfp_code">
    <c:out value = "${param.contractor_cfp_code}" default = "0"/>
</c:set>

<c:set var = "contractor_cfp_cat_id">
    <c:out value = "${param.contractor_cfp_cat_id}" default = "0"/>
</c:set>

<c:set var = "agency_id">
    <c:out value = "${param.agency_id}" default = "0"/>
</c:set>

<c:set var = "job_name">
    <c:out value = "${param.job_name}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = "0"/>
</c:set>

<c:set var = "selected_contractor_id">
    <c:out value = "${param.contractor_id}" default = "0"/>
</c:set>

<c:set var = "selected_contractor_firstname">
    <c:out value = "${param.selected_contractor_firstname}" default = ""/>
</c:set>

<c:set var = "selected_contractor_lastname">
    <c:out value = "${param.selected_contractor_lastname}" default = ""/>
</c:set>

<c:set var = "contractor" value = "${sessionScope.ctid}" scope = "page"/>

<sql:query var = "jobtitles">
    select * from standardjobnames order by job_name
</sql:query>

<sql:query var = "contractor">
    select * from contractors where contractor_id = ?

    <sql:param value = "${param.contractor_id}"/>
</sql:query>

<c:set var = "selected_contractor_id">
    <c:out value = "${contractor.rows[0].contractor_id}"/>
</c:set>

<c:set var = "selected_contractor_firstname">
    <c:out value = "${contractor.rows[0].contractor_firstname}"/>
</c:set>

<c:set var = "selected_contractor_lastname">
    <c:out value = "${contractor.rows[0].contractor_lastname}"/>
</c:set>

<c:choose>
    <c:when test = "${!empty job_name}">
        <sql:query var = "jobname">
            select cfp_code from cfp_info where cfp_title = ?

            <sql:param value = "${job_name}"/>
        </sql:query>

        <c:set var = "cfp_code">
            <c:out value = "${jobname.rows[0].cfp_code}"/>
        </c:set>

        <sql:query var = "contractors">
            select distinct a.contractor_id, a.contractor_lastname, a.contractor_firstname, a.contractor_login,
            a.contractor_password, a.contractor_email, a.contractor_phone, a.contractor_fax, a.contractor_address,
            substring(a.contractor_profile,1,1200) as contractor_profile, a.contractor_coordinator, a.cfp_code,
            a.cfp_cat_id, a.agency_id, a.resume_file_name, a.payment_rate, a.next_status_update_date

            from contractors a, contractor_skills b, cfp_skills c where a.contractor_id > 0 and a.contractor_id =
            b.contractor_id and b.skill_id = c.skill_id and c.cfp_code = ?

            <c:if test = "${contractor_cfp_code!=0}">
                and cfp_code = ?
            </c:if>

            <c:if test = "${contractor_cfp_cat_id!=0}">
                and cfp_cat_id = ?
            </c:if>

            order by contractor_lastname, contractor_firstname

            <sql:param value = "${cfp_code}"/>

            <c:if test = "${contractor_cfp_code!=0}">
                <sql:param value = "${contractor_cfp_code}"/>
            </c:if>

            <c:if test = "${contractor_cfp_cat_id!=0}">
                <sql:param value = "${contractor_cfp_cat_id}"/>
            </c:if>
        </sql:query>
    </c:when>

    <c:when test = "${empty job_name}">
        <sql:query var = "contractors">
            select contractor_id, contractor_lastname, contractor_firstname, contractor_login, contractor_password,
            contractor_email, contractor_phone, contractor_fax, contractor_address,
            substring(contractor_profile,1,1200) as contractor_profile, contractor_coordinator, cfp_code, cfp_cat_id,
            agency_id, resume_file_name, payment_rate, next_status_update_date

            from contractors where contractor_id > 0

            <c:if test = "${contractor_cfp_code!=0}">
                and cfp_code = ?
            </c:if>

            <c:if test = "${contractor_cfp_cat_id!=0}">
                and cfp_cat_id = ?
            </c:if>

            order by contractor_lastname, contractor_firstname

            <c:if test = "${contractor_cfp_code!=0}">
                <sql:param value = "${contractor_cfp_code}"/>
            </c:if>

            <c:if test = "${contractor_cfp_cat_id!=0}">
                <sql:param value = "${contractor_cfp_cat_id}"/>
            </c:if>
        </sql:query>
    </c:when>
</c:choose>

<sql:query var = "contracting_agencies">
    select * from contracting_agencies order by agency_name
</sql:query>

<table border = "0" cellspacing = "0" cellpadding = "2" width = "50%">
    <tr bgcolor = "BCBCBC">
        <td align = "right">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=contracting_agencies">

            <cf:GetPhrase phrase_id = "978" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td align = "center">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=simple_contractors_list">

            <cf:GetPhrase phrase_id = "972" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <sql:query var = "cfp_list">
        select cfp_code, cfp_title from cfp_info order by cfp_title
    </sql:query>

    <tr>
        <td>
            &nbsp;
        </td>
    </tr>

    <tr bgcolor = "D7D7D7">
        <td>
            <font size = "-1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "959" lang_id = "${lang}"/>:
        </td>
    </tr>
    <!---  Add New Contractor --->
    <form action = "index.jsp?fuseaction=modify_contractor" method = "post">
        <input type = "hidden" name = "act" value = "add">

        <tr bgcolor = "EBEBEB">
            <td align = "center">
                <font size = "-1" face = "Arial">

                <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>

                :

                <c:choose>
                    <c:when test = "${contractor_cfp_code==0}">
                        <select name = "cfp_code">
                            <option value = "0"><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                            <c:forEach items = "${cfp_list.rows}" var = "rowx">
                                <option value = "<c:out value="${rowx.cfp_code}" />">
                                <c:out value = "${rowx.cfp_title}"/>
                            </c:forEach>
                        </select>
                    </c:when>

                    <c:otherwise>
                        <input type = "hidden" name = "cfp_code" value = "<c:out value="${contractor_cfp_code}" />">

                        <c:out value = "${cfp_title}"/>
                    </c:otherwise>
                </c:choose>

                <font size = "-1" face = "Arial">

                <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>

                :

                <select name = "agency_id">
                    <option value = "0"><cf:GetPhrase phrase_id = "550" lang_id = "${lang}"/>

                    <c:forEach items = "${contracting_agencies.rows}" var = "rowy">
                        <option value = "<c:out value="${rowy.agency_id}" />"><c:out value = "${rowy.agency_name}"/>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <tr>
            <td align = "center">
                <input type = "submit" value = "<cf:GetPhrase phrase_id="959" lang_id="${lang}" />">
            </td>
        </tr>
    </form>

    <sql:query var = "cfp_list">
        select cfp_code, cfp_title from cfp_info order by cfp_title
    </sql:query>

    <tr>
        <td>
            &nbsp;
        </td>
    </tr>

    <tr bgcolor = "D7D7D7">
        <td>
            <font size = "-1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "959" lang_id = "${lang}"/>:
        </td>
    </tr>
    <!---  Add New Contractor --->
    <form action = "index.jsp?fuseaction=modify_contractor" method = "post">
        <input type = "hidden" name = "act" value = "add">

        <tr bgcolor = "EBEBEB">
            <td align = "center">
                <font size = "-1" face = "Arial">

                <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>

                :

                <c:choose>
                    <c:when test = "${contractor_cfp_code==0}">
                        <select name = "cfp_code">
                            <option value = "0"><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                            <c:forEach items = "${cfp_list.rows}" var = "rowx">
                                <option value = "<c:out value="${rowx.cfp_code}" />">
                                <c:out value = "${rowx.cfp_title}"/>
                            </c:forEach>
                        </select>
                    </c:when>

                    <c:otherwise>
                        <input type = "hidden" name = "cfp_code" value = "<c:out value="${contractor_cfp_code}" />">

                        <c:out value = "${cfp_title}"/>
                    </c:otherwise>
                </c:choose>

                <font size = "-1" face = "Arial">

                <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>

                :

                <select name = "agency_id">
                    <option value = "0"><cf:GetPhrase phrase_id = "550" lang_id = "${lang}"/>

                    <c:forEach items = "${contracting_agencies.rows}" var = "rowy">
                        <option value = "<c:out value="${rowy.agency_id}" />"><c:out value = "${rowy.agency_name}"/>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <tr>
            <td align = "center">
                <input type = "submit" value = "<cf:GetPhrase phrase_id="959" lang_id="${lang}" />">
            </td>
        </tr>
    </form>

    <!--- End Add Contractor --->

    <!-- Start Select A New Job --->

    <tr>
        <td>
            <font face = "arial" size = "-1"><b>

            <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/>:
        </td>
    </tr>

    <!-- End Select A New Job --->

    <!-- Start Display Data on Each Contractor that Satisfies Criteria --->
    <tr>
        <td>
            <form action = "index.jsp?fuseaction=contractor" method = "post">
                <select name = "contractor_id">
                    <option value = "<c:out value="${selected_contractor_id}" />">
                    <c:out value = "${selected_contractor_lastname}, ${selected_contractor_firstname}"/>

                    <c:forEach items = "${contractors.rows}" var = "row">
                        <option value = "<c:out value="${row.contractor_id}" />">
                        <c:out value = "${row.contractor_lastname}, ${row.contractor_firstname}"/>
                    </c:forEach>
                </select>
        </td>
    </tr>

    <tr>
        <td align = "center">
            <input type = "submit" value = "  <cf:GetPhrase phrase_id="523" lang_id="${lang}" />  ">
        </td>
    </tr>

    </form>
</table>

<HR>

<!-- Start Display Data on  Contractor  --->

<sql:query var = "edit_contractor_skills">
    select a.skill_id,b.skill_name from contractor_skills a, professional_skills b where a.contractor_id = ? and
    a.skill_id = b.skill_id order by b.skill_name

    <sql:param value = "${param.contractor_id}"/>
</sql:query>

<sql:query var = "initiative_setup">
    select concat(substring_index(host_url,'/',4),'/') as host from initiative_setup where initiative_setup_id = 1
</sql:query>

<c:set var = "app_directory">
    <c:out value = "${initiative_setup.rows[0].host}"/>
</c:set>

<c:forEach items = "${contractor.rows}" var = "row">
    <table border = "0" cellspacing = "0" cellpadding = "2" width = "100%">
        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>

        <tr bgcolor = "E8E8E8">
            <td colspan = "2">
                <font face = "Arial"><b>

                <c:out value = "${row.contractor_lastname}, ${row.contractor_firstname}"/>
            </td>

            <td>
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b>
            </td>

            <td>
                <font size = "-1" face = "Arial">

                <c:out value = "${row.contractor_login}"/>
            </td>
        </tr>

        <tr>
            <td colspan = "2">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "2">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.contractor_email}"/>
            </td>
        </tr>

        <tr>
            <td colspan = "2">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "2">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.contractor_phone}"/>
            </td>
        </tr>

        <tr>
            <td colspan = "2">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "2">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.contractor_fax}"/>
            </td>
        </tr>

        <tr>
            <td colspan = "2">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "2">
                <font size = "-1" face = "Arial">

                <c:out value = "${row.contractor_address}"/>
            </td>
        </tr>

        <tr>
            <td colspan = "2" valign = "TOP">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "704" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "2">
                <font size = "-1" face = "Arial">

                <cf:ParagraphFormat value = "${row.contractor_profile}"/>
            </td>
        </tr>

        <tr>
        </tr>

        <tr>
            <td colspan = "2" valign = "TOP">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "1001" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "2">
                <font size = "1" face = "Arial">

                <a STYLE="text-decoration: underline"  href = "<c:out value="${app_directory}" /><c:out value="docs/" /><c:out value="${row.resume_file_name}" /> "
                   <c:out
                   value = "target=_new"/>

                >

                <c:out value = "${row.resume_file_name}"/>

                </a></font>
            </td>
        </tr>

        <tr>
            <td colspan = "2" valign = "TOP">
                <font size = "-1" face = "Arial"><b>

                <cf:GetPhrase phrase_id = "997" lang_id = "${lang}"/>:</b>
            </td>

            <td colspan = "2">
                <table cellpadding = 4 cellspacing = 2 border = 5>
                    <tr bgcolor = "#c8d8f8">
                        <c:forEach items = "${edit_contractor_skills.rows}" var = "rowskills" begin = "1" end = "5">
                            <td valign = "top">
                                <font size = "1" face = "Arial">

                                <c:out value = "${rowskills.skill_name}"/></font>
                            </td>
                        </c:forEach>
                    </tr>
                </table>

                <table cellpadding = 4 cellspacing = 2 border = 5>
                    <tr bgcolor = "#c8d8f8">
                        <c:forEach items = "${edit_contractor_skills.rows}" var = "rowskills" begin = "6" end = "10">
                            <td valign = "top">
                                <font size = "1" face = "Arial">

                                <c:out value = "${rowskills.skill_name}"/></font>
                            </td>
                        </c:forEach>
                    </tr>
                </table>

                <table cellpadding = 4 cellspacing = 2 border = 5>
                    <tr bgcolor = "#c8d8f8">
                        <c:forEach items = "${edit_contractor_skills.rows}" var = "rowskills" begin = "11" end = "15">
                            <td valign = "top">
                                <font size = "1" face = "Arial">

                                <c:out value = "${rowskills.skill_name}"/></font>
                            </td>
                        </c:forEach>
                    </tr>
                </table>

                <table cellpadding = 4 cellspacing = 2 border = 5>
                    <tr bgcolor = "#c8d8f8">
                        <c:forEach items = "${edit_contractor_skills.rows}" var = "rowskills" begin = "16" end = "20">
                            <td valign = "top">
                                <font size = "1" face = "Arial">

                                <c:out value = "${rowskills.skill_name}"/></font>
                            </td>
                        </c:forEach>
                    </tr>
                </table>

                <table cellpadding = 4 cellspacing = 2 border = 5>
                    <tr bgcolor = "#c8d8f8">
                        <c:forEach items = "${edit_contractor_skills.rows}" var = "rowskills" begin = "21" end = "25">
                            <td valign = "top">
                                <font size = "1" face = "Arial">

                                <c:out value = "${rowskills.skill_name}"/></font>
                            </td>
                        </c:forEach>
                    </tr>
                </table>
            </td>
        </tr>

        <c:if test = "${row.cfp_code!=0}">
            <sql:query var = "cfp_info">
                select cfp_code, cfp_title from cfp_info where cfp_code = ?

                <sql:param value = "${row.cfp_code}"/>
            </sql:query>

            <tr>
                <td colspan = "2">
                    <font face = "Arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "586" lang_id = "${lang}"/>:
                </td>

                <td colspan = "2">
                    <font face = "Arial" size = "-1">

                    <c:out value = "${cfp_info.rows[0].cfp_title}"/>
                </td>
            </tr>
        </c:if>

        <c:if test = "${row.cfp_cat_id!=0}">
            <sql:query var = "cfp_cat_info">
                select cfp_cat_id, cfp_cat_name from cfp_category where cfp_cat_id = ?

                <sql:param value = "${row.cfp_cat_id}"/>
            </sql:query>

            <tr>
                <td colspan = "2">
                    <font face = "Arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "630" lang_id = "${lang}"/>:
                </td>

                <td colspan = "2">
                    <font face = "Arial" size = "-1">

                    <c:out value = "${cfp_cat_info.rows[0].cfp_cat_name}"/>
                </td>
            </tr>
        </c:if>

        <sql:query var = "contracting_agency">
            select agency_name from contracting_agencies where agency_id = ?

            <sql:param value = "${agency_id}"/>
        </sql:query>

        <tr>
            <td>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "976" lang_id = "${lang}"/>:
            </td>

            <td colspan = "3">
                <font face = "Arial" size = "-1">

                <c:out value = "${contracting_agency.rows[0].agency_name}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "1022" lang_id = "${lang}"/>:
            </td>

            <td colspan = "3">
                <font face = "Arial" size = "-1">

                <c:out value = "${contractor.rows[0].payment_rate}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "1037" lang_id = "${lang}"/>:
            </td>

            <td colspan = "3">
                <font face = "Arial" size = "-1">

                <fmt:formatDate value = "${contractor.rows[0].next_status_update_date}" pattern = "dd-MMM-yyyy"/>
            </td>
        </tr>

        <c:if test = "${sessionScope.user=='coordinator' }">
            <tr>
                <td colspan = "2">
                    &nbsp;
                </td>

                <td colspan = "2" align = "left">
                    <font size = "1" face = "Arial">

                    <table>
                        <tr>
                            <td>
                                <form action = "index.jsp?fuseaction=act_contractor_del" method = "post">
                                    <input type = "hidden" name = "act" value = "delete"> <input type = "hidden"
                                           name = "contractor_id"
                                           value = "<c:out value="${row.contractor_id}" />"> <input type = "hidden"
                                           name = "delete_confirm"
                                           value = "<cf:GetPhrase phrase_id="543" lang_id="${lang}" />">
                                    <input type = "submit" value = "<cf:GetPhrase phrase_id="143" lang_id="${lang}" />">
                                </form>
                            </td>

                            <td>
                                <form action = "index.jsp?fuseaction=modify_contractor" method = "post">
                                    <input type = "hidden" name = "act" value = "edit"> <input type = "hidden"
                                           name = "contractor_id"
                                           value = "<c:out value="${row.contractor_id}" />">
                                    <input type = "submit" value = "<cf:GetPhrase phrase_id="144" lang_id="${lang}" />">
                                </form>
                            </td>
                        </tr>
                    </table>

                    </font>
                </td>
            </tr>
        </c:if>

        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>
    </table>
</c:forEach>
