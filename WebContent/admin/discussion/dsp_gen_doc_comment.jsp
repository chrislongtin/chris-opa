<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- archive comment view and compose page --->

<c:set var = "act">
    <c:out value = "${param.act}" default = "view"/>
</c:set>

<c:set var = "doc_id">
    <c:out value = "${param.doc_id}" default = "0"/>
</c:set>

<!--- retrieve proponent information from database related to particular document --->
<sql:query var = "doc_info">
    select doc_title, doc_filename from admin_documents where doc_id = ?

    <sql:param value = "${doc_id}"/>
</sql:query>

<!--- setting directory name where docs are stored --->
<sql:query var = "download_dir">
    select host_url, public_attachments from initiative_setup
</sql:query>

<c:forEach var = "row" items = "${download_dir.rows}">
    <c:set var = "host_url" value = "${row.host_url}"/>

    <c:set var = "public_attachments" value = "${row.public_attachments}"/>
</c:forEach>

<!--- document download link --->
<c:forEach var = "row" items = "${doc_info.rows}">
    <p>
    <font size = "+1"><b>

    <c:out value = "${row.doc_title}"/>

    <fmt:message key = "33" /></b></font>

    <p>
    <a STYLE = "text-decoration: underline"
       href = "../docs/<c:out value='${row.doc_filename}'/>?ois=no">

    <fmt:message key = "34" /></a> |
    <a STYLE = "text-decoration: underline"
       href = "../docs/<c:out value='${row.doc_filename}'/>?ois=yes">

    <fmt:message key = "35" /></a>
</c:forEach>

<c:choose>
    <c:when test = "${act == 'view'}">
        <p>
        <fmt:message key = "36" />

        <!--- link to add a new comment to this discussion --->
        <a STYLE = "text-decoration: underline"
        href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='gen_doc_comment'/>
<c:param name='act' value='add'/>
<c:param name='lang' value='${lang}'/>
<c:param name='doc_id' value='${doc_id}'/>
</c:url>"> <b>

        <fmt:message key = "37" /></b></a>

        <p>
        <hr size = "1">

        <!--- selecting messages related to document --->
        <sql:query var = "QueryName">
            select * from admin_discussion where doc_id = ? and discuss_parent
            = 0 order by discuss_date desc, discussion_id desc

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
            <c:forEach var = "row" items = "${QueryName.rows}">

                <!--- messages output --->
                <p>
                <li><font size = "3"><a STYLE = "text-decoration: underline"
                                        href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='gen_doc_comment'/>
<c:param name='doc_id' value='${doc_id}'/>
<c:param name='lang' value='${lang}'/>
<c:param name='show_msg' value='yes'/>
<c:param name='id_num' value='${row.discussion_id}'/>
</c:url>">

                <c:out value = "${row.discuss_subject}"/></a> <i><c:choose>
                    <c:when test = "${!empty row.discuss_author}">
                        <c:out value = "${row.discuss_author}"/>
                    </c:when>

                    <c:otherwise>
                        <fmt:message key = "38" />
                    </c:otherwise>
                </c:choose>

                </i></font>

                <!--- body of message which appears after clicking on subject of message --->
                <c:if test = "${row.discussion_id == id_num && show_msg == 'yes'}">
                    <table border = "0" cellspacing = "0" cellpadding = "5">
                        <td bgcolor = "E1E1E1">
                            <font face = "Arial" size = "-2">

                            <fmt:formatDate value = "${row.discuss_date}"
                            pattern = "MMM dd, yyyy"/> | <a STYLE = "text-decoration: underline"
                            href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='gen_doc_comment'/>
