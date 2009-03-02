<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- archive comment view and compose page --->

<c:set var = "act">
    <c:out value = "${param.act}" default = "view"/>
</c:set>

<c:set var = "doc_id">
    <c:out value = "${param.doc_id}" default = ""/>
</c:set>

<!--- retrieve proponent information from database related to particular document --->
<sql:query var = "doc_info">
    select d.doc_title, p.proponent_leader_firstname,
    p.proponent_leader_lastname, d.tracking_code, d.doc_filename, p.cfp_code
    from documents d, proponent_record p where d.doc_id = ? and
    d.tracking_code = p.tracking_code

    <sql:param value = "${doc_id}"/>
</sql:query>

<c:set var = "di" value = "${doc_info.rows[0]}" scope = "page"/>

<!--- setting directory name where docs are stored --->
<sql:query var = "download_dir">
    select host_url, public_attachments from initiative_setup
</sql:query>

<c:set var = "host_url" value = "${download_dir.rows[0].host_url}"
       scope = "page"/>

<c:set var = "public_attachments"
       value = "${download_dir.rows[0].public_attachments}"
       scope = "page"/>

<!--- document download link --->
<p>
<font size = "+1"><b>

<c:out value = "${di.doc_title}"/>

<cf:GetPhrase phrase_id = "33" lang_id = "${lang}"/></b></font>

<br>
<a STYLE = "text-decoration: underline"
   href = "index.jsp?fuseaction=archive_proposal&tracking_code=<c:out value="${di.tracking_code}" />&lang=<c:out value="${lang}" />"><i>

<c:out value = "${di.proponent_leader_firstname} ${di.proponent_leader_lastname}"/></i></a><c:if test = "${di.doc_filename!=''}">
    <p>
    <a STYLE = "text-decoration: underline"
       href = "docs/<c:out value="${di.doc_filename}" />?ois=no">

    <cf:GetPhrase phrase_id = "34" lang_id = "${lang}"/></a> |
    <a STYLE = "text-decoration: underline"
       href = "docs/<c:out value="${di.doc_filename}" />?ois=yes">

    <cf:GetPhrase phrase_id = "35" lang_id = "${lang}"/></a>
</c:if>

