<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@include  file ="../../taglibs_declarations.jsp"%> 

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

    String [] values = request.getParameterValues("members");

    pageContext.setAttribute("members", values);
%>

<c:set var = "list_id">
    <c:out value = "${param.list}" default = "0"/>
</c:set>

<c:set var = "from">
    <c:out value = "${param.from}" default = ""/>
</c:set>

<c:set var = "from_spc">
    <c:out value = "${param.from_spc}" default = ""/>
</c:set>

<c:set var = "subj">
    <c:out value = "${param.subj}" default = ""/>
</c:set>

<c:set var = "mess_body">
    <c:out value = "${param.mess_body}" default = ""/>
</c:set>

<c:set var = "send_to_all">
    <c:out value = "${param.send_to_all}" default = "0"/>
</c:set>

<sql:query var = "list">
    select list_name from mailinglists where list_id = ? and coordinator_id = ?

    <sql:param value = "${list_id}"/>

    <sql:param value = "${sessionScope.coord_id}"/>
</sql:query>

<c:if test = "${list.rowCount == 1}">
    <sql:query var = "m_id" maxRows = "1">
        select message_id from messages order by message_id desc
    </sql:query>

    <c:choose>
        <c:when test = "${m_id.rowCount == 0}">
            <c:set var = "message_id" value = "1"/>
        </c:when>

        <c:otherwise>
            <c:set var = "message_id" value = "${m_id.rows[0].message_id + 1}"/>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test = "${send_to_all == 1}">
            <sql:query var = "member">
                select members.* from members, listmembers where
                members.member_id = listmembers.member_id and
                listmembers.member_status = 1 and listmembers.list_id = ?
                order by members.member_name

                <sql:param value = "${list_id}"/>
            </sql:query>

            <c:if test = "${member.rowCount > 0}">
                <sql:update>
                    insert into messages ( message_id, list_id, sent_date,
                    message_from, message_text

                    <c:if test = "${!empty from_spc}">
                        , from_spc
                    </c:if>

                    <c:if test = "${!empty subj}">
                        , subject
                    </c:if>

                    ) values( ?, ?, CURDATE(), ?, ?

                    <c:if test = "${!empty from_spc}">
                        , ?
                    </c:if>

                    <c:if test = "${!empty subj}">
                        , ?
                    </c:if>

                    )

                    <sql:param value = "${message_id}"/>

                    <sql:param value = "${list_id}"/>

                    <sql:param value = "${from}"/>

                    <sql:param value = "${mess_body}"/>

                    <c:if test = "${!empty from_spc}">
                        <sql:param value = "${from_spc}"/>
                    </c:if>

                    <c:if test = "${!empty subj}">
                        <sql:param value = "${subj}"/>
                    </c:if>
                </sql:update>

                <c:forEach var = "row" items = "${member.rows}">
<%--                     <mt:mail session = "java:/comp/env/mail/session">
                        <mt:from>
                            <c:if test = "${!empty from_spc}">
                                "

                                <c:out value = "${from_spc}"/>

                                "
                            </c:if><<c:out value="${from}"/>></mt:from>
			<mt:setrecipient type="to"><c:out value="${row.member_email}"/></mt:setrecipient>
			<mt:subject><c:out value="${subj}"/></mt:subject>
			<mt:message>
			<c:out value="${mess_body}"/>
			</mt:message>
			<mt:send/>
			</mt:mail> --%>
		      <sm:Sendmail host = "leapfrogindex.com" domain = "leapfrogindex.com" port = "25"                
				    from = "${from_spc}"          to = "${row.member_email}" debug = "true"
				  subject = "${subj}"     content = "${mess_body}">
		     </sm:Sendmail>

<sql:update>
	insert into sentto
  (message_id, member_id)
  values
  (?, ?)
  <sql:param value="${message_id}" />
  <sql:param value="${row.member_id}" />
</sql:update>

</c:forEach>
</c:if>

	</c:when>



  
  <c:otherwise>

 <c:if test="${!empty members}">
 
<sql:update>
	insert into messages
  (
  message_id, 
  list_id, 
  sent_date, 
  message_from, 
  message_text
  <c:if test="${!empty from_spc}">
  , from_spc
  </c:if>
  <c:if test="${!empty subj}">
  , subject
  </c:if>
  )
  values(
  ?,
  ?, 
  CURDATE(),
  ?,
  ?
  <c:if test="${!empty from_spc}">
  , ?
  </c:if>
  <c:if test="${!empty subj}">
  , ?
  </c:if>
  
  )
  <sql:param value="${message_id}" />
  <sql:param value="${list_id}" />
  <sql:param value="${from}" />
  <sql:param value="${mess_body}" />
  <c:if test="${!empty from_spc}">
    <sql:param value="${from_spc}" />
  </c:if>
  <c:if test="${!empty subj}">
    <sql:param value="${subj}" />
  </c:if>
  
</sql:update>  

  
<c:forEach var="row" items="${members}">
	<sql:query var="member">
	select members.*
  from members
  where member_id = ?
  <sql:param value="${row}" />
  </sql:query>  
  <c:if test="${member.rowCount == 1}">
<%-- <mt:mail session="java:/comp/env/mail/session" >
<mt:from><c:if test="${!empty from_spc}">"<c:out value="${from_spc}" />" </c:if><<c:out value="${from}"/>></mt:from>
<mt:setrecipient type="to"><c:out value="${member.rows[0].member_email}"/></mt:setrecipient>
<mt:subject><c:out value="${subj}"/></mt:subject>
<mt:message>
<c:out value="${mess_body}"/>
</mt:message>
<mt:send/>
</mt:mail> --%>
		      <sm:Sendmail host = "leapfrogindex.com" domain = "leapfrogindex.com" port = "25"                
				    from = "${from_spc}"          to = "${member.rows[0].member_email}" debug = "true"
				  subject = "${subj}"     content = "${mess_body}">
		     </sm:Sendmail>

<sql:update>
	insert into sentto
  (message_id, member_id)
  values
  (?, ?)
  <sql:param value="${message_id}" />
  <sql:param value="${row}" />
</sql:update>
    
  </c:if>

</c:forEach>
 </c:if>
     
  </c:otherwise>

</c:choose>

<c:import url="communication/dsp_comm_ml_sent.jsp?message=${message_id}" />

</c:if>









