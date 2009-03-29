<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!---------------------- REVIEWER SETTINGS --------------------------->
<!--- determine if reviewer is limited to seeing only select CFPs ---->

<c:set var = "r_cfp_code">
    <c:out value = "${param.r_cfp_code}" default = "0"/>
</c:set>

<c:set var = "r_cfp_cat_id">
    <c:out value = "${param.r_cfp_cat_id}" default = "0"/>
</c:set>

<c:choose>
    <c:when test = "${sessionScope.user!='coordinator'}">
        <c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

        <sql:query var = "reviewer_settings">
            select cfp_code, cfp_cat_id from reviewers where reviewer_id = ?

            <sql:param value = "${reviewer}"/>
        </sql:query>

        <c:set var = "r_cfp_code"
               value = "${reviewer_settings.rows[0].cfp_code}"
               scope = "page"/>

        <c:set var = "r_cfp_cat_id"
               value = "${reviewer_settings.rows[0].cfp_cat_id}"
               scope = "page"/>

        <sql:query var = "cfp_name">
            select cfp_title, cfp_code from cfp_info

            <c:if test = "${r_cfp_code!=0}">
                where cfp_code = ?
            </c:if>

            order by cfp_code

            <c:if test = "${r_cfp_code!=0}">
                <sql:param value = "${r_cfp_code}"/>
            </c:if>
        </sql:query>

        <sql:query var = "category">
            select * from cfp_category

            <c:if test = "${r_cfp_cat_id!=0}">
                where cfp_cat_id = ?
            </c:if>

            order by cfp_code, cfp_cat_name

            <c:if test = "${r_cfp_cat_id!=0}">
                <sql:param value = "${r_cfp_cat_id}"/>
            </c:if>
        </sql:query>
    </c:when>

    <c:otherwise>

        <!--- get full list of CFPs for coordinator --->
        <sql:query var = "cfp_name">
            select cfp_title, cfp_code from cfp_info order by cfp_code
        </sql:query>

        <sql:query var = "category">
            select * from cfp_category order by cfp_code, cfp_cat_name
        </sql:query>
    </c:otherwise>
</c:choose>

<!--- proposal tracking & review --->
<h3>

<fmt:message key = "6" /></h3>

<!--- If user is a reviewer, retrieve the reviewer_id number from the session.user variable --->
<c:if test = "${sessionScope.user!='coordinator'}">

    <!--- retrieve a list of proposals that the reviewer is responsible for, where the review has not already been completed --->
    <sql:query var = "proposal_info">
        select p.tracking_code, p.proposal_title, p.cfp_code from
        proponent_record p, reviewer_assignment ra where ra.reviewer_id = ?
        and (ra.proposal_review_completed = 0 or ra.proposal_review_completed
        is null) and ra.proposal = 1 and ra.tracking_code = p.tracking_code
        order by proposal_title

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <h4>

    <fmt:message key = "638" /></h4>

    <c:choose>
        <c:when test = "${proposal_info.rowCount==0}">
            <fmt:message key = "289" />
        </c:when>

        <c:otherwise>
            <p>
            <fmt:message key = "290" />

            <ul>
                <c:forEach items = "${proposal_info.rows}" var = "row">
                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=proposal_review&tracking_code=<c:out value="${row.tracking_code}" />">

                    <c:out value = "${row.proposal_title} (P${row.tracking_code})"/></a>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>

    <sql:query var = "edit_reviews">
        select ra.tracking_code, p.proposal_title from reviewer_assignment ra,
        cfp_info c, proponent_record p where ra.reviewer_id = ? and
        ra.proposal_review_completed = 1 and ra.proposal = 1 and
        ra.tracking_code = p.tracking_code and ra.cfp_code = c.cfp_code and
        c.cfp_proposal_review_deadline >= CURDATE()

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <c:if test = "${edit_reviews.rowCount!=0}">
        <h4>

        <fmt:message key = "639" />:</h4>

        <ul>
            <c:forEach items = "${edit_reviews.rows}" var = "row">
                <li><a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=proposal_edit_review&tracking_code=<c:out value="${row.tracking_code}" />">

                <c:out value = "${row.proposal_title} (P${row.tracking_code})"/></a>
            </c:forEach>
        </ul>
    </c:if>

    <!--- Report Review --->

    <sql:query var = "report_info">
        select p.tracking_code, p.proposal_title,
        p.cfp_code,doc.doc_title,doc.doc_filename,doc.doc_id from
        proponent_record p, reviewer_assignment ra, documents doc,
        document_types dt where ra.reviewer_id = ? and
        (ra.report_review_completed = 0 or ra.report_review_completed is null)
        and ra.report = 1 and ra.tracking_code = p.tracking_code and
        ra.tracking_code = doc.tracking_code and doc.doc_type_id =
        dt.doc_type_id and dt.doc_type_name like '%Report%' order by
        proposal_title

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <h4>

    <fmt:message key = "903" /></h4>

    <c:choose>
        <c:when test = "${report_info.rowCount==0}">
            <fmt:message key = "904" />
        </c:when>

        <c:otherwise>
            <p>
            <fmt:message key = "905" />

            <ul>
                <c:forEach items = "${report_info.rows}" var = "row">
                    <li><a STYLE = "text-decoration: underline"
                           href = "index.jsp?fuseaction=report_review&act=add&proposal_title=<c:out value="${row.proposal_title}" />&doc_title=<c:out value="${row.doc_title}" />&tracking_code=<c:out value="${row.tracking_code}" />&doc_id=<c:out value="${row.doc_id}" />&doc_filename=<c:out value="${row.doc_filename}" />">

                    <c:out value = "${row.doc_title} (P${row.tracking_code})"/></a>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>

    <!--- Report Review  Edit--->

    <sql:query var = "edit_report_reviews">
        select ra.tracking_code, p.proposal_title,
        doc.doc_title,doc.doc_filename,doc.doc_id from reviewer_assignment ra,
        cfp_info c, proponent_record p, documents doc where ra.reviewer_id = ?
        and ra.report_review_completed = 1 and ra.report = 1 and
        ra.tracking_code = p.tracking_code and ra.cfp_code = c.cfp_code and
        ra.tracking_code = doc.tracking_code and c.cfp_report_review_deadline
        >= CURDATE()

        <sql:param value = "${reviewer}"/>
    </sql:query>

    <c:if test = "${edit_reviews.rowCount!=0}">
        <h4>

        <fmt:message key = "902" />:</h4>

        <ul>
            <c:forEach items = "${edit_report_reviews.rows}" var = "row">
                <li><a STYLE = "text-decoration: underline"
                       href = "index.jsp?fuseaction=report_edit_review&proposal_title=<c:out value="${row.proposal_title}" />&doc_id=<c:out value="${row.doc_id}" />&doc_title=<c:out value="${row.doc_title}" />&tracking_code=<c:out value="${row.tracking_code}" />&doc_filename=<c:out value="${row.doc_filename}" />">

                <c:out value = "${row.doc_title} (P${row.tracking_code})"/></a>
            </c:forEach>
        </ul>
    </c:if>

    <h4>

    <fmt:message key = "640" />:</h4>
