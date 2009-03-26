/* drop database opa; */

/*create database opa;*/

use opa;
/*grant ALL on opa.* to opa@localhost identified by 'opa' with grant option;*/


/*==============================================================*/
/* table : currency_code                                        */
/*==============================================================*/
create table if not exists currency_code
(
   currency_id                    int                            not null auto_increment,
   currency                       varchar(64)                    not null,
   primary key (currency_id)
);

/*==============================================================*/
/* table : reviewers                                            */
/*==============================================================*/
create table if not exists reviewers
(
   reviewer_id                    int                            not null auto_increment,
   reviewer_lastname              varchar(255),
   reviewer_firstname             varchar(255),
   reviewer_login                 varchar(50),
   reviewer_password              varchar(50),
   reviewer_email                 varchar(255),
   reviewer_phone                 varchar(50),
   reviewer_fax                   varchar(50),
   reviewer_address               text,
   reviewer_profile               text,
   reviewer_coordinator           int(1),
   cfp_code                       int                            default 0,
   cfp_cat_id                     int                            default 0,
   payment_rate                   decimal(10,2)                  default 1,
   primary key (reviewer_id)
);

/*==============================================================*/
/* index: reviewers_login_idx                                   */
/*==============================================================*/
create index reviewers_login_idx on reviewers
(
   reviewer_login
);

/*==============================================================*/
/* table : record_status                                        */
/*==============================================================*/
create table if not exists record_status
(
   status_id                      int                            not null auto_increment,
   status_name                    varchar(128)                   not null,
   primary key (status_id)
);

/*==============================================================*/
/* table : document_types                                       */
/*==============================================================*/
create table if not exists document_types
(
/* NMC 2006.09.15 > Removed Auto-Increment
   doc_type_id                    int                            not null auto_increment,
*/
   doc_type_id                    int                            not null,
   doc_type_name                  varchar(128)                   not null,
   doc_type_category              varchar(10)                    not null,
   primary key (doc_type_id)
);

/*==============================================================*/
/* table : default_letters                                      */
/*==============================================================*/
create table if not exists default_letters
(
   letter_id                      int                            not null auto_increment,
   letter_subject                 varchar(255),
   letter_body                    text,
   status_id                      int,
   primary key (letter_id)   
);

/*==============================================================*/
/* table : languages                                            */
/*==============================================================*/
create table if not exists languages
(
   lang_id                        int                            not null auto_increment,
   language                       varchar(128)                   not null,
   primary key (lang_id)
);

/*==============================================================*/
/* table : initiative_info                                      */
/*==============================================================*/
create table if not exists initiative_info
(
   initiative_id                  int                            not null auto_increment,
   initiative_name                varchar(255)                   not null,
   lang_id                        int                            not null,
   background                     text,
   eligibility                    text,
   review_process                 text,
   proposal_format                text,
   copyright                      text,
   record_lifecycle               varchar(50),
   about_submitting               text,
   ia_name                        varchar(255),
   ia_contact                     varchar(255),
   ia_email                       varchar(255),
   ia_address                     varchar(255),
   ia_courier                     varchar(255),
   ia_phone                       varchar(255),
   ia_fax                         varchar(255),
   ia_courier_inst                text,
   ia_url                         varchar(255),
   admin_image_title              varchar(255),
   public_image_title             varchar(255),
   image_toolbar                  varchar(255),
   primary key (initiative_id)   
);

/*==============================================================*/
/* table : initiative_setup                                     */
/*==============================================================*/
create table if not exists initiative_setup
(
   initiative_setup_id            int                            not null auto_increment,
   lang_id                        int,
   host_url                       varchar(255),
   host_doc_dir                   text,
   public_info                    varchar(50),
   public_info_degree             varchar(50),
   minimum_score                  float(10,1),
   minimum_rank                   float(10,1),
   show_weights                   varchar(50),
   use_initiative_criteria        int(1),
   use_cfp_criteria               int(1),
   show_reviewers                 int(1),
   show_reviewers_summary         int(1),
   background_image               text,
   admin_header_background        text,
   public_header_background       text,
   criteria_rankings              int,
   multiple_cfps                  int(1),
   public_attachments             int(1),
   default_lang                   int,
   listname                       varchar(255),
   application_name               varchar(50),
   application_directory          varchar(255),
   public_interface               int(1) default 0,
   primary key (initiative_setup_id)   
);

