<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- initiative website information setup --->

<c:set var = "act">
    <c:out value = "${param.act}" default = "display"/>
</c:set>

<sql:query var = "setup_info">
    select I.*, L.language from initiative_setup I, languages L where I.default_lang = L.lang_id
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "1" lang_id = "${lang}"/></h3>

<!--- display information --->
<c:choose>
    <c:when test = "${act == 'display'}">
        <c:choose>
            <c:when test = "${setup_info.rowCount == 0}">
                <cf:GetPhrase phrase_id = "209" lang_id = "${lang}"/>

                .
                <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='site_setup'/>
<c:param name='act' value='setup'/>
<c:param name='${user}'/>
</c:url>">

                <cf:GetPhrase phrase_id = "210" lang_id = "${lang}"/></a>.
            </c:when>

            <c:otherwise>
                <table border = "0" cellspacing = "0" cellpadding = "5">
                    <c:forEach var = "row" items = "${setup_info.rows}">
                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "211" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.host_url}'/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "212" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.host_doc_dir}'/>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "950" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.application_name}'/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "951" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.application_directory}'/>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "341" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.listname}'/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "213" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.public_info == 'all'}">
                                        <cf:GetPhrase phrase_id = "537" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:when test = "${row.public_info == 'accepted'}">
                                        <cf:GetPhrase phrase_id = "538" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:when test = "${row.public_info == 'none'}">
                                        <cf:GetPhrase phrase_id = "539" lang_id = "${lang}"/>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "214" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.public_info_degree == 'complete'}">
                                        <cf:GetPhrase phrase_id = "540" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:when test = "${row.public_info_degree == 'limited'}">
                                        <cf:GetPhrase phrase_id = "541" lang_id = "${lang}"/>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "216" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.multiple_cfps == 1}">
                                        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:otherwise>
                                        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "217" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.use_initiative_criteria == 1}">
                                        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:otherwise>
                                        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "218" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.use_cfp_criteria == 1}">
                                        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:otherwise>
                                        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "224" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.criteria_rankings}'/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "194" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.minimum_rank}'/>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "215" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.show_weights}'/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "219" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.show_reviewers == 1}">
                                        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:otherwise>
                                        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "220" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.show_reviewers_summary == 1}">
                                        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:otherwise>
                                        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "221" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.background_image}'/>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "974" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.public_interface == 1}">
                                        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:otherwise>
                                        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "222" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.public_header_background}'/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "223" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.admin_header_background}'/>
                            </td>
                        </tr>

                        <tr bgcolor = "F4F4F4">
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "225" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1"><c:choose>
                                    <c:when test = "${row.public_attachments == 1}">
                                        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                                    </c:when>

                                    <c:otherwise>
                                        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <cf:GetPhrase phrase_id = "339" lang_id = "${lang}"/>:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = '${row.language}'/>

                                (

                                <c:out value = '${row.default_lang}'/>)
                            </td>
                        </tr>

                        <tr>
                            <td colspan = "2">
                                <font face = "Arial">

                                <center>
                                    <p>
                                    <br>
                                    <h3><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='site_setup'/>
