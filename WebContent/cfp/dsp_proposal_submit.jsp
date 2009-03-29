<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- submit a proposal through the web --->

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "previous_tracking_code">
    <c:out value = "${param.previous_tracking_code}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = ""/>
</c:set>

<c:set var = "proponent_password">
    <c:out value = "${param.proponent_password}" default = ""/>
</c:set>

<c:set var = "proposal_title">
    <c:out value = "${param.proposal_title}" default = ""/>
</c:set>

<c:set var = "doc_filename">
    <c:out value = "${param.doc_filename}" default = ""/>
</c:set>

<c:set var = "requested_amount">
    <c:out value = "${param.requested_amount}" default = ""/>
</c:set>

<c:set var = "proponent_institution">
    <c:out value = "${param.proponent_institution}" default = ""/>
</c:set>

<c:set var = "proponent_address">
    <c:out value = "${param.proponent_address}" default = ""/>
</c:set>

<c:set var = "proponent_phone">
    <c:out value = "${param.proponent_phone}" default = ""/>
</c:set>

<c:set var = "proponent_fax">
    <c:out value = "${param.proponent_fax}" default = ""/>
</c:set>

<c:set var = "proponent_email">
    <c:out value = "${param.proponent_email}" default = ""/>
</c:set>

<c:set var = "proponent_url">
    <c:out value = "${param.proponent_url}" default = ""/>
</c:set>

<c:set var = "proponent_leader_firstname">
    <c:out value = "${param.proponent_leader_firstname}" default = ""/>
</c:set>

<c:set var = "proponent_leader_lastname">
    <c:out value = "${param.proponent_leader_lastname}" default = ""/>
</c:set>

<c:set var = "proponent_leader_initial">
    <c:out value = "${param.proponent_leader_initial}" default = ""/>
</c:set>

<c:set var = "proponent_leader_affiliation">
    <c:out value = "${param.proponent_leader_affiliation}" default = ""/>
</c:set>

<c:set var = "proponent_leader_address">
    <c:out value = "${param.proponent_leader_address}" default = ""/>
</c:set>

<c:set var = "proponent_leader_phone">
    <c:out value = "${param.proponent_leader_phone}" default = ""/>
</c:set>

<c:set var = "proponent_leader_fax">
    <c:out value = "${param.proponent_leader_fax}" default = ""/>
</c:set>

<c:set var = "proponent_leader_email">
    <c:out value = "${param.proponent_leader_email}" default = ""/>
</c:set>

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<c:set var = "pword_check">
    <c:out value = "${param.pword_check}" default = "yes"/>
</c:set>

<c:set var = "deadline_date">
    <c:out value = "${param.deadline_date}" default = "current"/>
</c:set>

<c:set var = "proponent_citizenship">
    <c:out value = "${param.proponent_citizenship}" default = ""/>
</c:set>

<c:set var = "proponent_residency">
    <c:out value = "${param.proponent_residency}" default = ""/>
</c:set>

<c:set var = "project_country">
    <c:out value = "${param.project_country}" default = ""/>
</c:set>