/*==============================================================*/
/* table : initiative_criteria                                  */
/*==============================================================*/
create table if not exists initiative_criteria
(
   i_criteria_id                  int                            not null auto_increment,
   i_criteria_name                text,
   i_criteria_weight              float(10,1),
   i_high_rank                    varchar(50),
   i_low_rank                     varchar(50),
   primary key (i_criteria_id)
);

/*==============================================================*/
/* table : coordinators                                         */
/*==============================================================*/
create table if not exists coordinators
(
   coordinator_id                 int                            not null auto_increment,
   coordinator_lastname           varchar(255),
   coordinator_firstname          varchar(255),
   coordinator_login              varchar(50),
   coordinator_password           varchar(50)                    not null,
   coordinator_email              varchar(255),
   coordinator_public_email       varchar(255),
   coordinator_admin_email        varchar(255),
   coordinator_phone              varchar(50),
   coordinator_fax                varchar(50),
   coordinator_address            varchar(255),
   receive_public_emails          int(1),
   receive_admin_emails           int(1),
   primary key (coordinator_id)
);

/*==============================================================*/
/* index: coord_login_idx                                       */
/*==============================================================*/
create index coord_login_idx on coordinators
(
   coordinator_login
);

/*==============================================================*/
/* table : members                                              */
/*==============================================================*/
create table if not exists members
(
   member_id                      int                            not null auto_increment,
   member_name                    varchar(128),
   member_email                   varchar(128)                   not null,
   primary key (member_id)
);

/*==============================================================*/
/* table : timesheetstatus                                      */
/*==============================================================*/
create table if not exists timesheetstatus
(
   status_id                      int                            not null auto_increment,
   ts_status                      varchar(16)                    not null,
   primary key (status_id)
);

/*==============================================================*/
/* table : faq                                                  */
/*==============================================================*/
create table if not exists faq
(
   faq_id                         int                            not null  auto_increment,
   faq_question                   text,
   faq_answer                     text,
   primary key (faq_id)
);

/*==============================================================*/
/* table : funding_agencies                                     */
/*==============================================================*/
create table if not exists funding_agencies
(
   agency_id                      int                            not null auto_increment,
   agency_name                    varchar(255),
   agency_contact                 varchar(255),
   agency_email                   varchar(255),
   agency_phone                   varchar(50),
   agency_url                     varchar(255),
   primary key (agency_id)
);

/*==============================================================*/
/* table : phrases                                              */
/*==============================================================*/
create table if not exists phrases
(
   phrase_id                      int                            not null,
   lang_id                        int                            not null,
   phrase                         varchar(255)                   not null,
   primary key (phrase_id, lang_id)   
);

/*==============================================================*/
/* table : cfp_info                                             */
/*==============================================================*/
create table if not exists cfp_info
(
   cfp_code                       int                            not null auto_increment,
   cfp_startdate                  date,
   cfp_title                      varchar(255),
   cfp_background                 text,
   cfp_objectives                 text,
   cfp_focus                      text,
   cfp_deadline                   date,
   cfp_report_deadline            date,
   cfp_format                     varchar(255),
   cfp_maxaward                   float(20,2) default 0.00,
   cfp_totalfunds                 float(20,2) default 0.00,
   cfp_proposal_review_deadline   date,
   cfp_report_review_deadline     date,
   currency_id                    int                            not null,
   first_reminder                 date,
   second_reminder                date,
   third_reminder                 date,
   primary key (cfp_code)
);

/*==============================================================*/
/* index: cfp_startdate_idx                                     */
/*==============================================================*/
create index cfp_startdate_idx on cfp_info
(
   cfp_startdate
);

/*==============================================================*/
/* table : mailinglists                                         */
/*==============================================================*/
create table if not exists mailinglists
(
   list_id                        int                            not null auto_increment,
   coordinator_id                 int,
   list_name                      varchar(20)                    not null,
   list_descr                     varchar(128),
   list_topic                     text,
   default_list                   int(1)                     not null default 0,
   primary key (list_id)
);

/*==============================================================*/
/* index: listdefault_idx                                       */
/*==============================================================*/
create index listdefault_idx on mailinglists
(
   default_list
);

/*==============================================================*/
/* table : listmembers                                          */
/*==============================================================*/
create table if not exists listmembers
(
   member_id                      int                            not null,
   list_id                        int                            not null,
   member_status                  int(1)                     not null default '1',
   primary key (member_id, list_id)
);

/*==============================================================*/
/* index: listmembers_status_idx                                */
/*==============================================================*/
create index listmembers_status_idx on listmembers
(
   member_status
);

