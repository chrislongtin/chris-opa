<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = ""/>
</c:set>

<c:set var = "cfp_cat_id">
    <c:out value = "${param.cfp_cat_id}" default = ""/>
</c:set>

<c:set var = "status_id">
    <c:out value = "${param.status_id}" default = ""/>
</c:set>

<c:set var = "proponent_leader_lastname">
    <c:out value = "${param.proponent_leader_lastname}" default = ""/>
</c:set>

<c:set var = "proponent_leader_firstname">
    <c:out value = "${param.proponent_leader_firstname}" default = ""/>
</c:set>

<c:set var = "proponent_citizenship">
    <c:out value = "${param.proponent_citizenship}" default = ""/>
</c:set>

<c:set var = "project_country">
    <c:out value = "${param.project_country}" default = ""/>
</c:set>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "tracking_code_param">
    <c:out value = "${param.tracking_code_param}" default = "="/>
</c:set>

<c:set var = "hidden">
    <c:out value = "${param.hidden}" default = "no"/>
</c:set>

<c:set var = "showinfo">
    <c:out value = "${param.showinfo}" default = "short"/>
</c:set>

<c:set var = "search_order">
    <c:out value = "${param.search_order}" default = "tracking_code"/>
</c:set>

<!----------------------- SEARCH CRITERIA ------------------------->
<c:if test = "${cfp_code!=''}">
    <sql:query var = "cfp_name">
        select cfp_title from cfp_info where cfp_code = ?

        <sql:param value = "${cfp_code}"/>
    </sql:query>
</c:if>

<c:if test = "${cfp_cat_id!=''}">
    <sql:query var = "cat_name">
        select cfp_cat_name from cfp_category where cfp_cat_id = ?

        <sql:param value = "${cfp_cat_id}"/>
    </sql:query>
</c:if>

<c:if test = "${status_id!=''}">
    <sql:query var = "status">
        select status_name from record_status where status_id = ?

        <sql:param value = "${status_id}"/>
    </sql:query>
</c:if>

<table border = "0" cellspacing = "0" cellpadding = "3">
    <tr>
        <td valign = "top">
            <font face = "arial" size = "-1"><b>

            <fmt:message key = "629" />
        </td>

        <td valign = "top">
            <font face = "arial" size = "-1"><c:if test = "${cfp_code!=''}">
                -

                <fmt:message key = "586" />

                :

                <c:out value = "${cfp_name.rows[0].cfp_title}"/>

                <br>
            </c:if>

            <c:if test = "${cfp_cat_id!=''}">
                -

                <fmt:message key = "630" />

                :

                <c:out value = "${cat_name.rows[0].cfp_cat_name}"/>

                <br>
            </c:if>

            <c:if test = "${status_id!=''}">
                -

                <fmt:message key = "58" />

                :

                <c:out value = "${status.rows[0].status_name}"/>

                <br>
            </c:if>

            <c:if test = "${tracking_code!=''}">
                -

                <fmt:message key = "57" />

                :

                <c:out value = "${tracking_code}"/>

                <br>
            </c:if>

            <c:if test = "${proponent_leader_lastname!=''}">
                -

                <fmt:message key = "620" />

                :

                <c:out value = "${proponent_leader_lastname}"/>

                <br>
            </c:if>

            <c:if test = "${proponent_leader_firstname!=''}">
                -

                <fmt:message key = "330" />

                :

                <c:out value = "${proponent_leader_firstname}"/>

                <br>
            </c:if>

            <c:if test = "${proponent_citizenship!=''}">
                -

                <fmt:message key = "621" />

                :

                <c:out value = "${proponent_citizenship}"/>

                <br>
            </c:if>

            <c:if test = "${project_country!=''}">
                -

                <fmt:message key = "631" />

                :

                <c:out value = "${project_country}"/>

                <br>
            </c:if>
        </td>
</table>

<!-------------- check to see if reviewer is a reviewer coordinator --------------->
<c:set var = "reviewer_coordinator">
    <c:out value = "${param.reviewer_coordinator}" default = "0"/>
