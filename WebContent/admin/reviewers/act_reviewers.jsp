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

<c:set var = "reviewer_id">
    <c:out value = "${param.reviewer_id}" default = ""/>
</c:set>

<c:set var = "reviewer_coordinator">
    <c:out value = "${param.reviewer_coordinator}" default = "0"/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = "0"/>
</c:set>

<c:set var = "cfp_cat_id">
    <c:out value = "${param.cfp_cat_id}" default = "0"/>
</c:set>

<c:set var = "delete_confirm">
    <c:out value = "${param.delete_confirm}" default = "no"/>
</c:set>

<c:set var = "redirect">
    <c:out value = "${param.redirect}" default = "yes"/>
</c:set>

<c:set var = "reviewer_firstname">
    <c:out value = "${param.reviewer_firstname}" default = ""/>
</c:set>

<c:set var = "reviewer_lastname">
    <c:out value = "${param.reviewer_lastname}" default = ""/>
</c:set>

<c:set var = "reviewer_login">
    <c:out value = "${param.reviewer_login}" default = ""/>
</c:set>

<c:set var = "reviewer_password">
    <c:out value = "${param.reviewer_password}" default = ""/>
</c:set>

<c:set var = "reviewer_email">
    <c:out value = "${param.reviewer_email}" default = ""/>
</c:set>

<c:set var = "reviewer_phone">
    <c:out value = "${param.reviewer_phone}" default = ""/>
</c:set>

<c:set var = "reviewer_fax">
    <c:out value = "${param.reviewer_fax}" default = ""/>
</c:set>

<c:set var = "reviewer_address">
    <c:out value = "${param.reviewer_address}" default = ""/>
</c:set>

<c:set var = "reviewer_profile">
    <c:out value = "${param.reviewer_profile}" default = ""/>
</c:set>

<c:set var = "payment_rate">
    <c:out value = "${param.payment_rate}" default = "1.00"/>
</c:set>

<!---------- DELETE REVIEWER ----------------->

