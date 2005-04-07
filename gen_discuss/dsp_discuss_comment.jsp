<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<% /*<!--- archive comment view and compose page --->*/
%>

<c:set var = "act">
    <c:out value = "${param.act}" default = "view"/>
</c:set>

<sql:query var = "download_dir">
    select host_url, public_attachments from initiative_setup
</sql:query>

<c:set var = "host_url" value = "${download_dir.rows[0].host_url}"/>

<c:set var = "public_attachments" value = "${download_dir.rows[0].public_attachments}"/>

<p>
<font size = "+1"><b>

<cf:GetPhrase phrase_id = "31" lang_id = "${lang}"/></b></font><c:choose>
    <c:when test = "${act == 'view'}">
        <p>
        <cf:GetPhrase phrase_id = "36" lang_id = "${lang}"/>
        <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='discuss_comment'/>
<c:param name='lang' value='${lang}'/>
<c:param name='act' value='add'/>
</c:url>"><b>

        <cf:GetPhrase phrase_id = "37" lang_id = "${lang}"/></b></a>

        <p>
        <hr size = "1">
        <sql:query var = "QueryName">
            select * from discussion where doc_id = 0 AND discuss_parent = 0 order by discuss_date desc, discussion_id
            desc
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
            <c:out value = "${param.level}" default = "0"/>
        </c:set>

        <ul>
            <c:forEach var = "row" items = "${QueryName.rows}">
                <p>
                <li><font size = "3"><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='discuss_comment'/>
<c:param name='lang' value='${lang}'/>
<c:param name='show_msg' value='yes'/>
<c:param name='id_num' value='${row.discussion_id}'/>
</c:url>">

                <c:out value = "${row.discuss_subject}"/></a> <i><c:choose>
                    <c:when test = "${row.discuss_author != ''}">
                        <c:out value = "${row.discuss_author}"/>
                    </c:when>

                    <c:otherwise>
                        <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
                    </c:otherwise>
                </c:choose>

                </i></font>

                <c:if test = "${row.discussion_id == id_num && show_msg == 'yes'}">
                    <table border = "0" cellspacing = "0" cellpadding = "5">
                        <td bgcolor = "E1E1E1">
                            <font face = "Arial" size = "-2">

                            <fmt:formatDate value = "${row.discuss_date}" pattern = "MMM dd, yyyy"/> |
                            <a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='discuss_comment'/>
<c:param name='lang' value='${lang}'/>
<c:param name='act' value='add'/>
<c:param name='discuss_parent' value='${row.discussion_id}'/>
</c:url>">

                            <cf:GetPhrase phrase_id = "39" lang_id = "${lang}"/></a></font>

                            <p>
                            <font face = "Arial" size = "-1">

                            <cf:ParagraphFormat value = "${row.discuss_message}"/>

                            <br>
                            <a STYLE="text-decoration: underline"  href = "docs/<c:out value='${row.discuss_attachment}'/>?ois=no">

                            <c:out value = "${row.discuss_attachment}"/></a></font>
                        </td>
                    </table>

                    <p>
                </c:if>

                <c:if test = "${row.discuss_replies != 0}">
                    <c:set var = "parent" value = "${row.discussion_id}"/>

                    <c:import url = "gen_discuss/dsp_discuss_thread.jsp?parent=${parent}"/>
                </c:if>
            </c:forEach>
        </ul>

<% /*<!--- general documents discussion section --->*/
%>

        <sql:query var = "doc_list">
            select doc_id, doc_title, doc_filename from documents where tracking_code = 0
        </sql:query>

        <c:if test = "${doc_list.rowCount > 0}">
            <hr size = "1">
            <h3>

            <cf:GetPhrase phrase_id = "514" lang_id = "${lang}"/></h3>
        </c:if>

        <table width = "300" border = "0" cellspacing = "0" cellpadding = "3">
            <c:forEach var = "row" items = "${doc_list.rows}">
                <tr>
                    <td>
                        <font face = "Arial" size = "-1"><a STYLE="text-decoration: underline"  href = "docs/<c:out value='${row.doc_filename}'/>?ois=no">

                        <c:out value = '${row.doc_title}'/></a>
                    </td>

                    <td>
                        <font face = "Arial"
                              size = "-1"><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='gen_doc_comment'/>
