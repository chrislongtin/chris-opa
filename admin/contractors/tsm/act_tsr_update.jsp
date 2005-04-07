<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../../act_session_check_sub.jsp"%>
<%@ include file = "../../../guard_required_params.jsp"%>

<%
    GuardRequiredParams guard = new GuardRequiredParams(request);

    if (guard.isParameterMissed())
        {
        out.write(guard.getSplashScreen());
        return;
        }
%>

<c:set var = "ts_id">
    <c:out value = "${param.ts}" default = "0"/>
</c:set>

<c:set var = "tr_id">
    <c:out value = "${param.tr}" default = "0"/>
</c:set>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:if test = "${act == 'update'}">
    <sql:query var = "timerecord">
        select * from contractor_timerecords where record_id = ?

        <sql:param value = "${tr_id}"/>
    </sql:query>

    <c:set var = "tr" value = "${timerecord.rows[0]}"/>

    <c:set var = "ts_id" value = "${tr.timesheet_id}"/>
</c:if>

<sql:query var = "timesheet">
    select p.proposal_title, t.* from proponent_record p, contractor_timesheets t where t.contractor_id = ? and
    t.timesheet_id = ? and t.tracking_code = p.tracking_code

    <sql:param value = "${sessionScope.ctid}"/>

    <sql:param value = "${ts_id}"/>
</sql:query>

<c:set var = "ts" value = "${timesheet.rows[0]}"/>

<c:choose>
    <c:when test = "${act == 'delete'}">
        <c:choose>
            <c:when test = "${ts.status_id == 1}">
                <p>
                <cf:GetPhrase phrase_id = "870" lang_id = "${lang}"/> -

                <br>
                <b>

                <c:out value = "${ts.tracking_code}. ${ts.proposal_title}"/>

                (

                <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.start_date}'/>

                -

                <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.end_date}'/>)</b>?

                <p>
                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=c_tsr_update&act=dodelete&ts=<c:out value="${ts_id}" />">[

                <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/> ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=c_tsr_view&ts=<c:out value="${ts_id}" />">[

                <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/> ]</a>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "872" lang_id = "${lang}"/>

                !
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test = "${act == 'dodelete'}">
        <c:choose>
            <c:when test = "${ts.status_id == 1}">
                <sql:update>
                    delete from contractor_timerecords where timesheet_id = ?

                    <sql:param value = "${ts_id}"/>
                </sql:update>

                <sql:update>
                    delete from contractor_timesheets where timesheet_id = ?

                    <sql:param value = "${ts_id}"/>
                </sql:update>

                <c:import url = "contractors/tsm/dsp_tsr_main.jsp"/>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "872" lang_id = "${lang}"/>

                !
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test = "${act == 'submit'}">
        <c:choose>
            <c:when test = "${ts.status_id == 1}">
                <p>
                <cf:GetPhrase phrase_id = "871" lang_id = "${lang}"/> -

                <br>
                <b>

                <c:out value = "${ts.tracking_code}. ${ts.proposal_title}"/>

                (

                <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.start_date}'/>

                -

                <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.end_date}'/>)</b>?

                <p>
                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=c_tsr_update&act=dosubmit&ts=<c:out value="${ts_id}" />">[

                <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/> ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=c_tsr_view&ts=<c:out value="${ts_id}" />">[

                <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/> ]</a>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "873" lang_id = "${lang}"/>

                !
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test = "${act == 'dosubmit'}">
        <c:choose>
            <c:when test = "${ts.status_id == 1}">
                <sql:update>
                    update contractor_timesheets set status_id = 2 where timesheet_id = ?

                    <sql:param value = "${ts_id}"/>
                </sql:update>

                <c:import url = "contractors/tsm/dsp_tsr_main.jsp"/>
            </c:when>

            <c:otherwise>
                <cf:GetPhrase phrase_id = "873" lang_id = "${lang}"/>

                !
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test = "${act == 'update'}">
        <c:choose>
            <c:when test = "${ts.status_id == 1}">
                <fmt:parseDate var = 'date1' pattern = 'MMM-dd-yyyy' value = '${param.date}'/>

                <fmt:formatDate var = 'date' pattern = 'yyyy-MM-dd' value = '${date1}'/>

                <fmt:formatDate var = 'date_d' pattern = 'dd' value = '${date1}'/>

                <fmt:formatDate var = 'date_m' pattern = 'MM' value = '${date1}'/>

                <fmt:formatDate var = 'date_y' pattern = 'yyyy' value = '${date1}'/>

                <fmt:formatDate var = 'start_date_d' pattern = 'dd' value = '${ts.start_date}'/>

                <fmt:formatDate var = 'start_date_m' pattern = 'MM' value = '${ts.start_date}'/>

                <fmt:formatDate var = 'start_date_y' pattern = 'yyyy' value = '${ts.start_date}'/>

                <fmt:formatDate var = 'end_date_d' pattern = 'dd' value = '${ts.end_date}'/>

                <c:choose>
                    <c:when test = "${(date_m != start_date_m) || (date_y != start_date_y) || (date_d < start_date_d) || (date_d > end_date_d)}">
                        <p>
                        <cf:GetPhrase phrase_id = "875" lang_id = "${lang}"/>: <b>

                        <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.start_date}'/>

                        -

                        <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${ts.end_date}'/></b>

                        <p>
                        <a STYLE="text-decoration: underline"  href = "javascript: history.back()"><<<cf:GetPhrase phrase_id="864" lang_id="${lang}" /></a>
		</c:when>
		<c:otherwise>
	
	<c:set var="spent"><c:out value="${param.spent}" default="0"/></c:set>  
	<c:set var="comment"><c:out value="${param.comment}" default=""/></c:set>  
	  
	  <sql:update>
		update contractor_timerecords
	    set
	    activity_date = ?,
	    hours_spent = ?,
	    comments = ?
	    where
	    record_id = ?
	    <sql:param value="${date}" />
	    <sql:param value="${spent}" />
	    <sql:param value="${comment}" />
	    <sql:param value="${tr_id}" />
	  </sql:update>
	  
	  <c:import url="contractors/tsm/dsp_tsr_view.jsp?ts=${ts_id}" />
	
		</c:otherwise>
	</c:choose>

	</c:when>
	<c:otherwise>
    <cf:GetPhrase phrase_id="874" lang_id="${lang}" />!
	</c:otherwise>
