<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>
<!--- archive main page --->

<!--- retrieving cfp info --->
<sql:query var = "cfp_name">
    select cfp_code, cfp_title from cfp_info order by cfp_title
</sql:query>

<!--- determine amount of info to be shown --->
<sql:query var = "info_shown">
    select public_info, public_info_degree from initiative_setup
</sql:query>

<c:set var = "public_info" value = "${info_shown.rows[0].public_info}"
       scope = "page"/>

<c:set var = "public_info_degree"
       value = "${info_shown.rows[0].public_info_degree}"
       scope = "page"/>

<h2>

<fmt:message key = "14" /></h2>

**

<fmt:message key = "51" />

<br>
**

<fmt:message key = "52" />

<br>
**

<fmt:message key = "53" />

<p>
<table border = "0" cellspacing = "0" cellpadding = "3">
    <c:forEach items = "${cfp_name.rows}" var = "row">

        <!--- output cfp information --->
        <tr bgcolor = "CFCFCF">
            <td colspan = "2">
                <font face = "Arial"><b><a STYLE = "text-decoration: underline"
                                           href = "index.jsp?fuseaction=cfp_info&cfp_code=<c:out value="${row.cfp_code}" />&lang=<c:out value="${lang}" />">CFP-

                <c:out value = "${row.cfp_code}"/>

                <c:out value = "${row.cfp_title}"/></a></b>
            </td>
        </tr>

        <!--- retrieve proponent info related to each cfp --->
        <sql:query var = "proponent_info">
            select distinct d.tracking_code, p.proponent_institution,
            p.proponent_leader_firstname, p.proponent_leader_lastname from
            documents d, proponent_record p where p.cfp_code = ? and
            d.tracking_code = p.tracking_code

            <sql:param value = "${row.cfp_code}"/>

            <c:if test = "${public_info=='accepted'}">
                and p.status_id = 5
            </c:if>
        </sql:query>

        <c:choose>
            <c:when test = "${empty proponent_info.rows[0].tracking_code}">
                <tr>
                    <td colspan = "2">
                        <font face = "Arial" size = "-1">

                        <center>
                            <fmt:message key = "54" />

                            .
                        </center>
                    </td>
                </tr>
            </c:when>

            <c:otherwise>

                <!--- output proponent information  --->
                <c:forEach items = "${proponent_info.rows}" var = "prow">
                    <tr>
                        <td colspan = "2">
                            <font face = "Arial" size = "-1">

                            <p>
                            <br>
                            <b>

                            <!--- if amount of info shown to public is limited, do not include link to full proponent info --->
                            <c:choose>
                                <c:when test = "${public_info_degree=='complete'}">
                                    <a STYLE = "text-decoration: underline"
                                       href = "index.jsp?fuseaction=archive_proposal&tracking_code=<c:out value="${prow.tracking_code}" />&lang=<c:out value="${lang}" />">

                                    <c:out value = "${prow.proponent_leader_firstname}"/>

                                    <c:out value = "${prow.proponent_leader_lastname}"/></a>
                                </c:when>

                                <c:otherwise>
                                    <c:if test = "${public_info_degree=='limited'}">
                                        <c:out value = "${prow.proponent_leader_firstname}"/>

                                        <c:out value = "${prow.proponent_leader_lastname}"/>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>

                            <c:if test = "${prow.proponent_institution!=''}">
                                <br>
                                <i>

                                <c:out value = "${prow.proponent_institution}"/></i>
                            </c:if>
                        </td>
                    </tr>

                    <c:set var = "tracking_code" value = "${prow.tracking_code}"
                           scope = "page"/>

                    <!--- retrieve document list for each proponent --->
                    <sql:query var = "documents">
                        select doc_title, doc_id, doc_filename from documents
                        where tracking_code = ? order by doc_title

                        <sql:param value = "${tracking_code}"/>
                    </sql:query>

                    <c:forEach items = "${documents.rows}" var = "drow">
                        <tr>
                            <td>
                                <li><font face = "Arial" size = "-1">

                                <!--- if public has access to all public info include link to view documents --->
                                <c:choose>
                                    <c:when test = "${public_info_degree=='complete'}">
                                        <c:if test = "${drow.doc_filename!=''}">
                                            <a STYLE = "text-decoration: underline"
                                               href = "docs/<c:out value="${drow.doc_filename}" />?ois=no">
                                        </c:if>

                                        <c:out value = "${drow.doc_title}"/>

                                        <c:if test = "${drow.doc_filename!=''}">

                                            </a>
                                        </c:if>
                                    </c:when>

                                    <c:otherwise>
                                        <c:if test = "${public_info_degree=='limited'}">
                                            <c:out value = "${drow.doc_title}"/>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td valign = "TOP">
                                <font face = "Arial" size = "-1">

                                <!--- if public has access to all pubic info include link to discussion --->
                                <c:choose>
                                    <c:when test = "${public_info_degree=='complete'}">
                                        <a STYLE = "text-decoration: underline"
                                           href = "index.jsp?fuseaction=archive_comment&doc_id=<c:out value="${drow.doc_id}" />&lang=<c:out value="${lang}" />">

                                        <fmt:message key = "55"
                                                      /></a>
                                    </c:when>

                                    <c:otherwise>
                                        &nbsp;
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:forEach>

                <tr>
                    <td colspan = "2">
                        &nbsp;
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</table>
