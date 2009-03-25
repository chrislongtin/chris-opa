<%@ page errorPage = "../dsp_error.jsp"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>

<!--- Delete Funding Agency --->

<sql:update var = "delete_agency">
    delete from funding_agencies where agency_id = ?

    <sql:param value = "${param.agency_id}"/>
</sql:update>

<c:import url = "funding/dsp_funding.jsp?fuseaction=funding&${user}"/>