</c:choose>  
  
  
	</c:when>

  
  
	<c:when test="${act == 'add'}">
	  
	<c:choose>
		<c:when test="${ts.status_id == 1}">
		  
		<fmt:parseDate var='date1' pattern='MMM-dd-yyyy' value='${param.date}'/>
		<fmt:formatDate var='date' pattern='yyyy-MM-dd' value='${date1}'/>
		
		<fmt:formatDate var='date_d' pattern='dd' value='${date1}'/>
		<fmt:formatDate var='date_m' pattern='MM' value='${date1}'/>
		<fmt:formatDate var='date_y' pattern='yyyy' value='${date1}'/>
		
		<fmt:formatDate var='start_date_d' pattern='dd' value='${ts.start_date}'/>
		<fmt:formatDate var='start_date_m' pattern='MM' value='${ts.start_date}'/>
		<fmt:formatDate var='start_date_y' pattern='yyyy' value='${ts.start_date}'/>
		<fmt:formatDate var='end_date_d' pattern='dd' value='${ts.end_date}'/>
		
		<c:choose>
		<c:when test="${(date_m != start_date_m) || (date_y != start_date_y) || (date_d < start_date_d) || (date_d > end_date_d)}">
		      <p><cf:GetPhrase phrase_id="875" lang_id="${lang}" />: <b><fmt:formatDate pattern='MMM-dd-yyyy' value='${ts.start_date}'/> - <fmt:formatDate pattern='MMM-dd-yyyy' value='${ts.end_date}'/></b>
		      <p><a STYLE="text-decoration: underline"  href="javascript:history.back()"><< <cf:GetPhrase phrase_id="864" lang_id="${lang}" /></a>
		</c:when>
		<c:otherwise>
		
			<c:set var="spent"><c:out value="${param.spent}" default="0"/></c:set>  
			<c:set var="comment"><c:out value="${param.comment}" default=""/></c:set>  
			  
			  <sql:update>
			    insert into contractor_timerecords
			    (activity_date, hours_spent, comments, timesheet_id)
			    values
			    (?, ?, ?, ?)
			    <sql:param value="${date}" />
			    <sql:param value="${spent}" />
			    <sql:param value="${comment}" />
			    <sql:param value="${ts_id}" />
			  </sql:update>
			
			  <c:import url="contractors/tsm/dsp_tsr_view.jsp?ts=${ts_id}" />
		  
		</c:otherwise>
	</c:choose>
	  

	</c:when>
	<c:otherwise>
		<cf:GetPhrase phrase_id="874" lang_id="${lang}" />!
	</c:otherwise>
</c:choose>  
  
	</c:when>
  
</c:choose>







