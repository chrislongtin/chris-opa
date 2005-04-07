<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<!--- check for session.user variable to insure user logged in --->
<%@ include file = "../act_session_check_sub.jsp"%>

<sql:query var = "currency">
    select * from currency_code order by currency
</sql:query>

<sql:query var = "skills">
    select * from professional_skills order by skill_name
</sql:query>

<sql:query var = "agencies">
    select agency_id,agency_name from funding_agencies order by agency_name
</sql:query>

<!--- Add new CFP --->
<c:choose>
    <c:when test = "${param.act == 'add'}">
        <sql:query var = "next_code" maxRows = "1">
            select cfp_code from cfp_info order by cfp_code desc
        </sql:query>

        <c:choose>
            <c:when test = "${next_code.rowCount > 0}">
                <c:set var = "cfp_code" value = "${next_code.rows[0].cfp_code + 1}"/>
            </c:when>

            <c:otherwise>
                <c:set var = "cfp_code" value = "1"/>
            </c:otherwise>
        </c:choose>

        <p>
        <h3>

        <cf:GetPhrase phrase_id = "148" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

        <hr size = "1">
        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp'/>
<c:param name='${user}'/>
</c:url>" method = "post">
            <input type = "hidden" name = "cfp_code" value = "<c:out value='${cfp_code}'/>">
            <input type = "hidden" name = "act" value = "add"> <input type = "hidden"
                   name = "cfp_title_required"
                   value = "<cf:GetPhrase phrase_id='467' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_maxaward_required"
                   value = "<cf:GetPhrase phrase_id='469' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_maxaward_float"
                   value = "<cf:GetPhrase phrase_id='470' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_totalfunds_required"
                   value = "<cf:GetPhrase phrase_id='471' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_startdate_required"
                   value = "<cf:GetPhrase phrase_id='472' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_deadline_required"
                   value = "<cf:GetPhrase phrase_id='473' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_report_deadline_required"
                   value = "<cf:GetPhrase phrase_id='474' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_proposal_review_deadline_required"
                   value = "<cf:GetPhrase phrase_id='475' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_report_review_deadline_required"
                   value = "<cf:GetPhrase phrase_id='476' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "first_reminder_required"
                   value = "<cf:GetPhrase phrase_id='477' lang_id='${lang}'/>">
            <input type = "hidden" name = "second_reminder_required"
                   value = "<cf:GetPhrase phrase_id='478' lang_id='${lang}'/>">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/>

            : CFP-

            <c:out value = '${cfp_code}'/></b>

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/>:</b></font>

            <br>
            <input type = "text" name = "cfp_title" size = "50">

            <p>
            <b>

            <cf:GetPhrase phrase_id = "80" lang_id = "${lang}"/>:</b>

            <br>
            <textarea name = "cfp_background" cols = "50" rows = "8" wrap>
            </textarea>

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "82" lang_id = "${lang}"/>:</b></font>

            <br>
            $ <input type = "number" name = "cfp_maxaward" size = "10" value = "0.00">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "83" lang_id = "${lang}"/>:</b></font>

            <br>
            $ <input type = "number" name = "cfp_totalfunds" size = "10" value = "0.00">

            <p>
            <font color = "FF0000"><b>*

            <cf:GetPhrase phrase_id = "160" lang_id = "${lang}"/></b></font>

            <select name = "currency_id">
                <option value = "155" selected>USD

                <c:forEach var = "cur" items = "${currency.rows}">
                    <option value = "<c:out value='${cur.currency_id}'/>"><c:out value = '${cur.currency}'/>
                </c:forEach>
            </select>

            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>

                    <td>
                        <font face = "Arial" size = "-1">mmm-dd-yyyy
                    </td>
                </tr>

                <tr>
                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1" color = "FF0000"><b>*

                        <cf:GetPhrase phrase_id = "78" lang_id = "${lang}"/>:</b>
                    </td>

                    <td>
                        <input type = "date" name = "cfp_startdate" size = "10" value = "Jan-01-2004">
                    </td>
                </tr>

                <tr>
                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1" color = "FF0000"><b>*

                        <cf:GetPhrase phrase_id = "123" lang_id = "${lang}"/>:</b>
                    </td>

                    <td>
                        <input type = "date" name = "cfp_deadline" size = "10" value = "Jan-01-2004">
                    </td>
                </tr>

                <tr>
                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1" color = "FF0000"><b>*

                        <cf:GetPhrase phrase_id = "124" lang_id = "${lang}"/>:</b>
                    </td>

                    <td>
                        <input type = "date" name = "cfp_proposal_review_deadline" size = "10" value = "Jan-01-2010">
                    </td>
                </tr>

                <tr>
                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1" color = "FF0000"><b>*

                        <cf:GetPhrase phrase_id = "125" lang_id = "${lang}"/>:</b>
                    </td>

                    <td>
                        <input type = "date" name = "first_reminder" size = "10" value = "Jan-01-2010">
                    </td>
                </tr>

                <tr>
                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1" color = "FF0000"><b>*

                        <cf:GetPhrase phrase_id = "126" lang_id = "${lang}"/>:</b>
                    </td>

                    <td>
                        <input type = "date" name = "second_reminder" size = "10" value = "Jan-01-2010">
                    </td>
                </tr>

                <tr>
                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1" color = "FF0000"><b>*

                        <cf:GetPhrase phrase_id = "161" lang_id = "${lang}"/>:</b>
                    </td>

                    <td>
                        <input type = "date" name = "cfp_report_deadline" size = "10" value = "Jan-01-2020">
                    </td>
                </tr>

                <tr>
                    <td align = "RIGHT">
                        <font face = "Arial" size = "-1" color = "FF0000"><b>*

                        <cf:GetPhrase phrase_id = "162" lang_id = "${lang}"/>:</b>
                    </td>

                    <td>
                        <input type = "date" name = "cfp_report_review_deadline" size = "10" value = "Jan-01-2020">
                    </td>
                </tr>
            </table>

            <p>
            <b>

            <cf:GetPhrase phrase_id = "129" lang_id = "${lang}"/>:</b>

            <br>
            <textarea name = "cfp_format" cols = "50" rows = "3" wrap>
            </textarea>

            <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
        </form>
    </c:when>

    <c:when test = "${param.act == 'edit'}">
        <!--- Modify existing CFP --->

        <c:set var = "cfp_code">
            <c:out value = '${param.cfp_code}'/>
        </c:set>

        <c:set var = "agency_id">
            <c:out value = '${param.agency_id}'/>
        </c:set>

        <sql:query var = "edit_cfp">
            select CI.*, C.currency from cfp_info CI, currency_code C where cfp_code = ? AND CI.currency_id =
            C.currency_id

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <sql:query var = "edit_cfp_skills">
            select a.skill_id,b.skill_name from cfp_skills a, professional_skills b where a.cfp_code = ? and
            a.skill_id = b.skill_id order by b.skill_name

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <sql:query var = "edit_no_cfp_skills">
            select professional_skills.skill_id,professional_skills.skill_name from professional_skills LEFT JOIN
            cfp_skills on professional_skills.skill_id = cfp_skills.skill_id and cfp_skills.cfp_code = ? where
            cfp_skills.skill_id is null order by professional_skills.skill_name

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <sql:query var = "assigned_agency">
            select a.agency_id,b.agency_name from funding_agencies_cfp a, funding_agencies b where a.cfp_code = ? and
            a.agency_id = b.agency_id

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <sql:query var = "unassigned_agencies">
            select a.agency_id,a.agency_name from funding_agencies a LEFT JOIN funding_agencies_cfp b on a.agency_id =
            b.agency_id and b.cfp_code = ? where b.cfp_code is null order by a.agency_name asc

            <sql:param value = "${cfp_code}"/>
        </sql:query>

        <p>
        <h3>

        <cf:GetPhrase phrase_id = "163" lang_id = "${lang}"/>:</h3>

        <p>
        <cf:GetPhrase phrase_id = "41" lang_id = "${lang}"/>

        <hr size = "1">
        <form action = "<c:url value='index.jsp'>