/*==============================================================*/
/* table : messages                                             */
/*==============================================================*/
create table if not exists messages
(
   message_id                     int                            not null auto_increment,
   list_id                        int                            not null,
   sent_date                      date                           not null,
   message_from                   varchar(128)			         not null,
   subject                        varchar(128),
   from_spc                       varchar(128),
   message_text                   text                           not null,
   primary key (message_id)
);

/*==============================================================*/
/* index: mess_date_idx                                         */
/*==============================================================*/
create index mess_date_idx on messages
(
   sent_date
);

/*==============================================================*/
/* table : sentto                                               */
/*==============================================================*/
create table if not exists sentto
(
   message_id                     int                            not null,
   member_id                      int                            not null,
   primary key (message_id, member_id)
);

/*==============================================================*/
/* table : cfp_category                                         */
/*==============================================================*/
create table if not exists cfp_category
(
   cfp_cat_id                     int                            not null auto_increment,
   cfp_code                       int,
   cfp_cat_name                   varchar(255)                   not null,
   primary key (cfp_cat_id)   
);

/*==============================================================*/
/* table : proponent_record                                     */
/*==============================================================*/
create table if not exists proponent_record
(
   tracking_code                  int                            not null  auto_increment,
   previous_tracking_code         int,
   cfp_cat_id                     int,
   date_submitted                 date,
   date_last_updated              date,
   proponent_password             varchar(50),
   proposal_title                 varchar(255),
   proposal_score_sum             float(10,1),
   proposal_rank                  float(10,1),
   requested_amount               float(20,2) default 0.00,
   awarded_amount                 float(20,2) default 0.00,
   award_comment                  text,
   status_id                      int,
   cfp_code                       int,
   proponent_institution          varchar(255),
   proponent_address              varchar(255),
   proponent_phone                varchar(50),
   proponent_fax                  varchar(50),
   proponent_email                varchar(255),
   proponent_url                  varchar(255),
   proponent_leader_firstname     varchar(128),
   proponent_leader_lastname      varchar(128),
   proponent_leader_initial       varchar(5),
   proponent_leader_affiliation   varchar(255),
   proponent_leader_address       varchar(255),
   proponent_leader_phone         varchar(50),
   proponent_leader_fax           varchar(50),
   proponent_leader_email         varchar(255),
   proposal_hide                  int(1),
   proponent_citizenship          varchar(128),
   proponent_residency            varchar(128),
   project_country                varchar(128),
   project_date                   varchar(255),
   primary key (tracking_code)
);

/*==============================================================*/
/* index: prrecord_datesubmitted_idx                            */
/*==============================================================*/
create index prrecord_datesubmitted_idx on proponent_record
(
   date_submitted
);

/*==============================================================*/
/* index: prrecord_hide_idx                                     */
/*==============================================================*/
create index prrecord_hide_idx on proponent_record
(
   proposal_hide
);

/*==============================================================*/
/* table : cfp_criteria                                         */
/*==============================================================*/
create table if not exists cfp_criteria
(
   cfp_criteria_id                int                            not null auto_increment,
   cfp_code                       int,
   cfp_criteria_name              varchar(255),
   cfp_criteria_weight            float(10,1),
   cfp_high_rank                  varchar(50),
   cfp_low_rank                   varchar(50),
   primary key (cfp_criteria_id)   
);

/*==============================================================*/
/* table : sent_messages                                        */
/*==============================================================*/
create table if not exists sent_messages
(
   sent_message_id                int                            not null auto_increment,
   tracking_code                  int,
   letter_id                      int,
   date_sent                      date,
   recipient1                     varchar(255),
   recipient2                     varchar(255),
   custom_body                    text,
   custom_subject                 varchar(255),
   primary key (sent_message_id)   
);

/*==============================================================*/
/* index: sentmessage_date_idx                                  */
/*==============================================================*/
create index sentmessage_date_idx on sent_messages
(
   date_sent
);

/*==============================================================*/
/* table : reviewer_assignment                                  */
/*==============================================================*/
create table if not exists reviewer_assignment
(
   assignment_id                  int                            not null auto_increment,
   reviewer_id                    int                            not null,
   cfp_code                       int                            not null,
   tracking_code                  int                            not null,
   proposal_review_completed      int(1) default 0,
   proposal                       int(1) default 0,
   report                         int(1) default 0,
   project                        int(1) default 0,
   report_review_completed        int(1) default 0,
   start_date					  date,
   end_date						  date,
   primary key (assignment_id)
);