<c:param name='act' value='setup'/>
<c:param name='${user}'/>
</c:url>">

                                    <cf:GetPhrase phrase_id = "131" lang_id = "${lang}"/></a></h3>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test = "${act == 'setup'}">
        <c:set var = "initiative_setup_id">
            <c:out value = "${param.initiative_setup_id}" default = "1"/>
        </c:set>

        <c:set var = "host_url">
            <c:out value = "${param.host_url}" default = ""/>
        </c:set>

        <c:set var = "host_doc_dir">
            <c:out value = "${param.host_doc_dir}" default = ""/>
        </c:set>

        <c:set var = "application_name">
            <c:out value = "${param.application_name}" default = ""/>
        </c:set>

        <c:set var = "application_directory">
            <c:out value = "${param.application_directory}" default = ""/>
        </c:set>

        <c:set var = "public_info">
            <c:out value = "${param.public_info}" default = ""/>
        </c:set>

        <c:set var = "public_info_degree">
            <c:out value = "${param.public_info_degree}" default = ""/>
        </c:set>

        <c:set var = "minimum_rank">
            <c:out value = "${param.minimum_rank}" default = ""/>
        </c:set>

        <c:set var = "show_weights">
            <c:out value = "${param.show_weights}" default = ""/>
        </c:set>

        <c:set var = "use_initiative_criteria">
            <c:out value = "${param.use_initiative_criteria}" default = "0"/>
        </c:set>

        <c:set var = "use_cfp_criteria">
            <c:out value = "${param.use_cfp_criteria}" default = "0"/>
        </c:set>

        <c:set var = "show_reviewers">
            <c:out value = "${param.show_reviewers}" default = "0"/>
        </c:set>

        <c:set var = "listname">
            <c:out value = "${param.listname}" default = ""/>
        </c:set>

        <c:set var = "show_reviewers_summary">
            <c:out value = "${param.show_reviewers_summary}" default = "0"/>
        </c:set>

        <c:set var = "background_image">
            <c:out value = "${param.background_image}" default = ""/>
        </c:set>

        <c:set var = "public_header_background">
            <c:out value = "${param.public_header_background}" default = ""/>
        </c:set>

        <c:set var = "admin_header_background">
            <c:out value = "${param.admin_header_background}" default = ""/>
        </c:set>

        <c:set var = "criteria_rankings">
            <c:out value = "${param.criteria_rankings}" default = ""/>
        </c:set>

        <c:set var = "multiple_cfps">
            <c:out value = "${param.multiple_cfps}" default = "0"/>
        </c:set>

        <c:set var = "public_attachments">
            <c:out value = "${param.public_attachments}" default = ""/>
        </c:set>

        <c:set var = "default_lang">
            <c:out value = "${param.default_lang}" default = ""/>
        </c:set>

        <c:set var = "language">
            <c:out value = "${param.language}" default = ""/>
        </c:set>

        <c:set var = "public_interface">
            <c:out value = "${param.public_interface}" default = "0"/>
        </c:set>

        <c:forEach var = "row" items = "${setup_info.rows}">
            <c:set var = "initiative_setup_id" value = "1"/>

            <c:set var = "host_url" value = "${row.host_url}"/>

            <c:set var = "host_doc_dir" value = "${row.host_doc_dir}"/>

            <c:set var = "application_name" value = "${row.application_name}"/>

            <c:set var = "application_directory" value = "${row.application_directory}"/>

            <c:set var = "listname" value = "${row.listname}"/>

            <c:set var = "public_info" value = "${row.public_info}"/>

            <c:set var = "public_info_degree" value = "${row.public_info_degree}"/>

            <c:set var = "minimum_rank" value = "${row.minimum_rank}"/>

            <c:set var = "show_weights" value = "${row.show_weights}"/>

            <c:set var = "use_initiative_criteria" value = "${row.use_initiative_criteria}"/>

            <c:set var = "use_cfp_criteria" value = "${row.use_cfp_criteria}"/>

            <c:set var = "show_reviewers" value = "${row.show_reviewers}"/>

            <c:set var = "show_reviewers_summary" value = "${row.show_reviewers_summary}"/>

            <c:set var = "background_image" value = "${row.background_image}"/>

            <c:set var = "public_header_background" value = "${row.public_header_background}"/>

            <c:set var = "admin_header_background" value = "${row.admin_header_background}"/>

            <c:set var = "criteria_rankings" value = "${row.criteria_rankings}"/>

            <c:set var = "multiple_cfps" value = "${row.multiple_cfps}"/>

            <c:set var = "public_attachments" value = "${row.public_attachments}"/>

            <c:set var = "default_lang" value = "${row.default_lang}"/>

            <c:set var = "language" value = "${row.language}"/>

            <c:set var = "public_interface" value = "${row.public_interface}"/>
        </c:forEach>

        <sql:query var = "languages">
            select * from languages order by language
        </sql:query>

        <p>
        <font color = "FF0000">

        <cf:GetPhrase phrase_id = "226" lang_id = "${lang}"/></font>

        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_site_setup'/>
