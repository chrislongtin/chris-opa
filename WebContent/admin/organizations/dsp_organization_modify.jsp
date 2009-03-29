<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--- Create a organization or edit organization record --->

<c:set var = "organization_id">
    <c:out value = "${param.organization_id}" default = ""/>
</c:set>

<c:set var = "organization_type_id">
    <c:out value = "${param.organization_type_id}" default = ""/>
</c:set>

<c:set var = "organization_name">
    <c:out value = "${param.organization_name}" default = ""/>
</c:set>

<c:set var = "organization_address_line_1">
    <c:out value = "${param.organization_address_line_1}" default = ""/>
</c:set>

<c:set var = "organization_address_line_2">
    <c:out value = "${param.organization_address_line_2}" default = ""/>
</c:set>

<c:set var = "organization_city">
    <c:out value = "${param.organization_city}" default = ""/>
</c:set>

<c:set var = "organization_prov_state_code">
    <c:out value = "${param.organization_prov_state_code}" default = ""/>
</c:set>

<c:set var = "organization_prov_state_name">
    <c:out value = "${param.organization_prov_state_name}" default = ""/>
</c:set>

<c:set var = "organization_postal_zip_code">
    <c:out value = "${param.organization_postal_zip_code}" default = ""/>
</c:set>

<c:set var = "organization_phone">
    <c:out value = "${param.organization_phone}" default = ""/>
</c:set>

<c:set var = "organization_fax">
    <c:out value = "${param.organization_fax}" default = ""/>
</c:set>

<c:set var = "organization_email">
    <c:out value = "${param.organization_email}" default = ""/>
</c:set>

<c:set var = "organization_url">
    <c:out value = "${param.organization_url}" default = ""/>
</c:set>

<c:set var = "organization_contact_firstname">
    <c:out value = "${param.organization_contact_firstname}" default = ""/>
</c:set>

<c:set var = "organization_contact_lastname">
    <c:out value = "${param.organization_contact_lastname}" default = ""/>
</c:set>

<c:set var = "organization_contact_initial">
    <c:out value = "${param.organization_contact_initial}" default = ""/>
</c:set>

<c:set var = "organization_contact_email">
    <c:out value = "${param.organization_contact_email}" default = ""/>
</c:set>

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<sql:query var = "organizationtypes">
    select organization_type_id, organization_type_name from
    organization_types where lang_id = ? order by organization_type_name

    <sql:param value = "${sessionScope.lang}"/>
</sql:query>

