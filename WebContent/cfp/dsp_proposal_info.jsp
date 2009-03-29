<%@ page import = "java.util.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<%@ include file = "../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- make sure that the user has logged in --->
<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:if test = "${tracking_code==''}">
    <p>
    <br>
    <div align = "center">
        <b>

        <fmt:message key = "770" />

        <p>
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=proposal_edit">

        <fmt:message key = "733" /></a>

        <fmt:message key = "734" /></b>
    </div>

    <%
    if (true)
        return;
    %>
</c:if>

<!--- show the proponent the full proposal record --->
<c:set var = "proponent_password">
    <c:out value = "${param.proponent_password}" default = ""/>
</c:set>

<!--- check that password is correct --->
<sql:query var = "password_check">
    select tracking_code, cfp_code from proponent_record where
    proponent_password = ? and tracking_code = ?

    <sql:param value = "${proponent_password}"/>

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:if test = "${empty password_check.rows[0].tracking_code}">
    <p>
    <br>
    <b>

    <fmt:message key = "773" />.</b>

    <%
    if (true)
        return;
    %>
</c:if>

<sql:query var = "proposal_info">
    select p.*, c.cfp_title from proponent_record p, cfp_info c where
    p.tracking_code = ? and p.cfp_code = c.cfp_code

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "cfp_code" value = "${proposal_info.rows[0].cfp_code}"
       scope = "page"/>

<!--- verify that cfp is still active --->
<sql:query var = "cfp_current_list">
    select cfp_title from cfp_info where cfp_code = ? and cfp_deadline >=
    CURDATE()

    <sql:param value = "${cfp_code}"/>
</sql:query>

<c:set var = "deadline_date" value = "current" scope = "page"/>

<c:if test = "${empty cfp_current_list.rows[0].cfp_title}">
    <c:set var = "deadline_date" value = "passed" scope = "page"/>
</c:if>

<sql:query var = "proposal_docs">
    select d.*, dt.doc_type_name from documents d, document_types dt where
    d.tracking_code = ? and d.doc_type_id = dt.doc_type_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<sql:query var = "proposal_researchers">
    select * from researchers where tracking_code = ?

    <sql:param value = "${tracking_code}"/>
</sql:query>

<sql:query var = "currency_type">
    select c.currency_id, c.currency from cfp_info cf, currency_code c where
    cf.cfp_code = ? and cf.currency_id = c.currency_id

    <sql:param value = "${cfp_code}"/>
</sql:query>

<c:set var = "currency" value = "${currency_type.rows[0].currency}"
       scope = "page"/>

<c:forEach items = "${proposal_info.rows}" var = "row">
    <sql:query var = "cfp_cat_name">
        select cfp_cat_name from cfp_category where cfp_cat_id = ?

        <sql:param value = "${row.cfp_cat_id}"/>
    </sql:query>

    <p>
    <br>
    <table>
        <tr>
            <td>
                <form action = "index.jsp?fuseaction=cfp_proposal"
                      method = "post">
                    <input type = "hidden" name = "tracking_code"
                    value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                    name = "proponent_password"
                    value = "<c:out value="${proponent_password}" />"> <input type = "hidden" name = "act" value = "edit">
                    <input type = "submit"
                    value = "<fmt:message key="144"  />">
                </form>
            </td>

            <td>
                <form action = "index.jsp?fuseaction=proposal_doc"
                      method = "post">
                    <input type = "hidden" name = "tracking_code"
                    value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                    name = "proponent_password"
                    value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                    value = "<fmt:message key="615"  />">
                </form>
            </td>

            <td>
                <form action = "index.jsp?fuseaction=proposal_researcher"
                      method = "post">
                    <input type = "hidden" name = "tracking_code"
                    value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                    name = "proponent_password"
                    value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                    value = "<fmt:message key="616"  />">
                </form>
            </td>
        </tr>
    </table>

    <table width = "100%" cellpadding = "3">
        <tr bgcolor = "CFCFCF">
            <td colspan = "2">
                <font face = "arial" size = "-1"><b>

                <fmt:message key = "617" />
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "100" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proposal_title}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "586" />:</font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.cfp_title}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "618" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${cfp_cat_name.rows[0].cfp_cat_name}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "69" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">(

                <c:out value = "${currency}"/>

                )

                <fmt:formatNumber value = "${row.requested_amount}"
                                  type = "currency"
                                  currencySymbol = ""/>
            </td>
        </tr>

        <c:if test = "${(row.previous_tracking_code!=0) and (row.previous_tracking_code!='')}">
            <tr>
                <td colspan = "2">
                    <font face = "arial" size = "-1">

                    <fmt:message key = "298" />

                    <c:out value = "${row.previous_tracking_code}"/>
                </td>
            </tr>
        </c:if>

        <tr bgcolor = "CFCFCF">
            <td colspan = "2">
                <font face = "arial" size = "-1"><b>

                <fmt:message key = "65" />:</b>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "330" />:
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_firstname}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "619" />:
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_initial}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "620" />:
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_lastname}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "300" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_affiliation}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "61" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_address}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "62" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_phone}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "29" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_fax}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "24" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_leader_email}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "621" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_citizenship}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "622" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_residency}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "761" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.project_country}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "624" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.project_date}"/>
            </td>
        </tr>

        <tr bgcolor = "CFCFCF">
            <td colspan = "2">
                <font face = "arial" size = "-1"><b>

                <fmt:message key = "103" />:</b>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "60" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_institution}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "25" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_address}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1"ss>

                <fmt:message key = "104" /></font>
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_phone}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "105" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_fax}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "106" />
            </td>

            <td>
                <font face = "arial" size = "-1">

                <c:out value = "${row.proponent_email}"/>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <fmt:message key = "64" />
            </td>

            <td>
                <c:out value = "${row.proponent_url}"/>
            </td>
        </tr>
    </table>
