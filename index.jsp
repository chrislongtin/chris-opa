<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<% /*<!--- PUBLIC Index Page for OPA (Online Proposal Appraisal) management system --->*/
%>

<c:if test = "${empty sessionScope.bypass}">
    <sql:query var = "where">
        select public_interface from initiative_setup
    </sql:query>

    <c:choose>
        <c:when test = "${where.rows[0].public_interface == 0}">
            <sql:query var = "public">
                select * from person_role_types where role_name = 'Public'
            </sql:query>

            <c:if test = "${public.rowCount > 0}">
                <sql:update>
                    delete from person_role_types where role_name='Public'
                </sql:update>
            </c:if>

            <c:redirect url = "admin/index.jsp"/>
        </c:when>

        <c:when test = "${where.rows[0].public_interface == 1}">
            <sql:query var = "public">
                select * from person_role_types where role_name = 'Public'
            </sql:query>

            <c:if test = "${public.rowCount==0}">
                <sql:update>
                    insert into person_role_types values (99,1,'Public')
                </sql:update>
            </c:if>

            <c:redirect url = "admin/index.jsp"/>
        </c:when>
    </c:choose>
</c:if>

<c:set var = "fuseaction" value = "${param.fuseaction}"/>

<c:import url = "public_header_site.jsp"/>
<c:import url = "public_header.jsp"/>

<c:choose>
    <c:when test = "${fuseaction == 'main'}">
        <c:import url = "default.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'login'}">
        <c:import url = "act_login.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'archive_main'}">
        <c:import url = "archive/dsp_archive_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'archive_proposal'}">
        <c:import url = "archive/dsp_archive_proposal.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'archive_comment'}">
        <c:import url = "archive/dsp_archive_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_archive_comment'}">
        <c:import url = "archive/act_archive_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'dsp_reviewers'}">
        <c:import url = "archive/dsp_reviewers.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'discuss_comment'}">
        <c:import url = "gen_discuss/dsp_discuss_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_discuss_comment'}">
        <c:import url = "gen_discuss/act_discuss_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'gen_doc_comment'}">
        <c:import url = "gen_discuss/dsp_gen_doc_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_gen_doc_comment'}">
        <c:import url = "gen_discuss/act_gen_doc_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'cfp_list'}">
        <c:import url = "cfp/dsp_cfp_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'cfp_info'}">
        <c:import url = "cfp/dsp_cfp_info.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'cfp_eligibility'}">
        <c:import url = "cfp/dsp_cfp_eligibility.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'cfp_proposal'}">
        <c:import url = "cfp/dsp_proposal_submit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_proposal_submit'}">
        <c:import url = "cfp/act_proposal_submit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'proposal_info'}">
        <c:import url = "cfp/dsp_proposal_info.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'proposal_edit'}">
        <c:import url = "cfp/dsp_proposal_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'report_add'}">
        <c:import url = "cfp/dsp_report_add.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'report_login'}">
        <c:import url = "cfp/dsp_report_login.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'report_doc'}">
        <c:import url = "cfp/dsp_report_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'proposal_doc'}">
        <c:import url = "cfp/dsp_proposal_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_proposal_doc'}">
        <c:import url = "cfp/act_proposal_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'proposal_researcher'}">
        <c:import url = "cfp/dsp_proposal_researcher.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_proposal_researcher'}">
        <c:import url = "cfp/act_proposal_researcher.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'submit_resume'}">
        <c:import url = "contractors/dsp_add_resume.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'edit_resume'}">
        <c:import url = "dsp_login_contractor.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_resume'}">
        <c:import url = "contractors/dsp_edit_resume.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'act_contractor'}">
        <c:import url = "contractors/act_contractors.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'faq'}">
        <c:import url = "faq/dsp_faq.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'cfp_search'}">
        <c:import url = "cfp/dsp_cfp_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'help'}">
        <c:import url = "dsp_help.jsp"/>
    </c:when>

    <c:otherwise>
        <c:import url = "default.jsp"/>
    </c:otherwise>
</c:choose>
<c:if test = "${fuseaction == 'help'}">
    <p>
    
    <cf:GetPhrase phrase_id = "1040" lang_id = "${lang}"/>

    <c:out value = ""/>

    <c:out value = ""/>

    <c:out value = ""/>
    </p>

    <c:import url = "public_footer.jsp"/>

<%
    if (true)
        return;
%>
</c:if>
<c:import url = "public_footer.jsp"/>
