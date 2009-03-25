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

<c:set var = "chapter_id">
    <c:out value = "${sessionScope.chapter}" default = "1"/>
</c:set>

<c:set var = "organization_id">
    <c:out value = "${param.organization_id}" default = "0"/>
</c:set>

<c:set var = "organization_type_id">
    <c:out value = "${param.organization_type_id}" default = "0"/>
</c:set>

<c:set var = "organization_name">
    <c:out value = "${param.organization_name}" default = ""/>
</c:set>

<c:set var = "organization_address_line_1">
    <c:out value = "${param.organization_address_line_1}" default = ""/>
</c:set>

<c:set var = "organization_address_line_2">
    <c:out value = "${param.organization_address_line_2}" default = ""/>
</c:set>

<c:set var = "organization_city">
    <c:out value = "${param.organization_city}" default = ""/>
</c:set>

<c:set var = "organization_prov_state_code">
    <c:out value = "${param.organization_prov_state_code}" default = ""/>
</c:set>

<c:set var = "organization_prov_state_name">
    <c:out value = "${param.organization_prov_state_name}" default = ""/>
</c:set>

<c:set var = "organization_postal_zip_code">
    <c:out value = "${param.organization_postal_zip_code}" default = ""/>
</c:set>

<c:set var = "organization_email">
    <c:out value = "${param.organization_email}" default = ""/>
</c:set>

<c:set var = "organization_url">
    <c:out value = "${param.organization_url}" default = ""/>
</c:set>

<c:set var = "organization_phone">
    <c:out value = "${param.organization_phone}" default = ""/>
</c:set>

<c:set var = "organization_fax">
    <c:out value = "${param.organization_fax}" default = ""/>
</c:set>

<c:set var = "organization_contact_firstname">
    <c:out value = "${param.organization_contact_firstname}" default = ""/>
</c:set>

<c:set var = "organization_contact_lastname">
    <c:out value = "${param.organization_contact_lastname}" default = ""/>
</c:set>

<c:set var = "organization_contact_initial">
    <c:out value = "${param.organization_contact_initial}" default = ""/>
</c:set>

