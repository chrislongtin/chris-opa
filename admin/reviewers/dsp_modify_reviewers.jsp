<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = "0"/>
</c:set>

<!--- check to see if the user is a reviewer, and if so see if s/he is restricted to a specific subcategory, and if s/he is a reviewer organizer --->
<c:set var = "reviewer">
    <c:out value = "${param.reviewer}" default = "0"/>
</c:set>

<c:set var = "reviewer_id">
    <c:out value = "${param.reviewer_id}" default = ""/>
</c:set>

<c:set var = "reviewer_organizer">
    <c:out value = "${param.reviewer_organizer}" default = "0"/>
</c:set>

<c:set var = "reviewer_cfp_cat_id">
    <c:out value = "${param.reviewer_cfp_cat_id}" default = "0"/>
</c:set>

<c:set var = "reviewer_cfp_code">
    <c:out value = "${param.reviewer_cfp_code}" default = "0"/>
</c:set>

<c:if test = "${sessionScope.user!='coordinator'}">
    <c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

    <sql:query var = "reviewer_settings">
        select cfp_cat_id, reviewer_coordinator, cfp_code from reviewers where reviewer_id = ?

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <c:if test = "${reviewer_settings.rowCount!=0}">
        <c:set var = "reviewer_cfp_cat_id" value = "${reviewer_settings.rows[0].cfp_cat_id}" scope = "page"/>

        <c:set var = "reviewer_cfp_code" value = "${reviewer_settings.rows[0].cfp_code}" scope = "page"/>

        <c:set var = "reviewer_organizer" value = "${reviewer_settings.rows[0].reviewer_coordinator}" scope = "page"/>
    </c:if>

    <!--- if reviewer is associated with a specific category get the name --->
    <c:if test = "${reviewer_cfp_cat_id!=0}">
        <sql:query var = "r_cfp_cat_title">
            select cfp_cat_name from cfp_category where cfp_cat_id = ?

            <sql:param value = "${reviewer_cfp_cat_id}"/>
        </sql:query>

        <c:set var = "cfp_cat_name" value = "${r_cfp_cat_title.rows[0].cfp_cat_name}" scope = "page"/>
    </c:if>
</c:if>

