<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- Display Funding Initiative Information --->

<sql:query var = "funding_initiative">
    select * from initiative_info where lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<c:forEach var = "row" items = "${funding_initiative.rows}">
    <c:set var = "lang_id" value = "${row.lang_id}"/>
</c:forEach>

<sql:query var = "funding_lang">
    select L.language, L.lang_id from initiative_info I, languages L where I.lang_id = L.lang_id
</sql:query>

<sql:query var = "funding_agencies">
    select * from funding_agencies order by agency_name
</sql:query>

<c:forEach var = "row" items = "${funding_initiative.rows}">
    <font size = "-1">

    <p>
    <h3>

    <c:out value = "${row.initiative_name}"/></h3>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "16" lang_id = "${lang}"/>:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.background}"/></menu>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "17" lang_id = "${lang}"/>:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.eligibility}"/></menu>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "18" lang_id = "${lang}"/>:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.review_process}"/></menu>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "19" lang_id = "${lang}"/>:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.copyright}"/></menu>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "20" lang_id = "${lang}"/>:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.proposal_format}"/></menu>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "21" lang_id = "${lang}"/>:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.about_submitting}"/></menu>

    <p>
    <b>

    <cf:GetPhrase phrase_id = "22" lang_id = "${lang}"/>:</b>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "197" lang_id = "${lang}"/>:</i>

    <c:out value = "${row.ia_name}"/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "200" lang_id = "${lang}"/>:</i>

    <c:out value = "${row.ia_contact}"/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</i>

    <c:out value = "${row.ia_address}"/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "26" lang_id = "${lang}"/>:</i>

    <c:out value = "${row.ia_courier}"/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</i>

    <c:out value = "${row.ia_phone}"/> - Fax:

    <c:out value = "${row.ia_fax}"/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</i> <a STYLE="text-decoration: underline"  href = "mailto:<c:out value='${row.ia_email}'/>">

    <c:out value = "${row.ia_email}"/></a>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "27" lang_id = "${lang}"/>:</i>

    <c:out value = "${row.ia_courier_inst}"/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:</i> <a STYLE="text-decoration: underline"  href = "<c:out value='${row.ia_url}'/>">

    <c:out value = "${row.ia_url}"/></a></font>

    <c:if test = "${user == 'coordinator'}">
        <p>
        <b>

        <cf:GetPhrase phrase_id = "201" lang_id = "${lang}"/>:</b>

        <c:out value = '${row.admin_image_title}'/>

        <p>
        <b>

        <cf:GetPhrase phrase_id = "202" lang_id = "${lang}"/>:</b>

        <c:out value = '${row.public_image_title}'/>
    </c:if>
</c:forEach>

<c:if test = "${user == 'coordinator'}">
    <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_funding'/>
<c:param name='act' value='edit'/>
<c:param name='${user}'/>
</c:url>"
          method = "post">
        <h3>

        <cf:GetPhrase phrase_id = "204" lang_id = "${lang}"/>:</h3>

        <select name = "lang_id">
            <c:forEach var = "row" items = "${funding_lang.rows}">
                <option value = "<c:out value='${row.lang_id}'/>"><c:out value = '${row.language}'/>
            </c:forEach>
        </select>

        <input type = "submit" value = " Select ">
    </form>
</c:if>

<a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_funding'/>
<c:param name='act' value='add'/>
<c:param name='${user}'/>
</c:url>"><h3>

<cf:GetPhrase phrase_id = "340" lang_id = "${lang}"/></h3></a>

<p>
<h4>

<cf:GetPhrase phrase_id = "30" lang_id = "${lang}"/>:</h4><c:forEach var = "row" items = "${funding_agencies.rows}">
    <font size = "-1">

    <p>
    <i>

    <cf:GetPhrase phrase_id = "197" lang_id = "${lang}"/>:</i>

    <c:out value = '${row.agency_name}'/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "23" lang_id = "${lang}"/>:</i>

    <c:out value = '${row.agency_contact}'/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</i> <a STYLE="text-decoration: underline"  href = "mailto:<c:out value='${row.agency_email}'/>">

    <c:out value = '${row.agency_email}'/></a>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</i>

    <c:out value = '${row.agency_phone}'/>

    <br>
    <i>

    <cf:GetPhrase phrase_id = "64" lang_id = "${lang}"/>:</i> <a STYLE="text-decoration: underline"  href = "<c:out value='${row.agency_url}'/>">

    <c:out value = '${row.agency_url}'/></a><c:if test = "${user == 'coordinator'}">
        <br>
        <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_agencies'/>
<c:param name='act' value='edit'/>
<c:param name='agency_id' value='${row.agency_id}'/>
<c:param name='${user}'/>
</c:url>">

        <cf:GetPhrase phrase_id = "196" lang_id = "${lang}"/></a>
    </c:if>

    </font>
</c:forEach>

<c:if test = "${user == 'coordinator'}">
    <p>
    <h4><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_agencies'/>
<c:param name='act' value='add'/>
<c:param name='${user}'/>
</c:url>">

    <cf:GetPhrase phrase_id = "199" lang_id = "${lang}"/></a></h4>
</c:if>