<c:param name='doc_id' value='${doc_id}'/>
<c:param name='lang' value='${lang}'/>
<c:param name='act' value='add'/>
<c:param name='discuss_parent' value='${row.discussion_id}'/>
</c:url>">

                            <fmt:message key = "39"
                                          /> </a></font>

                            <p>
                            <font face = "Arial" size = "-1">

                            <cf:ParagraphFormat value = "${row.discuss_message}"/>

                            <br>
                            <a STYLE = "text-decoration: underline"
                               href = "docs/<c:out value='${row.discuss_attachment}'/>?ois=no">

                            <c:out value = "${row.discuss_attachment}"/></a></font>
                        </td>
                    </table>

                    <p>
                </c:if>

                <c:if test = "${row.discuss_replies != 0}">
                    <c:set var = "parent" value = "${row.discussion_id}"/>

                    <!--- this template retrieves subsequent replies to any first level messages --->
                    <c:import url = "discussion/dsp_discuss_doc_thread.jsp?parent=${parent}"/>
                </c:if>
            </c:forEach>
        </ul>
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

            <fmt:message key = "40" />:</h4>

            <cfelse>
                <h4>

                <fmt:message key = "39" />:</h4>

                <!--- reply to a message, retrieving original message --->
                <sql:query var = "message_reply">
                    select * from admin_discussion where discussion_id = ?

                    <sql:param value = "${discuss_parent}"/>
                </sql:query>

                <!--- original message being replied to --->
                <c:forEach var = "row" items = "${message_reply.rows}">
                    <hr size = "1">
                    <c:out value = "${row.discuss_subject}"/>

                    <i><c:choose>
                        <c:when test = "${empty row.discuss_author}">
                            Anonymous
                        </c:when>

                        <c:otherwise>
                            <c:out value = "${row.discuss_author}"/>
                        </c:otherwise>
                    </c:choose>

                    </i>

                    <br>
                    <font size = "-2">

                    <fmt:formatDate value = "${row.discuss_date}"
                                    pattern = "MMM dd, yyyy"/></font>

                    <br>
                    <menu>
                    <cf:ParagraphFormat value = "${row.discuss_message}"/></menu>

                    <hr size = "1">
                    <c:set var = "discuss_level"
                           value = "${discuss_level + 1}"/>
                </c:forEach>
            </c:if>

            <p>
            <fmt:message key = "41" />

            <!--- input form for reply or new message --->
            <c:forEach var = "row" items = "${doc_info.rows}">
                <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_gen_doc_comment'/>
<c:param name='lang' value='${lang}'/>
</c:url>"
                      method = "post"
                      ENCTYPE = "multipart/form-data">
                    <input type = "hidden" name = "doc_id"
                    value = "<c:out value='${doc_id}'/>"> <input type = "hidden"
                    name = "discuss_level"
                    value = "<c:out value='${discuss_level}'/>"> <input type = "hidden"
                    name = "discuss_parent"
                    value = "<c:out value='${discuss_parent}'/>">
            </c:forEach>

            <input type = "hidden" name = "discuss_message_required"
            value = "<fmt:message key='516'  />"> <input type = "hidden" name = "discuss_subject_required" value = "<fmt:message key='517'  />">
            <font color = "FF0000"><b>*

            <fmt:message key = "42" />:</b></font>
            <input type = "text" name = "discuss_subject" size = "40">

            <p>
            <b>

            <fmt:message key = "43" />:</b>
            <input type = "text" name = "discuss_author"> <i>(

            <fmt:message key = "45" />)</i>

            <br>
            <b>

            <fmt:message key = "44" />:</b>
            <input type = "text" name = "discuss_email"> <i>(

            <fmt:message key = "45" />)</i>

            <p>
            <font color = "FF0000">* <b>

            <fmt:message key = "46" />:</b></font>

            <br>
            <textarea name = "discuss_message" cols = "60" rows = "15" wrap>
            </textarea>

            <!--- if admin allows attachments --->
            <c:if test = "${public_attachments == 1}">
                <p>
                <b>

                <fmt:message key = "47" />:</b>

                <br>
                <input type = "file" name = "discuss_attachment" size = "40">

                <br>
                <i>

                <fmt:message key = "48" /></i>
            </c:if>

            <p>
            <input type = "submit"
                   value = "  <fmt:message key="456"  />  ">

            </form>

            <p>
            <fmt:message key = "49" />
        </c:when>
    </c:choose>
