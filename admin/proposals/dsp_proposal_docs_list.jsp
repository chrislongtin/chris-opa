<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = ""/>
</c:set>

<!--- show the proponent the full proposal record --->

<sql:query var = "proposal_info">
    select p.*, c.cfp_title from proponent_record p, cfp_info c where
    p.tracking_code = ? and p.cfp_code = c.cfp_code

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "pi" value = "${proposal_info.rows[0]}" scope = "page"/>

<sql:query var = "proposal_docs">
    select d.*, dt.doc_type_name from documents d, document_types dt where
    d.tracking_code = ? and d.doc_type_id = dt.doc_type_id

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "source">
    <c:out value = "${param.source}" default = "proposal_list"/>
</c:set>

<c:choose>
    <c:when test = "${(source=='proposal_list') and (sessionScope.user=='coordinator')}">
        <p>
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=proposal_list&cfp_code=<c:out value="${cfp_code}" />">

        <cf:GetPhrase phrase_id = "610" lang_id = "${lang}"/></a>
    </c:when>

    <c:when test = "${source=='review'}">
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=proposal_review&tracking_code=<c:out value="${tracking_code}" />">

        <cf:GetPhrase phrase_id = "611" lang_id = "${lang}"/></a>
    </c:when>

    <c:when test = "${source=='review_edit'}">
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=proposal_edit_review&tracking_code=<c:out value="${tracking_code}" />">

        <cf:GetPhrase phrase_id = "611" lang_id = "${lang}"/></a>
    </c:when>
</c:choose>

<p>
<h3>

<c:out value = "${pi.proposal_title}"/></h3> <b>

<cf:GetPhrase phrase_id = "586" lang_id = "${lang}"/>:</b>

<c:out value = "${pi.cfp_title}"/>

<br>
<b>

<cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:</b>

<c:out value = "${tracking_code}"/>

<p>
<table width = "100%" border = "0" cellspacing = "0" cellpadding = "2">
    <tr bgcolor = "CFCFCF">
        <td colspan = "3">
            <font face = "arial" size = "-1"><b>

            <cf:GetPhrase phrase_id = "595" lang_id = "${lang}"/>:</b>
        </td>
    </tr>

    <tr>
        <td colspan = "3">
            &nbsp;
        </td>
    </tr>

    <c:forEach items = "${proposal_docs.rows}" var = "row">
        <tr bgcolor = "E9E9E9">
            <td colspan = "3">
                <font face = "arial" size = "-1"><b>

                <c:out value = "${row.doc_title}"/></b>

                <br>
                <font face = "arial" size = "-2">

                <fmt:formatDate value = "${row.doc_date}"
                                pattern = "MMM dd, yyyy"/>

                <br>
                <c:out value = "${row.doc_type_name}"/></font>
            </td>
        </tr>

        <tr>
            <td colspan = "3">
                <font face = "arial" size = "-1">
                <c:if test = "${!empty row.doc_filename}">
                    <a STYLE = "text-decoration: underline"
                       href = "../docs/<c:out value="${row.doc_filename}" />?ois=no"
                       target = "new">

                    <c:out value = "${row.doc_filename}"/></a>
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
