<%@ page errorPage = "dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "act_session_check.jsp"%>

<!--- check to see if the user is a contractor, and if so see if s/he is restricted to a specific subcategory, and if s/he is a contractor organizer --->

<c:set var = "selection">
    <c:out value = "${param.selection}" default = ""/>
</c:set>

<c:set var = "displayType">
    <c:out value = "${param.displayType}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${displayType == 'pdf'}">
        <c:set var = "REPORT_PGM" value = "pdfReportsDisplay.jsp" scope = "page"/>
    </c:when>

    <c:when test = "${displayType == 'html'}">
        <c:set var = "REPORT_PGM" value = "htmlReportsDisplay.jsp" scope = "page"/>
    </c:when>

    <c:when test = "${displayType == 'xls'}">
        <c:set var = "REPORT_PGM" value = "xlsReportsDisplay.jsp" scope = "page"/>
    </c:when>

    <c:when test = "${displayType == 'csv'}">
        <c:set var = "REPORT_PGM" value = "csvReportsDisplay.jsp" scope = "page"/>
    </c:when>

    <c:when test = "${displayType == 'xml'}">
        <c:set var = "REPORT_PGM" value = "xmlReportsDisplay.jsp" scope = "page"/>
    </c:when>
</c:choose>

<!--- OPA admin header --->
<sql:query var = "setup">
    select host_url from initiative_setup
</sql:query>

<c:set var = "REPORT_DIRECTORY" value = "${setup.rows[0].host_url}" scope = "session"/>

<c:set var = "REPORT_PROG" value = "${sessionScope.REPORT_DIRECTORY}${REPORT_PGM}" scope = "page"/>

<c:redirect url = '${REPORT_PROG}'>
    <c:param name = "selection" value = "${selection}"/>
</c:redirect>