<c:set var = "project_date">
    <c:out value = "${param.project_date}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${act=='edit'}">

        <!--- check that password is correct --->
        <sql:query var = "password_check">
            select tracking_code, cfp_code from proponent_record where
            proponent_password = ? and tracking_code = ?

            <sql:param value = "${proponent_password}"/>

            <sql:param value = "${tracking_code}"/>
        </sql:query>

        <c:choose>
            <c:when test = "${empty password_check.rows[0].tracking_code}">
                <p>
                <br>
                <b>

                <fmt:message key = "773" />.</b>

                <c:set var = "pword_check" value = "no" scope = "page"/>
            </c:when>

            <c:otherwise>
                <h3>

                <fmt:message key = "662" /></h3>
            </c:otherwise>
        </c:choose>

        <sql:query var = "edit_proposal">
            select * from proponent_record where tracking_code = ?

            <sql:param value = "${tracking_code}"/>
        </sql:query>

        <c:set var = "ep" value = "${edit_proposal.rows[0]}" scope = "page"/>

        <c:set var = "previous_tracking_code"
               value = "${ep.previous_tracking_code}"
               scope = "page"/>

        <c:set var = "tracking_code" value = "${ep.tracking_code}"
               scope = "page"/>

        <c:set var = "cfp_code" value = "${ep.cfp_code}" scope = "page"/>

        <c:set var = "cfp_cat_id" value = "${ep.cfp_cat_id}" scope = "page"/>

        <c:set var = "proponent_password" value = "${ep.proponent_password}"
               scope = "page"/>

        <c:set var = "proposal_title" value = "${ep.proposal_title}"
               scope = "page"/>

        <c:set var = "requested_amount" value = "${ep.requested_amount}"
               scope = "page"/>

        <c:set var = "proponent_institution"
               value = "${ep.proponent_institution}"
               scope = "page"/>

        <c:set var = "proponent_address" value = "${ep.proponent_address}"
               scope = "page"/>

        <c:set var = "proponent_phone" value = "${ep.proponent_phone}"
               scope = "page"/>

        <c:set var = "proponent_fax" value = "${ep.proponent_fax}"
               scope = "page"/>

        <c:set var = "proponent_email" value = "${ep.proponent_email}"
               scope = "page"/>

        <c:set var = "proponent_url" value = "${ep.proponent_url}"
               scope = "page"/>

        <c:set var = "proponent_leader_firstname"
               value = "${ep.proponent_leader_firstname}"
               scope = "page"/>

        <c:set var = "proponent_leader_lastname"
               value = "${ep.proponent_leader_lastname}"
               scope = "page"/>

        <c:set var = "proponent_leader_initial"
               value = "${ep.proponent_leader_initial}"
               scope = "page"/>

        <c:set var = "proponent_leader_affiliation"
               value = "${ep.proponent_leader_affiliation}"
               scope = "page"/>

        <c:set var = "proponent_leader_address"
               value = "${ep.proponent_leader_address}"
               scope = "page"/>

        <c:set var = "proponent_leader_phone"
               value = "${ep.proponent_leader_phone}"
               scope = "page"/>

        <c:set var = "proponent_leader_fax" value = "${ep.proponent_leader_fax}"
               scope = "page"/>

        <c:set var = "proponent_leader_email"
               value = "${ep.proponent_leader_email}"
               scope = "page"/>

        <c:set var = "proponent_citizenship"
               value = "${ep.proponent_citizenship}"
               scope = "page"/>

        <c:set var = "proponent_residency" value = "${ep.proponent_residency}"
               scope = "page"/>

        <c:set var = "project_country" value = "${ep.project_country}"
               scope = "page"/>

        <c:set var = "project_date" value = "${ep.project_date}"
               scope = "page"/>

        <c:set var = "act" value = "edit" scope = "page"/>

        <sql:query var = "edit_doc">
            select doc_filename from documents where tracking_code = ? and
            doc_type_id = 1

            <sql:param value = "${tracking_code}"/>
        </sql:query>

        <c:set var = "proposal_filename"
               value = "${edit_doc.rows[0].doc_filename}"
               scope = "page"/>

        <!--- verify that cfp is still active 
        <cfoutput>
        <cfset Current_Date = #createODBCDate(Now())#>
        </cfoutput>
        --->

        <sql:query var = "cfp_current_list">
            select cfp_title from cfp_info where cfp_code = ? AND cfp_deadline
            >= CURDATE()

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <c:if test = "${empty cfp_current_list.rows[0].cfp_title}">
            <c:set var = "deadline_date" value = "passed" scope = "page"/>
        </c:if>

        <!--- get the cfp category name if associated with one --->
        <sql:query var = "cfp_cat_info">
            select * from cfp_category where cfp_cat_id = ?

            <sql:param value = "${cfp_cat_id}"/>
        </sql:query>

        <c:set var = "cfp_cat_name"
               value = "${cfp_cat_info.rows[0].cfp_cat_name}"
               scope = "page"/>
    </c:when>

    <c:otherwise>
        <h3>

        <fmt:message key = "93" /></h3>
    </c:otherwise>
</c:choose>