<c:set var = "cfp_code" value = "${di.cfp_code}" scope = "page"/><c:choose>
    <c:when test = "${act=='view'}">
        <p>
        <cf:GetPhrase phrase_id = "36" lang_id = "${lang}"/>

        <!--- link to add a new comment to this discussion --->
        <a STYLE = "text-decoration: underline"
        href = "index.jsp?fuseaction=archive_comment&doc_id=<c:out value="${doc_id}" />&cfp_code=<c:out value="${cfp_code}" />&act=add"> <b>

        <cf:GetPhrase phrase_id = "37" lang_id = "${lang}"/></b></a>

        <p>
        <hr size = "1">

        <!--- selecting messages related to document --->
        <sql:query var = "qn">
            select * from discussion where doc_id = ? and discuss_parent = 0
            order by discuss_date desc

            <sql:param value = "${doc_id}"/>
        </sql:query>

        <c:set var = "id_num">
            <c:out value = "${param.id_num}" default = "0"/>
        </c:set>

        <c:set var = "show_msg">
            <c:out value = "${param.show_msg}" default = "no"/>
        </c:set>

        <c:set var = "parent">
            <c:out value = "${param.parent}" default = "0"/>
        </c:set>

        <c:set var = "level">
            <c:out value = "${param.level}" default = "1"/>
        </c:set>

        <ul>
            <c:forEach items = "${qn.rows}" var = "row">

                <!--- messages output --->
                <p>
                <li><font size = "3"><a STYLE = "text-decoration: underline"
                                        href = "index.jsp?fuseaction=archive_comment&doc_id=<c:out value="${doc_id}" />&lang=<c:out value="${lang}" />&show_msg=yes&id_num=<c:out value="${row.discussion_id}" />">

                <c:out value = "${row.discuss_subject}"/></a> <i><c:choose>
                    <c:when test = "${row.discuss_author!=''}">
                        <c:out value = "${row.discuss_author}"/>
                    </c:when>

                    <c:otherwise>
                        <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
                    </c:otherwise>
                </c:choose>

                </i></font>

                <!--- body of message which appears after clicking on subject of message --->
                <c:if test = "${(row.discussion_id==id_num) and (show_msg=='yes')}">
                    <table border = "0" cellspacing = "0" cellpadding = "5">
                        <td bgcolor = "E1E1E1">
                            <font face = "Arial" size = "-2">

                            <fmt:formatDate value = "${row.discuss_date}"
                            pattern = "MMM dd, yyyy"/> | <a STYLE = "text-decoration: underline"
                            href = "index.jsp?fuseaction=archive_comment&doc_id=<c:out value="${doc_id}" />&lang=<c:out value="${lang}" />&act=add&discuss_parent=<c:out value="${row.discussion_id}" />">

                            <cf:GetPhrase phrase_id = "39"
                                          lang_id = "${lang}"/> </a></font>

                            <p>
                            <font face = "Arial" size = "-1">

                            <cf:ParagraphFormat value = "${row.discuss_message}"/>

                            <br>
                            <a STYLE = "text-decoration: underline"
                               href = "docs/<c:out value="${row.discuss_attachment}" />?ois=no">

                            <c:out value = "${row.discuss_attachment}"/></a></font>
                        </td>
                    </table>

                    <p>
                </c:if>

                <c:if test = "${row.discuss_replies!=0}">
                    <c:set var = "parent" value = "${row.discussion_id}"
                           scope = "page"/>

                    <c:import url = "archive/dsp_archive_thread.jsp?parent=${parent}"/>
                </c:if>
            </c:forEach>
        </ul>
    </c:when>

    <c:otherwise>
        <c:if test = "${act=='add'}">
            <c:set var = "discuss_level">
                <c:out value = "${param.discuss_level}" default = "1"/>
            </c:set>

            <c:set var = "discuss_parent">
                <c:out value = "${param.discuss_parent}" default = "0"/>
            </c:set>

            <c:choose>
                <c:when test = "${discuss_parent==0}">
                    <h4>

                    <cf:GetPhrase phrase_id = "40" lang_id = "${lang}"/>:</h4>
                </c:when>

                <c:otherwise>
                    <h4>

                    <cf:GetPhrase phrase_id = "39" lang_id = "${lang}"/>:</h4>

                    <!--- reply to a message, retrieving original message --->
                    <sql:query var = "message_reply">
                        select * from discussion where discussion_id = ?

                        <sql:param value = "${discuss_parent}"/>
                    </sql:query>

                    <c:set var = "mr" value = "${message_reply.rows[0]}"
                           scope = "page"/>

                    <!--- original message being replied to --->
                    <hr size = "1">
                    <c:out value = "${mr.discuss_subject}"/>

                    <i><c:choose>
                        <c:when test = "${mr.discuss_author==''}">
                            <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
                        </c:when>

                        <c:otherwise>
                            <c:out value = "${mr.discuss_author}"/>
                        </c:otherwise>
                    </c:choose>

                    </i>

                    <br>
                    <font size = "-2">

                    <fmt:formatDate value = "${mr.discuss_date}"
                                    pattern = "MMM dd, yyyy"/></font>

                    <br>
                    <menu>
                    <cf:ParagraphFormat value = "${mr.discuss_message}"/></menu>

                    <hr size = "1">
                    <c:set var = "discuss_level" value = "${discuss_level + 1}"
                           scope = "page"/>
                </c:otherwise>
            </c:choose>

            <p>
            <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

            <!--- input form for reply or new message --->
            <form action = "index.jsp?fuseaction=act_archive_comment&lang=<c:out value="${lang}" />"
                  method = "post"
                  ENCTYPE = "multipart/form-data">
                <input type = "hidden" name = "tracking_code"
                value = "<c:out value="${di.tracking_code}" />"> <input type = "hidden"
                name = "doc_id" value = "<c:out value="${doc_id}" />">
                <input type = "hidden" name = "cfp_code"
                value = "<c:out value="${di.cfp_code}" />"> <input type = "hidden"
                name = "discuss_level"
                value = "<c:out value="${discuss_level}" />"> <input type = "hidden"
                name = "discuss_parent"
                value = "<c:out value="${discuss_parent}" />"> <input type = "hidden"
                name = "discuss_message_required"
                value = "<cf:GetPhrase phrase_id="516" lang_id="${lang}" />"> <input type = "hidden" name = "discuss_subject_required" value = "<cf:GetPhrase phrase_id="517" lang_id="${lang}" />">
                <font color = "FF0000"><b>*

                <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:</b></font>
                <input type = "text" name = "discuss_subject" size = "40">

                <p>
                <b>

                <cf:GetPhrase phrase_id = "43" lang_id = "${lang}"/>:</b>
                <input type = "text" name = "discuss_author"> <i>(

                <cf:GetPhrase phrase_id = "45" lang_id = "${lang}"/>)</i>

                <br>
                <b>

                <cf:GetPhrase phrase_id = "44" lang_id = "${lang}"/>:</b>
                <input type = "text" name = "discuss_email"> <i>(

                <cf:GetPhrase phrase_id = "45" lang_id = "${lang}"/>)</i>

                <p>
                <font color = "FF0000">* <b>

                <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:</b></font>

                <br>
                <textarea name = "discuss_message" cols = "60" rows = "15" wrap>
                </textarea>

                <!--- if admin allows attachments --->
                <c:if test = "${public_attachments==1}">
                    <p>
                    <b>

                    <cf:GetPhrase phrase_id = "47" lang_id = "${lang}"/>:</b>

                    <br>
                    <input type = "file" name = "discuss_attachment"
                           size = "40">

                    <br>
                    <i>

                    <cf:GetPhrase phrase_id = "48" lang_id = "${lang}"/></i>
                </c:if>

                <p>
                <input type = "submit"
                       value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
            </form>

            <p>
            <cf:GetPhrase phrase_id = "49" lang_id = "${lang}"/>
        </c:if>
    </c:otherwise>
</c:choose>