</c:if>

<!--------------- search form for retrieving a list of proposals ----------------->
<sql:query var = "status">
    select * from record_status order by status_id
</sql:query>

<sql:query var = "track_code">
    select tracking_code from proponent_record order by tracking_code
</sql:query>

<sql:query var = "firstname">
    select proponent_leader_firstname, COUNT(proponent_leader_firstname) AS
    firstname_sum from proponent_record group by proponent_leader_firstname
</sql:query>

<sql:query var = "lastname">
    select proponent_leader_lastname, COUNT(proponent_leader_lastname) AS
    lastname_sum from proponent_record group by proponent_leader_lastname
</sql:query>

<sql:query var = "citizenship">
    select distinct proponent_citizenship from proponent_record order by
    proponent_citizenship
</sql:query>

<sql:query var = "implementation">
    select distinct project_country from proponent_record order by
    project_country
</sql:query>

<form action = "index.jsp?fuseaction=proposal_list" method = "post">
    <table width = "50%" border = "1" cellspacing = "0" cellpadding = "5">
        <tr>
            <td bgcolor = "CACACA">
                <font face = "arial" size = "-1"><b>

                <fmt:message key = "586" />:
            </td>

            <td colspan = "3" bgcolor = "EAEAEA">
                <select name = "cfp_code">
                    <c:if test = "${r_cfp_code==0}">
                        <option value = "">
                        <fmt:message key = "641" />
                    </c:if>

                    <c:forEach items = "${cfp_name.rows}" var = "row">
                        <option value = "<c:out value="${row.cfp_code}" />">
                        <c:out value = "${row.cfp_title} (${row.cfp_code})"/>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <tr>
            <td bgcolor = "CACACA">
                <font face = "arial" size = "-1"><b>

                <fmt:message key = "630" />:
            </td>

            <td colspan = "3" bgcolor = "EAEAEA">
                <select name = "cfp_cat_id">
                    <c:if test = "${r_cfp_cat_id==0}">
                        <option value = "">
                        <fmt:message key = "641" />
                    </c:if>

                    <c:forEach items = "${category.rows}" var = "row">
                        <option value = "<c:out value="${row.cfp_cat_id}" />">
                        <c:out value = "${row.cfp_cat_name} (CFP:${row.cfp_code})"/>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <c:if test = "${sessionScope.user=='coordinator'}">
            <tr>
                <td bgcolor = "CACACA">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "58" />:
                </td>

                <td bgcolor = "EAEAEA">
                    <select name = "status_id">
                        <option value = "">
                        <fmt:message key = "641" />

                        <c:forEach items = "${status.rows}" var = "row">
                            <option value = "<c:out value="${row.status_id}" />"><c:out value = "${row.status_name}"/>
                        </c:forEach>
                    </select>
                </td>

                <td bgcolor = "CACACA">
                    <font face = "arial" size = "-1"><b>

                    <fmt:message key = "57" />:
                </td>

                <td bgcolor = "EAEAEA">
                    <select name = "tracking_code_param">
                        <option value = "=">=

                        <option value = "ge">>=

                        <option value = "le"><=</select>
	<select name="tracking_code"><option value=""><fmt:message key="641"  />
  <c:forEach items="${track_code.rows}" var="row">
  	<option value="<c:out value="${row.tracking_code}" />"><c:out value="${row.tracking_code}" />
  </c:forEach>
  </select></td>

