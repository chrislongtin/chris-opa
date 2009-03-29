<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<h3>

<fmt:message key = "178" /></h3>

<!-------------- PROPONENT NOTIFICATIONS ---------------------->

<table width = "100%" border = "0" cellspacing = "0" cellpadding = "3">
    <c:if test = "${user == 'coordinator'}">
        <tr bgcolor = "EAEAEA">
            <td>
                <font face = "arial"><b>

                <fmt:message key = "485" />:
            </td>
        </tr>

        <sql:query var = "cfp_list">
            select cfp_code, cfp_title from cfp_info order by cfp_title
        </sql:query>

        <sql:query var = "list">
            select listname from initiative_setup
        </sql:query>

        <c:forEach var = "row" items = "${list.rows}">
            <c:set var = "listname" value = "${row.listname}"/>
        </c:forEach>

        <td>
            <font face = "arial" size = "-1">

            <ul>
                <c:if test = "${user == 'coordinator'}">
                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=comm_default_letters">

                    <fmt:message key = "182" /></a>

                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=dsp_send_letters">

                    <fmt:message key = "264" /></a>
                </c:if>

                <li><a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=comm_view_sent"
                       method = "post">

                <fmt:message key = "486" />
            </ul>
        </td>

        </tr>
    </c:if>

    <!--------------------- MAILING LISTS -------------------------->

    <sql:query var = "default_ml">
        select list_id, list_name from mailinglists where default_list = 1 and
        coordinator_id = ?

        <sql:param value = "${sessionScope.coord_id}"/>
    </sql:query>

    <tr bgcolor = "EAEAEA">
        <td>
            <font face = "arial"><b>

            <fmt:message key = "831" />:
        </td>
    </tr>

    <tr>
        <td>
            <font face = "arial" size = "-1">

            <ul>
                <li><a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=comm_ml">

                <fmt:message key = "800" /></a>

                <c:if test = "${!empty default_ml.rows[0].list_id}">
                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=comm_ml_send&list=<c:out value="${default_ml.rows[0].list_id}"/>">

                    <fmt:message key = "801" />

                    :

                    <c:out value = "${default_ml.rows[0].list_name}"/></a>
                </c:if>
            </ul>
        </td>
    </tr>

    <c:if test = "${user == 'coordinator'}">

        <!-------------------------- FAQ ------------------------------>

        <tr bgcolor = "EAEAEA">
            <td>
                <font face = "arial"><b>

                <fmt:message key = "15" />:
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <ul>
                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=comm_faq">

                    <fmt:message key = "489" /></a>
                </ul>
            </td>
        </tr>

        <tr bgcolor = "EAEAEA">
            <td>
                <font face = "arial"><b>

                <fmt:message key = "33" />:
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <ul>
                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=gen_doc_add">

                    <fmt:message key = "490" /></a>

                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=gen_doc_del">

                    <fmt:message key = "491" /></a>

                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=discuss_main">

                    <fmt:message key = "492" /></a>
                </ul>
            </td>
        </tr>
    </c:if>

    <tr>
        <td bgcolor = "EAEAEA">
            <font face = "arial"><b>

            <fmt:message key = "493" />:
        </td>
    </tr>

    <tr>
        <td>
            <font face = "arial" size = "-1">

            <ul>
                <li><a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=discuss_comment">

                <fmt:message key = "494" /></a>

                <li><a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=admin_gen_doc_add">

                <fmt:message key = "490" /></a>

                <c:if test = "${user == 'coordinator'}">
                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=admin_gen_doc_del">

                    <fmt:message key = "491" /></a>

                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=admin_discuss_main">

                    <fmt:message key = "492" /></a>
                </c:if>
            </ul>
        </td>
    </tr>
</table>