<c:param name='fuseaction' value='act_cfp'/>
<c:param name='${user}'/>
</c:url>" method = "post">
            <input type = "hidden" name = "cfp_code" value = "<c:out value='${cfp_code}'/>">
            <input type = "hidden" name = "act" value = "edit"> <input type = "hidden"
                   name = "cfp_title_required"
                   value = "<cf:GetPhrase phrase_id='467' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_maxaward_required"
                   value = "<cf:GetPhrase phrase_id='469' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_maxaward_required"
                   value = "<cf:GetPhrase phrase_id='469' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_totalfunds_required"
                   value = "<cf:GetPhrase phrase_id='471' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_startdate_required"
                   value = "<cf:GetPhrase phrase_id='472' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_deadline_required"
                   value = "<cf:GetPhrase phrase_id='473' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_report_deadline_required"
                   value = "<cf:GetPhrase phrase_id='474' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_proposal_review_deadline_required"
                   value = "<cf:GetPhrase phrase_id='475' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "cfp_report_review_deadline_required"
                   value = "<cf:GetPhrase phrase_id='476' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "first_reminder_required"
                   value = "<cf:GetPhrase phrase_id='477' lang_id='${lang}'/>"> <input type = "hidden"
                   name = "second_reminder_required"
                   value = "<cf:GetPhrase phrase_id='478' lang_id='${lang}'/>">
            <c:forEach var = "row" items = "${edit_cfp.rows}">
                <p>
                <b>

                <cf:GetPhrase phrase_id = "56" lang_id = "${lang}"/>

                : CFP-

                <c:out value = '${row.cfp_code}'/></b>

                <p>
                <font color = "FF0000"><b>*

                <cf:GetPhrase phrase_id = "151" lang_id = "${lang}"/>:</b></font>

                <br>
                <input type = "text" name = "cfp_title" value = "<c:out value='${row.cfp_title}'/>" size = "50">

                <p>
                <b>

                <cf:GetPhrase phrase_id = "80" lang_id = "${lang}"/>:</b>

                <br>
                <textarea name = "cfp_background" cols = "50" rows = "3" wrap>
                    <c:out value = '${row.cfp_background}'/>
                </textarea>

                <p>
                <font color = "FF0000"><b>*

                <cf:GetPhrase phrase_id = "82" lang_id = "${lang}"/>:</b></font>

                <br>
                <input type = "number"
                       name = "cfp_maxaward"
                       value = "<fmt:formatNumber value='${row.cfp_maxaward}' type='currency' currencySymbol=''/>"
                       size = "25">

                <p>
                <font color = "FF0000"><b>*

                <cf:GetPhrase phrase_id = "83" lang_id = "${lang}"/>:</b></font>

                <br>
                <input type = "number"
                       name = "cfp_totalfunds"
                       value = "<fmt:formatNumber value='${row.cfp_totalfunds}' type='currency' currencySymbol=''/>"
                       size = "25">

                <p>
                <font color = "FF0000">*

                <cf:GetPhrase phrase_id = "160" lang_id = "${lang}"/></font>

                <select name = "currency_id">
                    <option value = "<c:out value='${row.currency_id}'/>"><c:out value = '${row.currency}'/>

                    <c:forEach var = "cur" items = "${currency.rows}">
                        <option value = "<c:out value='${cur.currency_id}'/>"><c:out value = '${cur.currency}'/>
                    </c:forEach>
                </select>

                </font>


                <table>
                    <tr>
                        <td>
                            &nbsp;
                        </td>

                        <td>
                            <font face = "Arial" size = "-1">mmm-dd-yyyy
                        </td>
                    </tr>

                    <tr>
                        <td align = "RIGHT">
                            <font face = "Arial" size = "-1" color = "FF0000"><b>*

                            <cf:GetPhrase phrase_id = "78" lang_id = "${lang}"/>:</b></font>
                        </td>

                        <td>
                            <input type = "date"
                                   name = "cfp_startdate"
                                   value = "<fmt:formatDate value='${row.cfp_startdate}' pattern='MMM-dd-yyyy'/>"
                                   size = "10">
                        </td>
                    </tr>

                    <tr>
                        <td align = "RIGHT">
                            <font face = "Arial" size = "-1" color = "FF0000"><b>*

                            <cf:GetPhrase phrase_id = "123" lang_id = "${lang}"/>:</b></font>
                        </td>

                        <td>
                            <input type = "date"
                                   name = "cfp_deadline"
                                   value = "<fmt:formatDate value='${row.cfp_deadline}' pattern='MMM-dd-yyyy'/>"
                                   size = "10">
                        </td>
                    </tr>

                    <tr>
                        <td align = "RIGHT">
                            <font face = "Arial" size = "-1" color = "FF0000"><b>*

                            <cf:GetPhrase phrase_id = "124" lang_id = "${lang}"/>:</b></font>
                        </td>

                        <td>
                            <input type = "date"
                                   name = "cfp_proposal_review_deadline"
                                   size = "10"
                                   value = "<fmt:formatDate value='${row.cfp_proposal_review_deadline}' pattern='MMM-dd-yyyy'/>">
                        </td>
                    </tr>

                    <tr>
                        <td align = "RIGHT">
                            <font face = "Arial" size = "-1" color = "FF0000"><b>*

                            <cf:GetPhrase phrase_id = "125" lang_id = "${lang}"/>:</b></font>
                        </td>

                        <td>
                            <input type = "date" name = "first_reminder" size = "10"
                                   value = "<fmt:formatDate value='${row.first_reminder}' pattern='MMM-dd-yyyy'/>">
                        </td>
                    </tr>

                    <tr>
                        <td align = "RIGHT">
                            <font face = "Arial" size = "-1" color = "FF0000"><b>*

                            <cf:GetPhrase phrase_id = "126" lang_id = "${lang}"/>:</b></font>
                        </td>

                        <td>
                            <input type = "date" name = "second_reminder" size = "10"
                                   value = "<fmt:formatDate value='${row.second_reminder}' pattern='MMM-dd-yyyy'/>">
                        </td>
                    </tr>

                    <tr>
                        <td align = "RIGHT">
                            <font face = "Arial" size = "-1" color = "FF0000"><b>*

                            <cf:GetPhrase phrase_id = "161" lang_id = "${lang}"/>:</b></font>
                        </td>

                        <td>
                            <input type = "date"
                                   name = "cfp_report_deadline"
                                   value = "<fmt:formatDate value='${row.cfp_report_deadline}' pattern='MMM-dd-yyyy'/>"
                                   size = "10">
                        </td>
                    </tr>

                    <tr>
                        <td align = "RIGHT">
                            <font face = "Arial" size = "-1" color = "FF0000"><b>*

                            <cf:GetPhrase phrase_id = "162" lang_id = "${lang}"/>:</b></font>
                        </td>

                        <td>
                            <input type = "date"
                                   name = "cfp_report_review_deadline"
                                   size = "10"
                                   value = "<fmt:formatDate value='${row.cfp_report_review_deadline}' pattern='MMM-dd-yyyy'/>">
                        </td>
                    </tr>
                </table>

                <p>
                <font face = "Arial" size = "-1"><b>

                <cf:GetPhrase phrase_id = "129" lang_id = "${lang}"/>:</b></font>

                <br>
                <textarea name = "cfp_format" cols = "50" rows = "3" wrap>
                    <c:out value = '${row.cfp_format}'/>
                </textarea>

                <input type = "submit" value = " <cf:GetPhrase phrase_id="456" lang_id="${lang}" /> ">
            </c:forEach>
        </form>
    </c:when>
</c:choose>
