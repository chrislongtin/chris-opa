<%@ page errorPage = "../dsp_error.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ page import = "java.sql.*"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<!--- check for session.user variable to insure user logged in --->

<%@ include file = "../act_session_check.jsp"%>

<!--------------------- DISPLAY CONTRACTORS -------------------------->

<c:set var = "contractor_cfp_code">
    <c:out value = "${param.contractor_cfp_code}" default = "0"/>
</c:set>

<c:set var = "contractor_cfp_cat_id">
    <c:out value = "${param.contractor_cfp_cat_id}" default = "0"/>
</c:set>

<c:set var = "agency_id">
    <c:out value = "${param.agency_id}" default = "0"/>
</c:set>

<c:set var = "job_name">
    <c:out value = "${param.job_name}" default = ""/>
</c:set>

<c:set var = "cfp_code">
    <c:out value = "${param.cfp_code}" default = "0"/>
</c:set>

<c:set var = "contractor" value = "${sessionScope.ctid}" scope = "page"/>

<sql:query var = "jobtitles">
    select * from standardjobnames order by job_name
</sql:query>

<c:choose>
    <c:when test = "${cfp_code > 0}">
<%
        ResultSet rs  = null;

        ResultSet rs2 = null;
        ResultSet rs3 = null;
        Connection conn = null;
        int count     = 0;
        String query  = null;
        int numberOfRows = 0;
        int cfpCode   = 1328;
        int contractorId = 0;
        int numberOfMatches = 0;
        int numberOfCfpSkills = 0;
        int [] cfpSkills = new int[20];
        String cfp    = request.getParameter("cfp_code");

        try
            {
            Class.forName("org.gjt.mm.mysql.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/applicants?user=root&password=");
            Statement stmt  = conn.createStatement();
            Statement stmt2 = conn.createStatement();
            Statement stmt3 = conn.createStatement();
            stmt.executeUpdate("delete from contractor_matches_temp");
            query = "select skill_id from cfp_skills where cfp_code = " + cfp;

            rs2 = stmt2.executeQuery(query);

            rs2.last();
            numberOfCfpSkills = rs2.getRow();
            rs2.beforeFirst();
            int inx = 0;

            while (rs2.next())
                {
                cfpSkills[inx] = rs2.getInt(1);
                inx++;
                }

            rs2.close();
            query = "select contractor_id from contractors";

            rs = stmt.executeQuery(query);

            while (rs.next())
                {
                numberOfMatches = 0;

                for (int ix = 0; ix < numberOfCfpSkills; ix++)
                    {
                    contractorId = rs.getInt(1);
                    query = "select skill_id from contractor_skills where contractor_id = " + contractorId
                                + " and skill_id = " + cfpSkills[ix];
                    rs3 = stmt3.executeQuery(query);

                    while (rs3.next())
                        {
                        numberOfMatches++;
                        }

                    rs3.close();
                    }

                if (numberOfMatches == numberOfCfpSkills)
                    {
                    query = "insert ignore into contractor_matches_temp values (" + contractorId + ")";
                    stmt.executeUpdate(query);
                    }
                }

            rs.close();
            }
        catch (Exception e)
            {
            e.printStackTrace(System.err);
            }
        finally
            {
            try
                {
                conn.close();
                }
            catch (Exception e)
                {
                e.printStackTrace(System.err);
                }
            }
%>

        <sql:query var = "contractors">
            select a.contractor_id, a.contractor_lastname, a.contractor_firstname, a.contractor_login,
            a.contractor_password, a.contractor_email, a.contractor_phone, a.contractor_fax, a.contractor_address,
            substring(a.contractor_profile,1,250) as contractor_profile, a.contractor_coordinator, a.cfp_code,
            a.cfp_cat_id, a.agency_id, resume_file_name from contractors a, contractor_matches_temp b where
            a.contractor_id > 0 and a.contractor_id = b.contractor_id order by a.contractor_lastname,
            a.contractor_firstname
        </sql:query>
    </c:when>

    <c:when test = "${cfp_code == 0}">
        <sql:query var = "contractors">
            select contractor_id, contractor_lastname, contractor_firstname, contractor_login, contractor_password,
            contractor_email, contractor_phone, contractor_fax, contractor_address,
            substring(contractor_profile,1,250) as contractor_profile, contractor_coordinator, cfp_code, cfp_cat_id,
            agency_id, resume_file_name, payment_rate, next_status_update_date

            from contractors where contractor_id > 0

            <c:if test = "${contractor_cfp_code!=0}">
                and cfp_code = ?
            </c:if>

            <c:if test = "${contractor_cfp_cat_id!=0}">
                and cfp_cat_id = ?
            </c:if>

            order by contractor_lastname, contractor_firstname

            <c:if test = "${contractor_cfp_code!=0}">
                <sql:param value = "${contractor_cfp_code}"/>
            </c:if>

            <c:if test = "${contractor_cfp_cat_id!=0}">
                <sql:param value = "${contractor_cfp_cat_id}"/>
            </c:if>
        </sql:query>
    </c:when>