/*==============================================================*/
/* table : contractor_assignment                                  */
/*==============================================================*/

create table if not exists contractor_assignment
(
   assignment_id                  int                            not null  auto_increment,
   contractor_id                    int                            not null,
   cfp_code                       int                            not null,
   tracking_code                  int                            not null,
   start_date					  date,
   end_date						  date,
   primary key (assignment_id)
);

/*==============================================================*/
/* table : documents                                            */
/*==============================================================*/
create table if not exists documents
(
   doc_id                         int                            not null  auto_increment,
   tracking_code                  int                            not null,
   doc_type_id                    int                            not null,
   doc_title                      varchar(255)                   not null,
   doc_filename                   text                           not null,
   doc_date                       date                           not null,
   doc_abstract                   text,
   primary key (doc_id)
);

/*==============================================================*/
/* index: doc_date_idx                                          */
/*==============================================================*/
create index doc_date_idx on documents
(
   doc_date
);

/*==============================================================*/
/* table : admin_documents                                      */
/*==============================================================*/
create table if not exists admin_documents
(
   doc_id                         int                            not null auto_increment,
   tracking_code                  int,
   doc_type_id                    int,
   cfp_code                       int,
   doc_title                      varchar(255),
   doc_filename                   text,
   doc_date                       date,
   primary key (doc_id)
);

/*==============================================================*/
/* index: admdoc_date_idx                                       */
/*==============================================================*/
create index admdoc_date_idx on admin_documents
(
   doc_date
);

/*==============================================================*/
/* table : report_appraisal                                     */
/*==============================================================*/
create table if not exists report_appraisal
(
   report_appraisal_id            int                            not null auto_increment,
   reviewer_id                    int                            not null,
   tracking_code                  int                            not null,
   doc_id                         int                            not null,
   report_comments                text,
   primary key (report_appraisal_id)
);

/*==============================================================*/
/* table : proposal_appraisal                                   */
/*==============================================================*/
create table if not exists proposal_appraisal
(
   appraisal_id                   int                            not null auto_increment,
   reviewer_id                    int,
   tracking_code                  int,
   appraisal_score                float(10,1),
   appraisal_rank                 float(10,1),
   appraisal_comment              text,
   i_criteria_id                  int                            not null,
   cfp_criteria_id                int,
   primary key (appraisal_id)
);

/*==============================================================*/
/* table : researchers                                          */
/*==============================================================*/
create table if not exists researchers
(
   researcher_id                  int                            not null auto_increment,
   tracking_code                  int,
   researcher_firstname           varchar(255),
   researcher_lastname            varchar(255),
   researcher_initial             varchar(5),
   researcher_phone               varchar(50),
   researcher_fax                 varchar(50),
   researcher_email               varchar(255),
   researcher_citizenship         varchar(255),
   researcher_residency           varchar(255),
   researcher_org                 varchar(255),
   primary key (researcher_id)   
);

/*==============================================================*/
/* table : public_comments                                      */
/*==============================================================*/
create table if not exists public_comments
(
   comment_id                     int                            not null auto_increment,
   tracking_code                  int                            not null,
   comment_body                   text                           not null,
   comment_date                   date                           not null,
   comment_name                   varchar(255),
   comment_email                  varchar(255),
   primary key (comment_id)
);

/*==============================================================*/
/* index: comment_date_idx                                      */
/*==============================================================*/
create index comment_date_idx on public_comments
(
   comment_date
);

/*==============================================================*/
/* table : admin_discussion                                     */
/*==============================================================*/
create table if not exists admin_discussion
(
   discussion_id                  int                            not null auto_increment,
   doc_id                         int,
   discuss_level                  int,
   discuss_parent                 int,
   discuss_subject                varchar(255),
   discuss_author                 varchar(255),
   discuss_email                  varchar(255),
   discuss_date                   date,
   discuss_message                text,
   discuss_replies                int,
   discuss_attachment             text,
   primary key (discussion_id)
);

/*==============================================================*/
/* index: admdisc_level_idx                                     */
/*==============================================================*/
create index admdisc_level_idx on admin_discussion
(
   discuss_level
);

/*==============================================================*/
/* index: admdisc_parent_idx                                    */
/*==============================================================*/
create index admdisc_parent_idx on admin_discussion
(
   discuss_parent
);

/*==============================================================*/
/* index: admdisc_date_idx                                      */
/*==============================================================*/
create index admdisc_date_idx on admin_discussion
(
   discuss_date
);