</c:set>

<c:if test = "${sessionScope.user!='coordinator'}">
    <c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

    <sql:query var = "r_coord_check">
        select reviewer_coordinator from reviewers where reviewer_id = ?

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <c:set var = "reviewer_coordinator"
           value = "${r_coord_check.rows[0].reviewer_coordinator}"
           scope = "page"/>
</c:if>

<!--------------------------- PROPOSAL INFORMATION ------------------------------->

<sql:query var = "proposal_info">
    select p.cfp_code, p.tracking_code, p.proponent_institution,
    p.requested_amount, p.awarded_amount, s.status_name, p.date_submitted,
    p.date_last_updated, p.proponent_leader_firstname,
    p.proponent_leader_lastname, p.proposal_title, p.cfp_cat_id,
    p.proponent_citizenship, p.proponent_residency, p.project_country,
    p.project_date from proponent_record p, record_status s where

    <c:if test = "${cfp_code!=''}">
        p.cfp_code = ? and
    </c:if>

    p.status_id = s.status_id and

    <c:choose>
        <c:when test = "${hidden=='no'}">
            proposal_hide = 0
        </c:when>

        <c:otherwise>
            proposal_hide = 1
        </c:otherwise>
    </c:choose>

    <c:if test = "${cfp_cat_id!=''}">
        and cfp_cat_id = ?
    </c:if>

    <c:if test = "${status_id!=''}">
        and p.status_id = ?
    </c:if>

    <c:if test = "${proponent_leader_lastname!=''}">
        and p.proponent_leader_lastname = ?
    </c:if>

    <c:if test = "${proponent_leader_firstname!=''}">
        and p.proponent_leader_firstname = ?
    </c:if>

    <c:if test = "${proponent_citizenship!=''}">
        and p.proponent_citizenship = ?
    </c:if>

    <c:if test = "${project_country!=''}">
        and p.project_country = ?
    </c:if>

    <c:if test = "${tracking_code!=''}">
        and p.tracking_code

        <c:choose>
            <c:when test = "${tracking_code_param=='='}">
                <c:out value = "=" escapeXml = "false"/>
            </c:when>

            <c:when test = "${tracking_code_param=='ge'}">
                <c:out value = ">=" escapeXml = "false"/>
            </c:when>

            <c:when test = "${tracking_code_param=='le'}">
                <c:out value = "<=" escapeXml = "false"/>
            </c:when>
        </c:choose>

        ?
    </c:if>

    <c:if test = "${sessionScope.user!='coordinator'}">
        and p.status_id > 3
    </c:if>

    order by

    <c:out value = "${search_order}"/>

    <c:if test = "${cfp_code!=''}">
        <sql:param value = "${cfp_code}"/>
    </c:if>

    <c:if test = "${cfp_cat_id!=''}">
        <sql:param value = "${cfp_cat_id}"/>
    </c:if>

    <c:if test = "${status_id!=''}">
        <sql:param value = "${status_id}"/>
    </c:if>

    <c:if test = "${proponent_leader_lastname!=''}">
        <sql:param value = "${proponent_leader_lastname}"/>
    </c:if>

    <c:if test = "${proponent_leader_firstname!=''}">
        <sql:param value = "${proponent_leader_firstname}"/>
    </c:if>

    <c:if test = "${proponent_citizenship!=''}">
        <sql:param value = "${proponent_citizenship}"/>
    </c:if>

    <c:if test = "${project_country!=''}">
        <sql:param value = "${project_country}"/>
    </c:if>

    <c:if test = "${tracking_code!=''}">
        <sql:param value = "${tracking_code}"/>
    </c:if>
</sql:query>