</c:forEach>

<c:if test = "${!(empty proposal_docs.rows[0].doc_type_name)}">
    <p>
    <table width = "100%" border = "0" cellspacing = "0" cellpadding = "2">
        <tr bgcolor = "CFCFCF">
            <td colspan = "3">
                <font face = "arial" size = "-1"><b>

                <fmt:message key = "595" />:</b>
            </td>
        </tr>

        <tr>
            <td colspan = "3">
                &nbsp;
            </td>
        </tr>

        <c:forEach items = "${proposal_docs.rows}" var = "row">
            <tr bgcolor = "E9E9E9">
                <td>
                    <font face = "arial" size = "-1"><b>

                    <c:out value = "${row.doc_title}"/></b>

                    <br>
                    <font face = "arial" size = "-2">

                    <fmt:formatDate value = "${row.doc_date}"
                                    pattern = "dd-MMM-yyyy"/>

                    <br>
                    <c:out value = "${row.doc_type_name}"/></font>
                </td>

                <c:choose>
                    <c:when test = "${(row.doc_type_id==1) and (deadline_date=='passed')}">
                        <td colspan = "2">
                            &nbsp;
                        </td>
                    </c:when>

                    <c:otherwise>
                        <td valign = "top" align = "right">
                            <form action = "index.jsp?fuseaction=proposal_doc"
                                  method = "post">
                                <input type = "hidden" name = "tracking_code"
                                value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                                <input type = "hidden" name = "doc_id"
                                value = "<c:out value="${row.doc_id}" />"> <input type = "hidden" name = "act" value = "edit">
                                <input type = "submit"
                                value = "   <fmt:message key="144"  />   ">
                            </form>
                        </td>

                        <td valign = "top" align = "right">
                            <form action = "index.jsp?fuseaction=act_proposal_doc"
                                  method = "post">
                                <input type = "hidden" name = "tracking_code"
                                value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                                <input type = "hidden" name = "doc_id"
                                value = "<c:out value="${row.doc_id}" />"> <input type = "hidden" name = "act" value = "delete_unconfirmed">
                                <input type = "submit"
                                value = "<fmt:message key="143"  />">
                            </form>
                        </td>
                    </c:otherwise>
                </c:choose>
            </tr>

            <tr>
                <td colspan = "3">
                    <font face = "arial" size = "-1">
                    <c:if test = "${row.doc_filename!=''}">
                        <c:out value = "${row.doc_filename}"/>
                    </c:if>

                    <p>
                    <cf:ParagraphFormat value = "${row.doc_abstract}"/>
                </td>
            </tr>

            <tr>
                <td colspan = "3">
                    &nbsp;
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<c:if test = "${!(empty proposal_researchers.rows[0].researcher_id)}">
    <table width = "100%" border = "0" cellspacing = "0" cellpadding = "2">
        <tr bgcolor = "CFCFCF">
            <td colspan = "4">
                <font face = "arial" size = "-1"><b>

                <fmt:message key = "626" /></b>
            </td>
        </tr>

        <tr>
            <td colspan = "4">
                &nbsp;
            </td>
        </tr>

        <c:forEach items = "${proposal_researchers.rows}" var = "row">
            <tr bgcolor = "EFEFEF">
                <td colspan = "2">
                    <font face = "arial" size = "-1"><b>

                    <c:out value = "${row.researcher_firstname} ${row.researcher_initial} ${row.researcher_lastname}"/></b>

                    <br>
                    <i>

                    <c:out value = "${row.researcher_email}"/></i>
                </td>

                <td valign = "top" align = "right" valign = "top">
                    <form action = "index.jsp?fuseaction=proposal_researcher"
                          method = "post">
                        <input type = "hidden" name = "tracking_code"
                        value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                        <input type = "hidden" name = "researcher_id"
                        value = "<c:out value="${row.researcher_id}" />"> <input type = "hidden" name = "act" value = "edit">
                        <input type = "submit"
                        value = "  <fmt:message key="144"  />  ">
                    </form>
                </td>

                <td align = "right">
                    <form action = "index.jsp?fuseaction=act_proposal_researcher"
                          method = "post">
                        <input type = "hidden" name = "tracking_code"
                        value = "<c:out value="${tracking_code}" />"> <input type = "hidden" name = "proponent_password" value = "<c:out value="${proponent_password}" />">
                        <input type = "hidden" name = "researcher_id"
                        value = "<c:out value="${row.researcher_id}" />"> <input type = "hidden" name = "act" value = "delete_unconfirmed">
                        <input type = "submit"
                        value = "<fmt:message key="143"  />">
                    </form>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "62" />:</b>

                    <c:out value = "${row.researcher_phone}"/>
                </td>

                <td>
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "29" />:</b>

                    <c:out value = "${row.researcher_fax}"/>
                </td>

                <td>
                    &nbsp;
                </td>

                <td>
                    &nbsp;
                </td>
            </tr>

            <tr>
                <td colspan = "2">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "621" />:</b>

                    <c:out value = "${row.researcher_citizenship}"/>
                </td>

                <td colspan = "2">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "627" />:</b>

                    <c:out value = "${row.researcher_residency}"/>
                </td>
            </tr>

            <tr>
                <td colspan = "4">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "628" />:</b>

                    <c:out value = "${row.researcher_org}"/>
                </td>
            </tr>

            <tr>
                <td colspan = "4">
                    &nbsp;
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
