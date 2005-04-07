<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.jspsmart.upload.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "delete_confirm">
    <c:out value = "${param.delete_confirm}" default = "yes"/>
</c:set>

<c:set var = "redirect">
    <c:out value = "${param.redirect}" default = "yes"/>
</c:set>

<c:set var = "contractor_id">
    <c:out value = "${param.contractor_id}" default = "0"/>
</c:set>

<!---------- DELETE CONTRACTOR ----------------->

<!--- check to see if the contractor has already submitted a timesheet --->
<sql:query var = "review_check">
    select timesheet_id from contractor_timesheets where contractor_id = ?

    <sql:param value = "${contractor_id}"/>
</sql:query>

<c:choose>
    <c:when test = "${(review_check.rowCount!=0) and (delete_confirm=='no')}">
        <c:set var = "redirect" value = "no" scope = "page"/>

        <div align = "center">
            <h2>

            <cf:GetPhrase phrase_id = "692" lang_id = "${lang}"/>

            !

            </h3>

            <h3>

            <cf:GetPhrase phrase_id = "693" lang_id = "${lang}"/>!</h3>

            <table border = "0" cellspacing = "0" cellpadding = "2">
                <td>
                    <form action = "index.jsp?fuseaction=act_contractor_del" method = "post">
                        <input type = "hidden" name = "act" value = "delete"> <input type = "hidden"
                               name = "delete_confirm"
                               value = "<cf:GetPhrase phrase_id="542" lang_id="${lang}" />">
                        <input type = "hidden" name = "contractor_id" value = "<c:out value="${contractor_id}" />">
                        <input type = "submit" value = " <cf:GetPhrase phrase_id="695" lang_id="${lang}" /> ">
                    </form>
                </td>

                <td>
                    <form action = "index.jsp?fuseaction=contractors" method = "post">
                        <input type = "submit" value = " <cf:GetPhrase phrase_id="696" lang_id="${lang}" /> ">
                    </form>
                </td>
            </table>
        </div>
    </c:when>

    <c:otherwise>
        <sql:update>
            delete from contractors where contractor_id = ?

            <sql:param value = "${contractor_id}"/>
        </sql:update>

        <sql:update>
            delete from contractor_assignment where contractor_id = ?

            <sql:param value = "${contractor_id}"/>
        </sql:update>

        <sql:update>
            delete from contractor_timesheets where contractor_id = ?

            <sql:param value = "${contractor_id}"/>
        </sql:update>

        <sql:update>
            delete from contractor_skills where contractor_id = ?

            <sql:param value = "${contractor_id}"/>
        </sql:update>
    </c:otherwise>
</c:choose>

<c:if test = "${redirect=='yes'}">
    <c:import url = "contractors/dsp_contractors.jsp"/>
</c:if>
