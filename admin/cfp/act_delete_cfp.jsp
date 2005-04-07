<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- check if proposals have been submitted for this cfp --->

<sql:query var = "cfp_check">
    select tracking_code from proponent_record where cfp_code = ?

    <sql:param value = "${param.cfp_code}"/>
</sql:query>

<c:choose>
    <c:when test = "${cfp_check.rowCount != 0}">
        <font color = "FF0000"><b>

        <cf:GetPhrase phrase_id = "442" lang_id = "${lang}"/></b></font>
    </c:when>

    <c:otherwise>
        <!--- confirm cfp delete --->

        <c:choose>
            <c:when test = "${param.act == 'confirm'}">
                <p>
                <h3>

                <cf:GetPhrase phrase_id = "443" lang_id = "${lang}"/>

                <c:out value = "${param.cfp_code}"/>?</h3> <b>

                <cf:GetPhrase phrase_id = "444" lang_id = "${lang}"/>!</b>

                <p>
                <table>
                    <td>
                        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='delete_cfp'/>
<c:param name='act' value='delete'/>
<c:param name='cfp_code' value='${param.cfp_code}'/>
<c:param name='${user}'/>
</c:url>"
                              method = "post">
                            <input type = "submit" value = " <cf:GetPhrase phrase_id="542" lang_id="${lang}" /> ">
                        </form>
                    </td>

                    <td>
                        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='show_cfp'/>
<c:param name='cfp_code' value='${param.cfp_code}'/>
<c:param name='${user}'/>
</c:url>"
                              method = "post">
                            <input type = "submit" value = " <cf:GetPhrase phrase_id="543" lang_id="${lang}" /> ">
                        </form>
                    </td>
                </table>
            </c:when>

            <c:when test = "${param.act == 'delete'}">
                <sql:update var = "delete_cfp">
                    delete from cfp_info where cfp_code = ?

                    <sql:param value = "${param.cfp_code}"/>
                </sql:update>

                <sql:update var = "delete_cfp_criteria">
                    delete from cfp_criteria where cfp_code = ?

                    <sql:param value = "${param.cfp_code}"/>
                </sql:update>

                <c:import url = "cfp/dsp_cfp_list.jsp?fuseaction=list_cfp&${user}"/>
            </c:when>
        </c:choose>
    </c:otherwise>
</c:choose>
