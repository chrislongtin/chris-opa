<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:if test = "${empty sessionScope.lang}">
    <sql:query var = "q" sql = "select default_lang from initiative_setup"/>

    <c:choose>
        <c:when test = "${(empty q.rows[0].default_lang) or (q.rows[0].default_lang==0)}">
            <c:set var = "lang" scope = "session" value = "1"/>
        </c:when>

        <c:otherwise>
            <c:set var = "lang" scope = "session"
                   value = "${q.rows[0].default_lang}"/>
        </c:otherwise>
    </c:choose>
</c:if>

<!--- Processing User login information --->
<c:set var = "login_type">
    <c:out value = "${param.login_type}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${login_type=='coordinator'}">
        <c:set var = "coordinator_login">
            <c:out value = "${param.coordinator_login}" default = ""/>
        </c:set>

        <c:set var = "coordinator_password">
            <c:out value = "${param.coordinator_password}" default = ""/>
        </c:set>

        <sql:query var = "vlc">
            select coordinator_login, coordinator_id from coordinators where
            coordinator_login = ? and coordinator_password = ?

            <sql:param value = "${coordinator_login}"/>

            <sql:param value = "${coordinator_password}"/>
        </sql:query>

        <c:if test = "${empty vlc.rows[0].coordinator_login}">
            <c:out value = "${coordinator_login}<br>${coordinator_password}<br>"
                   escapeXml = "false"/>

            <cf:GetPhrase phrase_id = "381" lang_id = "${lang}"/>

            .

            <cf:GetPhrase phrase_id = "382" lang_id = "${lang}"/>

            <a STYLE = "text-decoration: underline"
               href = "dsp_login_coordinator.jsp">

            <cf:GetPhrase phrase_id = "383" lang_id = "${lang}"/></a>.

            <%
            if (true)
                return;
            %>
        </c:if>

        <c:set var = "user" value = "coordinator" scope = "session"/>

        <c:set var = "coord_id" value = "${vlc.rows[0].coordinator_id}"
               scope = "session"/>

        <sql:update>
            insert into user_logon_history values(?,?,?,NOW())

            <sql:param value = "${user}"/>

            <sql:param value = "${param.coordinator_login}"/>

            <sql:param value = "${param.coordinator_password}"/>
        </sql:update>

        <c:import url = "index.jsp?fuseaction=proposals"/>
    </c:when>

    <c:when test = "${login_type=='reviewer'}">
        <c:set var = "reviewer_login">
            <c:out value = "${param.reviewer_login}" default = ""/>
        </c:set>

        <c:set var = "reviewer_password">
            <c:out value = "${param.reviewer_password}" default = ""/>
        </c:set>

        <sql:query var = "vlr">
            select reviewer_login, reviewer_id, reviewer_coordinator from
            reviewers where reviewer_login = ? and reviewer_password = ?

            <sql:param value = "${reviewer_login}"/>

            <sql:param value = "${reviewer_password}"/>
        </sql:query>

        <c:if test = "${empty vlr.rows[0].reviewer_login}">
            <cf:GetPhrase phrase_id = "381" lang_id = "${lang}"/>

            .

            <cf:GetPhrase phrase_id = "382" lang_id = "${lang}"/>

            <a STYLE = "text-decoration: underline"
               href = "dsp_login_reviewer.jsp">

            <cf:GetPhrase phrase_id = "383" lang_id = "${lang}"/></a>.

            <%
            if (true)
                return;
            %>
        </c:if>

        <c:set var = "user" value = "reviewer" scope = "session"/>

        <c:set var = "rcoord" value = "${vlr.rows[0].reviewer_coordinator}"
               scope = "session"/>

        <c:set var = "rid" value = "${vlr.rows[0].reviewer_id}"
               scope = "session"/>

        <sql:update>
            insert into user_logon_history values(?,?,?,NOW())

            <sql:param value = "${user}"/>

            <sql:param value = "${param.reviewer_login}"/>

            <sql:param value = "${param.reviewer_password}"/>
        </sql:update>

        <c:import url = "index.jsp?fuseaction=proposals"/>
    </c:when>

    <c:when test = "${login_type=='contractor'}">
        <c:set var = "contractor_login">
            <c:out value = "${param.contractor_login}" default = ""/>
        </c:set>

        <c:set var = "contractor_password">
            <c:out value = "${param.contractor_password}" default = ""/>
        </c:set>

        <sql:query var = "vlr">
            select contractor_login, contractor_id from contractors where
            contractor_login = ? and contractor_password = ?

            <sql:param value = "${contractor_login}"/>

            <sql:param value = "${contractor_password}"/>
        </sql:query>

        <c:if test = "${empty vlr.rows[0].contractor_login}">
            <cf:GetPhrase phrase_id = "381" lang_id = "${lang}"/>

            .

            <cf:GetPhrase phrase_id = "382" lang_id = "${lang}"/>

            <a STYLE = "text-decoration: underline"
               href = "dsp_login_contractor.jsp">

            <cf:GetPhrase phrase_id = "383" lang_id = "${lang}"/></a>.

            <%
            if (true)
                return;
            %>
        </c:if>

        <c:set var = "user" value = "contractor" scope = "session"/>

        <c:set var = "ctid" value = "${vlr.rows[0].contractor_id}"
               scope = "session"/>

        <sql:update>
            insert into user_logon_history values(?,?,?,NOW())

            <sql:param value = "${user}"/>

            <sql:param value = "${param.contractor_login}"/>

            <sql:param value = "${param.contractor_password}"/>
        </sql:update>

        <c:import url = "index.jsp?fuseaction=c_tsr_main"/>
    </c:when>

    <c:when test = "${login_type=='public_contractor'}">
        <c:set var = "contractor_login">
            <c:out value = "${param.contractor_login}" default = ""/>
        </c:set>

        <c:set var = "contractor_password">
            <c:out value = "${param.contractor_password}" default = ""/>
        </c:set>

        <sql:query var = "vlr">
            select contractor_login, contractor_id from contractors where
            contractor_login = ? and contractor_password = ?

            <sql:param value = "${contractor_login}"/>

            <sql:param value = "${contractor_password}"/>
        </sql:query>

        <c:if test = "${empty vlr.rows[0].contractor_login}">
            <cf:GetPhrase phrase_id = "381" lang_id = "${lang}"/>

            .

            <cf:GetPhrase phrase_id = "382" lang_id = "${lang}"/>

            <a STYLE = "text-decoration: underline"
               href = "dsp_login_contractor.jsp">

            <cf:GetPhrase phrase_id = "383" lang_id = "${lang}"/></a>.

            <%
            if (true)
                return;
            %>
        </c:if>

        <c:set var = "user" value = "contractor" scope = "session"/>

        <c:set var = "ctid" value = "${vlr.rows[0].contractor_id}"
               scope = "session"/>

        <sql:update>
            insert into user_logon_history values(?,?,?,NOW())

            <sql:param value = "${user}"/>

            <sql:param value = "${param.contractor_login}"/>

            <sql:param value = "${param.contractor_password}"/>
        </sql:update>

        <c:import url = "../index.jsp?fuseaction=act_resume"/>
    </c:when>
</c:choose>