<sql:query var = "currency_type">
    select c.currency_id, c.currency from cfp_info cf, currency_code c where
    cf.cfp_code = ? and cf.currency_id = c.currency_id

    <sql:param value = "${cfp_code}"/>
</sql:query>

<c:set var = "currency" value = "${currency_type.rows[0].currency}"
       scope = "page"/>

<c:if test = "${pword_check=='yes'}">
    <fmt:message key = "41" />

    <form action = "index.jsp?fuseaction=act_proposal_submit&lang=<c:out value="${lang}" />"
          method = "post"
          ENCTYPE = "multipart/form-data">
        <input type = "hidden" name = "act" value = "<c:out value="${act}" />">
        <input type = "hidden" name = "cfp_code"
        value = "<c:out value="${cfp_code}" />">
        <input type = "hidden" name = "cfp_code_required"
        value = "<fmt:message key="776"  />"><c:choose>
            <c:when test = "${act=='add'}">
                <input type = "hidden"
                       name = "proponent_password_required"
                       value = "<fmt:message key="777"  />">
            </c:when>

            <c:otherwise>
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                name = "proponent_password"
                value = "<c:out value="${proponent_password}"/> ">
            </c:otherwise>
        </c:choose>

        <input type = "hidden" name = "proposal_title_required"
        value = "<fmt:message key="664"  />"> <input type = "hidden" name = "requested_amount_float" value = "<fmt:message key="778"  />">
        <input type = "hidden" name = "proponent_institution_required"
        value = "<fmt:message key="666"  />"> <input type = "hidden" name = "proponent_address_required" value = "<fmt:message key="667"  />">
        <input type = "hidden" name = "proponent_phone_required"
        value = "<fmt:message key="668"  />"> <input type = "hidden" name = "proponent_leader_affiliation_required" value = "<fmt:message key="669"  />">
        <input type = "hidden" name = "proponent_leader_address_required"
        value = "<fmt:message key="670"  />"> <input type = "hidden" name = "proponent_leader_firstname_required" value = "<fmt:message key="698"  />">
        <input type = "hidden" name = "proponent_leader_lastname_required"
        value = "<fmt:message key="697"  />"> <input type = "hidden"
        name = "proponent_leader_phone_required"
        value = "<fmt:message key="671"  />">

        <table width = "100%" cellpadding = "3">
            <tr bgcolor = "CFCFCF">
                <td colspan = "2">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "617" />
                </td>
            </tr>

            <c:if test = "${act=='add'}">
                <tr>
                    <td>
                        <font face = "arial" size = "-1" color = "FF0000">*

                        <fmt:message key = "299" />

                        <fmt:message key = "92"
                                      /></font>
                    </td>

                    <td>
                        <input type = "password" name = "proponent_password"
                               size = "10">
                    </td>
                </tr>

                <tr>
                    <td colspan = "2">
                        <font face = "arial" size = "-2">

                        <fmt:message key = "99" />
                    </td>
                </tr>
            </c:if>

            <!--- if cfp categories exist list them here --->
            <sql:query var = "cfp_category">
                select * from cfp_category where cfp_code = ? order by
                cfp_cat_id

                <sql:param value = "${cfp_code}"/>
            </sql:query>

            <c:if test = "${!(empty cfp_category.rows[0].cfp_cat_id)}">
                <tr>
                    <td>
                        <font face = "arial"
                              size = "-1"><font color = "FF0000">*

                        <fmt:message key = "618"
                                      /></font>
                    </td>

                    <td>
                        <select name = "cfp_cat_id">
                            <c:if test = "${act=='edit'}">
                                <c:if test = "${!(empty cfp_cat_info.rows[0].cfp_cat_id)}">
                                    <option value = "<c:out value="${cfp_cat_id}" />"><c:out value = "${cfp_cat_name}"/>
                                </c:if>
                            </c:if>

                            <c:forEach items = "${cfp_category.rows}"
                                       var = "row">
                                <option value = "<c:out value="${row.cfp_cat_id}" />"><c:out value = "${row.cfp_cat_name}"/>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </c:if>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "100" /></font>
                </td>

                <td>
                    <input type = "text" name = "proposal_title" size = "40"
                           value = "<c:out value="${proposal_title}" />">
                </td>
            </tr>

            <c:if test = "${(deadline_date=='current') and act!='edit'}">
                <tr>
                    <td valign = "top">
                        <font face = "Arial" size = "-1">

                        <fmt:message key = "101" />
                    </td>

                    <td>
                        <font face = "Arial" size = "-1"> <font face = "Arial"
                              size = "-2"><input type = "file"
                                                 name = "doc_filename"
                                                 size = "30">
                    </td>
                </tr>

                <tr>
                    <td colspan = "2">
                        <font face = "Arial" size = "-2">

                        <fmt:message key = "48" />
                    </td>
                </tr>
            </c:if>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "69" /></font>
                </td>

                <td>
                    <font face = "arial" size = "-1">(

                    <c:out value = "${currency}"/>) <input type = "number"
                           name = "requested_amount"
                           size = "10"
                           value = "<fmt:formatNumber value="${requested_amount}" type="currency" currencySymbol=""/>">
                </td>
            </tr>

            <tr>
                <td colspan = "2">
                    <font face = "arial" size = "-1">

                    <fmt:message key = "298" />
                    <input type = "number"
                           name = "previous_tracking_code"
                           size = "2"
                           value = "<c:out value="${previous_tracking_code}" />">
                </td>
            </tr>

            <tr bgcolor = "CFCFCF">
                <td colspan = "2">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "65" /></b>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "330" />
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_firstname"
                           value = "<c:out value="${proponent_leader_firstname}" />"
                           size = "10">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "619" />
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_initial"
                           value = "<c:out value="${proponent_leader_initial}" />"
                           size = "2">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "620" />
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_lastname"
                           value = "<c:out value="${proponent_leader_lastname}" />"
                           size = "10">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "300" /></font>
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_affiliation"
                           value = "<c:out value="${proponent_leader_affiliation}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "61" /></font>
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_address"
                           value = "<c:out value="${proponent_leader_address}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "62" /></font>
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_phone"
                           size = "10"
                           value = "<c:out value="${proponent_leader_phone}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "29" />
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_fax"
                           size = "10"
                           value = "<c:out value="${proponent_leader_fax}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "24" />
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_leader_email"
                           value = "<c:out value="${proponent_leader_email}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "621" />
                </td>

                <td>
                    <input type = "text" name = "proponent_citizenship"
                           value = "<c:out value="${proponent_citizenship}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "622" />
                </td>

                <td>
                    <input type = "text" name = "proponent_residency"
                           value = "<c:out value="${proponent_residency}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "623" />
                </td>

                <td>
                    <input type = "text" name = "project_country"
                           value = "<c:out value="${project_country}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "624" />
                </td>

                <td>
                    <input type = "text" name = "project_date"
                           value = "<c:out value="${project_date}" />">
                </td>
            </tr>

            <tr bgcolor = "CFCFCF">
                <td colspan = "2">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "103" /></b>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "60" /></font>
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_institution"
                           value = "<c:out value="${proponent_institution}" />"
                           size = "40">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "25" /></font>
                </td>

                <td>
                    <input type = "text"
                           name = "proponent_address"
                           value = "<c:out value="${proponent_address}" />"
                           size = "40">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1" color = "FF0000">*

                    <fmt:message key = "104" /></font>
                </td>

                <td>
                    <input type = "text" name = "proponent_phone" size = "10"
                           value = "<c:out value="${proponent_phone}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "105" />
                </td>

                <td>
                    <input type = "text" name = "proponent_fax" size = "10"
                           value = "<c:out value="${proponent_fax}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "106" />
                </td>

                <td>
                    <input type = "text" name = "proponent_email"
                           value = "<c:out value="${proponent_email}" />">
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <fmt:message key = "64" />
                </td>

                <td>
                    <input type = "text" name = "proponent_url"
                           value = "<c:out value="${proponent_url}" />">
                </td>
            </tr>

            <tr bgcolor = "CFCFCF">
                <td colspan = "2" align = "center">
                    <input type = "submit"
                           value = " <fmt:message key="463"  /> ">
                </td>
            </tr>
        </table>
</c:if>