</tr><tr>

	<td bgcolor="CACACA"><font face="arial" size="-1"><b><fmt:message key="620"  />:</td>
	<td bgcolor="EAEAEA"><select name="proponent_leader_lastname"><option value=""><fmt:message key="641"  />
  <c:forEach items="${lastname.rows}" var="row">
  	<option value="<c:out value="${row.proponent_leader_lastname}" />"><c:out value="${row.proponent_leader_lastname}" /> 
    <c:if test="${row.lastname_sum > 1}" >
    	(<c:out value="${row.lastname_sum}" />)
    </c:if>
  </c:forEach>
  </select></td>
	<td bgcolor="CACACA"><font face="arial" size="-1"><b><fmt:message key="330"  />:</td>
	<td bgcolor="EAEAEA"><select name="proponent_leader_firstname"><option value=""><fmt:message key="641"  />
  <c:forEach items="${firstname.rows}" var="row">
  	<option value="<c:out value="${row.proponent_leader_firstname}" />"><c:out value="${row.proponent_leader_firstname}" /> 
    <c:if test="${row.firstname_sum > 1}" >
    	(<c:out value="${row.firstname_sum}" />)
    </c:if>
  </c:forEach>
  </select></td>

</tr><tr>

	<td bgcolor="CACACA"><font face="arial" size="-1"><b><fmt:message key="621"  />:</td>
	<td bgcolor="EAEAEA"><select name="proponent_citizenship"><option value=""><fmt:message key="641"  />
  <c:forEach items="${citizenship.rows}" var="row">
    <c:if test="${!empty row.proponent_citizenship}" >
    	<option value="<c:out value="${row.proponent_citizenship}" />"><c:out value="${row.proponent_citizenship}" />
    </c:if>
  </c:forEach>
  </select></td>
	<td bgcolor="CACACA"><font face="arial" size="-1"><b><fmt:message key="631"  />:</td>
	<td bgcolor="EAEAEA"><select name="project_country"><option value=""><fmt:message key="641"  />
  <c:forEach items="${implementation.rows}" var="row">
    <c:if test="${!empty row.project_country}" >
      <option value="<c:out value="${row.project_country}" />"><c:out value="${row.project_country}" />
    </c:if>
  </c:forEach>
  </select></td>

</tr>	
</c:if>

<tr>

	<td bgcolor="CACACA"><font face="arial" size="-1"><b><fmt:message key="642"  />:</td>
	<td bgcolor="EAEAEA"><font face="arial" size="-1">
		<input type="radio" name="showinfo" value="short" checked><fmt:message key="643"  />
		<input type="radio" name="showinfo" value="long"><fmt:message key="644"  />
		<input type="checkbox" name="hidden" value="yes"><fmt:message key="645"  />
	</td>
	<td bgcolor="CACACA"><font face="arial" size="-1"><b><fmt:message key="170"  />:</td>
	<td bgcolor="EAEAEA"><select name="search_order">
		<option value="tracking_code"><fmt:message key="57"  />
		<option value="cfp_code"><fmt:message key="586"  />
		<option value="cfp_cat_id"><fmt:message key="630"  />
		<option value="p.status_id"><fmt:message key="58"  />
		<option value="proponent_leader_lastname"><fmt:message key="620"  />
		<option value="proponent_leader_firstname"><fmt:message key="330"  />
		<option value="proponent_citizenship"><fmt:message key="621"  />
		<option value="project_country"><fmt:message key="631"  />
		<option value="proposal_title"><fmt:message key="100"  />
		</select>
	</td>
	
</tr><tr>
	
	<td colspan="4" align="center" bgcolor="000000"><input type="submit" value="  <fmt:message key="646"  />  "></td>
	
</tr></table>

</form>

<c:if test="${sessionScope.user=='coordinator'}" >

<form action="index.jsp?fuseaction=proposal_submit" method="post">
<input type="hidden" name="act" value="add">

<br><table width="50%" cellpadding="3" cellspacing="0" border="0">

<tr>

	<td colspan="2"><font face="arial" size="+1"><b><fmt:message key="647"  /></td>

</tr><tr>

	<td><font face="arial" size="-1"><b><fmt:message key="586"  />:</td>
	<td><select name="cfp_code">
  <c:forEach items="${cfp_name.rows}" var="row">
  	<option value="<c:out value="${row.cfp_code}" />"><c:out value="${row.cfp_title}" />
  </c:forEach>
  </select></td>

</tr><tr>

	<td colspan="2" align="center"><input type="submit" value=" <fmt:message key="648"  /> "></td>

</tr></table>

</form>
	
</c:if>






