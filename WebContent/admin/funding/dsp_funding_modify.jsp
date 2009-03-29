<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<!--- Modify or Add Funding Initiative Information --->

<c:choose>
    <c:when test = "${param.act == 'add'}">

        <!--- setting initiative number --->
        <sql:query var = "funding_initiative" maxRows = "1">
            select initiative_id from initiative_info order by initiative_id
            desc
        </sql:query>

        <c:choose>
            <c:when test = "${funding_initiative.rowCount == 0}">
                <c:set var = "initiative_id" value = "1"/>
            </c:when>

            <c:otherwise>
                <c:forEach var = "row" items = "${funding_initiative.rows}">
                    <c:set var = "initiative_id"
                           value = "${row.initiative_id + 1}"/>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <!--- determining if any languages have not been completed --->
        <sql:query var = "getlang">
            select l.language, l.lang_id from languages l left join
            initiative_info i on l.lang_id = i.lang_id where i.lang_id is null
        </sql:query>

        <!--- setting empty values to allow for the use of one form --->
        <c:set var = "initiative_name">
            <c:out value = "${param.initiative_name}" default = ""/>
        </c:set>

        <c:set var = "background">
            <c:out value = "${param.background}" default = ""/>
        </c:set>

        <c:set var = "eligibility">
            <c:out value = "${param.eligibility}" default = ""/>
        </c:set>

        <c:set var = "review_process">
            <c:out value = "${param.review_process}" default = ""/>
        </c:set>

        <c:set var = "proposal_format">
            <c:out value = "${param.proposal_format}" default = ""/>
        </c:set>

        <c:set var = "copyright">
            <c:out value = "${param.copyright}" default = ""/>
        </c:set>

        <c:set var = "record_lifecycle">
            <c:out value = "${param.record_lifecycle}" default = ""/>
        </c:set>

        <c:set var = "about_submitting">
            <c:out value = "${param.about_submitting}" default = ""/>
        </c:set>

        <c:set var = "ia_name">
            <c:out value = "${param.ia_name}" default = ""/>
        </c:set>

        <c:set var = "ia_email">
            <c:out value = "${param.ia_email}" default = ""/>
        </c:set>

        <c:set var = "ia_address">
            <c:out value = "${param.ia_address}" default = ""/>
        </c:set>

        <c:set var = "ia_courier">
            <c:out value = "${param.ia_courier}" default = ""/>
        </c:set>

        <c:set var = "ia_phone">
            <c:out value = "${param.ia_phone}" default = ""/>
        </c:set>

        <c:set var = "ia_fax">
            <c:out value = "${param.ia_fax}" default = ""/>
        </c:set>

        <c:set var = "ia_courier_inst">
            <c:out value = "${param.ia_courier_inst}" default = ""/>
        </c:set>

        <c:set var = "ia_url">
            <c:out value = "${param.ia_url}" default = ""/>
        </c:set>

        <c:set var = "admin_image_title">
            <c:out value = "${param.admin_image_title}" default = ""/>
        </c:set>

        <c:set var = "public_image_title">
            <c:out value = "${param.public_image_title}" default = ""/>
        </c:set>

        <c:set var = "image_toolbar">
            <c:out value = "${param.image_toolbar}" default = ""/>
        </c:set>

        <c:set var = "lang_id">
            <c:out value = "${param.lang_id}" default = ""/>
        </c:set>

        <c:set var = "ia_contact">
            <c:out value = "${param.ia_contact}" default = ""/>
        </c:set>
    </c:when>

    <c:when test = "${param.act == 'edit'}">
        <sql:query var = "funding_initiative">
            select * from initiative_info where lang_id = ?

            <sql:param value = "${param.lang_id}"/>
        </sql:query>

        <c:forEach var = "row" items = "${funding_initiative.rows}">
            <c:set var = "initiative_name" value = "${row.initiative_name}"/>

            <c:set var = "initiative_id" value = "${row.initiative_id}"/>

            <c:set var = "background" value = "${row.background}"/>

            <c:set var = "eligibility" value = "${row.eligibility}"/>

            <c:set var = "review_process" value = "${row.review_process}"/>

            <c:set var = "proposal_format" value = "${row.proposal_format}"/>

            <c:set var = "copyright" value = "${row.copyright}"/>

            <c:set var = "record_lifecycle" value = "${row.record_lifecycle}"/>

            <c:set var = "about_submitting" value = "${row.about_submitting}"/>

            <c:set var = "ia_name" value = "${row.ia_name}"/>

            <c:set var = "ia_email" value = "${row.ia_email}"/>

            <c:set var = "ia_address" value = "${row.ia_address}"/>

            <c:set var = "ia_courier" value = "${row.ia_courier}"/>

            <c:set var = "ia_phone" value = "${row.ia_phone}"/>

            <c:set var = "ia_fax" value = "${row.ia_fax}"/>

            <c:set var = "ia_courier_inst" value = "${row.ia_courier_inst}"/>

            <c:set var = "ia_url" value = "${row.ia_url}"/>

            <c:set var = "public_image_title"
                   value = "${row.public_image_title}"/>

            <c:set var = "admin_image_title"
                   value = "${row.admin_image_title}"/>

            <c:set var = "image_toolbar" value = "${row.image_toolbar}"/>

            <c:set var = "lang_id" value = "${row.lang_id}"/>

            <c:set var = "ia_contact" value = "${row.ia_contact}"/>
        </c:forEach>
    </c:when>
