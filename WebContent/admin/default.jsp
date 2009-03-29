<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:set var = "lang" value = "${sessionScope.lang}" scope = "page"/>

<c:if test = "${(empty sessionScope.user) or (sessionScope.user=='')}">
    <c:import url = "dsp_login.jsp"/>

    <c:import url = "footer.jsp"/>

    <%
    if (true)
        return;
    %>
</c:if>

<!--- default login page --->
<!--- this page is customized to the coordinator and reviewer roles --->

<c:choose>
    <c:when test = "${sessionScope.user=='coordinator'}">
        <sql:query var = "worksite_check">
            select * from initiative_setup
        </sql:query>

        <sql:query var = "initiative_info">
            select * from initiative_info where lang_id = 1
        </sql:query>

        <sql:query var = "criteria">
            select i_criteria_id from initiative_criteria
        </sql:query>

        <sql:query var = "reviewers">
            select reviewer_id from reviewers
        </sql:query>

        <sql:query var = "coordinators">
            select coordinator_id from coordinators
        </sql:query>

        <sql:query var = "cfps">
            select cfp_code from cfp_info
        </sql:query>

        <sql:query var = "proponents">
            select tracking_code from proponent_record
        </sql:query>

        <sql:query var = "assignments">
            select assignment_id from reviewer_assignment
        </sql:query>

        <sql:query var = "letters">
            select letter_id from default_letters
        </sql:query>

        <sql:query var = "languages">
            select lang_id from languages
        </sql:query>

        <fmt:message key = "384" />

        !

        <p>
        <fmt:message key = "385" />:
        <!--- <br><i>Tasks with a check mark next to them have been completed</i> --->

        <p>
        <table border = "1" cellspacing = "0" cellpadding = "3">
            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <fmt:message key = "386" />
                </td>

                <td>
                    <font face = "Arial" size = "-1">
                    <cfoutput query = "worksite_check">
                        <c:if test = "${empty worksite_check.rows[0].host_url}">
                            <li><fmt:message key = "211"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].host_doc_dir}">
                            <li><fmt:message key = "212"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].public_info}">
                            <li><fmt:message key = "387"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].public_info_degree}">
                            <li><fmt:message key = "387"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].minimum_score}">
                            <li><fmt:message key = "389"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].show_weights}">
                            <li><fmt:message key = "390"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].use_initiative_criteria}">
                            <li><fmt:message key = "391"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].use_cfp_criteria}">
                            <li><fmt:message key = "392"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].show_reviewers}">
                            <li><fmt:message key = "393"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].show_reviewers_summary}">
                            <li><fmt:message key = "394"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].background_image}">
                            <li><fmt:message key = "395"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].admin_header_background}">
                            <li><fmt:message key = "396"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].public_header_background}">
                            <li><fmt:message key = "397"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].criteria_rankings}">
                            <li><fmt:message key = "398"
                                          />
                        </c:if>

                        <c:if test = "${empty worksite_check.rows[0].multiple_cfps}">
                            <li><fmt:message key = "399"
                                          />
                        </c:if>

                        <c:if test = "${(!empty worksite_check.rows[0].host_url) and (!empty worksite_check.rows[0].host_doc_dir) and (!empty worksite_check.rows[0].public_info) and (!empty worksite_check.rows[0].public_info_degree) and (!empty worksite_check.rows[0].minimum_score) and (!empty worksite_check.rows[0].minimum_rank) and (!empty worksite_check.rows[0].show_weights) and (!empty worksite_check.rows[0].use_initiative_criteria) and (!empty worksite_check.rows[0].use_cfp_criteria) and (!empty worksite_check.rows[0].show_reviewers) and (!empty worksite_check.rows[0].show_reviewers_summary) and (!empty worksite_check.rows[0].background_image) and (!empty worksite_check.rows[0].admin_header_background) and (!empty worksite_check.rows[0].criteria_rankings) and (!empty worksite_check.rows[0].multiple_cfps)}">
                            DONE
                        </c:if>
                </td>
            </tr>

            <c:if test = "${!empty languages.rows[1].lang_id}">
                <tr>
                    <td>
                        <font face = "Arial" size = "-1">

                        <fmt:message key = "400" />
                    </td>

                    <td>
                        <font face = "Arial" size = "-1">

                        <fmt:message key = "401" />
                    </td>
                </tr>
            </c:if>

            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <fmt:message key = "402" />
                </td>

                <td>
                    <font face = "Arial" size = "-1">
                    <c:if test = "${empty initiative_info.rows[0].initiative_name}">
                        <li>
                        <fmt:message key = "207" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].background}">
                        <li>
                        <fmt:message key = "403" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].eligibility}">
                        <li><fmt:message key = "17" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].review_process}">
                        <li><fmt:message key = "18" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].proposal_format}">
                        <li>
                        <fmt:message key = "404" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].copyright}">
                        <li>
                        <fmt:message key = "405" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].record_lifecycle}">
                        <li>
                        <fmt:message key = "406" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].about_submitting}">
                        <li><fmt:message key = "21" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_name}">
                        <li>
                        <fmt:message key = "408" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_contact}">
                        <li>
                        <fmt:message key = "409" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_email}">
                        <li>
                        <fmt:message key = "410" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_address}">
                        <li>
                        <fmt:message key = "411" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_courier}">
                        <li>
                        <fmt:message key = "412" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_courier_inst}">
                        <li>
                        <fmt:message key = "413" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_phone}">
                        <li>
                        <fmt:message key = "414" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_fax}">
                        <li>
                        <fmt:message key = "415" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].ia_url}">
                        <li>
                        <fmt:message key = "416" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].admin_image_title}">
                        <li>
                        <fmt:message key = "201" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].public_image_title}">
                        <li>
                        <fmt:message key = "202" />
                    </c:if>

                    <c:if test = "${empty initiative_info.rows[0].image_toolbar}">
                        <li>
                        <fmt:message key = "203" />
                    </c:if>

                    <c:if test = "${(!empty initiative_info.rows[0].initiative_name) and (!empty initiative_info.rows[0].background) and (!empty initiative_info.rows[0].eligibility) and (!empty initiative_info.rows[0].review_process) and (!empty initiative_info.rows[0].proposal_format) and (!empty initiative_info.rows[0].copyright) and (!empty initiative_info.rows[0].record_lifecycle) and (!empty initiative_info.rows[0].about_submitting) and (!empty initiative_info.rows[0].ia_name) and (!empty initiative_info.rows[0].ia_contact) and (!empty initiative_info.rows[0].ia_email) and (!empty initiative_info.rows[0].ia_address) and (!empty initiative_info.rows[0].ia_courier) and (!empty initiative_info.rows[0].ia_courier_inst) and (!empty initiative_info.rows[0].ia_phone) and (!empty initiative_info.rows[0].ia_fax) and (!empty initiative_info.rows[0].ia_url) and (!empty initiative_info.rows[0].admin_image_title) and (!empty initiative_info.rows[0].public_image_title) and (!empty initiative_info.rows[0].image_toolbar)}">
                        DONE
                    </c:if>
                </td>
            </tr>

            <c:if test = "${init_crit==1}">
                <tr>
                    <td>
                        <font face = "Arial" size = "-1">

                        <fmt:message key = "419" />
                    </td>

                    <td>
                        <font face = "Arial" size = "-1"><c:choose>
                            <c:when test = "${empty criteria.rows[0].i_criteria_id}">
                                <fmt:message key = "420"
                                              />
                            </c:when>

                            <c:otherwise>
                                <fmt:message key = "421"
                                              />
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:if>

            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <fmt:message key = "422" />
                </td>

                <td>
                    <font face = "Arial" size = "-1"><c:choose>
                        <c:when test = "${empty reviewers.rows[0].reviewer_id}">
                            <fmt:message key = "422"
                                          />
                        </c:when>

                        <c:otherwise>
                            <fmt:message key = "421"
                                          />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <fmt:message key = "423" />
                </td>

                <td>
                    <font face = "Arial" size = "-1"><c:choose>
                        <c:when test = "${empty coordinators.rows[0].coordinator_id}">
                            <fmt:message key = "423"
                                          />
                        </c:when>

                        <c:otherwise>
                            <fmt:message key = "421"
                                          />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <fmt:message key = "424" />
                </td>

                <td>
                    <font face = "Arial" size = "-1"><c:choose>
                        <c:when test = "${empty cfps.rows[0].cfp_code}">
                            <fmt:message key = "424"
                                          />
                        </c:when>

                        <c:otherwise>
                            <fmt:message key = "421"
                                          />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <fmt:message key = "425" />
                </td>

                <td>
                    <font face = "Arial" size = "-1"><c:choose>
                        <c:when test = "${proponents.rowCount > assignments.rowCount}">
                            <fmt:message key = "426"
                                          />
                        </c:when>

                        <c:otherwise>
                            <fmt:message key = "421"
                                          />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <td>
                    <font face = "Arial" size = "-1">

                    <fmt:message key = "164" />
                </td>

                <td>
                    <font face = "Arial" size = "-1"><c:choose>
                        <c:when test = "${letters.rowCount==0}">
                            <fmt:message key = "182"
                                          />
                        </c:when>

                        <c:otherwise>
                            <fmt:message key = "421"
                                          />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </c:when>

    <c:otherwise>
        <c:set var = "reviewer" value = "${sessionScope.rid}" scope = "page"/>

        <!--- retrieve a list of proposals that the reviewer is responsible for, where the review has not already been completed --->
        <sql:query var = "proposal_info">
            select p.tracking_code, p.proposal_title, p.cfp_code from
            proponent_record p, reviewer_assignment ra where ra.reviewer_id =
            ? and (ra.proposal_review_completed = 0 or
            ra.proposal_review_completed is null) and ra.proposal = 1 and
            ra.tracking_code = p.tracking_code order by proposal_title

            <sql:param value = "${reviewer}"/>
        </sql:query>

        <h4>

        <fmt:message key = "427" /></h4>

        <c:choose>
            <c:when test = "${proposal_info.rowCount==0}">
                <fmt:message key = "289" />

                .
            </c:when>

            <c:otherwise>
                <p>
                <fmt:message key = "290" />

                <ul>
                    <c:forEach items = "${proposal_info.rows}" var = "row">
                        <li><a STYLE = "text-decoration: underline"
                               href = "index.jsp?fuseaction=proposal_review&tracking_code=<c:out value="${proposal_info.rows[0].tracking_code}" />">

                        <c:out value = "${proposal_info.rows[0].proposal_title} (P${proposal_info.rows[0].tracking_code})"/></a>
                    </c:forEach>
                </ul>

                <sql:query var = "edit_reviews">
                    select ra.assignment_id, ra.tracking_code,
                    p.proposal_title from reviewer_assignment ra, cfp_info c,
                    proponent_record p where ra.reviewer_id = ? and
                    ra.proposal_review_completed = 1 and ra.proposal = 1 and
                    ra.cfp_code = c.cfp_code and
                    c.cfp_proposal_review_deadline >= CURDATE() and
                    ra.tracking_code = p.tracking_code

                    <sql:param value = "${reviewer}"/>
                </sql:query>

                <c:if test = "${edit_reviews.rowCount!=0}">
                    <h4>

                    <fmt:message key = "428" />:</h4>

                    <ul>
                        <c:forEach items = "${edit_reviews.rows}" var = "row">
                            <li><a STYLE = "text-decoration: underline"
                                   href = "index.jsp?fuseaction=proposal_edit_review&tracking_code=<c:out value="${row.tracking_code}" />">

                            <c:out value = "${row.proposal_title} (P${row.tracking_code})"/></a>
                        </c:forEach>
                    </ul>
                </c:if>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
