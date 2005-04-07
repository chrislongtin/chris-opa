<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->

<c:set var = "job_name">
    <c:out value = "${param.job_name}" default = ""/>
</c:set>

<c:set var = "agency_name">
    <c:out value = "${param.agency_name}" default = ""/>
</c:set>

<c:set var = "job_length">
    <c:out value = "${param.job_length}" default = ""/>
</c:set>

<%
    java.sql.Date sqldate = new java.sql.Date(new Date().getTime());

    pageContext.setAttribute("Current_Date", sqldate.toString());
%>

<!--- List all Current Call for Proposals (CFPs) --->

<sql:query var = "CFP_current_list">
    select cfp_title, cfp_startdate,cfp_deadline, cfp_code, cfp_focus from cfp_info where cfp_deadline >= ?

    <c:if test = "${!empty job_name}">
        and cfp_title like concat('%',?,'%')
    </c:if>

    <c:if test = "${!empty agency_name}">
        and cfp_focus = ?
    </c:if>

    <c:if test = "${!empty job_length}">
        and cfp_background like concat('%',?,'%')
    </c:if>

    order by cfp_deadline asc

    <sql:param value = "${Current_Date}"/>

    <c:if test = "${!empty job_name}">
        <sql:param value = "${job_name}"/>
    </c:if>

    <c:if test = "${!empty agency_name}">
        <sql:param value = "${agency_name}"/>
    </c:if>

    <c:if test = "${!empty job_length}">
        <sql:param value = "${job_length}"/>
    </c:if>
</sql:query>

<c:set var = "cur_reccount" value = "${CFP_current_list.rowCount}"/>

<!--- List all Archived Call for Proposals (CFPs) --->

