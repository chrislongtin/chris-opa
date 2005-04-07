<%@ page errorPage = "dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>
<!--- check for session.user variable to insure user logged in --->

<%@ include file = "act_session_check.jsp"%>

<center>
    <h2>

    <cf:GetPhrase phrase_id = "1025" lang_id = "${lang}"/></h2> <h3><b>

    <cf:GetPhrase phrase_id = "1023" lang_id = "${lang}"/></h3>

    <form action = "act_reports_main.jsp" method = "post">
        <table width = '100%' border = 1 cellpadding = 2 cellspacing = 0>
            <sql:query var = "application_areas">
                select * from application_areas
            </sql:query>

            <c:forEach items = "${application_areas.rows}" var = "row">
                <c:set var = "application_area_id" value = "${row.application_area_id}" scope = "page"/>

                <sql:query var = "reports">
                    select report_id,report_label from reports_control_table where application_area_id = ? and

                    <c:if test = "${sessionScope.user == 'coordinator'}">
                        user_group_code = 'C'
                    </c:if>

                    <c:if test = "${sessionScope.user == 'reviewer'}">
                        user_group_code = 'R'
                    </c:if>

                    <c:if test = "${sessionScope.user == 'contractor'}">
                        user_group_code = 'T'
                    </c:if>

                    <sql:param value = "${application_area_id}"/>
                </sql:query>

                <c:if test = "${reports.rowCount > 0}">
                    <tr bgcolor = 'FFFFCC'>
                        <td align = 'center'>
                            <c:out value = "${row.application_area_name}"/>
                        </td>
                    </tr>

                    <c:forEach items = "${reports.rows}" var = "rowa">
                        <tr bgcolor = 'CCCCFF' BORDERCOLOR = #c0c0c0>
                            <td>
                                <input type = "radio" name = "selection" value = "<c:out value="${rowa.report_id}" />">

                                <c:out value = "${rowa.report_label}"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </table>

        <h3>

        <cf:GetPhrase phrase_id = "1024" lang_id = "${lang}"/></h3>

        <table width = '100%' border = 1 cellpadding = 2 cellspacing = 0>
            <tr bgcolor = 'CCCCFF'BORDERCOLOR=#c0c0c0>
                <td align = 'center'>
                    <input type = "radio" name = "displayType" value = "pdf" checked>

                    <cf:GetPhrase phrase_id = "1026" lang_id = "${lang}"/>
                    &nbsp;&nbsp;<input type = "radio" name = "displayType" value = "html">

                    <cf:GetPhrase phrase_id = "1027" lang_id = "${lang}"/>
                    &nbsp;&nbsp;<input type = "radio" name = "displayType" value = "xls">

                    <cf:GetPhrase phrase_id = "1028" lang_id = "${lang}"/>
                    &nbsp;&nbsp;<input type = "radio" name = "displayType" value = "csv">

                    <cf:GetPhrase phrase_id = "1029" lang_id = "${lang}"/>
                    &nbsp;&nbsp;<input type = "radio" name = "displayType" value = "xml">

                    <cf:GetPhrase phrase_id = "1030" lang_id = "${lang}"/>
                </td>
            </tr>
        </table>

        <br>
        <br>
        <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
    </form>
</center>

</form>

<center>
