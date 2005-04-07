<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "contractor_id" value = "${sessionScope.ctid}" scope = "page"/>

<!-------------------------- EDIT CONTRACTOR -------------------------------->

<sql:query var = "edit_contractor">
    select * from contractors where contractor_id = ?

    <sql:param value = "${contractor_id}"/>
</sql:query>

<sql:query var = "edit_contractor_skills">
    select a.skill_id,b.skill_name from contractor_skills a, professional_skills b where contractor_id = ? and
    a.skill_id = b.skill_id order by b.skill_name

    <sql:param value = "${contractor_id}"/>
</sql:query>

<sql:query var = "edit_no_contractor_skills">
    select professional_skills.skill_id,professional_skills.skill_name from professional_skills LEFT JOIN
    contractor_skills on professional_skills.skill_id = contractor_skills.skill_id and contractor_skills.contractor_id
    = ? where contractor_skills.skill_id is null order by professional_skills.skill_name

    <sql:param value = "${contractor_id}"/>
</sql:query>

<c:set var = "er" value = "${edit_contractor.rows[0]}" scope = "page"/>

<c:set var = "doc_filename" value = "${er.resume_file_name}" scope = "page"/>

<c:set var = "cfp_code" value = "${er.cfp_code}" scope = "page"/>

<h3>

<cf:GetPhrase phrase_id = "960" lang_id = "${lang}"/>:</h3>

<form action = "index.jsp?fuseaction=act_contractor" method = "post" ENCTYPE = "multipart/form-data">
    <input type = "hidden" name = "act" value = "edit">
    <input type = "hidden" name = "contractor_id" value = "<c:out value="${er.contractor_id}" />">
    <input type = "hidden"
           name = "contractor_lastname_required"
           value = "<cf:GetPhrase phrase_id="697" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_firstname_required"
           value = "<cf:GetPhrase phrase_id="698" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_login_required"
           value = "<cf:GetPhrase phrase_id="699" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_email_required"
           value = "<cf:GetPhrase phrase_id="710" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_password_required"
           value = "<cf:GetPhrase phrase_id="709" lang_id="${lang}" />">
    <input type = "hidden" name = "contractor_phone_required"
           value = "<cf:GetPhrase phrase_id="711" lang_id="${lang}" />">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "330" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_firstname" value = "<c:out value="${er.contractor_firstname}" />"
           size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "329" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_lastname" value = "<c:out value="${er.contractor_lastname}" />" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_login" value = "<c:out value="${er.contractor_login}" />" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/>:</b></font><c:choose>
        <c:when test = "${contractor==er.contractor_id}">
            <br>
            <input type = "text" name = "contractor_password" value = "<c:out value="${er.contractor_password}" />"
                   size = "30">
        </c:when>

        <c:otherwise>
            <br>
            <input type = "password" name = "contractor_password" value = "<c:out value="${er.contractor_password}" />"
                   size = "30">
        </c:otherwise>
    </c:choose>

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_email" value = "<c:out value="${er.contractor_email}" />" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_phone" value = "<c:out value="${er.contractor_phone}" />" size = "30">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "contractor_fax" value = "<c:out value="${er.contractor_fax}" />" size = "30">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "contractor_address" value = "<c:out value="${er.contractor_address}" />" size = "30">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "606" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "file" name = "doc_filename" size = "30"><c:if test = "${doc_filename!=''}">
        <br>
        <cf:GetPhrase phrase_id = "607" lang_id = "${lang}"/>

        <c:out value = "${doc_filename}"/>
    </c:if>

    <p>
    <cf:GetPhrase phrase_id = "704" lang_id = "${lang}"/>:

    <br>
    <textarea name = "contractor_profile" rows = "3" cols = "50" wrap>
        <c:out value = "${er.contractor_profile}"/>
    </textarea>

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "997" lang_id = "${lang}"/>:</b></font>

    <br>
    <select name = "skill_id" multiple size = "10">
        <option value = "0" selected><cf:GetPhrase phrase_id = "998" lang_id = "${lang}"/>

        <c:forEach items = "${edit_contractor_skills.rows}" var = "rowa">
            <option value = "<c:out value="${rowa.skill_id}" />" selected><c:out value = "${rowa.skill_name}"/>
        </c:forEach>

        <c:forEach items = "${edit_no_contractor_skills.rows}" var = "rowb">
            <option value = "<c:out value="${rowb.skill_id}" />"><c:out value = "${rowb.skill_name}"/>
        </c:forEach>
    </select>
    </p>

    <p>
    <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