/*==============================================================*/
/* table : timesheets                                           */
/*==============================================================*/
create table if not exists timesheets
(
   timesheet_id                   int                            not null auto_increment,
   status_id                      int                            not null,
   reviewer_id                    int,
   tracking_code                  int                            not null,
   start_date                     date                           not null,
   end_date                       date                           not null,
   primary key (timesheet_id)
);

/*==============================================================*/
/* index: timesheet_dates_idx                                   */
/*==============================================================*/
create index timesheet_dates_idx on timesheets
(
   start_date,
   end_date
);

/*==============================================================*/
/* table : timerecords                                          */
/*==============================================================*/
create table if not exists timerecords
(
   record_id                      int                            not null auto_increment,
   timesheet_id                   int,
   activity_date                  date                           not null,
   hours_spent                    int                            not null,
   hours_approved                 int                            default 0,
   comments                       text,
   primary key (record_id)
);

/*==============================================================*/
/* index: timerecord_date_idx                                   */
/*==============================================================*/
create index timerecord_date_idx on timerecords
(
   activity_date
);

/*==============================================================*/
/* table : discussion                                           */
/*==============================================================*/
create table if not exists discussion
(
   discussion_id                  int                            not null auto_increment,
   doc_id                         int,
   discuss_level                  int,
   discuss_parent                 int                            default 0,
   discuss_subject                varchar(255)                   not null,
   discuss_author                 varchar(255),
   discuss_email                  varchar(255),
   discuss_date                   datetime                       not null,
   discuss_message                text                           not null,
   discuss_replies                int,
   discuss_attachment             text,
   primary key (discussion_id)   
);

/*==============================================================*/
/* index: disc_level_idx                                        */
/*==============================================================*/
create index disc_level_idx on discussion
(
   discuss_level
);

/*==============================================================*/
/* index: disc_parent_idx                                       */
/*==============================================================*/
create index disc_parent_idx on discussion
(
   discuss_parent
);

/*==============================================================*/
/* index: disc_date_idx                                         */
/*==============================================================*/
create index disc_date_idx on discussion
(
   discuss_date
);



/*==============================================================*/
/* table : contractors                                            */
/*==============================================================*/
create table if not exists contractors
(
   contractor_id                    int                            not null auto_increment,
   contractor_lastname              varchar(255),
   contractor_firstname             varchar(255),
   contractor_login                 varchar(50),
   contractor_password              varchar(50),
   contractor_email                 varchar(255),
   contractor_phone                 varchar(50),
   contractor_fax                   varchar(50),
   contractor_address               text,
   contractor_profile               text,
   cfp_code                       int                            default 0,
   cfp_cat_id                     int                            default 0,
   agency_id                      int                            default 0,
   payment_rate                   decimal(10,2)                  default 1,
   next_status_update_date 		  date 							 default '2004-07-31',
   primary key (contractor_id)
);

/*==============================================================*/
/* index: contractors_login_idx                                   */
/*==============================================================*/
create index contractors_login_idx on contractors
(
   contractor_login
);



/*==============================================================*/
/* table : persons                                            */
/*==============================================================*/
create table if not exists persons
(
   person_id                    int                            not null auto_increment,
   person_type_id               int(1)                     default 0,
   organization_id              int                            default 0,
   primary key (person_id)
);


/*==============================================================*/
/* table : person_types                                       */
/*==============================================================*/
create table if not exists person_types
(
/* NMC 2006.09.15 > Removed Auto-Increment
   person_type_id                    int(1)                     not null auto_increment,
*/
   person_type_id                    int(1)                     not null,
   person_type_name                  varchar(128)                   not null,
   primary key (person_type_id)
);


/*==============================================================*/
/* table : contractor_assignment                                  */
/*==============================================================*/
create table if not exists contractor_assignment
(
   assignment_id                  int                            not null,
   contractor_id                  int                            not null,
   cfp_code                       int                            not null,
   tracking_code                  int                            not null,
   start_date					  date							 not null,
   end_date						  date,
   primary key (assignment_id)
);


/*==============================================================*/
/* table : organizations                                     */
/*==============================================================*/
create table if not exists organizations
(
   organization_id                      int                            not null auto_increment,
   organization_type_id                 int(1)                  not null,  
   primary key (organization_id)
);


/*==============================================================*/
/* table : organization_types                                       */
/*==============================================================*/
create table if not exists organization_types
(
/* NMC 2006.09.15 > Removed Auto-Increment
   organization_type_id                    int(1)                     not null auto_increment,
*/
   organization_type_id                    int(1)                     not null,
   organization_type_name                  varchar(128)                   not null,
   primary key (organization_type_id)
);

