<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "prop">
    select p.tracking_code, p.proposal_title, p.cfp_code from proponent_record p, reviewer_assignment ra, cfp_info c
    where ra.reviewer_id = ? and ra.proposal = 1 and ra.tracking_code = p.tracking_code and c.cfp_code = p.cfp_code
    and c.cfp_proposal_review_deadline >= CURDATE() order by p.tracking_code desc

    <sql:param value = "${sessionScope.rid}"/>
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "842" lang_id = "${lang}"/></h3>

<c:choose>
    <c:when test = "${prop.rowCount > 0}">
        <form name = "tsc_form" method = "post" action = "index.jsp?fuseaction=tsr_docreate">
            <table width = "100%" border = "0" cellspacing = "0" cellpadding = "5">
                <tr>
                    <td align = "right">
                        <font face = "Arial, Helvetica, sans-serif" size = "-1">

                        <cf:GetPhrase phrase_id = "57" lang_id = "${lang}"/>:</font>
                    </td>

                    <td align = "left">
                        <font face = "Arial, Helvetica, sans-serif" size = "-1">

                        <select name = "tr_code">
                            <c:forEach var = "row" items = "${prop.rows}">
                                <option value = "<c:out value="${row.tracking_code}" />">
                                <c:out value = "${row.tracking_code}. ${row.proposal_title} "/>

                                (

                                <cf:GetPhrase phrase_id = "586" lang_id = "${lang}"/>

                                :

                                <c:out value = "${row.cfp_code}"/>

                                )</option>
                            </c:forEach>
                        </select>

                        <input type = "hidden" name = "tr_code_required"
                               value = "<cf:GetPhrase phrase_id='859' lang_id='${lang}'/>"> </font>
                    </td>
                </tr>

                <tr>
                    <td align = "left" colspan = "2">
                        <font face = "Arial, Helvetica, sans-serif" size = "-1">

                        <cf:GetPhrase phrase_id = "858" lang_id = "${lang}"/></font>
                    </td>
                </tr>

                <tr>
                    <td align = "right">
                        <font face = "Arial, Helvetica, sans-serif" size = "-1">

                        <cf:GetPhrase phrase_id = "846" lang_id = "${lang}"/>

                        <br>
                        (mmm-dd-yyyy):</font>
                    </td>

                    <td align = "left">
                        <font face = "Arial, Helvetica, sans-serif" size = "-1">
                        <input type = "text" name = "start_date" value = "">
                        <input type = "hidden" name = "start_date_required"
                               value = "<cf:GetPhrase phrase_id='860' lang_id='${lang}'/>"> </font>
                    </td>
                </tr>

                <tr>
                    <td align = "right">
                        <font face = "Arial, Helvetica, sans-serif" size = "-1">

                        <cf:GetPhrase phrase_id = "847" lang_id = "${lang}"/>

                        <br>
                        (mmm-dd-yyyy):</font>
                    </td>

                    <td align = "left">
                        <font face = "Arial, Helvetica, sans-serif" size = "-1">
                        <input type = "text" name = "end_date" value = "">
                        <input type = "hidden" name = "end_date_required"
                               value = "<cf:GetPhrase phrase_id='861' lang_id='${lang}'/>"> </font>
                    </td>
                </tr>

                <tr align = "center">
                    <td colspan = "2">
                        <input type = "submit" name = "create_submit"
                               value = "<cf:GetPhrase phrase_id="842" lang_id="${lang}" />">
                    </td>
                </tr>
            </table>
        </form>
    </c:when>

    <c:otherwise>
        <cf:GetPhrase phrase_id = "289" lang_id = "${lang}"/>
    </c:otherwise>
</c:choose>