<c:choose>
    <c:when test = "${act=='add'}">

        <!-------------------------- ADD NEW REVIEWER -------------------------------->

        <!--- get title and subcategories of associated cfp selected on dsp_reviewers--->
        <c:if test = "${(cfp_code!=0) and (!empty cfp_code)}">
            <sql:query var = "cfp_name">
                select cfp_title from cfp_info where cfp_code = ?

                <sql:param value = "${cfp_code}"/>
            </sql:query>

            <sql:query var = "cfp_categories">
                select * from cfp_category where cfp_code = ?

                <sql:param value = "${cfp_code}"/>
            </sql:query>
        </c:if>

        <h3>

        <cf:GetPhrase phrase_id = "254" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

        <form action = "index.jsp?fuseaction=act_reviewer&act=add" method = "post">
            <input type = "hidden" name = "cfp_code" value = "<c:out value="${cfp_code}" />"> <input type = "hidden"
                   name = "reviewer_lastname_required"
                   value = "<cf:GetPhrase phrase_id="697" lang_id="${lang}" />"> <input type = "hidden"
                   name = "reviewer_firstname_required"
                   value = "<cf:GetPhrase phrase_id="698" lang_id="${lang}" />"> <input type = "hidden"
                   name = "reviewer_login_required"
                   value = "<cf:GetPhrase phrase_id="699" lang_id="${lang}" />"> <input type = "hidden"
                   name = "reviewer_email_required"
                   value = "<cf:GetPhrase phrase_id="702" lang_id="${lang}" />"> <input type = "hidden"
                   name = "reviewer_password_required"
                   value = "<cf:GetPhrase phrase_id="701" lang_id="${lang}" />">
            <input type = "hidden" name = "reviewer_phone_required"
                   value = "<cf:GetPhrase phrase_id="703" lang_id="${lang}" />">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "330" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "reviewer_firstname" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "329" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "reviewer_lastname" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "reviewer_login" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "reviewer_password" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "reviewer_email" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "reviewer_phone" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "reviewer_fax" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "reviewer_address" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "704" lang_id = "${lang}"/>:</b>

            <br>
            <textarea name = "reviewer_profile" rows = "3" cols = "50" wrap>
            </textarea>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "1022" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "payment_rate" size = "15"><c:if test = "${sessionScope.user=='coordinator'}">
                <p>
                <b>

                <cf:GetPhrase phrase_id = "705" lang_id = "${lang}"/>?:</b>
                <input type = "checkbox" name = "reviewer_coordinator" value = "1"> yes
            </c:if>

            <c:choose>
                <c:when test = "${(cfp_code!=0) and (!empty cfp_code)}">
                    <p>
                    <b>

                    <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>:</b>

                    <c:out value = "${cfp_name.rows[0].cfp_title}"/><c:if test = "${cfp_categories.rowCount!=0}">
                        <p>
                        <b>

                        <cf:GetPhrase phrase_id = "707" lang_id = "${lang}"/>:</b><c:choose>
                            <c:when test = "${reviewer_cfp_cat_id==0}">
                                <select name = "cfp_cat_id">
                                    <option value = "0"><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                                    <c:forEach items = "${cfp_categories.rows}" var = "row">
                                        <option value = "<c:out value="${row.cfp_cat_id}" />">
                                        <c:out value = "${row.cfp_cat_name}"/>
                                    </c:forEach>
                                </select>
                            </c:when>

                            <c:otherwise>
                                <input type = "hidden" name = "cfp_cat_id"
                                       value = "<c:out value="${reviewer_cfp_cat_id}" />">

                                <c:out value = "${cfp_cat_name}"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:when>

                <c:otherwise>
                    <p>
                    <b>

                    <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>:</b>

                    <cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>
                </c:otherwise>
            </c:choose>

            <p>
            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>

    <c:when test = "${act=='edit'}">

        <!-------------------------- EDIT REVIEWER -------------------------------->

        <sql:query var = "edit_reviewer">
            select * from reviewers where reviewer_id = ?

            <sql:param value = "${reviewer_id}"/>
        </sql:query>

        <c:set var = "er" value = "${edit_reviewer.rows[0]}" scope = "page"/>

        <c:set var = "cfp_code" value = "${er.cfp_code}" scope = "page"/>

        <sql:query var = "cfp_list">
            select cfp_code, cfp_title from cfp_info where cfp_code<> ?
order by cfp_title
	<sql:param value="${cfp_code}" />
</sql:query>

<h3><cf:GetPhrase phrase_id="337" lang_id="${lang}" />:</h3>

<p><cf:GetPhrase phrase_id="41" lang_id="${lang}" />

<c:if test="${(!empty cfp_code) and (cfp_code!=0)}" >
	
<sql:query var="cfp_info">
select cfp_code, cfp_title
from cfp_info
where cfp_code = ?
	<sql:param value="${cfp_code}" />
</sql:query>

<c:set var="cfp_title" value="${cfp_info.rows[0].cfp_title}" scope="page" />

<sql:query var="cfp_cat_info">
select cfp_cat_id, cfp_cat_name
from cfp_category
where cfp_cat_id = ?
	<sql:param value="${er.cfp_cat_id}" />
</sql:query>

<c:set var="cfp_cat_name" value="${cfp_cat_info.rows[0].cfp_cat_name}" scope="page" />

<sql:query var="cfp_categories">
select *
from cfp_category
where cfp_code = ? and
	cfp_cat_id <> ?
	<sql:param value="${cfp_code}" />
  <sql:param value="${er.cfp_cat_id}" />
</sql:query>

</c:if>

<form action="index.jsp?fuseaction=act_reviewer" method="post">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="reviewer_id" value="<c:out value="${er.reviewer_id}" />">
<input type="hidden" name="reviewer_lastname_required" value="<cf:GetPhrase phrase_id="697" lang_id="${lang}" />">
<input type="hidden" name="reviewer_firstname_required" value="<cf:GetPhrase phrase_id="698" lang_id="${lang}" />">
<input type="hidden" name="reviewer_login_required" value="<cf:GetPhrase phrase_id="699" lang_id="${lang}" />">
<input type="hidden" name="reviewer_email_required" value="<cf:GetPhrase phrase_id="710" lang_id="${lang}" />">
<input type="hidden" name="reviewer_password_required" value="<cf:GetPhrase phrase_id="709" lang_id="${lang}" />">
<input type="hidden" name="reviewer_phone_required" value="<cf:GetPhrase phrase_id="711" lang_id="${lang}" />">

