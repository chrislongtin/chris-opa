<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = "0"/>
</c:set>

<!--- check to see if the user is a contractor, and if so see if s/he is restricted to a specific subcategory, and if s/he is a contractor organizer --->
<c:set var = "contractor">
    <c:out value = "${param.contractor}" default = "0"/>
</c:set>

<c:set var = "contractor_id">
    <c:out value = "${param.contractor_id}" default = ""/>
</c:set>

<c:set var = "agency_id">
    <c:out value = "${param.agency_id}" default = ""/>
</c:set>

<c:set var = "contractor_cfp_cat_id">
    <c:out value = "${param.contractor_cfp_cat_id}" default = "0"/>
</c:set>

<c:set var = "contractor_cfp_code">
    <c:out value = "${param.contractor_cfp_code}" default = "0"/>
</c:set>

<!-------------------------- ADD NEW CONTRACTOR/RESUME -------------------------------->

<sql:query var = "contracting_agency">
    select agency_name from contracting_agencies where agency_id = ?

    <sql:param value = "${agency_id}"/>
</sql:query>

<sql:query var = "skills">
    select * from professional_skills
</sql:query>

<h3>

<cf:GetPhrase phrase_id = "968" lang_id = "${lang}"/>:</h3>

<p>
<cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

<form action = "index.jsp?fuseaction=act_contractor" method = "post" ENCTYPE = "multipart/form-data">
    <input type = "hidden" name = "act" value = "add">
    <input type = "hidden" name = "cfp_code" value = "<c:out value="${cfp_code}" />"> <input type = "hidden"
           name = "contractor_lastname_required"
           value = "<cf:GetPhrase phrase_id="697" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_firstname_required"
           value = "<cf:GetPhrase phrase_id="698" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_login_required"
           value = "<cf:GetPhrase phrase_id="699" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_email_required"
           value = "<cf:GetPhrase phrase_id="702" lang_id="${lang}" />"> <input type = "hidden"
           name = "contractor_password_required"
           value = "<cf:GetPhrase phrase_id="701" lang_id="${lang}" />">
    <input type = "hidden" name = "contractor_phone_required"
           value = "<cf:GetPhrase phrase_id="703" lang_id="${lang}" />">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "330" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_firstname" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "329" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_lastname" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_login" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_password" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_email" size = "30">

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b></font>

    <br>
    <input type = "text" name = "contractor_phone" size = "30">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "contractor_fax" size = "30">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "text" name = "contractor_address" size = "30">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "606" lang_id = "${lang}"/>:</b>

    <br>
    <input type = "file" name = "resume_file_name" size = "30">

    <p>
    <b>

    <cf:GetPhrase phrase_id = "704" lang_id = "${lang}"/>:</b>

    <br>
    <textarea name = "contractor_profile" rows = "3" cols = "50" wrap>
    </textarea>

    <p>
    <font color = "FF0000"><b>*

    <cf:GetPhrase phrase_id = "997" lang_id = "${lang}"/>

    :(

    <cf:GetPhrase phrase_id = "998" lang_id = "${lang}"/>)</b></font>

    <br>
    <select name = "skill_id" multiple size = "10">
        <c:forEach items = "${skills.rows}" var = "row">
            <option value = "<c:out value="${row.skill_id}" />"><c:out value = "${row.skill_name}"/>
        </c:forEach>
    </select>
    </p>

    <p>
    <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>
