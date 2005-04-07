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

    String [] values = request.getParameterValues("members");

    pageContext.setAttribute("members", values);
%>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<c:set var = "member_id">
    <c:out value = "${param.member}" default = "0"/>
</c:set>

<c:set var = "list_id">
    <c:out value = "${param.list}" default = "0"/>
</c:set>

<c:set var = "active">
    <c:out value = "${param.active}" default = "0"/>
</c:set>

<c:set var = "member_name">
    <c:out value = "${param.member_name}" default = ""/>
</c:set>

<c:set var = "member_email">
    <c:out value = "${param.member_email}" default = ""/>
</c:set>

<c:set var = "del" value = "no"/>

<sql:query var = "member">
    select distinct members.* from members, listmembers, mailinglists where mailinglists.list_id = listmembers.list_id
    and mailinglists.coordinator_id = ? and listmembers.member_id = members.member_id and members.member_id = ?

    <sql:param value = "${sessionScope.coord_id}"/>

    <sql:param value = "${member_id}"/>
</sql:query>

<c:choose>
    <c:when test = "${(act=='edit') && (member.rowCount == 1)}">
        <sql:update>
            update members set member_name = ?, member_email = ? where member_id = ?

            <sql:param value = "${member_name}"/>

            <sql:param value = "${member_email}"/>

            <sql:param value = "${member_id}"/>
        </sql:update>

        <sql:update>
            update listmembers set member_status = ? where member_id = ? and list_id = ?

            <sql:param value = "${active}"/>

            <sql:param value = "${member_id}"/>

            <sql:param value = "${list_id}"/>
        </sql:update>

        <c:import url = "communication/dsp_comm_ml_members.jsp?list=${list_id}"/>
    </c:when>

    <c:when test = "${(act=='delfromlist') && (member.rowCount == 1)}">
        <p>
        <cf:GetPhrase phrase_id = "834" lang_id = "${lang}"/>?

        <p>
        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_ml_editmembers&act=dodelfromlist&member=<c:out value="${member_id}" />&list=<c:out value="${list_id}" />">[

        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/> ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_ml_members&list=<c:out value="${list_id}" />">[

        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/> ]</a>
    </c:when>

    <c:when test = "${(act=='dodelfromlist') && (member.rowCount == 1)}">
        <sql:update>
            delete from listmembers where member_id = ? and list_id = ?

            <sql:param value = "${member_id}"/>

            <sql:param value = "${list_id}"/>
        </sql:update>

        <sql:query var = "lm">
            select * from listmembers where member_id = ?

            <sql:param value = "${member_id}"/>
        </sql:query>

        <c:if test = "${lm.rowCount == 0}">
            <sql:update>
                delete from sentto where member_id = ?

                <sql:param value = "${member_id}"/>
            </sql:update>

            <sql:update>
                delete from members where member_id = ?

                <sql:param value = "${member_id}"/>
            </sql:update>
        </c:if>

        <c:import url = "communication/dsp_comm_ml_members.jsp?list=${list_id}"/>
    </c:when>

    <c:when test = "${(act=='del') && (member.rowCount == 1)}">
        <p>
        <cf:GetPhrase phrase_id = "835" lang_id = "${lang}"/>?

        <p>
        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_ml_editmembers&act=dodel&member=<c:out value="${member_id}" />&list=<c:out value="${list_id}" />">[

        <cf:GetPhrase phrase_id = "542" lang_id = "${lang}"/> ]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_ml_members&list=<c:out value="${list_id}" />">[

        <cf:GetPhrase phrase_id = "543" lang_id = "${lang}"/> ]</a>
    </c:when>

    <c:when test = "${(act=='dodel') && (member.rowCount == 1)}">
        <sql:update>
            delete from listmembers where member_id = ?

            <sql:param value = "${member_id}"/>
        </sql:update>

        <sql:update>
            delete from sentto where member_id = ?

            <sql:param value = "${member_id}"/>
        </sql:update>

        <sql:update>
            delete from members where member_id = ?

            <sql:param value = "${member_id}"/>
        </sql:update>

        <c:import url = "communication/dsp_comm_ml_members.jsp?list=${list_id}"/>
    </c:when>

    <c:when test = "${act=='create'}">
        <sql:query var = "listc">
            select * from mailinglists where list_id = ? and coordinator_id = ?

            <sql:param value = "${list_id}"/>

            <sql:param value = "${sessionScope.coord_id}"/>
        </sql:query>

        <c:if test = "${listc.rowCount == 1}">
            <sql:query var = "m_id" maxRows = "1">
                select member_id from members order by member_id desc
            </sql:query>

            <c:if test = "${m_id.rowCount!=0}">
                <c:set var = "member_id" value = "${m_id.rows[0].member_id + 1}"/>
            </c:if>

            <c:if test = "${m_id.rowCount==0}">
                <c:set var = "member_id" value = "1"/>
            </c:if>

            <sql:update>
                insert into members ( member_id, member_email

                <c:if test = "${!empty member_name}">
                    , member_name
                </c:if>

                ) values ( ?, ?

                <c:if test = "${!empty member_name}">
                    , ?
                </c:if>

                )

                <sql:param value = "${member_id}"/>

                <sql:param value = "${member_email}"/>

                <c:if test = "${!empty member_name}">
                    <sql:param value = "${member_name}"/>
                </c:if>
            </sql:update>

            <sql:update>
                insert into listmembers (member_id, list_id, member_status) values (?, ?, ?)

                <sql:param value = "${member_id}"/>

                <sql:param value = "${list_id}"/>

                <sql:param value = "${active}"/>
            </sql:update>

            <c:import url = "communication/dsp_comm_ml_members.jsp?list=${list_id}"/>
        </c:if>
    </c:when>

    <c:when test = "${act=='add'}">
        <c:forEach var = "m" items = "${members}">
            <sql:update>
                insert into listmembers (member_id, list_id, member_status) values (?, ?, 1)

                <sql:param value = "${m}"/>

                <sql:param value = "${list_id}"/>
            </sql:update>
        </c:forEach>

        <c:import url = "communication/dsp_comm_ml_members.jsp?list=${list_id}"/>
    </c:when>
</c:choose>