<c:choose>
    <c:when test = "${act=='edit'}">
        <h3>

        <fmt:message key = "1114" /></h3>

        <sql:query var = "edit_organization">
            select * from organizations where organization_id = ?

            <sql:param value = "${organization_id}"/>
        </sql:query>

        <c:set var = "ec" value = "${edit_organization.rows[0]}"
               scope = "page"/>

        <c:set var = "organization_id" value = "${ec.organization_id}"
               scope = "page"/>

        <c:set var = "organization_name" value = "${ec.organization_name}"
               scope = "page"/>

        <c:set var = "organization_type_id" value = "${ec.organization_type_id}"
               scope = "page"/>

        <c:set var = "organization_address_line_1"
               value = "${ec.organization_address_line_1}"
               scope = "page"/>

        <c:set var = "organization_address_line_2"
               value = "${ec.organization_address_line_2}"
               scope = "page"/>

        <c:set var = "organization_city" value = "${ec.organization_city}"
               scope = "page"/>

        <c:set var = "organization_prov_state_code"
               value = "${ec.organization_prov_state_code}"
               scope = "page"/>

        <c:set var = "organization_prov_state_name"
               value = "${ec.organization_prov_state_name}"
               scope = "page"/>

        <c:set var = "organization_postal_zip_code"
               value = "${ec.organization_postal_zip_code}"
               scope = "page"/>

        <c:set var = "organization_phone" value = "${ec.organization_phone}"
               scope = "page"/>

        <c:set var = "organization_fax" value = "${ec.organization_fax}"
               scope = "page"/>

        <c:set var = "organization_email" value = "${ec.organization_email}"
               scope = "page"/>

        <c:set var = "organization_url" value = "${ec.organization_url}"
               scope = "page"/>

        <c:set var = "organization_contact_firstname"
               value = "${ec.organization_contact_firstname}"
               scope = "page"/>

        <c:set var = "organization_contact_lastname"
               value = "${ec.organization_contact_lastname}"
               scope = "page"/>

        <c:set var = "organization_contact_initial"
               value = "${ec.organization_contact_initial}"
               scope = "page"/>

        <c:set var = "organization_contact_email"
               value = "${ec.organization_contact_email}"
               scope = "page"/>

        <c:set var = "act" value = "edit" scope = "page"/>

        <sql:query var = "curr_organizationtype">
            select organization_type_id, organization_type_name from
            organization_types where organization_type_id = ? and lang_id = ?
            order by organization_type_name

            <sql:param value = "${organization_type_id}"/>

            <sql:param value = "${sessionScope.lang}"/>
        </sql:query>

        <fmt:message key = "41" />

        <form action = "index.jsp?fuseaction=act_organization" method = "post">
            <input type = "hidden"
                   name = "act"
                   value = "<c:out value="${act}" />"> <input type = "hidden"
                   name = "organization_id"
                   value = "<c:out value="${organization_id}" />">
            <input type = "hidden"
                   name = "organization_type_id_required"
                   value = "<fmt:message key="1121"  />">
            <input type = "hidden"
                   name = "organization_name_required"
                   value = "<fmt:message key="1117"  />">

            <table width = "100%" cellpadding = "3">
                <tr bgcolor = "CFCFCF">
                    <td colspan = "2">
                        <font face = "arial" size = "-1"><b>

                        <fmt:message key = "1115" />
                    </td>
                </tr>

                <tr>
                    <td><font face = "arial" color = "FF0000">*

                        <fmt:message key = "628"
                                      /></font></td>

                    <td><input type = "text"
                               name = "organization_name"
                               size = "40"
                               value = "<c:out value="${organization_name}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1119"
                                      /></td>

                    <td>
                        <select name = "organization_type_id" size = "1"
                                multiple = "no">
                            <option value = "<c:out value="${curr_organizationtype.rows[0].organization_type_id}" />"
                                    selected>
                            <c:out value = "${curr_organizationtype.rows[0].organization_type_name}"/>

                            <c:forEach items = "${organizationtypes.rows}"
                                       var = "row">
                                <option value = "<c:out value="${row.organization_type_id}" />">
                                <c:out value = "${row.organization_type_name}"/>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "61"
                                      />-1</td>

                    <td><input type = "text"
                               name = "organization_address_line_1"
                               size = "40"
                               value = "<c:out value="${organization_address_line_1}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "61"
                                      />-2</td>

                    <td><input type = "text"
                               name = "organization_address_line_2"
                               size = "40"
                               value = "<c:out value="${organization_address_line_2}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1058"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_city"
                               size = "40"
                               value = "<c:out value="${organization_city}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1059"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_prov_state_code"
                               size = "4"
                               value = "<c:out value="${organization_prov_state_code}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1060"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_prov_state_name"
                               size = "40"
                               value = "<c:out value="${organization_prov_state_name}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1061"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_postal_zip_code"
                               size = "15"
                               value = "<c:out value="${organization_postal_zip_code}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "62"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_phone"
                               size = "20"
                               value = "<c:out value="${organization_phone}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "29"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_fax"
                               size = "20"
                               value = "<c:out value="${organization_fax}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "24"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_email"
                               value = "<c:out value="${organization_email}" />"
                               size = "40"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "64"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_url"
                               value = "<c:out value="${organization_url}" />"
                               size = "40"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "330"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_contact_firstname"
                               value = "<c:out value="${organization_contact_firstname}" />"
                               size = "40"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "619"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_contact_initial"
                               value = "<c:out value="${organization_contact_initial}" />"
                               size = "5"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "329"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_contact_lastname"
                               value = "<c:out value="${organization_contact_lastname}" />"
                               size = "40"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "24"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_contact_email"
                               value = "<c:out value="${organization_contact_email}" />"
                               size = "40"></td>
                </tr>

                </tr>

                <tr bgcolor = "CFCFCF">
                    <td colspan = "2"
                        align = "center"><input type = "submit"
                                                value = " <fmt:message key = "456" /> "></td>
        </form>

        </tr>

        </table>
    </c:when>

    <c:when test = "${act=='add'}">
        <h3>

        <fmt:message key = "1118" /></h3>

        <c:set var = "act" value = "add" scope = "page"/>

        <fmt:message key = "41" />

        <form action = "index.jsp?fuseaction=act_organization" method = "post">
            <input type = "hidden"
                   name = "act"
                   value = "<c:out value="${act}" />"> <input type = "hidden"
                   name = "organization_id"
                   value = "<c:out value="${organization_id}" />">
            <input type = "hidden"
                   name = "organization_type_id_required"
                   value = "<fmt:message key="1121"  />">
            <input type = "hidden"
                   name = "organization_name_required"
                   value = "<fmt:message key="1117"  />">

            <table width = "100%" cellpadding = "3">
                <tr bgcolor = "CFCFCF">
                    <td colspan = "2">
                        <font face = "arial" size = "-1"><b>

                        <fmt:message key = "1115" />
                    </td>
                </tr>

                <tr>
                    <td><font face = "arial" color = "FF0000">

                        <fmt:message key = "628"
                                      />*</font></td>

                    <td><input type = "text"
                               name = "organization_name"
                               size = "40"
                               value = "<c:out value="${organization_name}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1119" />

                        </font></td>

                    <td>
                        <select name = "organization_type_id" size = "1"
                                multiple = "no">
                            <c:forEach items = "${organizationtypes.rows}"
                                       var = "row">
                                <option value = "<c:out value="${row.organization_type_id}" />">
                                <c:out value = "${row.organization_type_name}"/>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "61"
                                      />-1</td>

                    <td><input type = "text"
                               name = "organization_address_line_1"
                               size = "40"
                               value = "<c:out value="${organization_address_line_1}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "61"
                                      />-2</td>

                    <td><input type = "text"
                               name = "organization_address_line_2"
                               size = "40"
                               value = "<c:out value="${organization_address_line_2}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1058"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_city"
                               size = "40"
                               value = "<c:out value="${organization_city}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1059"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_prov_state_code"
                               size = "4"
                               value = "<c:out value="${organization_prov_state_code}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1060"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_prov_state_name"
                               size = "40"
                               value = "<c:out value="${organization_prov_state_name}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "1061"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_postal_zip_code"
                               size = "15"
                               value = "<c:out value="${organization_postal_zip_code}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "62"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_phone"
                               size = "10"
                               value = "<c:out value="${organization_phone}" />"
                               size = "20"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "29"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_fax"
                               size = "10"
                               value = "<c:out value="${organization_fax}" />"
                               size = "20"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "24"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_email"
                               value = "<c:out value="${organization_email}" />"
                               size = "40"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "64"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_url"
                               value = "<c:out value="${organization_url}" />"
                               size = "40"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "330"
                                      /></td>

                    <td><input type = "text"
                               size = "40"
                               name = "organization_contact_firstname"
                               value = "<c:out value="${organization_contact_firstname}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "619"
                                      /></td>

                    <td><input type = "text"
                               name = "organization_contact_initial"
                               value = "<c:out value="${organization_contact_initial}" />"
                               size = "5"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "329"
                                      /></td>

                    <td><input type = "text"
                               size = "40"
                               name = "organization_contact_lastname"
                               value = "<c:out value="${organization_contact_lastname}" />"></td>
                </tr>

                <tr>
                    <td>
                        <fmt:message key = "23" />

                        <fmt:message key = "24"
                                      /></td>

                    <td><input type = "text"
                               size = "40"
                               name = "organization_contact_email"
                               value = "<c:out value="${organization_contact_email}" />"></td>
                </tr>

                </tr>

                <tr bgcolor = "CFCFCF">
                    <td colspan = "2"
                        align = "center"><input type = "submit"
                                                value = " <fmt:message key = "456" /> "></td>
        </form>

        </tr>

        </table>
    </c:when>
</c:choose>

<!--- option to delete the organization record --->
<c:if test = "${act=='edit'}">
    <h3>

    <fmt:message key = "1116" /></h3>

    <form action = "index.jsp?fuseaction=act_organization" method = "post">
        <input type = "hidden"
               name = "organization_id"
               value = "<c:out value="${organization_id}" />">
        <input type = "hidden" name = "act" value = "delete">

        <fmt:message key = "130" />

        <br><input type = "submit"
                   value = " <fmt:message key = "143" /> ">
    </form>
</c:if>
