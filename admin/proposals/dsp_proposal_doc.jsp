<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<c:set var = "act">
    <c:out value = "${param.act}" default = "add"/>
</c:set>

<c:set var = "doc_title">
    <c:out value = "${param.doc_title}" default = ""/>
</c:set>

<c:set var = "doc_id">
    <c:out value = "${param.doc_id}" default = ""/>
</c:set>

<c:set var = "doc_abstract">
    <c:out value = "${param.doc_abstract}" default = ""/>
</c:set>

<c:set var = "doc_filename">
    <c:out value = "${param.doc_filename}" default = ""/>
</c:set>

<c:set var = "doc_type_name">
    <c:out value = "${param.doc_type_name}" default = ""/>
</c:set>

<c:set var = "tracking_code">
    <c:out value = "${param.tracking_code}" default = ""/>
</c:set>

<c:choose>
    <c:when test = "${act=='edit'}">
        <sql:query var = "doc_edit">
            select * from documents where doc_id = ?

            <sql:param value = "${doc_id}"/>
        </sql:query>

        <c:set var = "doc_title" value = "${doc_edit.rows[0].doc_title}"
               scope = "page"/>

        <c:set var = "doc_abstract" value = "${doc_edit.rows[0].doc_abstract}"
               scope = "page"/>

        <c:set var = "doc_filename" value = "${doc_edit.rows[0].doc_filename}"
               scope = "page"/>

        <c:set var = "doc_type_id" value = "${doc_edit.rows[0].doc_type_id}"
               scope = "page"/>

        <sql:query var = "document_type">
            select * from document_types where doc_type_id = ?

            <sql:param value = "${doc_type_id}"/>
        </sql:query>

        <c:set var = "doc_type_name"
               value = "${document_type.rows[0].doc_type_name}"
               scope = "page"/>

        <p>
        <h3>

        <cf:GetPhrase phrase_id = "603" lang_id = "${lang}"/></h3>
    </c:when>

    <c:otherwise>
        <p>
        <h3>

        <cf:GetPhrase phrase_id = "604" lang_id = "${lang}"/></h3>
    </c:otherwise>
</c:choose>

<form action = "index.jsp?fuseaction=act_proposal_doc" method = "post"
      ENCTYPE = "multipart/form-data">
    <input type = "hidden" name = "tracking_code"
    value = "<c:out value="${tracking_code}" />">
    <input type = "hidden" name = "doc_title_required"
    value = "<cf:GetPhrase phrase_id="605" lang_id="${lang}" />"> <input type = "hidden"
    name = "act" value = "<c:out value="${act}" />">
    <c:if test = "${act=='edit'}">
        <input type = "hidden" name = "doc_id"
               value = "<c:out value="${doc_id}" />">
    </c:if>

    <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

    <p>
    <table>
        <tr>
            <td>
                <font face = "arial" size = "-1" color = "FF0000">*

                <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/>:
            </td>

            <td>
                <input type = "text" name = "doc_title" size = "30"
                       value = "<c:out value="${doc_title}" />">
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <cf:GetPhrase phrase_id = "606" lang_id = "${lang}"/>:
            </td>

            <td>
                <font face = "arial"
                size = "-1"><input type = "file" name = "doc_filename"
                size = "30"><c:if test = "${!empty doc_filename}">
                    <br>
                    <cf:GetPhrase phrase_id = "607" lang_id = "${lang}"/>

                    <c:out value = "${doc_filename}"/>
                </c:if>
            </td>
        </tr>

        <tr>
            <td>
                <font face = "arial" size = "-1">

                <cf:GetPhrase phrase_id = "608" lang_id = "${lang}"/>:
            </td>

            <td>
                <font face = "arial" size = "-1">

                <textarea name = "doc_abstract" cols = "50" rows = "5" wrap>
                    <c:out value = "${doc_abstract}"/>
                </textarea>
            </td>
        </tr>

        <sql:query var = "type_name">
            select * from document_types where doc_type_id > 0 order by
            doc_type_id
        </sql:query>

        <c:if test = "${type_name.rowCount!=0}">
            <tr>
                <td>
                    <font face = "arial" size = "-1">

                    <cf:GetPhrase phrase_id = "117" lang_id = "${lang}"/>:
                </td>

                <td>
                    <font face = "arial" size = "-1">

                    <select name = "doc_type_id">
                        <c:if test = "${!empty doc_type_name}">
                            <option value = "<c:out value="${doc_type_id}" />">
                            <c:out value = "${doc_type_name}"/>
                        </c:if>

                        <c:forEach items = "${type_name.rows}" var = "row">
                            <c:if test = "${row.doc_type_id!=doc_type_id}">
                                <option value = "<c:out value="${row.doc_type_id}" />"><c:out value = "${row.doc_type_name}"/>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </c:if>

        <tr>
            <td colspan = "2" align = "center">
                <input type = "submit"
                       value = "   <cf:GetPhrase phrase_id="456" lang_id="${lang}" />   ">
            </td>
        </tr>
    </table>
</form>