<c:set var = "organization_contact_email">
    <c:out value = "${param.organization_contact_email}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${act=='delete'}">
        <sql:update>
            delete from organizations where organization_id = ?

            <sql:param value = "${organization_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${act=='add'}">
        <sql:query var = "chap_num" maxRows = "1">
            select organization_id from organizations order by organization_id
            desc
        </sql:query>

        <c:if test = "${chap_num.rowCount!=0}">
            <c:set var = "organization_id"
                   value = "${chap_num.rows[0].organization_id + 1}"
                   scope = "page"/>
        </c:if>

        <c:if test = "${chap_num.rowCount==0}">
            <c:set var = "organization_id" value = "1" scope = "page"/>
        </c:if>

        <sql:update>
            insert into organizations (organization_id, organization_name,
            organization_type_id,

            <c:if test = "${!empty organization_address_line_1}">
                organization_address_line_1,
            </c:if>

            <c:if test = "${!empty organization_address_line_2}">
                organization_address_line_2,
            </c:if>

            <c:if test = "${!empty organization_city}">
                organization_city,
            </c:if>

            <c:if test = "${!empty organization_prov_state_code}">
                organization_prov_state_code,
            </c:if>

            <c:if test = "${!empty organization_prov_state_name}">
                organization_prov_state_name,
            </c:if>

            <c:if test = "${!empty organization_postal_zip_code}">
                organization_postal_zip_code,
            </c:if>

            <c:if test = "${!empty organization_phone}">
                organization_phone,
            </c:if>

            <c:if test = "${!empty organization_fax}">
                organization_fax,
            </c:if>

            <c:if test = "${!empty organization_email}">
                organization_email,
            </c:if>

            <c:if test = "${!empty organization_url}">
                organization_url,
            </c:if>

            <c:if test = "${!empty organization_contact_firstname}">
                organization_contact_firstname,
            </c:if>

            <c:if test = "${!empty organization_contact_initial}">
                organization_contact_initial,
            </c:if>

            <c:if test = "${!empty organization_contact_lastname}">
                organization_contact_lastname,
            </c:if>

            <c:if test = "${!empty organization_contact_email}">
                organization_contact_email,
            </c:if>

            create_timestamp,created_by_userid,last_update_timestamp,last_updated_by_userid,chapter_id
            ) values ( ?, ?,?,

            <c:if test = "${!empty organization_address_line_1}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_address_line_2}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_city}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_prov_state_code}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_prov_state_name}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_postal_zip_code}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_phone}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_fax}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_email}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_url}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_contact_firstname}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_contact_initial}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_contact_lastname}">
                ?,
            </c:if>

            <c:if test = "${!empty organization_contact_email}">
                ?,
            </c:if>

            NOW(),?,NOW(),?,? )

            <sql:param value = "${organization_id}"/>

            <sql:param value = "${organization_name}"/>

            <sql:param value = "${organization_type_id}"/>

            <c:if test = "${!empty organization_address_line_1}">
                <sql:param value = "${organization_address_line_1}"/>
            </c:if>

            <c:if test = "${!empty organization_address_line_2}">
                <sql:param value = "${organization_address_line_2}"/>
            </c:if>

            <c:if test = "${!empty organization_city}">
                <sql:param value = "${organization_city}"/>
            </c:if>

            <c:if test = "${!empty organization_prov_state_code}">
                <sql:param value = "${organization_prov_state_code}"/>
            </c:if>

            <c:if test = "${!empty organization_prov_state_name}">
                <sql:param value = "${organization_prov_state_name}"/>
            </c:if>

            <c:if test = "${!empty organization_postal_zip_code}">
                <sql:param value = "${organization_postal_zip_code}"/>
            </c:if>

            <c:if test = "${!empty organization_phone}">
                <sql:param value = "${organization_phone}"/>
            </c:if>

            <c:if test = "${!empty organization_fax}">
                <sql:param value = "${organization_fax}"/>
            </c:if>

            <c:if test = "${!empty organization_email}">
                <sql:param value = "${organization_email}"/>
            </c:if>

            <c:if test = "${!empty organization_url}">
                <sql:param value = "${organization_url}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_firstname}">
                <sql:param value = "${organization_contact_firstname}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_initial}">
                <sql:param value = "${organization_contact_initial}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_lastname}">
                <sql:param value = "${organization_contact_lastname}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_email}">
                <sql:param value = "${organization_contact_email}"/>
            </c:if>

            <sql:param value = "${sessionScope.user_id}"/>

            <sql:param value = "${sessionScope.user_id}"/>

            <sql:param value = "${chapter_id}"/>
        </sql:update>
    </c:when>

    <c:when test = "${act=='edit'}">
        <sql:update>
            update organizations set organization_name = ?

            <c:if test = "${!empty organization_address_line_1}">
                ,organization_address_line_1=?
            </c:if>

            <c:if test = "${!empty organization_address_line_2}">
                ,organization_address_line_2=?
            </c:if>

            <c:if test = "${!empty organization_city}">
                ,organization_city=?
            </c:if>

            <c:if test = "${!empty organization_prov_state_code}">
                ,organization_prov_state_code=?
            </c:if>

            <c:if test = "${!empty organization_prov_state_name}">
                ,organization_prov_state_name=?
            </c:if>

            <c:if test = "${!empty organization_postal_zip_code}">
                ,organization_postal_zip_code=?
            </c:if>

            <c:if test = "${!empty organization_phone}">
                ,organization_phone=?
            </c:if>

            <c:if test = "${!empty organization_fax}">
                ,organization_fax=?
            </c:if>

            <c:if test = "${!empty organization_email}">
                ,organization_email=?
            </c:if>

            <c:if test = "${!empty organization_email}">
                ,organization_url=?
            </c:if>

            <c:if test = "${!empty organization_contact_firstname}">
                ,organization_contact_firstname=?
            </c:if>

            <c:if test = "${!empty organization_contact_initial}">
                ,organization_contact_initial=?
            </c:if>

            <c:if test = "${!empty organization_contact_lastname}">
                ,organization_contact_lastname=?
            </c:if>

            <c:if test = "${!empty organization_contact_email}">
                ,organization_contact_email=?
            </c:if>

            ,last_update_timestamp = NOW(), last_updated_by_userid =
            ?,chapter_id = ? where organization_id=?

            <sql:param value = "${organization_name}"/>

            <c:if test = "${!empty organization_address_line_1}">
                <sql:param value = "${organization_address_line_1}"/>
            </c:if>

            <c:if test = "${!empty organization_address_line_2}">
                <sql:param value = "${organization_address_line_2}"/>
            </c:if>

            <c:if test = "${!empty organization_city}">
                <sql:param value = "${organization_city}"/>
            </c:if>

            <c:if test = "${!empty organization_prov_state_code}">
                <sql:param value = "${organization_prov_state_code}"/>
            </c:if>

            <c:if test = "${!empty organization_prov_state_name}">
                <sql:param value = "${organization_prov_state_name}"/>
            </c:if>

            <c:if test = "${!empty organization_postal_zip_code}">
                <sql:param value = "${organization_postal_zip_code}"/>
            </c:if>

            <c:if test = "${!empty organization_phone}">
                <sql:param value = "${organization_phone}"/>
            </c:if>

            <c:if test = "${!empty organization_fax}">
                <sql:param value = "${organization_fax}"/>
            </c:if>

            <c:if test = "${!empty organization_email}">
                <sql:param value = "${organization_email}"/>
            </c:if>

            <c:if test = "${!empty organization_url}">
                <sql:param value = "${organization_url}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_firstname}">
                <sql:param value = "${organization_contact_firstname}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_initial}">
                <sql:param value = "${organization_contact_initial}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_lastname}">
                <sql:param value = "${organization_contact_lastname}"/>
            </c:if>

            <c:if test = "${!empty organization_contact_email}">
                <sql:param value = "${organization_contact_email}"/>
            </c:if>

            <sql:param value = "${sessionScope.user_id}"/>

            <sql:param value = "${chapter_id}"/>

            <sql:param value = "${organization_id}"/>
        </sql:update>
    </c:when>
</c:choose>

<c:import url = "organizations/dsp_organizations.jsp"/>
