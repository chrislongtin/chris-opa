<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
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
    select L.language, L.lang_id from initiative_info I, languages L where
    I.lang_id = L.lang_id
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

    <fmt:message key = "16" />:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.background}"/></menu>

    <p>
    <b>

    <fmt:message key = "17" />:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.eligibility}"/></menu>

    <p>
    <b>

    <fmt:message key = "18" />:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.review_process}"/></menu>

    <p>
    <b>

    <fmt:message key = "19" />:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.copyright}"/></menu>

    <p>
    <b>

    <fmt:message key = "20" />:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.proposal_format}"/></menu>

    <p>
    <b>

    <fmt:message key = "21" />:</b>

    <br>
    <menu><cf:ParagraphFormat value = "${row.about_submitting}"/></menu>

    <p>
    <b>

    <fmt:message key = "22" />:</b>

    <br>
    <i>

    <fmt:message key = "197" />:</i>

    <c:out value = "${row.ia_name}"/>

    <br>
    <i>

    <fmt:message key = "200" />:</i>

    <c:out value = "${row.ia_contact}"/>

    <br>
    <i>

    <fmt:message key = "61" />:</i>

    <c:out value = "${row.ia_address}"/>

    <br>
    <i>

    <fmt:message key = "26" />:</i>

    <c:out value = "${row.ia_courier}"/>

    <br>
    <i>

    <fmt:message key = "62" />:</i>

    <c:out value = "${row.ia_phone}"/> - Fax:

    <c:out value = "${row.ia_fax}"/>

    <br>
    <i>

    <fmt:message key = "24" />:</i>
    <a STYLE = "text-decoration: underline"
       href = "mailto:<c:out value='${row.ia_email}'/>">

    <c:out value = "${row.ia_email}"/></a>

    <br>
    <i>

    <fmt:message key = "27" />:</i>

    <c:out value = "${row.ia_courier_inst}"/>

    <br>
    <i>

    <fmt:message key = "64" />:</i>
    <a STYLE = "text-decoration: underline"
       href = "<c:out value='${row.ia_url}'/>">

    <c:out value = "${row.ia_url}"/></a></font>

    <c:if test = "${user == 'coordinator'}">
        <p>
        <b>

        <fmt:message key = "201" />:</b>

        <c:out value = '${row.admin_image_title}'/>

        <p>
        <b>

        <fmt:message key = "202" />:</b>

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

        <fmt:message key = "204" />:</h3>

        <select name = "lang_id">
            <c:forEach var = "row" items = "${funding_lang.rows}">
                <option value = "<c:out value='${row.lang_id}'/>">
                <c:out value = '${row.language}'/>
            </c:forEach>
        </select>

        <input type = "submit" value = " Select ">
    </form>
</c:if>

<a STYLE = "text-decoration: underline"
   href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_funding'/>
<c:param name='act' value='add'/>
<c:param name='${user}'/>
</c:url>"><h3>

<fmt:message key = "340" /></h3></a>

<p>
<h4>

<fmt:message key = "30" />:</h4>
<c:forEach var = "row" items = "${funding_agencies.rows}">
    <font size = "-1">

    <p>
    <i>

    <fmt:message key = "197" />:</i>

    <c:out value = '${row.agency_name}'/>

    <br>
    <i>

    <fmt:message key = "23" />:</i>

    <c:out value = '${row.agency_contact}'/>

    <br>
    <i>

    <fmt:message key = "24" />:</i>
    <a STYLE = "text-decoration: underline"
       href = "mailto:<c:out value='${row.agency_email}'/>">

    <c:out value = '${row.agency_email}'/></a>

    <br>
    <i>

    <fmt:message key = "62" />:</i>

    <c:out value = '${row.agency_phone}'/>

    <br>
    <i>

    <fmt:message key = "64" />:</i>
    <a STYLE = "text-decoration: underline"
       href = "<c:out value='${row.agency_url}'/>">

    <c:out value = '${row.agency_url}'/></a>
    <c:if test = "${user == 'coordinator'}">
        <br>
        <a STYLE = "text-decoration: underline"
           href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_agencies'/>
<c:param name='act' value='edit'/>
<c:param name='agency_id' value='${row.agency_id}'/>
<c:param name='${user}'/>
</c:url>">

        <fmt:message key = "196" /></a>
    </c:if>

    </font>
</c:forEach>

<c:if test = "${user == 'coordinator'}">
    <p>
    <h4><a STYLE = "text-decoration: underline"
           href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='modify_agencies'/>
<c:param name='act' value='add'/>
<c:param name='${user}'/>
</c:url>">

    <fmt:message key = "199" /></a></h4>
</c:if>
