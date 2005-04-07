<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>
<%@ include file = "../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:set var = "tc">
    <c:out value = "${param.tr_code}" default = "0"/>
</c:set>

<sql:query var = "prop">
    select distinct p.tracking_code from proponent_record p, reviewer_assignment ra, cfp_info c where ra.reviewer_id =
    ? and ra.proposal = 1 and ra.tracking_code = p.tracking_code and ra.tracking_code = ? and c.cfp_code = p.cfp_code
    and c.cfp_proposal_review_deadline >= CURDATE()

    <sql:param value = "${sessionScope.rid}"/>

    <sql:param value = "${tc}"/>
</sql:query>

<c:if test = "${prop.rowCount == 1}">
    <fmt:parseDate var = 'start_date' pattern = 'MMM-dd-yy' value = '${param.start_date}'/>

    <fmt:parseDate var = 'end_date' pattern = 'MMM-dd-yy' value = '${param.end_date}'/>

    <fmt:formatDate var = 'start' pattern = 'yyyy-MM-dd' value = '${start_date}'/>

    <fmt:formatDate var = 'end' pattern = 'yyyy-MM-dd' value = '${end_date}'/>

    <fmt:formatDate var = 'end_date_d' pattern = 'dd' value = '${end_date}'/>

    <fmt:formatDate var = 'end_date_m' pattern = 'MM' value = '${end_date}'/>

    <fmt:formatDate var = 'end_date_y' pattern = 'yyyy' value = '${end_date}'/>

    <fmt:formatDate var = 'start_date_d' pattern = 'dd' value = '${start_date}'/>

    <fmt:formatDate var = 'start_date_m' pattern = 'MM' value = '${start_date}'/>

    <fmt:formatDate var = 'start_date_y' pattern = 'yyyy' value = '${start_date}'/>

    <c:choose>
        <c:when test = "${start_date_y != end_date_y}">
            <p>
            <cf:GetPhrase phrase_id = "862" lang_id = "${lang}"/>

            <p>
            <a STYLE="text-decoration: underline"  href = "javascript: history.back()"><<<cf:GetPhrase phrase_id="864" lang_id="${lang}" /></a>
	</c:when>
	<c:when test="${start_date_m != end_date_m}">
    <p><cf:GetPhrase phrase_id="863" lang_id="${lang}" />
    <p><a STYLE="text-decoration: underline"  href="javascript:history.back()"><< <cf:GetPhrase phrase_id="864" lang_id="${lang}" /></a>
	</c:when>
	<c:when test="${start_date_d >= end_date_d}">
    <p><cf:GetPhrase phrase_id="865" lang_id="${lang}" />
    <p><a STYLE="text-decoration: underline"  href="javascript:history.back()"><< <cf:GetPhrase phrase_id="864" lang_id="${lang}" /></a>
	</c:when>
	<c:otherwise>
    <sql:query var="over">
    	select * from timesheets
      where reviewer_id = ? and
      tracking_code = ? and
      ((start_date < ? and end_date > ?) or (start_date < ? and end_date > ?))
      <sql:param value="${sessionScope.rid}" />
      <sql:param value="${tc}" />
      <sql:param value="${start}" />
      <sql:param value="${start}" />      
      <sql:param value="${end}" />            
      <sql:param value="${end}" />            
    </sql:query>
    <c:set var="lt" value="0" />
    <c:choose>
    	<c:when test="${over.rowCount == 0}">
		
        <sql:update>
        	insert into timesheets
          (status_id, reviewer_id, tracking_code, start_date, end_date )
          values
          (1, ?, ?, ?, ?)
          <sql:param value="${sessionScope.rid}" />
          <sql:param value="${tc}" />
          <sql:param value="${start}" />
          <sql:param value="${end}" />
        </sql:update>
    
        <c:import url="tsm/dsp_tsr_main.jsp" />        
        
    	</c:when>
    	<c:otherwise>
        <p><cf:GetPhrase phrase_id="866" lang_id="${lang}" /></p>
        <p><a STYLE="text-decoration: underline"  href="javascript:history.back()"><< <cf:GetPhrase phrase_id="864" lang_id="${lang}" /></a>        
    	</c:otherwise>
    </c:choose>
    
	</c:otherwise>
</c:choose>


</c:if>




