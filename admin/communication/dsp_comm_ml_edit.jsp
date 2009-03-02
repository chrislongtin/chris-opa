<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
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

                <cf:GetPhrase phrase_id = "816" lang_id = "${lang}"/></h3>

                <form name = "edit_ml" method = "post"
                      action = "index.jsp?fuseaction=comm_ml_doedit">
                    <table width = "100%" border = "0" cellspacing = "0"
                           cellpadding = "10">
                        <tr>
                            <td>
                                <FONT face = Arial
                                      size = -1><font color = "FF0000"><b>*

                                <cf:GetPhrase phrase_id = "810"
                                              lang_id = "${lang}"/>:</b></font></font>
                            </td>

                            <td>
                                <input type = "text" name = "list_name"
                                size = "20" maxlength = "20"
                                value = "<c:out value="${list.rows[0].list_name}" />">
                                <input type = "hidden"
                                name = "list_name_required"
                                value = "<cf:GetPhrase phrase_id="832" lang_id="${lang}" />">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <FONT face = Arial size = -1>

                                <cf:GetPhrase phrase_id = "811"
                                              lang_id = "${lang}"/>:</font>
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

                                <cf:GetPhrase phrase_id = "812"
                                              lang_id = "${lang}"/>:</font>
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

            <cf:GetPhrase phrase_id = "807" lang_id = "${lang}"/>

            </font>

            </td>

            </tr>

            <tr align = "center">
                <td colspan = "2">
                    <input type = "hidden" name = "act" value = "doedit">
                    <input type = "hidden" name = "list"
                    value = "<c:out value="${list_id}" />"> <input type = "submit"
                    name = "submit_edit"
                    value = "<cf:GetPhrase phrase_id="817" lang_id="${lang}" />">
                </td>
            </tr>

            </table>

            </form>

            </c:when>

            <c:when test = "${act=='del'}">
                <p>
                <cf:GetPhrase phrase_id = "818" lang_id = "${lang}"/> - <b>

                <c:out value = "${list.rows[0].list_name}"/></b>?

                <p>
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml_doedit&act=del&list=<c:out value="${list_id}" />">[

                <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml">[

                <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/> ]</a>
            </c:when>

            <c:when test = "${act=='default'}">
                <p>
                <cf:GetPhrase phrase_id = "826" lang_id = "${lang}"/> - <b>

                <c:out value = "${list.rows[0].list_name}"/></b>?

                <p>
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml_doedit&act=default&list=<c:out value="${list_id}" />">[

                <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/>
                ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a STYLE = "text-decoration: underline"
                   href = "index.jsp?fuseaction=comm_ml">[

                <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/> ]</a>
            </c:when>

            </c:choose>
        </c:if>

        </c:if>
