<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<h3>

<cf:GetPhrase phrase_id = "178" lang_id = "${lang}"/></h3>

<!-------------- PROPONENT NOTIFICATIONS ---------------------->

<table width = "100%" border = "0" cellspacing = "0" cellpadding = "3">
    <c:if test = "${user == 'coordinator'}">
        <tr bgcolor = "EAEAEA">
            <td>
                <font face = "arial"><b>

                <cf:GetPhrase phrase_id = "485" lang_id = "${lang}"/>:
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
                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_default_letters">

                    <cf:GetPhrase phrase_id = "182" lang_id = "${lang}"/></a>

                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=dsp_send_letters">

                    <cf:GetPhrase phrase_id = "264" lang_id = "${lang}"/></a>
                </c:if>

                <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_view_sent" method = "post">

                <cf:GetPhrase phrase_id = "486" lang_id = "${lang}"/>
            </ul>
        </td>

        </tr>
    </c:if>

    <!--------------------- MAILING LISTS -------------------------->

    <sql:query var = "default_ml">
        select list_id, list_name from mailinglists where default_list = 1 and coordinator_id = ?

        <sql:param value = "${sessionScope.coord_id}"/>
    </sql:query>

    <tr bgcolor = "EAEAEA">
        <td>
            <font face = "arial"><b>

            <cf:GetPhrase phrase_id = "831" lang_id = "${lang}"/>:
        </td>
    </tr>

    <tr>
        <td>
            <font face = "arial" size = "-1">

            <ul>
                <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_ml">

                <cf:GetPhrase phrase_id = "800" lang_id = "${lang}"/></a>

                <c:if test = "${!empty default_ml.rows[0].list_id}">
                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_ml_send&list=<c:out value="${default_ml.rows[0].list_id}"/>">

                    <cf:GetPhrase phrase_id = "801" lang_id = "${lang}"/>

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

                <cf:GetPhrase phrase_id = "15" lang_id = "${lang}"/>:
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <ul>
                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_faq">

                    <cf:GetPhrase phrase_id = "489" lang_id = "${lang}"/></a>
                </ul>
            </td>
        </tr>

        <tr bgcolor = "EAEAEA">
            <td>
                <font face = "arial"><b>

                <cf:GetPhrase phrase_id = "33" lang_id = "${lang}"/>:
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <ul>
                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=gen_doc_add">

                    <cf:GetPhrase phrase_id = "490" lang_id = "${lang}"/></a>

                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=gen_doc_del">

                    <cf:GetPhrase phrase_id = "491" lang_id = "${lang}"/></a>

                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=discuss_main">

                    <cf:GetPhrase phrase_id = "492" lang_id = "${lang}"/></a>
                </ul>
            </td>
        </tr>
    </c:if>

    <tr>
        <td bgcolor = "EAEAEA">
            <font face = "arial"><b>

            <cf:GetPhrase phrase_id = "493" lang_id = "${lang}"/>:
        </td>
    </tr>

    <tr>
        <td>
            <font face = "arial" size = "-1">

            <ul>
                <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=discuss_comment">

                <cf:GetPhrase phrase_id = "494" lang_id = "${lang}"/></a>

                <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=admin_gen_doc_add">

                <cf:GetPhrase phrase_id = "490" lang_id = "${lang}"/></a>

                <c:if test = "${user == 'coordinator'}">
                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=admin_gen_doc_del">

                    <cf:GetPhrase phrase_id = "491" lang_id = "${lang}"/></a>

                    <li><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=admin_discuss_main">

                    <cf:GetPhrase phrase_id = "492" lang_id = "${lang}"/></a>
                </c:if>
            </ul>
        </td>
    </tr>
</table>
