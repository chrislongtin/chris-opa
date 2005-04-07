<%@ page errorPage = "dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "act_session_check_sub.jsp"%>

<!--- OPA admin header --->

<sql:query var = "setup">
    select application_name from initiative_setup
</sql:query>

<center>
    <h2>How Co-Browse Works</h2>
</center>

<font face = 'arial,helvetica' color = blue size = 2>

<p>
To start co-browsing, start the co-browse servlet (Click on the link below). On the main screen you create a session
(channel, presentation). Just type the name for new session. Have all persons you want to co-browse with you to start
the servlet also. As soon as you do that, everybody who is running the same servlet will be able to join this session
(channel). They need to choose a session from the list of opened sessions and type their own nickname (for real-time
chat).
</p>

<p>
As a session owner you will see a list of users joined to your channel. Type some URL in the control frame. All your
users will see the same. The browser on the client side doesn't need to be refreshed, your client will see the same
page entered in your window without his doing anything! Hit any link on the requested page or type another URL and
again your client will see it!
</p>

<p>
Co-browse supports real-time chat. So you may discuss your surfing with participants. </font>

</p>

<!--- CO-Browse For Reviewers --->
<center>
    <p>
    <font size = "2"><a STYLE="text-decoration: underline"  href = "../../<c:out value="${setup.rows[0].application_name}" />/servlet/Cobrowser"
                        target = "_new">

    <cf:GetPhrase phrase_id = "956" lang_id = "${lang}"/></a></font>
    </p>
</center>
