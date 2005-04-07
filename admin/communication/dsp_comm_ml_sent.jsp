<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "message_id">
    <c:out value = "${param.message}" default = "0"/>
</c:set>

<c:set var = "list_id">
    <c:out value = "${param.list}" default = "0"/>
</c:set>

<c:choose>
    <c:when test = "${list_id > 0}">
        <sql:query var = "mess">
            select messages.*, mailinglists.list_name from mailinglists, messages where mailinglists.list_id = ? and
            mailinglists.coordinator_id = ? and messages.list_id = mailinglists.list_id order by messages.sent_date desc

            <sql:param value = "${list_id}"/>

            <sql:param value = "${sessionScope.coord_id}"/>
        </sql:query>

        <c:if test = "${mess.rowCount > 0}">
            <H3>

            <c:out value = "${mess.rows[0].list_name}"/>

            -

            <cf:GetPhrase phrase_id = "829" lang_id = "${lang}"/></H3>

            <c:forEach var = "row" items = "${mess.rows}">
                <p>
                <a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=comm_ml_sent&message=<c:out value="${row.message_id}" />">

                <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${row.sent_date}'/>

                -

                <c:out value = "${row.subject}"/></a></p>
            </c:forEach>
        </c:if>
    </c:when>

    <c:when test = "${message_id > 0}">
        <sql:query var = "m">
            select messages.*, mailinglists.list_name from mailinglists, messages where messages.list_id =
            mailinglists.list_id and messages.message_id = ? and mailinglists.coordinator_id = ?

            <sql:param value = "${message_id}"/>

            <sql:param value = "${sessionScope.coord_id}"/>
        </sql:query>

        <c:if test = "${m.rowCount == 1}">
            <c:set var = "mess" value = "${m.rows[0]}"/>

            <sql:query var = "mem">
                select distinct members.* from members, sentto where sentto.member_id = members.member_id and
                sentto.message_id = ? order by members.member_name

                <sql:param value = "${message_id}"/>
            </sql:query>

            <H3>

            <c:out value = "${mess.list_name}"/>

            -

            <cf:GetPhrase phrase_id = "839" lang_id = "${lang}"/></H3>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "188" lang_id = "${lang}"/>:</b>

            <fmt:formatDate pattern = 'MMM-dd-yyyy' value = '${mess.sent_date}'/></p>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "172" lang_id = "${lang}"/>:</b>

            <c:out value = "${mess.from_spc} <${mess.message_from}>"/></p>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "840" lang_id = "${lang}"/></b>:

            <c:set var = "count" value = "0"/><c:forEach var = "row" items = "${mem.rows}">
                <c:if test = "${count > 0}">
                    <c:out value = ", "/>
                </c:if>

                <c:out value = "${row.member_name} <${row.member_email}>"/>

                <c:set var = "count" value = "${count + 1}"/>
            </c:forEach>

            .</p>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:</b>

            <c:out value = "${mess.subject}"/></p>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "830" lang_id = "${lang}"/>:</b>

            <br>
            <cf:ParagraphFormat value = "${mess.message_text}"/>
        </c:if>
    </c:when>
</c:choose>
