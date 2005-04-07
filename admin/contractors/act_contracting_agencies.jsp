<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<%@ include file = "../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "agency_id">
    <c:out value = "${param.agency_id}" default = ""/>
</c:set>

<c:set var = "delete_confirm">
    <c:out value = "${param.delete_confirm}" default = "yes"/>
</c:set>

<c:set var = "redirect">
    <c:out value = "${param.redirect}" default = "yes"/>
</c:set>

<c:set var = "agency_name">
    <c:out value = "${param.agency_name}" default = ""/>
</c:set>

<c:set var = "agency_contact">
    <c:out value = "${param.agency_contact}" default = ""/>
</c:set>

<c:set var = "agency_email">
    <c:out value = "${param.agency_email}" default = ""/>
</c:set>

<c:set var = "agency_phone">
    <c:out value = "${param.agency_phone}" default = ""/>
</c:set>

<c:set var = "agency_url">
    <c:out value = "${param.agency_url}" default = ""/>
</c:set>

<!---------- DELETE CONTRACTING AGENCY ----------------->

<c:choose>
    <c:when test = "${act=='delete'}">

        <!--- check to see if the contracting agency has contractors who have time sheets and records  --->
        <sql:query var = "review_check" maxRows = "1">
            select c.contractor_id,ca.agency_name from contractors c, contractor_timesheets t, contracting_agencies ca
            where c.contractor_id = t.contractor_id and c.agency_id = ca.agency_id and c.agency_id = ?

            <sql:param value = "${agency_id}"/>
        </sql:query>

        <c:choose>
            <c:when test = "${review_check.rowCount!=0}">

                <!--- delete cannot be done --->

                <div align = "center">
                    <h2>

                    <cf:GetPhrase phrase_id = "692" lang_id = "${lang}"/>!</h2> <h3>

                    <c:out value = "${review_check.rows[0].agency_name}"/></h3> <h4>

                    <cf:GetPhrase phrase_id = "980" lang_id = "${lang}"/>!</h4>

                    <table border = "0" cellspacing = "0" cellpadding = "2">
                        <tr>
                            <td>
                                <form action = "index.jsp?fuseaction=contracting_agencies" method = "post">
                                    <input type = "submit"
                                           value = " <cf:GetPhrase phrase_id="943" lang_id="${lang}" /> ">
                                </form>
                            </td>
                        </tr>
                    </table>
                </div>
            </c:when>

            <c:when test = "${review_check.rowCount == 0}">
                <sql:update>
                    delete from contracting_agencies where agency_id = ?

                    <sql:param value = "${agency_id}"/>
                </sql:update>

                <sql:update>
                    update contractors set agency_id = 0 where agency_id = ?

                    <sql:param value = "${agency_id}"/>
                </sql:update>
            </c:when>
        </c:choose>
    </c:when>

    <c:when test = "${act=='add'}">

        <!------------- ADD CONTRACTING AGENCY ----------------->
        <sql:query var = "contracting_agency_num" maxRows = "1">
            select agency_id from contracting_agencies order by agency_id desc
        </sql:query>

        <c:choose>
            <c:when test = "${contracting_agency_num.rowCount==0}">
                <c:set var = "agency_id" value = "1" scope = "page"/>
            </c:when>

            <c:otherwise>
                <c:set var = "agency_id" value = "${contracting_agency_num.rows[0].agency_id + 1}" scope = "page"/>
            </c:otherwise>
        </c:choose>

        <sql:update>
            insert into contracting_agencies ( agency_id, agency_name,

            <c:if test = "${!empty agency_contact}">
                agency_contact,
            </c:if>

            <c:if test = "${!empty agency_email}">
                agency_email,
            </c:if>

            <c:if test = "${!empty agency_phone}">
                agency_phone,
            </c:if>

            <c:if test = "${!empty agency_url}">
                agency_url
            </c:if>

            ) values ( ?, ?,

            <c:if test = "${!empty agency_contact}">
                ?,
            </c:if>

            <c:if test = "${!empty agency_email}">
                ?,
            </c:if>

            <c:if test = "${!empty agency_phone}">
                ?,
            </c:if>

            <c:if test = "${!empty agency_url}">
                ?
            </c:if>

            )

            <sql:param value = "${agency_id}"/>

            <sql:param value = "${agency_name}"/>

            <c:if test = "${!empty agency_contact}">
                <sql:param value = "${agency_contact}"/>
            </c:if>

            <c:if test = "${!empty agency_email}">
                <sql:param value = "${agency_email}"/>
            </c:if>

            <c:if test = "${!empty agency_phone}">
                <sql:param value = "${agency_phone}"/>
            </c:if>

            <c:if test = "${!empty agency_url}">
                <sql:param value = "${agency_url}"/>
            </c:if>
        </sql:update>
    </c:when>

    <c:when test = "${act=='edit'}">

        <!------------------------- EDIT CONTRACTING AGENCY ----------------------------->

        <sql:update>
            update contracting_agencies set agency_name=?,

            <c:if test = "${!empty agency_contact}">
                agency_contact=?,
            </c:if>

            <c:if test = "${!empty agency_email}">
                agency_email=?,
            </c:if>

            <c:if test = "${!empty agency_phone}">
                agency_phone=?,
            </c:if>

            <c:if test = "${!empty agency_url}">
                agency_url=?
            </c:if>

            where agency_id=?

            <sql:param value = "${agency_name}"/>

            <c:if test = "${!empty agency_contact}">
                <sql:param value = "${agency_contact}"/>
            </c:if>

            <c:if test = "${!empty agency_email}">
                <sql:param value = "${agency_email}"/>
            </c:if>

            <c:if test = "${!empty agency_phone}">
                <sql:param value = "${agency_phone}"/>
            </c:if>

            <c:if test = "${!empty agency_url}">
                <sql:param value = "${agency_url}"/>
            </c:if>

            <sql:param value = "${agency_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:if test = "${redirect=='yes'}">
    <c:import url = "contractors/dsp_contracting_agencies.jsp"/>
</c:if>
