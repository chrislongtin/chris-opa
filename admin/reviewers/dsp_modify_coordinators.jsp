<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "act">
    <c:out value = "${param.act}" default = ""/>
</c:set>

<!--- add, or edit coordinators --->

<c:choose>
    <c:when test = "${act=='add'}">
        <h3>

        <cf:GetPhrase phrase_id = "328" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

        <form action = "index.jsp?fuseaction=act_coordinator" method = "post">
            <input type = "hidden" name = "act" value = "add"> <input type = "hidden"
                   name = "coordinator_lastname_required"
                   value = "<cf:GetPhrase phrase_id="697" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_firstname_required"
                   value = "<cf:GetPhrase phrase_id="698" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_login_required"
                   value = "<cf:GetPhrase phrase_id="699" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_email_required"
                   value = "<cf:GetPhrase phrase_id="702" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_password_required"
                   value = "<cf:GetPhrase phrase_id="701" lang_id="${lang}" />">
            <input type = "hidden" name = "coordinator_phone_required"
                   value = "<cf:GetPhrase phrase_id="703" lang_id="${lang}" />">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "330" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_firstname" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "329" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_lastname" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_login" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_password" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_email" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_phone" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "coordinator_fax" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "coordinator_address" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "332" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "receive_public_emails" value = "1">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "333" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "coordinator_public_email" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "334" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "receive_admin_emails" value = "1">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "335" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "coordinator_admin_email" size = "30">

            <p>
            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>

    <c:when test = "${act=='edit'}">
        <c:set var = "coordinator_id">
            <c:out value = "${param.coordinator_id}" default = ""/>
        </c:set>

        <sql:query var = "edit_coord">
            select * from coordinators where coordinator_id = ?

            <sql:param value = "${coordinator_id}"/>
        </sql:query>

        <c:set var = "ec" value = "${edit_coord.rows[0]}" scope = "page"/>

        <h3>

        <cf:GetPhrase phrase_id = "336" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

        <form action = "index.jsp?fuseaction=act_coordinator" method = "post">
            <input type = "hidden" name = "coordinator_id" value = "<c:out value="${ec.coordinator_id}" />">
            <input type = "hidden" name = "act" value = "edit"> <input type = "hidden"
                   name = "coordinator_lastname_required"
                   value = "<cf:GetPhrase phrase_id="697" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_firstname_required"
                   value = "<cf:GetPhrase phrase_id="698" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_login_required"
                   value = "Y<cf:GetPhrase phrase_id="699" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_email_required"
                   value = "<cf:GetPhrase phrase_id="702" lang_id="${lang}" />"> <input type = "hidden"
                   name = "coordinator_password_required"
                   value = "<cf:GetPhrase phrase_id="701" lang_id="${lang}" />">
            <input type = "hidden" name = "coordinator_phone_required"
                   value = "<cf:GetPhrase phrase_id="703" lang_id="${lang}" />">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "330" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_firstname" value = "<c:out value="${ec.coordinator_firstname}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "329" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_lastname" value = "<c:out value="${ec.coordinator_lastname}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "331" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_login" value = "<c:out value="${ec.coordinator_login}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "92" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "password"                                      name = "coordinator_password"
                   value = "<c:out value="${ec.coordinator_password}" />" size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "24" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_email" value = "<c:out value="${ec.coordinator_email}" />"
                   size = "30">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "62" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "coordinator_phone" value = "<c:out value="${ec.coordinator_phone}" />"
                   size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "29" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "coordinator_fax" value = "<c:out value="${ec.coordinator_fax}" />" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "61" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text" name = "coordinator_address" value = "<c:out value="${ec.coordinator_address}" />"
                   size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "332" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "receive_public_emails" value = "1" <c:if
                   test = "${ec.receive_public_emails==1}"> checked

            </c:if>

            >

            <p>
            <b>

            <cf:GetPhrase phrase_id = "333" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text"                                              name = "coordinator_public_email"
                   value = "<c:out value="${ec.coordinator_public_email}" />" size = "30">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "334" lang_id = "${lang}"/>:</b>
            <input type = "checkbox" name = "receive_admin_emails" value = "1" <c:if
                   test = "${ec.receive_admin_emails==1}"> checked

            </c:if>

            >

            <p>
            <b>

            <cf:GetPhrase phrase_id = "335" lang_id = "${lang}"/>:</b>

            <br>
            <input type = "text"                                             name = "coordinator_admin_email"
                   value = "<c:out value="${ec.coordinator_admin_email}" />" size = "30">

            <p>
            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>
</c:choose>
