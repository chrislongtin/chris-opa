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

<c:if test = "${sessionScope.user!='coordinator'}">
    <c:set var = "contractor" value = "${sessionScope.ctid}" scope = "page"/>

    <sql:query var = "contractor_settings">
        select cfp_cat_id, cfp_code from contractors where contractor_id = ?

        <sql:param value = "${contractor}"/>
    </sql:query>

    <c:if test = "${contractor_settings.rowCount!=0}">
        <c:set var = "contractor_cfp_cat_id" value = "${contractor_settings.rows[0].cfp_cat_id}" scope = "page"/>

        <c:set var = "contractor_cfp_code" value = "${contractor_settings.rows[0].cfp_code}" scope = "page"/>
    </c:if>

    <!--- if contractor is associated with a specific category get the name --->
    <c:if test = "${contractor_cfp_cat_id!=0}">
        <sql:query var = "r_cfp_cat_title">
            select cfp_cat_name from cfp_category where cfp_cat_id = ?

            <sql:param value = "${contractor_cfp_cat_id}"/>
        </sql:query>

        <c:set var = "cfp_cat_name" value = "${r_cfp_cat_title.rows[0].cfp_cat_name}" scope = "page"/>
    </c:if>
</c:if>

<c:choose>
    <c:when test = "${act=='add'}">

        <!-------------------------- ADD NEW CONTRACTOR -------------------------------->

        <!--- get title and subcategories of associated cfp selected on dsp_contractors--->
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

            <c:choose>
                <c:when test = "${(cfp_code!=0) and (!empty cfp_code)}">
                    <p>
                    <b>

                    <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>:</b>

                    <c:out value = "${cfp_name.rows[0].cfp_title}"/><c:if test = "${cfp_categories.rowCount!=0}">
                        <p>
                        <b>

                        <cf:GetPhrase phrase_id = "707" lang_id = "${lang}"/>:</b><c:choose>
                            <c:when test = "${contractor_cfp_cat_id==0}">
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
                                       value = "<c:out value="${contractor_cfp_cat_id}" />">

                                <c:out value = "${cfp_cat_name}"/>
                                <input type = "hidden" name = "agency_id" value = "<c:out value="${agency_id}" />">

                                <c:out value = "${contracting_agency.rows[0].agency_name}"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:when>

                <c:otherwise>
                    <p>
                    <b>

                    <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>:</b>

                    <cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                    <p>
                    <b>

                    <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>:</b>

                    <c:out value = "${contracting_agency.rows[0].agency_name}"/>
                </c:otherwise>
            </c:choose>

            <p>
            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>

    <c:when test = "${act=='edit'}">

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
            contractor_skills on professional_skills.skill_id = contractor_skills.skill_id and
            contractor_skills.contractor_id = ? where contractor_skills.skill_id is null order by
            professional_skills.skill_name

            <sql:param value = "${contractor_id}"/>
        </sql:query>

        <c:set var = "er" value = "${edit_contractor.rows[0]}" scope = "page"/>

        <c:set var = "doc_filename" value = "${er.resume_file_name}" scope = "page"/>

        <c:set var = "cfp_code" value = "${er.cfp_code}" scope = "page"/>

        <sql:query var = "cfp_list">
            select cfp_code, cfp_title from cfp_info where cfp_code<> ?
		order by cfp_title
			<sql:param value="${cfp_code}" />
		</sql:query>
		

		<sql:query var="contracting_agencies">
		select * from contracting_agencies
		order by agency_name
		</sql:query>
		
		
		<sql:query var="contracting_agency">
		select * from contracting_agencies
		where agency_id = ?
		<sql:param value="${agency_id}"/>
		</sql:query>

		<h3><cf:GetPhrase phrase_id="960" lang_id="${lang}" />:</h3>
		
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
		
		
		<form action="index.jsp?fuseaction=act_contractor" method="post" ENCTYPE="multipart/form-data">
		<input type="hidden" name="act" value="edit">
		<input type="hidden" name="contractor_id" value="<c:out value="${er.contractor_id}" />">
		<input type="hidden" name="agency_id" value="<c:out value="${er.agency_id}" />">
		<input type="hidden" name="contractor_lastname_required" value="<cf:GetPhrase phrase_id="697" lang_id="${lang}" />">
		<input type="hidden" name="contractor_firstname_required" value="<cf:GetPhrase phrase_id="698" lang_id="${lang}" />">
		<input type="hidden" name="contractor_login_required" value="<cf:GetPhrase phrase_id="699" lang_id="${lang}" />">
		<input type="hidden" name="contractor_email_required" value="<cf:GetPhrase phrase_id="710" lang_id="${lang}" />">
		<input type="hidden" name="contractor_password_required" value="<cf:GetPhrase phrase_id="709" lang_id="${lang}" />">
		<input type="hidden" name="contractor_phone_required" value="<cf:GetPhrase phrase_id="711" lang_id="${lang}" />">
		
		<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="330" lang_id="${lang}" />:</b></font>
		<br><input type="text" name="contractor_firstname" value="<c:out value="${er.contractor_firstname}" />" size="30">
		
		<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="329" lang_id="${lang}" />:</b></font>
		<br><input type="text" name="contractor_lastname" value="<c:out value="${er.contractor_lastname}" />" size="30">
		
		<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="331" lang_id="${lang}" />:</b></font>
		<br><input type="text" name="contractor_login" value="<c:out value="${er.contractor_login}" />" size="30">
		<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="92" lang_id="${lang}" />:</b></font>
		
		<c:choose>
			<c:when test="${contractor==er.contractor_id}">
		    <br><input type="text" name="contractor_password" value="<c:out value="${er.contractor_password}" />" size="30">		
			</c:when>
			<c:otherwise>
		    <br><input type="password" name="contractor_password" value="<c:out value="${er.contractor_password}" />" size="30">	
			</c:otherwise>
		</c:choose>
		
		<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="24" lang_id="${lang}" />:</b></font>
		<br><input type="text" name="contractor_email" value="<c:out value="${er.contractor_email}" />" size="30">
		<p><font color="FF0000"><b>* <cf:GetPhrase phrase_id="62" lang_id="${lang}" />:</b></font>
		<br><input type="text" name="contractor_phone" value="<c:out value="${er.contractor_phone}" />" size="30">
		<p><b><cf:GetPhrase phrase_id="29" lang_id="${lang}" />:</b>
		<br><input type="text" name="contractor_fax" value="<c:out value="${er.contractor_fax}" />" size="30">
		<p><b><cf:GetPhrase phrase_id="61" lang_id="${lang}" />:</b>
		<br><input type="text" name="contractor_address" value="<c:out value="${er.contractor_address}" />" size="30">
		
		<p><b><cf:GetPhrase phrase_id="606" lang_id="${lang}" />:</b>
		<br><input type="file" name="doc_filename"  size="30">
		  <c:if test="${doc_filename!=''}" >
		    <br><cf:GetPhrase phrase_id="607" lang_id="${lang}" /> <c:out value="${doc_filename}" />  	
		  </c:if>
		  
		<p><cf:GetPhrase phrase_id="704" lang_id="${lang}" />:
		<br><textarea name="contractor_profile" rows="3" cols="50" wrap><c:out value="${er.contractor_profile}" /></textarea>		
		
		<p><font color="FF0000"><b>*<cf:GetPhrase phrase_id="997" lang_id="${lang}"/>:</b></font>
		<br><select name="skill_id" multiple size="10"><option value="0" selected><cf:GetPhrase phrase_id="998" lang_id="${lang}"/>
		<c:forEach items="${edit_contractor_skills.rows}" var="rowa">
		<option value="<c:out value="${rowa.skill_id}" />" selected><c:out value="${rowa.skill_name}" />
		</c:forEach>    
		<c:forEach items="${edit_no_contractor_skills.rows}" var="rowb">
		<option value="<c:out value="${rowb.skill_id}" />" ><c:out value="${rowb.skill_name}" />
		</c:forEach>    
		</select>
		</p>
		<p><cf:GetPhrase phrase_id="706" lang_id="${lang}" />: <select name="cfp_code">
		<c:if test="${(!empty cfp_code) and (cfp_code!=0)}" >
			<option value="<c:out value="${cfp_code}" />"><c:out value="${cfp_title}" />
		</c:if>
		<c:if test="${sessionScope.user=='coordinator' or contractor_cfp_code==0}" >
			<option value="0"><cf:GetPhrase phrase_id="641" lang_id="${lang}" />
		  <c:forEach items="${cfp_list.rows}" var="row">
			<option value="<c:out value="${row.cfp_code}" />"><c:out value="${row.cfp_title}" />
		  </c:forEach>
		</c:if>
		 </select>
		<font size="-1" face="Arial"><cf:GetPhrase phrase_id="977" lang_id="${lang}" />:<select name="agency_id"><option value="${agency_id}"><c:out value="${contracting_agency.rows[0].agency_name}" />
		  <c:forEach items="${contracting_agencies.rows}" var="row">
			<option value="<c:out value="${row.agency_id}" />"><c:out value="${row.agency_name}" />
		  </c:forEach>
		</select>	
		<c:if test="${((!empty cfp_code) and (cfp_code!=0)) and cfp_categories.rowCount!=0}" >
		<p><cf:GetPhrase phrase_id="706" lang_id="${lang}" />:<select name="cfp_cat_id">
		<c:if test="${er.cfp_cat_id!=0}" >
			<option value="<c:out value="${er.cfp_cat_id}" />"><c:out value="${cfp_cat_name}" />
		</c:if>
		<c:if test="${sessionScope.user=='coordinator' or  contractor_cfp_cat_id==0}" >
		  <option value="0"><cf:GetPhrase phrase_id="641" lang_id="${lang}" />
		  <c:forEach items="${cfp_categories.rows}" var="row">
			<option value="<c:out value="${row.cfp_cat_id}" />"><c:out value="${row.cfp_cat_name}" />
		  </c:forEach>
		</c:if>
		
		</select>
		
		</c:if>
		
		<p><input type="submit" value=" <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
		</form>
		
		
		
	</c:when>
</c:choose>