<c:choose>
    <c:when test = "${proposal_info.rowCount==0}">
        <h3>

        <fmt:message key = "632" />.</h3>
    </c:when>

    <c:otherwise>
        <p>
        <div align = "center">
            <h4>

            <c:out value = "${proposal_info.rowCount}"/>

            <fmt:message key = "916" />.</h4>
        </div>

        <font size = "-2"><a STYLE = "text-decoration: underline"
                             href = "index.jsp?fuseaction=dsp_send_letters">

        <fmt:message key = "264" /></a></font>
        <c:forEach items = "${proposal_info.rows}" var = "row">

            <!--- get the cfp title for the proposal --->
            <sql:query var = "cfp_name">
                select cfp_title from cfp_info where cfp_code = ?

                <sql:param value = "${row.cfp_code}"/>
            </sql:query>

            <!--- get the cfp category name for the proposal --->
            <sql:query var = "cfp_catname">
                select cfp_cat_name from cfp_category where cfp_cat_id = ?

                <sql:param value = "${row.cfp_cat_id}"/>
            </sql:query>

            <!--- query to see if any documents have been submitted for the proposal --->
            <sql:query var = "docs">
                select doc_title from documents where tracking_code = ?

                <sql:param value = "${row.tracking_code}"/>
            </sql:query>

            <!--- retrieving assigned reviewer info for each proposal --->
            <sql:query var = "reviewers_assigned">
                select r.reviewer_lastname, r.reviewer_firstname from
                reviewer_assignment ra, reviewers r where ra.tracking_code = ?
                and ra.reviewer_id = r.reviewer_id and ra.proposal = 1

                <sql:param value = "${row.tracking_code}"/>
            </sql:query>

            <!--- retrieving outstanding reviewer info for each proposal --->
            <sql:query var = "reviewers_pending">
                select r.reviewer_lastname, r.reviewer_firstname from
                reviewer_assignment ra, reviewers r where ra.tracking_code = ?
                and ra.reviewer_id = r.reviewer_id and ra.proposal = 1 and
                proposal_review_completed = 0

                <sql:param value = "${row.tracking_code}"/>
            </sql:query>

            <p>
            <table border = "1" cellspacing = "0" cellpadding = "3"
                   width = "100%">
                <tr bgcolor = "CFCFCF">
                    <td colspan = "2">
                        <center>
                            <font face = "Arial" size = "+1"> <b>

                            <c:out value = "${row.proposal_title}"/></b>
                            <font size = "-1">

                            <br>
                            <b>

                            <c:out value = "${cfp_name.rows[0].cfp_title}"/></b>

                            <br>
                            <i>

                            <c:out value = "${cfp_catname.rows[0].cfp_cat_name}"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        <font face = "Arial" size = "-1"><b>

                        <fmt:message key = "57"
                                      />:</b>
                    </td>

                    <td>
                        <font face = "Arial" size = "-1">P-

                        <c:out value = "${row.tracking_code}"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        <font face = "Arial" size = "-1"><b>

                        <fmt:message key = "595"
                                      />:</b>
                    </td>

                    <td>
                        <font face = "Arial" size = "-1"><c:choose>
                            <c:when test = "${docs.rowCount==0}">
                                <fmt:message key = "515"
                                              />

                                .
                            </c:when>

                            <c:otherwise>
                                <a STYLE = "text-decoration: underline"
                                   href = "index.jsp?fuseaction=proposal_docs_list&tracking_code=<c:out value="${row.tracking_code}" />">

                                <fmt:message key = "597"
                                              /></a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <c:if test = "${showinfo=='long'}">
                    <tr>
                        <td>
                            <font face = "Arial" size = "-1"><b>

                            <fmt:message key = "266"
                                          />:</b>
                        </td>

                        <td>
                            <font face = "Arial" size = "-1">

                            <fmt:formatDate value = "${row.date_submitted}"
                                            pattern = "MMM dd, yyyy"/>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <font face = "Arial" size = "-1"><b>

                            <fmt:message key = "267"
                                          />:</b>
                        </td>

                        <td>
                            <font face = "Arial" size = "-1">

                            <fmt:formatDate value = "${row.date_last_updated}"
                                            pattern = "MMM dd, yyyy"/>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <font face = "Arial" size = "-1"><b>

                            <fmt:message key = "66"
                                          />:</b>
                        </td>

                        <td>
                            <font face = "Arial" size = "-1">

                            <c:out value = "${row.proponent_leader_lastname}, ${row.proponent_leader_firstname}"/>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <font face = "Arial" size = "-1"><b>

                            <fmt:message key = "60"
                                          />:</b>
                        </td>

                        <td>
                            <font face = "Arial" size = "-1">

                            <c:out value = "${row.proponent_institution}"/>
                        </td>
                    </tr>

                    <c:if test = "${(!empty row.proponent_citizenship) or (!empty row.proponent_residency)}">
                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <fmt:message key = "634"
                                              />:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = "${row.proponent_citizenship} / ${row.proponent_residency}"/>
                            </td>
                        </tr>
                    </c:if>

                    <c:if test = "${(!empty row.project_country) or (!empty row.project_date)}">
                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <fmt:message key = "635"
                                              />:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">

                                <c:out value = "${row.project_country} / ${row.project_date}"/>
                            </td>
                        </tr>
                    </c:if>

                    <tr>
                        <td>
                            <font face = "Arial" size = "-1"><b>

                            <fmt:message key = "58"
                                          />:</b>
                        </td>

                        <td>
                            <font face = "Arial" size = "-1">

                            <c:out value = "${row.status_name}"/>
                        </td>
                    </tr>

                    <c:if test = "${(sessionScope.user=='coordinator') or (reviewer_coordinator==1)}">
                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <fmt:message key = "273"
                                              />:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">
                                <c:forEach items = "${reviewers_assigned.rows}"
                                           var = "ra">
                                    <c:out value = "${ra.reviewer_firstname} ${ra.reviewer_lastname}"/>

                                    ,
                                </c:forEach>

                                &nbsp;
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <font face = "Arial" size = "-1"><b>

                                <fmt:message key = "274"
                                              />:</b>
                            </td>

                            <td>
                                <font face = "Arial" size = "-1">
                                <c:forEach items = "${reviewers_pending.rows}"
                                           var = "rp">
                                    <c:out value = "${rp.reviewer_firstname} ${rp.reviewer_lastname}"/>

                                    ,
                                </c:forEach>

                                &nbsp;
                            </td>
                        </tr>
                    </c:if>
                </c:if>

                <c:if test = "${(sessionScope.user=='coordinator') or (reviewer_coordinator==1)}">
                    <tr>
                        <td>
                            &nbsp;
                        </td>

                        <td align = "right">
                            <font face = "Arial" size = "-2">
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp?fuseaction=proposal_assign&tracking_code=<c:out value="${row.tracking_code}" />&cfp_code=<c:out value="${row.cfp_code}" />&cfp_cat_id=<c:out value="${row.cfp_cat_id}" />">

                            <fmt:message key = "250"
                                          /></a>

                            <c:if test = "${sessionScope.user=='coordinator'}">
                                <br>
                                <a STYLE = "text-decoration: underline"
                                   href = "index.jsp?fuseaction=proposal_info&tracking_code=<c:out value="${row.tracking_code}" />">

                                <fmt:message key = "636"
                                              /></a>
                            </c:if>

                            <br>
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp?fuseaction=proposal_summary&tracking_code=<c:out value="${row.tracking_code}" />">

                            <fmt:message key = "637"
                                          /></a>

                            <br>
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp?fuseaction=tsc_main&tracking_code=<c:out value="${row.tracking_code}" />">

                            <fmt:message key = "841"
                                          /></a>

                            <br>
                            <a STYLE = "text-decoration: underline"
                               href = "index.jsp?fuseaction=report_summary&tracking_code=<c:out value="${row.tracking_code}" />">

                            <fmt:message key = "906"
                                          /></a>
                        </td>
                    </tr>
                </c:if>
            </table>
        </c:forEach>
    </c:otherwise>
</c:choose>
