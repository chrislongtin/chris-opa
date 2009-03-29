<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${param.lang}" scope = "page"/>

<!--- make sure that the user has logged in --->
<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:if test = "${tracking_code==''}">
    <p>
    <br>
    <div align = "center">
        <b>

        <fmt:message key = "770" />

        <p>
        <a STYLE = "text-decoration: underline"
           href = "index.jsp?fuseaction=report_edit">

        <fmt:message key = "733" /></a>

        <fmt:message key = "734" /></b>
    </div>

    <%
    if (true)
        return;
    %>
</c:if>

<!--- show the proponent the full proposal record --->
<c:set var = "proponent_password">
    <c:out value = "${param.proponent_password}" default = ""/>
</c:set>

<!--- check that password is correct --->
<sql:query var = "password_check">
    select tracking_code, cfp_code from proponent_record where
    proponent_password = ? and tracking_code = ?

    <sql:param value = "${proponent_password}"/>

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:if test = "${empty password_check.rows[0].tracking_code}">
    <p>
    <br>
    <b>

    <fmt:message key = "773" />.</b>

    <%
    if (true)
        return;
    %>
</c:if>

<sql:query var = "proposal_info">
    select p.*, c.cfp_title from proponent_record p, cfp_info c where
    p.tracking_code = ? and p.cfp_code = c.cfp_code

    <sql:param value = "${tracking_code}"/>
</sql:query>

<c:set var = "cfp_code" value = "${proposal_info.rows[0].cfp_code}"
       scope = "page"/>

<!--- verify that cfp (report deadline) is still active --->
<sql:query var = "cfp_current_list">
    select cfp_title from cfp_info where cfp_code = ? and cfp_report_deadline
    >= CURDATE()

    <sql:param value = "${cfp_code}"/>
</sql:query>

<c:set var = "deadline_date" value = "current" scope = "page"/>

<c:if test = "${empty cfp_current_list.rows[0].cfp_title}">
    <c:set var = "deadline_date" value = "passed" scope = "page"/>
</c:if>

<c:choose>
    <c:when test = "${(deadline_date=='passed')}">
        <p>
        <fmt:message key = "915" />:
    </c:when>

    <c:otherwise>
        <c:if test = "${param.act == 'add'}">
            <sql:query var = "initiative_info">
                select copyright,ia_name, ia_email, ia_address, ia_courier,
                ia_courier_inst, ia_fax, ia_phone from initiative_info where
                lang_id = ?

                <sql:param value = "${lang}"/>
            </sql:query>

            <c:forEach items = "${initiative_info.rows}" var = "row">
                <c:set var = "cr" value = "${row.copyright}" scope = "page"/>

                <p>
                <h3>

                <fmt:message key = "19" />:</h3>

                <cf:ParagraphFormat value = "${cr}"/>

                <form action = "index.jsp?fuseaction=report_doc"
                      method = "post">
                    <input type = "hidden" name = "act" value = "add">
                    <input type = "hidden" name = "lang"
                    value = "<c:out value="${lang}" />"> <input type = "hidden"
                    name = "tracking_code"
                    value = "<c:out value="${tracking_code}" />"> <input type = "hidden"
                    name = "proponent_password"
                    value = "<c:out value="${proponent_password}" />"> <input type = "submit"
                    value = "<fmt:message key="110"  />">
                </form>

                <p>
                <fmt:message key = "76" />

                <p>
                <fmt:message key = "111" />:

                <center>
                    <p>
                    <b>

                    <c:out value = "${row.ia_name}"/></b>

                    <br>
                    <fmt:message key = "24" />:
                    <a STYLE = "text-decoration: underline"
                       href = "mailto:<c:out value="${row.ia_email}" />">

                    <c:out value = "${row.ia_email}"/></a>

                    <br>
                    <fmt:message key = "25" />:

                    <c:out value = "${row.ia_address}"/>

                    <br>
                    <fmt:message key = "26" />:

                    <c:out value = "${row.ia_courier}"/>

                    <br>
                    <fmt:message key = "27" />:

                    <c:out value = "${row.ia_courier_inst}"/>

                    <br>
                    <fmt:message key = "28" />:

                    <c:out value = "${row.ia_phone}"/> -

                    <fmt:message key = "29" />:

                    <c:out value = "${row.ia_fax}"/>
                </center>
            </c:forEach>
        </c:if>

        <c:if test = "${param.act == 'edit'}">
            <sql:query var = "docid" maxRows = "1">
                select d.doc_id from documents d, document_types dt where
                d.tracking_code = ? and d.doc_type_id > 0 and d.doc_type_id =
                dt.doc_type_id and dt.doc_type_category = 'R'

                <sql:param value = "${tracking_code}"/>
            </sql:query>

            <c:if test = "${docid.rowCount!=0}">
                <c:set var = "doc_id" value = "${docid.rows[0].doc_id}"
                       scope = "page"/>

                <c:import url = "cfp/dsp_report_edit_doc.jsp">
                    <c:param name = "tracking_code" value = "${tracking_code}"/>

                    <c:param name = "doc_id" value = "${doc_id}"/>

                    <c:param name = "lang" value = "${lang}"/>
                </c:import>
            </c:if>
        </c:if>
    </c:otherwise>
</c:choose>