<c:param name='${user}'/>
</c:url>"
              enctype = "multipart/form-data"
              method = "post">
            <input type = "hidden" name = "initiative_setup_id" value = "1"> <input type = "hidden"
                   name = "host_url_required"
                   value = "<cf:GetPhrase phrase_id='544' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "host_doc_dir_required"
                   value = "<cf:GetPhrase phrase_id='545' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "application_name_required"
                   value = "<cf:GetPhrase phrase_id='952' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "application_directory_required"
                   value = "<cf:GetPhrase phrase_id='953' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "minimum_rank_required"
                   value = "<cf:GetPhrase phrase_id='546' lang_id='${lang}'/>">
            <input type = "hidden" name = "criteria_rankings_range" value = "min=2 max=10">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "211" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "host_url" value = "<c:out value='${host_url}'/>" size = "40">

            <br>
            <i>(

            <cf:GetPhrase phrase_id = "551" lang_id = "${lang}"/>)</i>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "212" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "host_doc_dir" value = "<c:out value='${host_doc_dir}'/>" size = "40">

            <br>
            <i>(

            <cf:GetPhrase phrase_id = "552" lang_id = "${lang}"/>)</i>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "950" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "application_name" value = "<c:out value='${application_name}'/>" size = "40">

            <br>
            <i>(

            <cf:GetPhrase phrase_id = "954" lang_id = "${lang}"/>)</i>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "951" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "application_directory" value = "<c:out value='${application_directory}'/>"
                   size = "40">

            <br>
            <i>(

            <cf:GetPhrase phrase_id = "955" lang_id = "${lang}"/>)</i>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "341" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "listname" value = "<c:out value='${listname}'/>" size = "40">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "227" lang_id = "${lang}"/>:</b>

            <select name = "public_info">
                <c:if test = "${!empty public_info}">
                    <option value = "<c:out value='${public_info}'/>"><c:choose>
                        <c:when test = "${public_info == 'all'}">
                            <cf:GetPhrase phrase_id = "537" lang_id = "${lang}"/>
                        </c:when>

                        <c:when test = "${public_info == 'accepted'}">
                            <cf:GetPhrase phrase_id = "538" lang_id = "${lang}"/>
                        </c:when>

                        <c:when test = "${public_info == 'none'}">
                            <cf:GetPhrase phrase_id = "539" lang_id = "${lang}"/>
                        </c:when>
                    </c:choose>
                </c:if>

                <option value = "all"><cf:GetPhrase phrase_id = "537" lang_id = "${lang}"/>

                <option value = "accepted"><cf:GetPhrase phrase_id = "538" lang_id = "${lang}"/>

                <option value = "none"><cf:GetPhrase phrase_id = "539" lang_id = "${lang}"/>
            </select>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "214" lang_id = "${lang}"/>:</b>

            <select name = "public_info_degree">
                <c:if test = "${!empty public_info_degree}">
                    <option value = "<c:out value='${public_info_degree}'/>"><c:choose>
                        <c:when test = "${public_info_degree == 'complete'}">
                            <cf:GetPhrase phrase_id = "540" lang_id = "${lang}"/>
                        </c:when>

                        <c:when test = "${public_info_degree == 'limited'}">
                            <cf:GetPhrase phrase_id = "541" lang_id = "${lang}"/>
                        </c:when>
                    </c:choose>
                </c:if>

                <option value = "complete"><cf:GetPhrase phrase_id = "540" lang_id = "${lang}"/>

                <option value = "limited"><cf:GetPhrase phrase_id = "541" lang_id = "${lang}"/>
            </select>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "216" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "multiple_cfps" value = "1" <c:if test = "${multiple_cfps == 1}">checked

            </c:if>

            >

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "217" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "use_initiative_criteria" value = "1" <c:if
                   test = "${use_initiative_criteria == 1}">checked

            </c:if>

            >

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "218" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "use_cfp_criteria" value = "1" <c:if
                   test = "${use_cfp_criteria == 1}">checked

            </c:if>

            >

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "224" lang_id = "${lang}"/>:</b>
            <input type = "text" name = "criteria_rankings" value = "<c:out value='${criteria_rankings}'/>"
                   size = "2"> <i>(2-10)</i>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "194" lang_id = "${lang}"/>:</b>
            <input type = "text" name = "minimum_rank" value = "<c:out value='${minimum_rank}'/>" size = "3">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "215" lang_id = "${lang}"/>:</b>

            <select name = "show_weights">
                <c:if test = "${!empty show_weights}">
                    <option value = "<c:out value='${show_weights}'/>"><c:out value = '${show_weights}'/>
                </c:if>

                <option value = "both"><cf:GetPhrase phrase_id = "548" lang_id = "${lang}"/>

                <option value = "reviewers"><cf:GetPhrase phrase_id = "252" lang_id = "${lang}"/>

                <option value = "public"><cf:GetPhrase phrase_id = "549" lang_id = "${lang}"/>

                <option value = "none"><cf:GetPhrase phrase_id = "550" lang_id = "${lang}"/>
            </select>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "219" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "show_reviewers" value = "1" <c:if test = "${show_reviewers == 1}">checked

            </c:if>

            >

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "220" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "show_reviewers_summary" value = "1" <c:if
                   test = "${show_reviewers_summary == 1}">checked

            </c:if>

            >

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "221" lang_id = "${lang}"/>:</b> <input type = "file" name = "background_image">
            <c:if test = "${!empty background_image}">
                <br>
                <font color = "FF0000"><b>"

                <c:out value = '${background_image}'/>

                "

                <cf:GetPhrase phrase_id = "228" lang_id = "${lang}"/></b></font>
            </c:if>

            <br>
            <font size = "-1"><i>(

            <cf:GetPhrase phrase_id = "555" lang_id = "${lang}"/>)</i></font>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "974" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "public_interface" value = "1" <c:if
                   test = "${public_interface == 1}">checked

            </c:if>

            >

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "222" lang_id = "${lang}"/>:</b>
            <input type = "file" name = "public_header_background"><c:if test = "${!empty public_header_background}">
                <br>
                <font color = "FF0000"><b>"

                <c:out value = '${public_header_background}'/>

                "

                <cf:GetPhrase phrase_id = "228" lang_id = "${lang}"/></b></font>
            </c:if>

            <br>
            <font size = "-1"><i>(

            <cf:GetPhrase phrase_id = "555" lang_id = "${lang}"/>)</i></font>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "223" lang_id = "${lang}"/>:</b>
            <input type = "file" name = "admin_header_background"><c:if test = "${!empty admin_header_background}">
                <br>
                <font color = "FF0000"><b>"

                <c:out value = '${admin_header_background}'/>

                "

                <cf:GetPhrase phrase_id = "228" lang_id = "${lang}"/></b></font>
            </c:if>

            <br>
            <font size = "-1"><i>(

            <cf:GetPhrase phrase_id = "555" lang_id = "${lang}"/>)</i></font>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "225" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "public_attachments" value = "1" <c:if
                   test = "${public_attachments == 1}">checked

            </c:if>

            >

            <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "339" lang_id = "${lang}"/>:</b>

            <select name = "default_lang">
                <option value = "<c:out value='${default_lang}'/>"><c:out value = '${language}'/>

                <c:forEach var = "row" items = "${languages.rows}">
                    <option value = "<c:out value='${row.lang_id}'/>"><c:out value = '${row.language}'/>
                </c:forEach>
            </select>

            <p>
            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>
</c:choose>