<c:choose>
    <c:when test = "${act=='delete'}">

        <!--- check to see if the reviewer has already submitted a review --->
        <sql:query var = "review_check">
            select appraisal_id from proposal_appraisal where reviewer_id = ?

            <sql:param value = "${reviewer_id}"/>
        </sql:query>

        <c:choose>
            <c:when test = "${(review_check.rowCount!=0) and (delete_confirm=='no')}">
                <c:set var = "redirect" value = "no" scope = "page"/>

                <div align = "center">
                    <h2>

                    <fmt:message key = "692" />

                    !

                    </h3>

                    <h3>

                    <fmt:message key = "693" />!</h3>

                    <table border = "0" cellspacing = "0" cellpadding = "2">
                        <td>
                            <form action = "index.jsp?fuseaction=act_reviewer"
                                  method = "post">
                                <input type = "hidden" name = "act"
                                value = "delete">
                                <input type = "hidden" name = "delete_confirm"
                                value = "<fmt:message key="542"  />">
                                <input type = "hidden" name = "reviewer_id"
                                value = "<c:out value="${reviewer_id}" />"> <input type = "submit"
                                value = " <fmt:message key="695"  /> ">
                            </form>
                        </td>

                        <td>
                            <form action = "index.jsp?fuseaction=reviewers"
                                  method = "post">
                                <input type = "submit"
                                       value = " <fmt:message key="696"  /> ">
                            </form>
                        </td>
                    </table>
                </div>
            </c:when>

            <c:otherwise>
                <sql:update>
                    delete from reviewers where reviewer_id = ?

                    <sql:param value = "${reviewer_id}"/>
                </sql:update>

                <sql:update>
                    delete from reviewer_assignment where reviewer_id = ?

                    <sql:param value = "${reviewer_id}"/>
                </sql:update>

                <sql:update>
                    delete from proposal_appraisal where reviewer_id = ?

                    <sql:param value = "${reviewer_id}"/>
                </sql:update>

                <sql:update>
                    delete from report_appraisal where reviewer_id = ?

                    <sql:param value = "${reviewer_id}"/>
                </sql:update>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test = "${act=='add'}">

        <!------------- ADD REVIEWER ----------------->
        <sql:query var = "reviewer_num" maxRows = "1">
            select reviewer_id from reviewers order by reviewer_id desc
        </sql:query>

        <c:choose>
            <c:when test = "${reviewer_num.rowCount==0}">
                <c:set var = "reviewer_id" value = "1" scope = "page"/>
            </c:when>

            <c:otherwise>
                <c:set var = "reviewer_id"
                       value = "${reviewer_num.rows[0].reviewer_id + 1}"
                       scope = "page"/>
            </c:otherwise>
        </c:choose>

        <sql:update>
            insert into reviewers ( reviewer_id, reviewer_firstname,
            reviewer_lastname, reviewer_login, reviewer_password,
            reviewer_email, reviewer_phone,

            <c:if test = "${!empty reviewer_fax}">
                reviewer_fax,
            </c:if>

            <c:if test = "${!empty reviewer_address}">
                reviewer_address,
            </c:if>

            <c:if test = "${!empty reviewer_profile}">
                reviewer_profile,
            </c:if>

            reviewer_coordinator, cfp_code, cfp_cat_id,payment_rate) values (
            ?, ?, ?, ?, ?, ?, ?,

            <c:if test = "${!empty reviewer_fax}">
                ?,
            </c:if>

            <c:if test = "${!empty reviewer_address}">
                ?,
            </c:if>

            <c:if test = "${!empty reviewer_profile}">
                ?,
            </c:if>

            ?, ?, ?, ?)

            <sql:param value = "${reviewer_id}"/>

            <sql:param value = "${reviewer_firstname}"/>

            <sql:param value = "${reviewer_lastname}"/>

            <sql:param value = "${reviewer_login}"/>

            <sql:param value = "${reviewer_password}"/>

            <sql:param value = "${reviewer_email}"/>

            <sql:param value = "${reviewer_phone}"/>

            <c:if test = "${!empty reviewer_fax}">
                <sql:param value = "${reviewer_fax}"/>
            </c:if>

            <c:if test = "${!empty reviewer_address}">
                <sql:param value = "${reviewer_address}"/>
            </c:if>

            <c:if test = "${!empty reviewer_profile}">
                <sql:param value = "${reviewer_profile}"/>
            </c:if>

            <sql:param value = "${reviewer_coordinator}"/>

            <sql:param value = "${cfp_code}"/>

            <sql:param value = "${cfp_cat_id}"/>

            <sql:param value = "${payment_rate}"/>
        </sql:update>
    </c:when>

    <c:when test = "${act=='edit'}">

        <!------------------------- EDIT REVIEWER ----------------------------->
        <sql:query var = "cfp_cat_check">
            select cfp_cat_id from cfp_category where cfp_code = ?

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <c:if test = "${cfp_cat_check.rowCount==0}">
            <c:set var = "cfp_cat_id" value = "0" scope = "page"/>
        </c:if>

        <sql:update>
            update reviewers set reviewer_lastname=?, reviewer_firstname=?,
            reviewer_login=?, reviewer_password=?, reviewer_email=?,
            reviewer_phone=?,

            <c:if test = "${!empty reviewer_fax}">
                reviewer_fax=?,
            </c:if>

            <c:if test = "${!empty reviewer_address}">
                reviewer_address=?,
            </c:if>

            <c:if test = "${!empty reviewer_profile}">
                reviewer_profile=?,
            </c:if>

            reviewer_coordinator=?, cfp_code = ?, cfp_cat_id = ?, payment_rate
            = ? where reviewer_id=?

            <sql:param value = "${reviewer_lastname}"/>

            <sql:param value = "${reviewer_firstname}"/>

            <sql:param value = "${reviewer_login}"/>

            <sql:param value = "${reviewer_password}"/>

            <sql:param value = "${reviewer_email}"/>

            <sql:param value = "${reviewer_phone}"/>

            <c:if test = "${!empty reviewer_fax}">
                <sql:param value = "${reviewer_fax}"/>
            </c:if>

            <c:if test = "${!empty reviewer_address}">
                <sql:param value = "${reviewer_address}"/>
            </c:if>

            <c:if test = "${!empty reviewer_profile}">
                <sql:param value = "${reviewer_profile}"/>
            </c:if>

            <sql:param value = "${reviewer_coordinator}"/>

            <sql:param value = "${cfp_code}"/>

            <sql:param value = "${cfp_cat_id}"/>

            <sql:param value = "${payment_rate}"/>

            <sql:param value = "${reviewer_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:if test = "${redirect=='yes'}">
    <c:import url = "reviewers/dsp_reviewers.jsp"/>
</c:if>
