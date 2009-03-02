<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "default_ml">
    select list_id, list_name, list_descr from mailinglists where default_list
    = 1 and coordinator_id = ?

    <sql:param value = "${sessionScope.coord_id}"/>
</sql:query>

<sql:query var = "mls">
    select list_id, list_name, list_descr from mailinglists where
    default_list<> 1 and
coordinator_id = ?
order by list_name
	<sql:param value="${sessionScope.coord_id}" />
</sql:query>


<h3><cf:GetPhrase phrase_id="800" lang_id="${lang}"/></h3>

<p><a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_new"><cf:GetPhrase phrase_id="802" lang_id="${lang}"/></a></p>
<hr size="1" noshade color="#DDDDDD">


<c:if test="${!empty default_ml.rows[0]}">
            <p><b><c:out value="${default_ml.rows[0].list_name}" /></b> - <cf:GetPhrase phrase_id="803" lang_id="${lang}" /></p>
            <p><c:out value="${default_ml.rows[0].list_descr}" /></p>
            <p><a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_edit&act=edit&list=<c:out value="${default_ml.rows[0].list_id}" />"><cf:GetPhrase phrase_id="804" lang_id="${lang}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_edit&act=del&list=<c:out value="${default_ml.rows[0].list_id}" />"><cf:GetPhrase phrase_id="805" lang_id="${lang}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_members&list=<c:out value="${default_ml.rows[0].list_id}" />"><cf:GetPhrase phrase_id="806" lang_id="${lang}" /></a><br>
              <br>
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_send&list=<c:out value="${default_ml.rows[0].list_id}"/>"><cf:GetPhrase phrase_id="808" lang_id="${lang}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_sent&list=<c:out value="${default_ml.rows[0].list_id}"/>"><cf:GetPhrase phrase_id="809" lang_id="${lang}" /></a> </p>
            <hr size="1" noshade color="#DDDDDD">
</c:if>

<c:forEach var="row" items="${mls.rows}">
            <p><b><c:out value="${row.list_name}" /></b></p>
            <p><c:out value="${row.list_descr}" /></p>
            <p><a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_edit&act=edit&list=<c:out value="${row.list_id}" />"><cf:GetPhrase phrase_id="804" lang_id="${lang}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_edit&act=del&list=<c:out value="${row.list_id}" />"><cf:GetPhrase phrase_id="805" lang_id="${lang}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_members&list=<c:out value="${row.list_id}" />"><cf:GetPhrase phrase_id="806" lang_id="${lang}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_edit&act=default&list=<c:out value="${row.list_id}" />"><cf:GetPhrase phrase_id="807" lang_id="${lang}" /></a><br>
              <br>
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_send&list=<c:out value="${row.list_id}"/>"><cf:GetPhrase phrase_id="808" lang_id="${lang}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <a STYLE="text-decoration: underline"  href="index.jsp?fuseaction=comm_ml_sent&list=<c:out value="${row.list_id}"/>"><cf:GetPhrase phrase_id="809" lang_id="${lang}" /></a> </p>
            <hr size="1" noshade color="#DDDDDD">
</c:forEach>