<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="330" lang_id="${lang}" />:</b></font>
<br><input type="text" name="reviewer_firstname" value="<c:out value="${er.reviewer_firstname}" />" size="30">

<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="329" lang_id="${lang}" />:</b></font>
<br><input type="text" name="reviewer_lastname" value="<c:out value="${er.reviewer_lastname}" />" size="30">

<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="331" lang_id="${lang}" />:</b></font>
<br><input type="text" name="reviewer_login" value="<c:out value="${er.reviewer_login}" />" size="30">
<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="92" lang_id="${lang}" />:</b></font>

<c:choose>
	<c:when test="${reviewer==er.reviewer_id}">
    <br><input type="text" name="reviewer_password" value="<c:out value="${er.reviewer_password}" />" size="30">		
	</c:when>
	<c:otherwise>
    <br><input type="password" name="reviewer_password" value="<c:out value="${er.reviewer_password}" />" size="30">	
	</c:otherwise>
</c:choose>

<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="24" lang_id="${lang}" />:</b></font>
<br><input type="text" name="reviewer_email" value="<c:out value="${er.reviewer_email}" />" size="30">
<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="62" lang_id="${lang}" />:</b></font>
<br><input type="text" name="reviewer_phone" value="<c:out value="${er.reviewer_phone}" />" size="30">
<p><b><cf:GetPhrase phrase_id="29" lang_id="${lang}" />:</b>
<br><input type="text" name="reviewer_fax" value="<c:out value="${er.reviewer_fax}" />" size="30">
<p><b><cf:GetPhrase phrase_id="61" lang_id="${lang}" />:</b>
<br><input type="text" name="reviewer_address" value="<c:out value="${er.reviewer_address}" />" size="30">
<p><cf:GetPhrase phrase_id="704" lang_id="${lang}" />:
<br><textarea name="reviewer_profile" rows="3" cols="50" wrap><c:out value="${er.reviewer_profile}" /></textarea>

<c:if test="${sessionScope.user=='coordinator'}" >
<p><cf:GetPhrase phrase_id="705" lang_id="${lang}" />?: <input type="checkbox" name="reviewer_coordinator" value="1" <c:if test="${er.reviewer_coordinator==1}" > checked </c:if>> <cf:GetPhrase phrase_id="542" lang_id="${lang}" />	
</c:if>

<p><cf:GetPhrase phrase_id="706" lang_id="${lang}" />: <select name="cfp_code">
<c:if test="${(!empty cfp_code) and (cfp_code!=0)}" >
	<option value="<c:out value="${cfp_code}" />"><c:out value="${cfp_title}" />
</c:if>
<c:if test="${(sessionScope.user=='coordinator') or ((reviewer_organizer==1) and (reviewer_cfp_code==0))}" >
	<option value="0"><cf:GetPhrase phrase_id="641" lang_id="${lang}" />
  <c:forEach items="${cfp_list.rows}" var="row">
  	<option value="<c:out value="${row.cfp_code}" />"><c:out value="${row.cfp_title}" />
  </c:forEach>
</c:if>
 </select>

<c:if test="${((!empty cfp_code) and (cfp_code!=0)) and cfp_categories.rowCount!=0}" >
<p><cf:GetPhrase phrase_id="706" lang_id="${lang}" />:<select name="cfp_cat_id">
<c:if test="${er.cfp_cat_id!=0}" >
	<option value="<c:out value="${er.cfp_cat_id}" />"><c:out value="${cfp_cat_name}" />
</c:if>
<c:if test="${(sessionScope.user=='coordinator') or ((reviewer_organizer==1) and (reviewer_cfp_cat_id==0))}" >
  <option value="0"><cf:GetPhrase phrase_id="641" lang_id="${lang}" />
  <c:forEach items="${cfp_categories.rows}" var="row">
  	<option value="<c:out value="${row.cfp_cat_id}" />"><c:out value="${row.cfp_cat_name}" />
  </c:forEach>
</c:if>

</select>

</c:if>
<p><b><cf:GetPhrase phrase_id="1022" lang_id="${lang}" />:</b>
<br><input type="text" name="payment_rate" value="<c:out value="${er.payment_rate}" />" size="15">

<p><input type="submit" value=" <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
</form>


		
	</c:when>
</c:choose>







