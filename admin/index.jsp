<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "fuseaction" value = "${param.fuseaction}"/>

<c:if test = "${((empty sessionScope.user) or (sessionScope.user=='')) and (fuseaction!='login')}">
    <c:import url = "dsp_login_type.jsp"/>

    <%
    if (true)
        return;
    %>
</c:if>

<c:if test = "${fuseaction!='login'}">
 <c:import url = "header_site.jsp"/>
</c:if>




<!--- layout and formatting is contained in the header --->
<c:if test = "${(fuseaction!='dsp_login') and (fuseaction!='login') and (!empty fuseaction)}">
    <c:import url = "header.jsp"/>
</c:if>

<c:choose>
    <c:when test = "${fuseaction=='dsp_login'}">
        <c:import url = "dsp_login_type.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='login'}">
        <c:import url = "act_login.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='main'}">
        <c:import url = "default.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='help'}">
        <c:import url = "dsp_help.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='site_setup'}">
        <c:import url = "funding/dsp_initiative_site_setup.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_site_setup'}">
        <c:import url = "funding/act_initiative_site_setup.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='funding'}">
        <c:import url = "funding/dsp_funding.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='modify_funding'}">
        <c:import url = "funding/dsp_funding_modify.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_funding'}">
        <c:import url = "funding/act_funding.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='modify_agencies'}">
        <c:import url = "funding/dsp_agencies_modify.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_funding_agencies'}">
        <c:import url = "funding/act_funding_agencies.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_delete_agency'}">
        <c:import url = "funding/act_delete_agencies.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='list_cfp'}">
        <c:import url = "cfp/dsp_cfp_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='show_cfp'}">
        <c:import url = "cfp/dsp_cfp.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='modify_cfp'}">
        <c:import url = "cfp/dsp_cfp_modify.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='cfp_edit_criteria'}">
        <c:import url = "cfp/dsp_cfp_criteria_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_cfp'}">
        <c:import url = "cfp/act_cfp.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_cfp_criteria'}">
        <c:import url = "cfp/act_cfp_criteria.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='cfp_criteria_import'}">
        <c:import url = "cfp/act_cfp_criteria_import.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='delete_cfp'}">
        <c:import url = "cfp/act_delete_cfp.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='cfp_category'}">
        <c:import url = "cfp/dsp_cfp_cat.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_cfp_cat'}">
        <c:import url = "cfp/act_cfp_cat.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='criteria'}">
        <c:import url = "criteria/dsp_criteria.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='edit_criteria'}">
        <c:import url = "criteria/dsp_edit_criteria.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_criteria'}">
        <c:import url = "criteria/act_modify_criteria.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='dsp_minimum_values'}">
        <c:import url = "criteria/dsp_minimum_values.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_minimum_values'}">
        <c:import url = "criteria/act_minimum_values.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='reviewers'}">
        <c:import url = "reviewers/dsp_reviewers.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='modify_reviewer'}">
        <c:import url = "reviewers/dsp_modify_reviewers.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_reviewer'}">
        <c:import url = "reviewers/act_reviewers.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='modify_coordinator'}">
        <c:import url = "reviewers/dsp_modify_coordinators.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_coordinator'}">
        <c:import url = "reviewers/act_coordinator.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposals'}">
        <c:import url = "proposals/dsp_proposal_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='reports'}">
        <c:import url = "proposals/dsp_report_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_list'}">
        <c:import url = "proposals/dsp_proposal_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_docs_list'}">
        <c:import url = "proposals/dsp_proposal_docs_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_assign'}">
        <c:import url = "proposals/dsp_proposal_assign.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_assign'}">
        <c:import url = "proposals/act_proposal_assign.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_reviewer_delete'}">
        <c:import url = "proposals/act_proposal_reviewer_delete.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_review'}">
        <c:import url = "proposals/dsp_proposal_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_edit_review'}">
        <c:import url = "proposals/dsp_edit_proposal_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_review'}">
        <c:import url = "proposals/act_proposal_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_edit_review'}">
        <c:import url = "proposals/act_edit_proposal_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_summary'}">
        <c:import url = "proposals/dsp_proposal_summary.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_status'}">
        <c:import url = "proposals/act_proposal_status.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_submit'}">
        <c:import url = "proposals/dsp_proposal_submit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_submit'}">
        <c:import url = "proposals/act_proposal_submit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_info'}">
        <c:import url = "proposals/dsp_proposal_info.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_doc'}">
        <c:import url = "proposals/dsp_proposal_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='report_doc'}">
        <c:import url = "proposals/dsp_report_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_doc'}">
        <c:import url = "proposals/act_proposal_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='proposal_researcher'}">
        <c:import url = "proposals/dsp_proposal_researcher.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_researcher'}">
        <c:import url = "proposals/act_proposal_researcher.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='report_review'}">
        <c:import url = "proposals/dsp_report_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_report_review'}">
        <c:import url = "proposals/act_report_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_report_doc'}">
        <c:import url = "proposals/act_report_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='report_edit_review'}">
        <c:import url = "proposals/dsp_edit_report_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_report_edit_review'}">
        <c:import url = "proposals/act_edit_report_review.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='report_summary'}">
        <c:import url = "proposals/dsp_report_summary.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='report_list'}">
        <c:import url = "proposals/dsp_report_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_main'}">
        <c:import url = "communication/dsp_comm_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_view_sent'}">
        <c:import url = "communication/dsp_view_sent.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_message_type'}">
        <c:import url = "communication/dsp_comm_message_type.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml'}">
        <c:import url = "communication/dsp_comm_ml.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_send'}">
        <c:import url = "communication/dsp_comm_ml_send.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_new'}">
        <c:import url = "communication/dsp_comm_ml_new.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_donew'}">
        <c:import url = "communication/act_comm_ml_new.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_edit'}">
        <c:import url = "communication/dsp_comm_ml_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_doedit'}">
        <c:import url = "communication/act_comm_ml_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_members'}">
        <c:import url = "communication/dsp_comm_ml_members.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_editmembers'}">
        <c:import url = "communication/act_comm_ml_members.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_send'}">
        <c:import url = "communication/dsp_comm_ml_send.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_dosend'}">
        <c:import url = "communication/act_comm_ml_send.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_ml_sent'}">
        <c:import url = "communication/dsp_comm_ml_sent.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsr_main'}">
        <c:import url = "tsm/dsp_tsr_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsr_create'}">
        <c:import url = "tsm/dsp_tsr_create.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsr_docreate'}">
        <c:import url = "tsm/act_tsr_create.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsr_view'}">
        <c:import url = "tsm/dsp_tsr_view.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsr_update'}">
        <c:import url = "tsm/act_tsr_update.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsc_main'}">
        <c:import url = "tsm/dsp_tsc_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsc_view'}">
        <c:import url = "tsm/dsp_tsc_view.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='tsc_update'}">
        <c:import url = "tsm/act_tsc_update.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_email_archive'}">
        <c:import url = "communication/dsp_comm_email_archive.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_email_message'}">
        <c:import url = "communication/dsp_comm_email_message.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_email_members'}">
        <c:import url = "communication/dsp_comm_email_members.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_faq'}">
        <c:import url = "communication/dsp_comm_faq.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_comm_faq'}">
        <c:import url = "communication/act_comm_faq.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='dsp_edit_comm_faq'}">
        <c:import url = "communication/dsp_edit_comm_faq.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_default_letters'}">
        <c:import url = "communication/dsp_comm_default_letters.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='comm_default_letter_body'}">
        <c:import url = "communication/dsp_comm_default_letter_body.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='edit_letter'}">
        <c:import url = "communication/dsp_edit_letter.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_letters'}">
        <c:import url = "communication/act_comm_default_letters.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='discuss_main'}">
        <c:import url = "communication/dsp_discuss_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='discuss_edit'}">
        <c:import url = "communication/dsp_discuss_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_discuss_edit'}">
        <c:import url = "communication/act_discuss_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='gen_doc_add'}">
        <c:import url = "communication/dsp_gen_doc_add.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='gen_doc_del'}">
        <c:import url = "communication/dsp_gen_doc_del.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_gen_doc'}">
        <c:import url = "communication/act_gen_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='dsp_send_letters'}">
        <c:import url = "communication/dsp_send_letters.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_send_letters'}">
        <c:import url = "communication/act_send_letters.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='discuss_comment'}">
        <c:import url = "discussion/dsp_discuss_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_discuss_comment'}">
        <c:import url = "discussion/act_discuss_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'gen_doc_comment'}">
        <c:import url = "discussion/dsp_gen_doc_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_gen_doc_comment'}">
        <c:import url = "discussion/act_gen_doc_comment.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='admin_discuss_main'}">
        <c:import url = "discussion/dsp_discuss_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='admin_discuss_edit'}">
        <c:import url = "discussion/dsp_discuss_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='admin_act_discuss_edit'}">
        <c:import url = "discussion/act_discuss_edit.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='admin_gen_doc_add'}">
        <c:import url = "discussion/dsp_gen_doc_add.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='admin_gen_doc_del'}">
        <c:import url = "discussion/dsp_gen_doc_del.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='admin_act_gen_doc'}">
        <c:import url = "discussion/act_gen_doc.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='lang_main'}">
        <c:import url = "language/dsp_lang_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='add_phrase'}">
        <c:import url = "language/dsp_add_phrase.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_add_phrase'}">
        <c:import url = "language/act_add_phrase.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='add_lang'}">
        <c:import url = "language/dsp_add_lang.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_add_lang'}">
        <c:import url = "language/act_add_lang.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='lang_convert'}">
        <c:import url = "language/dsp_lang_convert.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_lang_convert'}">
        <c:import url = "language/act_lang_convert.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='contractors'}">
        <c:import url = "contractors/dsp_contractors.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_contractor'}">
        <c:import url = "contractors/act_contractors.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='modify_contractor'}">
        <c:import url = "contractors/dsp_modify_contractors.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='contracting_agencies'}">
        <c:import url = "contractors/dsp_contracting_agencies.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_contracting_agency'}">
        <c:import url = "contractors/act_contracting_agencies.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='modify_contracting_agency'}">
        <c:import url = "contractors/dsp_modify_contracting_agencies.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='contractor_assign'}">
        <c:import url = "contractors/dsp_contractor_assign.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_contractor_assign'}">
        <c:import url = "contractors/act_contractor_assign.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_proposal_contractor_delete'}">
        <c:import url = "contractors/act_proposal_contractor_delete.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsr_main'}">
        <c:import url = "contractors/tsm/dsp_tsr_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsr_create'}">
        <c:import url = "contractors/tsm/dsp_tsr_create.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsr_docreate'}">
        <c:import url = "contractors/tsm/act_tsr_create.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsr_view'}">
        <c:import url = "contractors/tsm/dsp_tsr_view.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsr_update'}">
        <c:import url = "contractors/tsm/act_tsr_update.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsc_main'}">
        <c:import url = "contractors/tsm/dsp_tsc_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsc_view'}">
        <c:import url = "contractors/tsm/dsp_tsc_view.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='c_tsc_update'}">
        <c:import url = "contractors/tsm/act_tsc_update.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='simple_reviewers_list'}">
        <c:import url = "reviewers/dsp_reviewers_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='simple_coordinators_list'}">
        <c:import url = "reviewers/dsp_coordinators_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='simple_contractors_list'}">
        <c:import url = "contractors/dsp_contractors_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='simple_contracting_agencies_list'}">
        <c:import url = "contractors/dsp_contracting_agencies_list.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='list_cfp_filter'}">
        <c:import url = "cfp/dsp_cfp_list_filter.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_contractor_del'}">
        <c:import url = "contractors/act_contractors_delete.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='skills'}">
        <c:import url = "cfp/dsp_professional_skills.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_skills'}">
        <c:import url = "cfp/act_professional_skills.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='dsp_edit_skills'}">
        <c:import url = "cfp/dsp_edit_professional_skills.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='job_titles'}">
        <c:import url = "cfp/dsp_job_titles.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='act_titles'}">
        <c:import url = "cfp/act_job_titles.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='dsp_edit_titles'}">
        <c:import url = "cfp/dsp_edit_job_titles.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='contractor'}">
        <c:import url = "contractors/dsp_contractor.jsp"/>
    </c:when>

    <c:when test = "${fuseaction=='cobrowse'}">
        <c:import url = "how_co_browse.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'mgt_reports'}">
        <c:import url = "dsp_reports_main.jsp"/>
    </c:when>

    <c:when test = "${fuseaction == 'displayReports'}">
        <c:import url = "ReportsDisplay.jsp"/>
    </c:when>

    <c:otherwise>
        <c:import url = "dsp_login_type.jsp"/>
    </c:otherwise>
</c:choose>

<c:if test = "${fuseaction == 'help'}">
    <p>
    <cf:GetPhrase phrase_id = "1040" lang_id = "${lang}"/>

    <c:out value = ""/>

    <c:out value = ""/>

    <c:out value = ""/>
    </p>

    <c:import url = "footer.jsp"/>

    <%
    if (true)
        return;
    %>
</c:if>

<c:if test = "${fuseaction!='login'}">
    <c:import url = "footer.jsp"/>
</c:if>
