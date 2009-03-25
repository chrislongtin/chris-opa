<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "list_id">
    <c:out value = "${param.list}" default = ""/>
</c:set>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:if test = "${!empty list_id}">
    <sql:query var = "list_c">
        select list_id from mailinglists where list_id = ? and coordinator_id
        = ?

        <sql:param value = "${list_id}"/>

        <sql:param value = "${sessionScope.coord_id}"/>
    </sql:query>

    <c:if test = "${list_c.rowCount == 1}">
        <c:choose>
            <c:when test = "${act=='doedit'}">

                <%@ include file = "../../guard_required_params.jsp"%>

                <%
                GuardRequiredParams guard = new GuardRequiredParams(request);

                if (guard.isParameterMissed())
                    {
                    out.write(guard.getSplashScreen());
                    return;
                    }
                %>

                <c:set var = "list_name">
                    <c:out value = "${param.list_name}"
                           default = "<cf:GetPhrase phrase_id="940" lang_id="${lang}" /> ${list_id}"/>
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

                <c:if test = "${default==1}">
                    <sql:update>
                        update mailinglists set default_list = 0 where
                        coordinator_id = ?

                        <sql:param value = "${sessionScope.coord_id}"/>
                    </sql:update>
                </c:if>

                <sql:update>
                    update mailinglists set list_name = ?, list_descr = ?,
                    list_topic = ?, default_list = ? where list_id = ?

                    <sql:param value = "${list_name}"/>

                    <sql:param value = "${list_descr}"/>

                    <sql:param value = "${list_topic}"/>

                    <sql:param value = "${default}"/>

                    <sql:param value = "${list_id}"/>
                </sql:update>
            </c:when>

            <c:when test = "${act=='del'}">
                <sql:query var = "mess">
                    select message_id from messages where list_id = ?

                    <sql:param value = "${list_id}"/>
                </sql:query>

                <c:forEach var = "row" items = "${mess.rows}">
                    <sql:update>
                        delete from sentto where message_id = ?

                        <sql:param value = "${row.message_id}"/>
                    </sql:update>
                </c:forEach>

                <sql:update>
                    delete from messages where list_id = ?

                    <sql:param value = "${list_id}"/>
                </sql:update>

                <sql:query var = "lm">
                    select member_id from listmembers where list_id = ?

                    <sql:param value = "${list_id}"/>
                </sql:query>

                <c:forEach var = "row" items = "${lm.rows}">
                    <sql:query var = "alm">
                        select list_id from listmembers where member_id = ?
                        and list_id<> ?
        <sql:param value="${row.member_id}" />
        <sql:param value="${list_id}" />
    	</sql:query>
      
      <c:if test="${alm.rowCount == 0}">
        <sql:update>
        	delete from listmembers
          where list_id = ? and
          member_id = ?
          <sql:param value="${list_id}" />
          <sql:param value="${row.member_id}" />
        </sql:update>
        <sql:update>
        	delete from members
          where member_id = ?
          <sql:param value="${row.member_id}" />
        </sql:update>
      </c:if>
      
    </c:forEach>
    
    <sql:update>
    	delete from mailinglists
      where list_id = ?
      <sql:param value="${list_id}" />
    </sql:update>
    

	</c:when>




	<c:when test="${act=='default'}">
    <sql:update>
    	update mailinglists 
      set default_list = 0
      where coordinator_id = ?
      <sql:param value="${sessionScope.coord_id}" />
    </sql:update>  
    <sql:update>
    	update mailinglists 
      set default_list = 1
      where list_id = ?
      <sql:param value="${list_id}" />
    </sql:update>  
	</c:when>
  
</c:choose>
  
  
  </c:if>
</c:if>

<c:import url="communication/dsp_comm_ml.jsp"/>