<sql:query var = "CFP_archived_list">
    select cfp_title, cfp_startdate,cfp_deadline, cfp_code, cfp_focus from cfp_info where cfp_deadline

    <?<c:if test = "${!empty job_name}">
        and cfp_title like concat('%',?,'%')

        </c:if>

        <c:if test = "${!empty agency_name}">
            and cfp_focus = ?
        </c:if>

        <c:if test = "${!empty job_length}">
            and cfp_background like concat('%',?,'%')
        </c:if>

        order by cfp_deadline asc

        <sql:param value = "${Current_Date}"/>

        <c:if test = "${!empty job_name}">
            <sql:param value = "${job_name}"/>
        </c:if>

        <c:if test = "${!empty agency_name}">
            <sql:param value = "${agency_name}"/>
        </c:if>

        <c:if test = "${!empty job_length}">
            <sql:param value = "${job_length}"/>
        </c:if>
    </sql:query>

    <c:set var = "arc_reccount" value = "${CFP_archived_list.rowCount}"/>

    <!--------------- search form for retrieving a list of CFPs ----------------->
    <sql:query var = "jobtitles">
        select * from standardjobnames order by job_name
    </sql:query>

    <sql:query var = "agencies">
        select * from funding_agencies order by agency_name
    </sql:query>

    <p>
    <h2>

    <cf:GetPhrase phrase_id = "5" lang_id = "${lang}"/></h2>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "1020" lang_id = "${lang}"/>

    :&nbsp;&nbsp;&nbsp;

    <c:out value = "${cur_reccount}"/>

    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;

    <cf:GetPhrase phrase_id = "1021" lang_id = "${lang}"/>

    :&nbsp;&nbsp;&nbsp;

    <c:out value = "${arc_reccount}"/></b></p>

    <br>
    <h4>

    <cf:GetPhrase phrase_id = "993" lang_id = "${lang}"/></h4>

    <table width = "100%" border = "1" cellspacing = "0" cellpadding = "5">
        <tr>
            <td bgcolor = "CACACA">
                <font face = "arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/>:
            </td>

            <c:if test = "${empty job_name}">
                <c:set var = "job_name" value = "All"/>
            </c:if>

            <td colspan = "3" bgcolor = "EAEAEA">
                <c:out value = "${job_name}"/>
            </td>
        </tr>

        <tr>
            <td bgcolor = "CACACA">
                <font face = "arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>:
            </td>

            <c:if test = "${empty agency_name}">
                <c:set var = "agency_name" value = "All"/>
            </c:if>

            <td colspan = "3" bgcolor = "EAEAEA">
                <c:out value = "${agency_name}"/>
            </td>
        </tr>

        <td bgcolor = "CACACA">
            <font face = "arial" size = "-1"><b>

            <cf:GetPhrase phrase_id = "984" lang_id = "${lang}"/>:
        </td>

        <c:if test = "${empty job_length}">
            <c:set var = "job_length" value = "All"/>
        </c:if>

        <td colspan = "3" bgcolor = "EAEAEA">
            <c:out value = "${job_length}"/>
        </td>

        </td>

        </tr>
    </table>

    <h4>

    <cf:GetPhrase phrase_id = "994" lang_id = "${lang}"/></h4>

    <form action = "index.jsp?fuseaction=cfp_search" method = "post">
        <table width = "100%" border = "1" cellspacing = "0" cellpadding = "5">
            <tr>
                <td bgcolor = "CACACA">
                    <font face = "arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/>:
                </td>

                <td colspan = "3" bgcolor = "EAEAEA">
                    <select name = "job_name">
                        <option value = ""><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                        <c:forEach items = "${jobtitles.rows}" var = "row">
                            <option value = "<c:out value="${row.job_name}" />"><c:out value = "${row.job_name}"/>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td bgcolor = "CACACA">
                    <font face = "arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>:
                </td>

                <td colspan = "3" bgcolor = "EAEAEA">
                    <select name = "agency_name">
                        <option value = ""><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                        <c:forEach items = "${agencies.rows}" var = "row">
                            <option value = "<c:out value="${row.agency_name}" />">
                            <c:out value = "${row.agency_name} (Agency:${row.agency_id})"/>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <td bgcolor = "CACACA">
                <font face = "arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "984" lang_id = "${lang}"/>:
            </td>

            <td colspan = "3" bgcolor = "EAEAEA">
                <select name = "job_length">
                    <option value = ""><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                    <option value = "Full Time"><cf:GetPhrase phrase_id = "985" lang_id = "${lang}"/>

                    <option value = "Contract"><cf:GetPhrase phrase_id = "986" lang_id = "${lang}"/>

                    <option value = "Part Time"><cf:GetPhrase phrase_id = "987" lang_id = "${lang}"/>

                    <option value = "Temp-to-Perm"><cf:GetPhrase phrase_id = "988" lang_id = "${lang}"/>

                    <option value = "Tempporary"><cf:GetPhrase phrase_id = "989" lang_id = "${lang}"/>

                    <option value = "Internship"><cf:GetPhrase phrase_id = "990" lang_id = "${lang}"/>

                    <option value = "Entry Level"><cf:GetPhrase phrase_id = "991" lang_id = "${lang}"/>

                    <option value = "Co-Op"><cf:GetPhrase phrase_id = "992" lang_id = "${lang}"/>
                </select>
            </td>

            </tr>

            <tr>
                <td colspan = "4" align = "center" bgcolor = "000000">
                    <input type = "submit" value = "  <cf:GetPhrase phrase_id="982" lang_id="${lang}" />  ">
                </td>
            </tr>
        </table>
    </form>

    <p>
    <c:choose>
        <c:when test = "${user == 'coordinator'}">
            <cf:GetPhrase phrase_id = "150" lang_id = "${lang}"/>
        </c:when>

        <c:otherwise>
            <cf:GetPhrase phrase_id = "149" lang_id = "${lang}"/>
        </c:otherwise>
    </c:choose>

    <p>
    <table width = "600" border = "1" cellspacing = "0" cellpadding = "5">
        <tr bgcolor = "D2D2D2">
            <td colspan = "6" align = "center">
                <font face = "Arial"><b>

                <cf:GetPhrase phrase_id = "85" lang_id = "${lang}"/></b>
            </td>
        </tr>

        <tr bgcolor = "E8E8E8">
            <td>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/></b>
            </td>

            <td>
                <font face = "Arial" size = "-1">

                <center>
                    <b>

                    <cf:GetPhrase phrase_id = "78" lang_id = "${lang}"/></b>
            </td>

            <td>
                <font face = "Arial" size = "-1">

                <center>
                    <b>

                    <cf:GetPhrase phrase_id = "79" lang_id = "${lang}"/></b>
            </td>

            <td>
                <font face = "Arial" size = "-1">

                <center>
                    <b>

                    <cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/></b>
            </td>

            <td align = "RIGHT">
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/></b>
            </td>
        </tr>

        <c:forEach var = "row" items = "${CFP_current_list.rows}">
            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <p>
                    <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_info'/>
