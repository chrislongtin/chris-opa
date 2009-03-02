<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "orgtypes">
    select * from organization_types where lang_id = ? order by
    organization_type_id

    <sql:param value = "${sessionScope.lang}"/>
</sql:query>

<sql:query var = "last_seq">
    select max(organization_type_id)+1 as next_orgtype_no from
    organization_types
</sql:query>

<c:set var = "next_no" value = "${last_seq.rows[0].next_orgtype_no}"/>

<h3>

<cf:GetPhrase phrase_id = "1126" lang_id = "${lang}"/></h3>

<%-- <c:choose>
    <c:when test = "${orgtypes.rowCount == 0}">
        <cf:GetPhrase phrase_id = "1127" lang_id = "${lang}"/>
    <!--- copy from existing chapter --->                               
        [ <font size = "-1"><a href = "index.jsp?fuseaction=dsp_copy_organization_types">
        <cf:GetPhrase phrase_id = "1046" lang_id = "${lang}"/></a></font> ]
    </c:when>

    <c:otherwise>
        <a href = "#add">

        <cf:GetPhrase phrase_id = "1120" lang_id = "${lang}"/></a>
    </c:otherwise>
</c:choose>
 --%>
<a href = "#add">

<cf:GetPhrase phrase_id = "1120" lang_id = "${lang}"/></a>

<p>
<table>
    <c:forEach var = "row" items = "${orgtypes.rows}">
        <tr>
            <td valign = "top" align = "right">
                <c:out value = '${row.organization_type_id}'/>
            </td>

            <td valign = "top">
                <c:out value = '${row.organization_type_name}'/>
            </td>

            <td valign = "top">
                <a href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_organization_type'/>
<c:param name='organization_type_id' value='${row.organization_type_id}'/>
<c:param name='act' value='Delete'/>
<c:param name='${user}'/>
</c:url>">

                <cf:GetPhrase phrase_id = "143" lang_id = "${lang}"/></a>
                <a href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='dsp_edit_organization_type'/>
<c:param name='organization_type_id' value='${row.organization_type_id}'/>
<c:param name='act' value='Edit'/>
<c:param name='${user}'/>
</c:url>">

                <cf:GetPhrase phrase_id = "144" lang_id = "${lang}"/></a>
            </td>
        </tr>
    </c:forEach>
</table>

<a name = "add"> <h4>

<cf:GetPhrase phrase_id = "1120" lang_id = "${lang}"/>:</h4>

<form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_organization_type'/>
<c:param name='${user}'/>
</c:url>"
      method = "post">
    <input type = "hidden" name = "act" value = "Add"> <input type = "hidden"
           name = "organization_type_id_required"
           value = "<cf:GetPhrase phrase_id='1121' lang_id='${lang}'/>">
    <input type = "hidden" name = "organization_type_name_required"
           value = "<cf:GetPhrase phrase_id='1122' lang_id='${lang}'/>"> <b>

    <cf:GetPhrase phrase_id = "1123" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "organization_type_id" length = "4"
           value = " <c:out value="${next_no}" />">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "1124" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "organization_type_name" length = "30">

    <p>
    <input type = "submit"
           value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