</c:choose>

<sql:query var = "contracting_agencies">
    select * from contracting_agencies order by agency_name
</sql:query>

<c:set var = "matchcount" value = "${contractors.rowCount}"/>

<p>
<center>
    <b>

    <c:out value = "${job_name}"/></b> </p>

</center>

<p>
<center>
    <b>Number of Contractors Found:

    <c:out value = "${matchcount}"/></b> </p>

</center>

<table border = "0" cellspacing = "0" cellpadding = "2" width = "50%">
    <tr bgcolor = "BCBCBC">
        <td align = "right">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=contracting_agencies">

            <cf:GetPhrase phrase_id = "978" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td align = "center">
            <font size = "+1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/>
        </td>
    </tr>

    <tr bgcolor = "BCBCBC">
        <td align = "center">
            <font size = "1" face = "Arial"><a STYLE="text-decoration: underline"  href = "index.jsp?fuseaction=simple_contractors_list">

            <cf:GetPhrase phrase_id = "972" lang_id = "${lang}"/></a></font>
        </td>
    </tr>

    <sql:query var = "cfp_list">
        select cfp_code, cfp_title from cfp_info order by cfp_title
    </sql:query>

    <tr>
        <td>
            &nbsp;
        </td>
    </tr>

    <tr bgcolor = "D7D7D7">
        <td>
            <font size = "-1" face = "Arial"><b>

            <cf:GetPhrase phrase_id = "959" lang_id = "${lang}"/>:
        </td>
    </tr>
    <!---  Add New Contractor --->
    <form action = "index.jsp?fuseaction=modify_contractor" method = "post">
        <input type = "hidden" name = "act" value = "add">

        <tr bgcolor = "EBEBEB">
            <td align = "center">
                <font size = "-1" face = "Arial">

                <cf:GetPhrase phrase_id = "706" lang_id = "${lang}"/>

                :

                <c:choose>
                    <c:when test = "${contractor_cfp_code==0}">
                        <select name = "cfp_code">
                            <option value = "0"><cf:GetPhrase phrase_id = "641" lang_id = "${lang}"/>

                            <c:forEach items = "${cfp_list.rows}" var = "rowx">
                                <option value = "<c:out value="${rowx.cfp_code}" />">
                                <c:out value = "${rowx.cfp_title}"/>
                            </c:forEach>
                        </select>
                    </c:when>

                    <c:otherwise>
                        <input type = "hidden" name = "cfp_code" value = "<c:out value="${contractor_cfp_code}" />">

                        <c:out value = "${cfp_title}"/>
                    </c:otherwise>
                </c:choose>

                <font size = "-1" face = "Arial">

                <cf:GetPhrase phrase_id = "977" lang_id = "${lang}"/>

                :

                <select name = "agency_id">
                    <option value = "0"><cf:GetPhrase phrase_id = "550" lang_id = "${lang}"/>

                    <c:forEach items = "${contracting_agencies.rows}" var = "rowy">
                        <option value = "<c:out value="${rowy.agency_id}" />"><c:out value = "${rowy.agency_name}"/>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <tr>
            <td align = "center">
                <input type = "submit" value = "<cf:GetPhrase phrase_id="959" lang_id="${lang}" />">
            </td>
        </tr>
    </form>

    <!--- End Add Contractor --->

    <!-- Start Select A New Job --->

    <tr>
        <td>
            <font face = "arial" size = "-1"><b>

            <cf:GetPhrase phrase_id = "958" lang_id = "${lang}"/>:
        </td>
    </tr>

    <!-- End Select A New Job --->

    <!-- Start Display Data on Each Contractor that Satisfies Criteria --->
    <tr>
        <td>
            <form action = "index.jsp?fuseaction=contractor" method = "post">
                <select name = "contractor_id">
                    <c:forEach items = "${contractors.rows}" var = "row">
                        <option value = "<c:out value="${row.contractor_id}" />">
                        <c:out value = "${row.contractor_lastname}, ${row.contractor_firstname}"/>
                    </c:forEach>
                </select>
        </td>
    </tr>

    <tr>
        <td align = "center">
            <input type = "submit" value = "  <cf:GetPhrase phrase_id="523" lang_id="${lang}" />  ">
        </td>
    </tr>

    </form>
</table>
