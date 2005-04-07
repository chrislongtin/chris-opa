<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

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

<c:set var = "list_id" value = "1"/>

<c:set var = "list_name">
    <c:out value = "${param.list_name}" default = ""/>
</c:set>

<c:set var = "list_descr">
    <c:out value = "${param.list_descr}" default = ""/>
</c:set>

<c:set var = "list_topic">
    <c:out value = "${param.list_topic}" default = ""/>
</c:set>

<c:set var = "default">
    <c:out value = "${param.default}" default = "0"/>
</c:set>

<%
    String [] values = request.getParameterValues("members");

    pageContext.setAttribute("members", values);
%>

<sql:query var = "list_num" maxRows = "1">
    select list_id from mailinglists order by list_id desc
</sql:query>

<c:if test = "${list_num.rowCount!=0}">
    <c:set var = "list_id" value = "${list_num.rows[0].list_id + 1}"/>

    <c:if test = "${default==1}">
        <sql:update>
            update mailinglists set default_list = 0 where coordinator_id = ?

            <sql:param value = "${sessionScope.coord_id}"/>
        </sql:update>
    </c:if>
</c:if>

<sql:update>
    insert into mailinglists ( list_id, list_name, coordinator_id,

    <c:if test = "${!empty list_descr}">
        list_descr,
    </c:if>

    <c:if test = "${!empty list_topic}">
        list_topic,
    </c:if>

    default_list ) values( ?, ?, ?,

    <c:if test = "${!empty list_descr}">
        ?,
    </c:if>

    <c:if test = "${!empty list_topic}">
        ?,
    </c:if>

    ? )

    <sql:param value = "${list_id}"/>

    <sql:param value = "${list_name}"/>

    <sql:param value = "${sessionScope.coord_id}"/>

    <c:if test = "${!empty list_descr}">
        <sql:param value = "${list_descr}"/>
    </c:if>

    <c:if test = "${!empty list_topic}">
        <sql:param value = "${list_topic}"/>
    </c:if>

    <sql:param value = "${default}"/>
</sql:update>

<c:forEach var = "member" items = "${members}">
    <sql:update>
        insert into listmembers (member_id, list_id, member_status) values (?, ?, 1)

        <sql:param value = "${member}"/>

        <sql:param value = "${list_id}"/>
    </sql:update>
</c:forEach>

<c:import url = "communication/dsp_comm_ml.jsp"/>