/*==============================================================*/
/* table : operson_role_types                                       */
/*==============================================================*/

create table if not exists person_role_types
(role_id  int(2) not null primary key auto_increment,
lang_id   int(1) not null,
role_name varchar(20) not null)
;


/*==============================================================*/
/* table : contractor timesheets                                           */
/*==============================================================*/
create table if not exists contractor_timesheets
(
   timesheet_id                   int                            not null auto_increment,
   status_id                      int                            not null,
   contractor_id                    int,
   tracking_code                  int                            not null,
   start_date                     date                           not null,
   end_date                       date                           not null,
   primary key (timesheet_id)
);

/*==============================================================*/
/* index: timesheet_dates_idx                                   */
/*==============================================================*/
create index ctimesheet_dates_idx on contractor_timesheets
(
   start_date,
   end_date
);

/*==============================================================*/
/* table : contractor timerecords                                          */
/*==============================================================*/
create table if not exists contractor_timerecords
(
   record_id                      int                            not null auto_increment,
   timesheet_id                   int,
   activity_date                  date                           not null,
   hours_spent                    int                            not null,
   hours_approved                 int                            default 0,
   comments                       text,
   primary key (record_id)
);

/*==============================================================*/
/* index: timerecord_date_idx                                   */
/*==============================================================*/
create index ctimerecord_date_idx on contractor_timerecords
(
   activity_date
);


/*==============================================================*/
/* table : contracting_agencies                                     */
/*==============================================================*/
create table if not exists contracting_agencies
(
   agency_id                      int         not null auto_increment,
   agency_name                    varchar(255),
   agency_contact                 varchar(255),
   agency_email                   varchar(255),
   agency_phone                   varchar(50),
   agency_url                     varchar(255),
   primary key (agency_id)
);

/*==============================================================*/
/* table : funding_agencies                                    */
/*==============================================================*/
CREATE TABLE funding_agencies_cfp(
	agency_id            integer NOT NULL ,
	cfp_code			 int not null,
	primary key(agency_id,cfp_code)
)
;
/*==============================================================*/
/* table : standard job names                                    */
/*==============================================================*/

CREATE TABLE standardjobnames(
	seq_no               integer PRIMARY KEY,
	job_name             varchar(40) NOT NULL
)
;


CREATE UNIQUE INDEX jobnidx ON standardjobnames(seq_no)
;

/*==============================================================*/
/* table : contractor search matches                                   */
/*==============================================================*/

create table contractor_matches_temp
(contractor_id integer not null primary key);

create unique index cmattidx on contractor_matches_temp(contractor_id);

/*==============================================================*/
/* table : reports contraol table                                    */
/*==============================================================*/

drop table if exists reports_control_table;

create table reports_control_table
(report_id	 int(4) not null auto_increment ,
report_filename varchar(40) not null,
user_group_code char(1) not null,
application_area_id int(4) not null,
report_label varchar(40) not null,
report_description tinytext,
primary key(report_id)
)
;
create unique index rctidx1 on reports_control_table(report_id);


/*==============================================================*/
/* table : application areas                                  */
/*==============================================================*/

drop table if exists application_areas;

create table application_areas
(application_area_id int(3) not null auto_increment,
application_area_name  varchar(40) not null,
primary key (application_area_id))
;

create unique index aaidx1 on application_areas(application_area_id);

drop table if exists cfp_skills;

create table cfp_skills
( cfp_code      int             not null,
skill_id        int             not null,
primary key(cfp_code,skill_id)
);


create unique index cfpskillsidx on cfp_skills (cfp_code,skill_id);


drop table if exists contractor_skills;

create table contractor_skills
( contractor_id int          not null,
skill_id        int          not null,
primary key(contractor_id,skill_id)
);


create unique index cskillsidx on contractor_skills (contractor_id,skill_id);



drop table if exists industry;
create table  industry
(
industry_id      int not null primary key,
industry_name     varchar(50) not null
);

create unique index pindustryidx on industry (industry_id);

drop table if exists professional_skills;
create table  professional_skills
(
skill_id      int not null primary key,
skill_name    varchar(50) not null,
industry_id   int(2)
);

create unique index pskillsidx on professional_skills (skill_id);


CREATE TABLE user_logon_history(
	user_type            varchar(40),
	user_id              varchar(40),
	user_password        varchar(40),
	logon_timestamp      timestamp NOT NULL PRIMARY KEY
)
;