<c:param name='doc_id' value='${row.doc_id}'/>
<c:param name='lang' value='${lang}'/>
</c:url>">

                        <cf:GetPhrase phrase_id = "55" lang_id = "${lang}"/></a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>

    <c:when test = "${act == 'add'}">
        <c:set var = "discuss_level">
            <c:out value = "${param.discuss_level}" default = "1"/>
        </c:set>

        <c:set var = "discuss_parent">
            <c:out value = "${param.discuss_parent}" default = "0"/>
        </c:set>

        <c:if test = "${discuss_parent == 0}">
            <h4>

            <cf:GetPhrase phrase_id = "37" lang_id = "${lang}"/>:</h4>

            <cfelse>
                <h4>

                <cf:GetPhrase phrase_id = "39" lang_id = "${lang}"/>:</h4>

                <sql:query var = "message_reply">
                    select * from discussion where discussion_id = ?

                    <sql:param value = "${discuss_parent}"/>
                </sql:query>

                <c:forEach var = "row" items = "${message_reply.rows}">
                    <hr size = "1">
                    <c:out value = "${row.discuss_subject}"/>

                    <i><c:choose>
                        <c:when test = "${row.discuss_author == ''}">
                            <cf:GetPhrase phrase_id = "38" lang_id = "${lang}"/>
                        </c:when>

                        <c:otherwise>
                            <c:out value = "${row.discuss_author}"/>
                        </c:otherwise>
                    </c:choose>

                    </i>

                    <br>
                    <font size = "-2">

                    <fmt:formatDate value = "${row.discuss_date}" pattern = "MMM dd, yyyy"/></font>

                    <br>
                    <menu><cf:ParagraphFormat value = "${row.discuss_message}"/></menu>

                    <hr size = "1">
                    <c:set var = "discuss_level" value = "${discuss_level + 1}"/>
                </c:forEach>
            </c:if>

            <p>
            <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

            <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_discuss_comment'/>
<c:param name='lang' value='${lang}'/>
</c:url>"
                  method = "post"
                  ENCTYPE = "multipart/form-data">
                <input type = "hidden" name = "tracking_code" value = "0">
                <input type = "hidden" name = "doc_id" value = "0">
                <input type = "hidden" name = "cfp_code" value = "0">
                <input type = "hidden" name = "discuss_level" value = "<c:out value='${discuss_level}'/>">
                <input type = "hidden" name = "discuss_parent" value = "<c:out value='${discuss_parent}'/>">
                <input type = "hidden"
                       name = "discuss_message_required"
                       value = "<cf:GetPhrase phrase_id="516" lang_id="${lang}"/>">
                <input type = "hidden" name = "discuss_subject_required"
                       value = "<cf:GetPhrase phrase_id="517" lang_id="${lang}"/>"> <font color = "FF0000"><b>*

                <cf:GetPhrase phrase_id = "42" lang_id = "${lang}"/>:</b></font>
                <input type = "text" name = "discuss_subject" size = "40">

                <p>
                <b>

                <cf:GetPhrase phrase_id = "43" lang_id = "${lang}"/>:</b>
                <input type = "text" name = "discuss_author"> <i>(

                <cf:GetPhrase phrase_id = "45" lang_id = "${lang}"/>)</i>

                <br>
                <b>

                <cf:GetPhrase phrase_id = "44" lang_id = "${lang}"/>:</b> <input type = "text" name = "discuss_email">
                <i>(

                <cf:GetPhrase phrase_id = "45" lang_id = "${lang}"/>)</i>

                <p>
                <font color = "FF0000">* <b>

                <cf:GetPhrase phrase_id = "46" lang_id = "${lang}"/>:</b></font>

                <br>
                <textarea name = "discuss_message" cols = "60" rows = "15" wrap>
                </textarea>

                <c:if test = "${public_attachments == 1}">
                    <p>
                    <b>

                    <cf:GetPhrase phrase_id = "47" lang_id = "${lang}"/>:</b>

                    <br>
                    <input type = "file" name = "discuss_attachment" size = "40">

                    <br>
                    <i>

                    <cf:GetPhrase phrase_id = "48" lang_id = "${lang}"/></i>
                </c:if>

                <p>
                <input type = "submit" value = "<cf:GetPhrase phrase_id="50" lang_id="${lang}" />">
            </form>

            <p>
            <cf:GetPhrase phrase_id = "49" lang_id = "${lang}"/>
        </c:when>
    </c:choose>