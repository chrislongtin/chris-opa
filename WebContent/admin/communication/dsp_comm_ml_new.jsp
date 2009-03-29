<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "members">
    select distinct members.* from members, listmembers, mailinglists where
    members.member_id = listmembers.member_id and listmembers.list_id =
    mailinglists.list_id and mailinglists.coordinator_id = ? order by
    members.member_name

    <sql:param value = "${sessionScope.coord_id}"/>
</sql:query>

<h3>

<fmt:message key = "802" /></h3>

<form name = "new_ml" method = "post"
      action = "index.jsp?fuseaction=comm_ml_donew">
    <table width = "100%" border = "0" cellspacing = "0" cellpadding = "10">
        <tr>
            <td>
                <FONT face = Arial size = -1><font color = "FF0000"><b>*

                <fmt:message key = "810"
                              />:</b></font></font>
            </td>

            <td>
                <input type = "text" name = "list_name" size = "20"
                maxlength = "20" value = "">
                <input type = "hidden" name = "list_name_required"
                value = "<fmt:message key="832"  />">
            </td>
        </tr>

        <tr>
            <td>
                <FONT face = Arial size = -1>

                <fmt:message key = "811" />:</font>
            </td>

            <td>
                <textarea name = "list_descr" wrap = "VIRTUAL" cols = "40"
                          rows = "3">
                </textarea>
            </td>
        </tr>

        <tr>
            <td>
                <FONT face = Arial size = -1>

                <fmt:message key = "812" />:</font>
            </td>

            <td>
                <textarea name = "list_topic" wrap = "VIRTUAL" cols = "40"
                          rows = "5">
                </textarea>
            </td>
        </tr>

        <c:if test = "${!empty members.rows[0]}">
            <tr>
                <td colspan = "2">
                    <FONT face = Arial size = -1>

                    <fmt:message key = "813" />

                    , (

                    <fmt:message key = "814" />

                    ):

                    <br>
                    <br>
                    <select name = "members" size = "5" multiple>
                        <c:forEach var = "row" items = "${members.rows}">
                            <option value = "<c:out value="${row.member_id}" />"><c:out value = "${row.member_name} (${row.member_email})"/>
                        </c:forEach>
                    </select>

                    </font>
                </td>
            </tr>
        </c:if>

        <tr>
            <td colspan = "2">
                <FONT face = Arial size = -1>
                <input type = "checkbox" name = "default" checked value = "1">

                <fmt:message key = "807" /></font>
            </td>
        </tr>

        <tr align = "center">
            <td colspan = "2">
                <input type = "hidden" name = "act" value = "donew">
                <input type = "submit"
                       name = "submit_new"
                       value = "<fmt:message key="815"  />">
            </td>
        </tr>
    </table>
</form>
