<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- convert phrases from one language to another --->

<!--- set lang_id1 to the first language identifier number selected --->

<c:set var = "lang_id1" value = "${param.lang_id1}"/>

<!--- set lang_id2 to the second language identifier number selected --->
<c:set var = "lang_id2" value = "${param.lang_id2}"/>

<!--- check to make sure both languages are not the same --->
<c:choose>
    <c:when test = "${lang_id1 == lang_id2}">
        <p>
        <br>
        <h3>

        <cf:GetPhrase phrase_id = "236" lang_id = "${lang}"/></h3>
    </c:when>

    <c:otherwise>

        <!--- selecting the phrases for each language from the phrases table --->
        <sql:query var = "primary_lang">
            select p1.phrase phrase1, p2.phrase phrase2, p1.phrase_id from
            phrases p1 left join phrases p2 on p1.phrase_id = p2.phrase_id and
            p1.lang_id = ? and p2.lang_id = ? where p1.lang_id = ? order by
            phrase1

            <sql:param value = "${lang_id1}"/>

            <sql:param value = "${lang_id2}"/>

            <sql:param value = "${lang_id1}"/>
        </sql:query>

        <!--- select the name of the first language --->
        <sql:query var = "lang_header1">
            select language from languages where lang_id = ?

            <sql:param value = "${lang_id1}"/>
        </sql:query>

        <!--- select the name of the second language --->
        <sql:query var = "lang_header2">
            select language from languages where lang_id = ?

            <sql:param value = "${lang_id2}"/>
        </sql:query>

        <font size = +1><b>

        <cf:GetPhrase phrase_id = "237" lang_id = "${lang}"/></b></font>

        <!--- sets how many rows to process on the submit page --->
        <c:set var = "maxrows" value = "${primary_lang.rowCount}"/>

        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_lang_convert'/>
<c:param name='${user}'/>
</c:url>"
              method = "post">
            <input type = "hidden" name = "maxrows"
            value = "<c:out value='${maxrows}'/>">
            <input type = "hidden" name = "lang_id2"
            value = "<c:out value='${lang_id2}'/>">

            <table border = "1" cellspacing = "0" cellpadding = "3"
                   valign = "TOP">
                <tr>
                    <td>
                        <font face = "Arial"><b>
                        <c:forEach var = "row" items = "${lang_header1.rows}">
                            <c:out value = '${row.language}'/>
                        </c:forEach>
                    </td>

                    <td>
                        <font face = "Arial"><b>
                        <c:forEach var = "row" items = "${lang_header2.rows}">
                            <c:out value = '${row.language}'/>
                        </c:forEach>
                    </td>
                </tr>

                <c:forEach var = "row" items = "${primary_lang.rows}">

                    <!--- <cfset dest_lang = "#Phrase_ID##qry_phrase2#"> --->

                    <tr>
                        <td>
                            <input type = "hidden" name = "phrase_id"
                            value = "<c:out value='${row.phrase_id}'/>"> <font face = "Arial"
                            size = "-1">

                            <c:out value = '${row.phrase1}'/>
                        </td>

                        <td>
                            <font face = "Arial"
                                  size = "-1"><input type = "text"
                                                     name = "dest<c:out value='${row.phrase_id}'/>"
                                                     size = "40"
                                                     value = "<c:out value='${row.phrase2}'/>">
                        </td>
                    </tr>
                </c:forEach>

                <tr>
                    <td colspan = "3">
                        <font face = "Arial" size = "-1" color = "FF0000">

                        <center>
                            <b>

                            <cf:GetPhrase phrase_id = "238"
                                          lang_id = "${lang}"/>.</b></font>

                        <p>
                        <input type = "submit"
                               value = " <cf:GetPhrase phrase_id="557" lang_id="${lang}" /> ">
                    </td>
                </tr>
            </table>
        </form>
    </c:otherwise>
</c:choose>
