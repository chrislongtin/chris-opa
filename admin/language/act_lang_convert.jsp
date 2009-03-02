<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- convert phrases from one language to another --->

<c:set var = "phrase">
    <c:out value = "${param.phrase}" default = ""/>
</c:set>

<c:set var = "lang_id">
    <c:out value = "${param.lang_id2}"/>
</c:set>

<c:forEach var = "id" items = "${paramValues.phrase_id}">
    <c:set var = "pid" value = "dest${id}"/>

    <c:set var = "phrase" value = "${param[pid]}"/>

    <sql:query var = "phrase_exists">
        select * from phrases where phrase_id = ? and lang_id = ?

        <sql:param value = "${id}"/>

        <sql:param value = "${lang_id}"/>
    </sql:query>

    <c:choose>
        <c:when test = "${phrase_exists.rowCount > 0 }">
            <sql:update var = "phrase_update">
                update phrases set phrase = ? where phrase_id = ? and lang_id
                = ?

                <sql:param value = "${phrase}"/>

                <sql:param value = "${id}"/>

                <sql:param value = "${lang_id}"/>
            </sql:update>
        </c:when>

        <c:otherwise>
            <c:if test = "${!empty phrase}">
                <sql:update var = "phrase_update">
                    insert into phrases ( phrase, phrase_id, lang_id ) values
                    ( ?, ?, ? )

                    <sql:param value = "${phrase}"/>

                    <sql:param value = "${id}"/>

                    <sql:param value = "${lang_id}"/>
                </sql:update>
            </c:if>
        </c:otherwise>
    </c:choose>
</c:forEach>

<c:import url = "language/dsp_lang_main.jsp?fuseaction=lang_main&${user}"/>
