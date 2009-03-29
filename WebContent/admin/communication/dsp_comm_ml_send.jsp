<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "list_id">
    <c:out value = "${param.list}" default = "0"/>
</c:set>

<sql:query var = "list">
    select list_name from mailinglists where list_id = ? and coordinator_id = ?

    <sql:param value = "${list_id}"/>

    <sql:param value = "${sessionScope.coord_id}"/>
</sql:query>

<c:if test = "${list.rowCount == 1}">
    <sql:query var = "members">
        select members.* from members, listmembers where members.member_id =
        listmembers.member_id and listmembers.member_status = 1 and
        listmembers.list_id = ? order by members.member_name

        <sql:param value = "${list_id}"/>
    </sql:query>

    <H3>

    <c:out value = "${list.rows[0].list_name}"/>

    :

    <fmt:message key = "808" /></H3>

    <form name = "send_form" method = "post"
          action = "index.jsp?fuseaction=comm_ml_dosend">
        <table width = "100%" border = "0" cellspacing = "0" cellpadding = "3">
            <tr>
                <td>
                    <FONT face = Arial size = -1 color = "FF0000"><b>*

                    <fmt:message key = "172"
                                  />:</b></font>
                </td>

                <td>
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">
                    <input type = "text" name = "from" maxlength = "128"
                    size = "30"> <input type = "hidden" name = "from_required"
                    value = "<fmt:message key="837"  />"> </font>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">

                    <fmt:message key = "838"
                                  />:</font>
                </td>

                <td>
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">
                    <input type = "text" name = "from_spc" maxlength = "128"
                           size = "30"> </font>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">

                    <fmt:message key = "42" />:</font>
                </td>

                <td>
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">
                    <input type = "text" name = "subj" maxlength = "128"
                           size = "40"> </font>
                </td>
            </tr>

            <tr>
                <td colspan = "2">
                    <FONT face = Arial size = -1 color = "FF0000"><b>*

                    <fmt:message key = "830" />:</b>

                    <br>
                    <textarea name = "mess_body" wrap = "VIRTUAL" cols = "50"
                              rows = "10">
                    </textarea>

                    <input type = "hidden"
                           name = "mess_body_required"
                           value = "<fmt:message key="482"  />"> </font>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">

                    <fmt:message key = "828"
                                  />:</font>
                </td>

                <td>
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">

                    <select name = "members" size = "5" multiple>
                        <c:forEach var = "row" items = "${members.rows}">
                            <option selected
                            value = "<c:out value="${row.member_id}" />"><c:out value = "${row.member_name} (${row.member_email})"/></option>
                        </c:forEach>
                    </select>

                    </font>
                </td>
            </tr>

            <tr align = "left">
                <td colspan = "2">
                    <font face = "Arial, Helvetica, sans-serif" size = "-1">
                    <input type = "checkbox" name = "send_to_all" value = "1"
                           checked>

                    <fmt:message key = "836" /></font>
                </td>
            </tr>

            <tr align = "center">
                <td colspan = "2">
                    <input type = "hidden" name = "list"
                    value = "<c:out value="${list_id}" />"> <input type = "submit"
                    name = "send_submit"
                    value = "<fmt:message key="808"  />">
                </td>
            </tr>
        </table>
    </form>
</c:if>