</c:choose>

<c:choose>
    <c:when test = "${param.act == 'add' && getlang.rowCount == 0}">
        <fmt:message key = "205" />
    </c:when>

    <c:otherwise>
        <p>
        <h3>

        <fmt:message key = "204" />:</h3>

        <p>
        <fmt:message key = "41" />

        <hr size = "1">
        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_funding'/>
<c:param name='${user}'/>
</c:url>"
              enctype = "multipart/form-data"
              method = "post">
            <input type = "hidden" name = "initiative_id"
            value = "<c:out value='${initiative_id}'/>"> <input type = "hidden"
            name = "act" value = "<c:out value='${param.act}'/>">
            <input type = "hidden" name = "initiative_name_required"
            value = "<fmt:message key='524' />"> <input type = "hidden" name = "eligibility_required" value = "<fmt:message key='525' />">
            <input type = "hidden" name = "review_process_required"
            value = "<fmt:message key='526' />"> <input type = "hidden" name = "copyright_required" value = "<fmt:message key='527' />">
            <input type = "hidden" name = "proposal_format_required"
            value = "<fmt:message key='528' />"> <input type = "hidden" name = "about_submitting_required" value = "<fmt:message key='529' />">
            <input type = "hidden" name = "ia_name_required"
            value = "<fmt:message key='530' />"> <input type = "hidden" name = "ia_email_required" value = "<fmt:message key='531' />">
            <input type = "hidden" name = "ia_address_required"
            value = "<fmt:message key='532' />"> <input type = "hidden" name = "ia_courier_required" value = "<fmt:message key='533' />">
            <input type = "hidden" name = "ia_phone_required"
            value = "<fmt:message key='534' />"> <input type = "hidden" name = "ia_fax_required" value = "<fmt:message key='535' />">
            <input type = "hidden" name = "ia_courier_inst_required"
            value = "<fmt:message key='536' />"><c:choose>
                <c:when test = "${param.act == 'add'}">
                    <p>
                    <b>

                    <fmt:message key = "206" />:</b>

                    <select name = "lang_id">
                        <c:forEach var = "row" items = "${getlang.rows}">
                            <option value = "<c:out value='${row.lang_id}'/>">
                            <c:out value = '${row.language}'/>
                        </c:forEach>
                    </select>
                </c:when>

                <c:when test = "${param.act == 'edit'}">
                    <input type = "hidden" name = "lang_id"
                           value = "<c:out value='${lang_id}'/>">
                </c:when>
            </c:choose>

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "207" />:</b></font>

            <br>
            <input type = "text"
                   name = "initiative_name"
                   value = "<c:out value='${initiative_name}'/>"
                   size = "60">

            <p>
            <b>

            <fmt:message key = "16" />:</b>

            <br>
            <textarea name = "background" cols = "50" rows = "3" wrap>
                <c:out value = '${background}'/>
            </textarea>

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "17" />:</b>

            <br>
            <textarea name = "eligibility" cols = "50" rows = "3" wrap>
                <c:out value = '${eligibility}'/>
            </textarea>

            <p>
            <b>*

            <fmt:message key = "18" />:</b>

            <br>
            <textarea name = "review_process" cols = "50" rows = "3" wrap>
                <c:out value = '${review_process}'/>
            </textarea>

            <p>
            <b>*

            <fmt:message key = "19" />:</b>

            <br>
            <textarea name = "copyright" cols = "50" rows = "3" wrap>
                <c:out value = '${copyright}'/>
            </textarea>

            <p>
            <b>*

            <fmt:message key = "20" />:</b>

            <br>
            <textarea name = "proposal_format" cols = "50" rows = "3" wrap>
                <c:out value = '${proposal_format}'/>
            </textarea>

            <p>
            <b>*

            <fmt:message key = "21" />:</b>

            <textarea name = "about_submitting" cols = "50" rows = "3" wrap>
                <c:out value = '${about_submitting}'/>
            </textarea>

            </font>

            <p>
            <b>

            <fmt:message key = "201" />:</b>

            <br>
            <input type = "file" name = "admin_image_title" size = "40">
            <c:if test = "${!empty admin_image_title}">
                <font color = "FF0000">"

                <c:out value = '${admin_image_title}'/>

                "

                <fmt:message key = "228" /></font>
            </c:if>

            <p>
            <b>

            <fmt:message key = "202" />:</b>

            <br>
            <input type = "file" name = "public_image_title" size = "40">
            <c:if test = "${!empty public_image_title}">
                <font color = "FF0000">"

                <c:out value = '${public_image_title}'/>

                "

                <fmt:message key = "228" /></font>
            </c:if>

            <p>
            <h3>

            <fmt:message key = "22" />:</h3>

            <p>
            <font color = "FF0000"><b>*

            <fmt:message key = "197" />:</b>

            <br>
            <input type = "text"                         name = "ia_name"
                   value = "<c:out value='${ia_name}'/>" size = "50">

            <p>
            <b>*

            <fmt:message key = "200" />:</b>

            <br>
            <input type = "text"                            name = "ia_contact"
                   value = "<c:out value='${ia_contact}'/>" size = "50">

            <p>
            <b>*

            <fmt:message key = "24" />:</b>

            <br>
            <input type = "text"                          name = "ia_email"
                   value = "<c:out value='${ia_email}'/>" size = "50">

            <p>
            <b>*

            <fmt:message key = "25" />:</b>

            <br>
            <input type = "text"                            name = "ia_address"
                   value = "<c:out value='${ia_address}'/>" size = "50">

            <p>
            <b>*

            <fmt:message key = "26" />:</b>

            <br>
            <input type = "text"                            name = "ia_courier"
                   value = "<c:out value='${ia_courier}'/>" size = "50">

            <p>
            <b>*

            <fmt:message key = "27" />:</b>

            <br>
            <textarea name = "ia_courier_inst" cols = "50" rows = "3" wrap>
                <c:out value = '${ia_courier_inst}'/>
            </textarea>

            <p>
            <b>*

            <fmt:message key = "62" />:</b>

            <br>
            <input type = "text"                          name = "ia_phone"
                   value = "<c:out value='${ia_phone}'/>" size = "25">

            <p>
            <b>*

            <fmt:message key = "29" />:</b>

            <br>
            <input type = "text"                        name = "ia_fax"
                   value = "<c:out value='${ia_fax}'/>" size = "25"></font>

            <p>
            <b>

            <fmt:message key = "208" />:</b>

            <br>
            <input type = "text" name = "ia_url" size = "50"
                   value = "<c:out value='${ia_url}'/>">

            <p>
            <input type = "submit"
                   value = " <fmt:message key="456"  /> ">
        </form>
    </c:otherwise>
</c:choose>
