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

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:if test = "${!empty list_id}">
    <sql:query var = "list">
        select * from mailinglists where list_id = ? and coordinator_id = ?

        <sql:param value = "${list_id}"/>

        <sql:param value = "${sessionScope.coord_id}"/>
    </sql:query>

    <c:if test = "${list.rowCount == 1}">
        <c:choose>
            <c:when test = "${act=='edit'}">
                <h3>

                <fmt:message key = "816" /></h3>

                <form name = "edit_ml" method = "post"
                      action = "index.jsp?fuseaction=comm_ml_doedit">
                    <table width = "100%" border = "0" cellspacing = "0"
                           cellpadding = "10">
                        <tr>
                            <td>
                                <FONT face = Arial
                                      size = -1><font color = "FF0000"><b>*

                                <fmt:message key = "810"
                                              />:</b></font></font>
                            </td>

                            <td>
                                <input type = "text" name = "list_name"
                                size = "20" maxlength = "20"
                                value = "<c:out value="${list.rows[0].list_name}" />">
                                <input type = "hidden"
                                name = "list_name_required"
                                value = "<fmt:message key="832"  />">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <FONT face = Arial size = -1>

                                <fmt:message key = "811"
                                              />:</font>
                            </td>

                            <td>
                                <textarea name = "list_descr" wrap = "VIRTUAL"
                                          cols = "40"         rows = "3">
                                    <c:out value = "${list.rows[0].list_descr}"/>
                                </textarea>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <FONT face = Arial size = -1>

                                <fmt:message key = "812"
                                              />:</font>
                            </td>

                            <td>
                                <textarea name = "list_topic" wrap = "VIRTUAL"
                                          cols = "40"         rows = "5">
                                    <c:out value = "${list.rows[0].list_topic}"/>
                                </textarea>
                            </td>
                        </tr>

                        <tr>
                            <td colspan = "2">
                                <FONT face = Arial size = -1>
                                <input type = "checkbox"
                                       name = "default"
                                       <c:if
                                       test = "${list.rows[0].default_list == 1}">

                                <c:out value = " checked "/>
            </c:if>

            value="1">

            <fmt:message key = "807" />

            </font>

            </td>

            </tr>

            <tr align = "center">
                <td colspan = "2">
                    <input type = "hidden" name = "act" value = "doedit">
                    <input type = "hidden" name = "list"
                    value = "<c:out value="${list_id}" />"> <input type = "submit"
                    name = "submit_edit"
                    value = "<fmt:message key="817"  />">
                </td>
            </tr>

            </table>

            </form>

            </c:when>

            <c:when test = "${act=='del'}">
                <p>
                <fmt:message key = "818" /> - <b>

                <c:out value = "${list.rows[0].list_name}"/></b>?

                <p>
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml_doedit&act=del&list=<c:out value="${list_id}" />">[

                <fmt:message key = "542" />
                ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml">[

                <fmt:message key = "543" /> ]</a>
            </c:when>

            <c:when test = "${act=='default'}">
                <p>
                <fmt:message key = "826" /> - <b>

                <c:out value = "${list.rows[0].list_name}"/></b>?

                <p>
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml_doedit&act=default&list=<c:out value="${list_id}" />">[

                <fmt:message key = "542" />
                ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml">[

                <fmt:message key = "543" /> ]</a>
            </c:when>

            </c:choose>
        </c:if>

        </c:if>