<c:param name='cfp_code' value='${row.cfp_code}'/>
<c:param name='job_name' value='${row.cfp_title}'/>
<c:param name='${user}'/>
</c:url>">

                    <c:out value = "${row.cfp_title}"/></a>
                </td>

                <td>
                    <font face = "Arial" size = "-1">

                    <center>
                        <fmt:formatDate value = "${row.cfp_startdate}" pattern = "dd-MMM-yyyy"/>
                </td>

                <td>
                    <font face = "Arial" size = "-1">

                    <center>
                        <fmt:formatDate value = "${row.cfp_deadline}" pattern = "dd-MMM-yyyy"/>
                </td>

                <td>
                    <font face = "Arial" size = "-1">

                    <center>
                        CFP-

                        <c:out value = "${row.cfp_code}"/>
                </td>

                <td align = "RIGHT">
                    <font face = "Arial" size = "-1">

                    <cf:ParagraphFormat value = "${row.cfp_focus}"/>
                </td>
            </tr>
        </c:forEach>

        <c:if test = "${CFP_archived_list.rowCount != 0}">
            <tr bgcolor = "D2D2D2">
                <td colspan = "6" align = "center">
                    <font face = "Arial"><b>

                    <cf:GetPhrase phrase_id = "152" lang_id = "${lang}"/></b>
                </td>
            </tr>

            <tr bgcolor = "E8E8E8">
                <td>
                    <font face = "Arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/></b>
                </td>

                <td>
                    <font face = "Arial" size = "-1">

                    <center>
                        <b>

                        <cf:GetPhrase phrase_id = "78" lang_id = "${lang}"/></b>
                </td>

                <td>
                    <font face = "Arial" size = "-1">

                    <center>
                        <b>

                        <cf:GetPhrase phrase_id = "79" lang_id = "${lang}"/></b>
                </td>

                <td>
                    <font face = "Arial" size = "-1">

                    <center>
                        <b>

                        <cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/></b>
                </td>

                <td align = "RIGHT">
                    <font face = "Arial" size = "-1"><b>

                    <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/></b>
                </td>
            </tr>

            <c:forEach var = "row" items = "${CFP_archived_list.rows}">
                <tr>
                    <td>
                        <font face = "Arial"
                              size = "-1"><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='cfp_info'/>
<c:param name='cfp_code' value='${row.cfp_code}'/>
<c:param name='job_name' value='${job_name}'/>
<c:param name='${user}'/>
</c:url>">

                        <c:out value = "${row.cfp_title}"/></a>
                    </td>

                    <td>
                        <font face = "Arial" size = "-1">

                        <center>
                            <fmt:formatDate value = "${row.cfp_startdate}" pattern = "dd-MMM-yyyy"/>
                    </td>

                    <td>
                        <font face = "Arial" size = "-1">

                        <center>
                            <fmt:formatDate value = "${row.cfp_deadline}" pattern = "dd-MMM-yyyy"/>
                    </td>

                    <td>
                        <font face = "Arial" size = "-1">

                        <center>
                            CFP-

                            <c:out value = "${row.cfp_code}"/>
                    </td>

                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1">

                        <cf:ParagraphFormat value = "${row.cfp_focus}"/>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
