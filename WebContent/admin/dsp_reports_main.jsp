<%@ page errorPage = "dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>
<!--- check for session.user variable to insure user logged in --->

<%@ include file = "act_session_check.jsp"%>

<center>
    <h2>

    <fmt:message key = "1025" /></h2> <h3><b>

    <fmt:message key = "1023" /></h3>

    <form action = "act_reports_main.jsp" method = "post">
        <table width = '100%' border = 1 cellpadding = 2 cellspacing = 0>
            <sql:query var = "application_areas">
                select * from application_areas
            </sql:query>

            <c:forEach items = "${application_areas.rows}" var = "row">
                <c:set var = "application_area_id"
                       value = "${row.application_area_id}"
                       scope = "page"/>

                <sql:query var = "reports">
                    select report_id,report_label from reports_control_table
                    where application_area_id = ? and

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
                                <input type = "radio"
                                       name = "selection"
                                       value = "<c:out value="${rowa.report_id}" />">

                                <c:out value = "${rowa.report_label}"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </table>

        <h3>

        <fmt:message key = "1024" /></h3>

        <table width = '100%' border = 1 cellpadding = 2 cellspacing = 0>
            <tr bgcolor = 'CCCCFF'BORDERCOLOR=#c0c0c0>
                <td align = 'center'>
                    <input type = "radio" name = "displayType" value = "pdf"
                           checked>

                    <fmt:message key = "1026" />
                    &nbsp;&nbsp;<input type = "radio" name = "displayType"
                                       value = "html">

                    <fmt:message key = "1027" />
                    &nbsp;&nbsp;<input type = "radio" name = "displayType"
                                       value = "xls">

                    <fmt:message key = "1028" />
                    &nbsp;&nbsp;<input type = "radio" name = "displayType"
                                       value = "csv">

                    <fmt:message key = "1029" />
                    &nbsp;&nbsp;<input type = "radio" name = "displayType"
                                       value = "xml">

                    <fmt:message key = "1030" />
                </td>
            </tr>
        </table>

        <br>
        <br>
        <input type = "submit"
               value = " <fmt:message key="456"  /> ">
    </form>
</center>

</form>

<center>
