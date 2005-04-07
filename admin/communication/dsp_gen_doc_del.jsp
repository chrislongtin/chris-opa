<%@ page errorPage = "../dsp_error.jsp"%>
<%@ page import = "java.util.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<c:set var = "act">
    <c:out value = "${param.act}" default = "view"/>
</c:set>

<c:choose>
    <c:when test = "${act == 'view'}">

        <!--- general documents discussion section --->
        <sql:query var = "doc_list">
            select doc_id, doc_title, doc_filename from documents where tracking_code = 0
        </sql:query>

        <hr size = "1">
        <h3>

        <cf:GetPhrase phrase_id = "505" lang_id = "${lang}"/></h3>

        <table width = "300" border = "0" cellspacing = "0" cellpadding = "3">
            <c:forEach var = "row" items = "${doc_list.rows}">
                <tr>
                    <td>
                        <font face = "Arial"
                              size = "-1"><a STYLE="text-decoration: underline"  href = "../docs/<c:out value='${row.doc_filename}'/>?ois=no">

                        <c:out value = '${row.doc_title}'/></a>
                    </td>

                    <td>
                        <font face = "Arial"
                              size = "-1"><a STYLE="text-decoration: underline"  href = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='gen_doc_del'/>
<c:param name='act' value='delete'/>
<c:param name='doc_id' value='${row.doc_id}'/>
<c:param name='${user}'/>
</c:url>">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>

    <c:when test = "${act == 'delete'}">
        <sql:update var = "doc_delete">
            delete from documents where doc_id = ?

            <sql:param value = "${param.doc_id}"/>
        </sql:update>

        <sql:update var = "msg_del">
            delete from discussion where doc_id = ?

            <sql:param value = "${param.doc_id}"/>
        </sql:update>

        <c:import url = "communication/dsp_gen_doc_del.jsp?fuseaction=gen_doc_del&act=view&${user}"/>
    </c:when>
</c:choose>
