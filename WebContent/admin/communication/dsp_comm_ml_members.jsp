<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "list_id">
    <c:out value = "${param.list}" default = ""/>
</c:set>

<sql:query var = "list">
    select list_name from mailinglists where list_id = ? and coordinator_id = ?

    <sql:param value = "${list_id}"/>

    <sql:param value = "${sessionScope.coord_id}"/>
</sql:query>

<c:if test = "${list.rowCount == 1}">
    <sql:query var = "members">
        select members.*, listmembers.member_status from members, listmembers
        where members.member_id = listmembers.member_id and
        listmembers.list_id = ? order by members.member_name

        <sql:param value = "${list_id}"/>
    </sql:query>

    <c:set var = "wexp" value = ""/>

    <H3>

    <c:out value = "${list.rows[0].list_name}"/>

    -

    <fmt:message key = "806" /></H3>

    <c:if test = "${members.rowCount > 0}">
        <h4>

        <fmt:message key = "819" /></h4>

        <c:forEach var = "row" items = "${members.rows}">
            <c:if test = "${!empty wexp}">
                <c:set var = "wexp">
                    <c:out value = "${wexp}, ${row.member_id}"/>
                </c:set>
            </c:if>

            <c:if test = "${empty wexp}">
                <c:set var = "wexp">
                    <c:out value = "${row.member_id}"/>
                </c:set>
            </c:if>

            <form name = "edit_member" method = "post"
                  action = "index.jsp?fuseaction=comm_ml_editmembers">
                <hr noshade size = "1" color = "#DDDDDD">
                <table width = "100%" border = "0" cellspacing = "0"
                       cellpadding = "3">
                    <tr>
                        <td>
                            <font face = "Arial, Helvetica, sans-serif"
                                  size = "-1">

                            <fmt:message key = "66"
                                          />:</font>
                        </td>

                        <td>
                            <input type = "text"
                                   maxlength = "128"
                                   name = "member_name"
                                   value = "<c:out value="${row.member_name}" />">
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <FONT face = Arial size = -1 color = "FF0000"><b>*

                            <fmt:message key = "24"
                                          />:</b></font>
                        </td>

                        <td>
                            <input type = "text" maxlength = "128"
                            name = "member_email"
                            value = "<c:out value="${row.member_email}" />"> <input type = "hidden"
                            name = "member_email_required"
                            value = "<fmt:message key="702"  />">
                        </td>
                    </tr>

                    <tr>
                        <td colspan = "2">
                            <font face = "Arial, Helvetica, sans-serif" font
                            size = "-1">
                            <input type = "checkbox" name = "active" value = "1"
                            <c:if test = "${row.member_status == 1}">

                            <c:out value = " checked "/>
        </c:if>

        >

        <fmt:message key = "820" />

        </font>

        </td>

        </tr>

        <tr>
            <td colspan = "2">
                <font face = "Arial, Helvetica, sans-serif" size = "-1">
                <input type = "hidden" name = "list"
                value = "<c:out value="${list_id}" />"> <input type = "hidden"
                name = "act" value = "edit">
                <input type = "hidden" name = "member"
                value = "<c:out value="${row.member_id}" />"> <input type = "submit"
                name = "save_changes"
                value = "<fmt:message key="817"  />">

                <br>
                <br>
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml_editmembers&act=delfromlist&member=<c:out value="${row.member_id}" />&list=<c:out value="${list_id}" />">

                <fmt:message key = "821" /></a>

                <br>
                <br>
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml_editmembers&act=del&member=<c:out value="${row.member_id}" />&list=<c:out value="${list_id}" />">

                <fmt:message key = "822" /></a> (

                <fmt:message key = "823" />) </font>
            </td>
        </tr>

        </table>

        </form>

        </c:forEach>

        <hr noshade size = "1">
    </c:if>

    <h4>

    <fmt:message key = "833" /></h4>

    <sql:query var = "other_members">
        select distinct members.* from members, listmembers, mailinglists
        where members.member_id = listmembers.member_id and
        listmembers.list_id = mailinglists.list_id and
        mailinglists.coordinator_id = ?

        <c:if test = "${!empty wexp}">
            and members.member_id not in (

            <c:out value = "${wexp}"/>

            )
        </c:if>

        <sql:param value = "${sessionScope.coord_id}"/>
    </sql:query>

    <c:if test = "${other_members.rowCount > 0}">
        <ul>
            <li><font face = Arial size = -1>

            <fmt:message key = "813" />

            , (

            <fmt:message key = "814" />) </font>

            <form name = "add_emembers" method = "post"
                  action = "index.jsp?fuseaction=comm_ml_editmembers">
                <font face = Arial size = -1>

                <select name = "members" size = "5" multiple>
                    <c:forEach var = "row" items = "${other_members.rows}">
                        <option value = "<c:out value="${row.member_id}" />">
                        <c:out value = "${row.member_name} (${row.member_email})"/>
                    </c:forEach>
                </select>

                </font> <input type = "hidden" name = "act" value = "add">
                <input type = "hidden" name = "active" value = "1">
                <input type = "hidden" name = "list"
                value = "<c:out value="${list_id}" />"> <input type = "submit"
                name = "add_members"
                value = "<fmt:message key="824"  />">
            </form>

            </li>
        </ul>
    </c:if>

    <br>
    <ul>
        <li><font face = "Arial, Helvetica, sans-serif" size = "-1">

        <fmt:message key = "825" /></font>

        <form name = "create_member" method = "post"
              action = "index.jsp?fuseaction=comm_ml_editmembers">
            <font face = "Arial, Helvetica, sans-serif" size = "-1">

            <fmt:message key = "66" />:
            <input type = "text" name = "member_name" maxlength = "128">

            <br>
            <FONT face = Arial size = -1 color = "FF0000"><b>*

            <fmt:message key = "24" />:</b></font>
            <input type = "text" name = "member_email" maxlength = "128">
            <input type = "hidden" name = "member_email_required"
                   value = "<fmt:message key="702"  />">

            <br>
            <input type = "checkbox" name = "active" value = "1" checked>

            <fmt:message key = "820" /> </font>

            <br>
            <input type = "hidden" name = "act" value = "create">
            <input type = "hidden" name = "list"
            value = "<c:out value="${list_id}" />">
            <input type = "submit" name = "create_member"
            value = "<fmt:message key="825"  />">
        </form>

        </li>
    </ul>

    </c:if>
