<%@ page import = "java.lang.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jstl/sql"%>
<%@ taglib prefix = "cf" uri = "http://archer-soft.com/taglibs/cf"%>

<c:if test = "${empty sessionScope.lang}">
    <sql:query var = "q" sql = "select default_lang from initiative_setup"/>

    <c:choose>
        <c:when test = "${(empty q.rows[0].default_lang) or (q.rows[0].default_lang==0)}">
            <c:set var = "lang" scope = "session" value = "1"/>
        </c:when>

        <c:otherwise>
            <c:set var = "lang" scope = "session"
                   value = "${q.rows[0].default_lang}"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test = "${!empty param.lang}">
    <c:set var = "lang" value = "${param.lang}" scope = "session"/>
</c:if>

<!--- selecting information to control the appearance of the website --->
<sql:query var = "setup">
    select background_image, public_header_background, multiple_cfps,
    use_initiative_criteria,
    public_info,application_name,application_directory from initiative_setup
</sql:query>

<sql:query var = "info">
    select public_image_title, image_toolbar from initiative_info where
    lang_id = ?

    <sql:param value = "${lang}"/>
</sql:query>

<HTML LANG = "en">
    <HEAD>
        <TITLE>Online Proposal Workflow Management</TITLE>
        <!-- CLF METADATA PROFILE: START-->
        <meta http-equiv = "Content-Type" content = "text/html; charset=UTF-8">
        <meta name = "MSSmartTagsPreventParsing" content = "TRUE">
        <link rel = "schema.dc" href = "http://purl.org/dc/elements/1.1/">
        <meta name = "dc.title" lang = "eng"
              content = "Online Proposal Workflow Management">
        <meta name = "dc.coverage" lang = "eng" content = "">
        <!--CLF METADATA PROFILE: END-->

        <style type = "text/css">
        <!--
        OL,UL,P,BODY,TD,TR,TH,FORM { font-family: Arial, Helvetica, sans-serif; font-size:10pt; color: #000000; }
      
        H1 { font-size: x-large; font-family: Arial, Helvetica, sans-serif; }
        H2 { font-size: large; font-family: Arial, Helvetica, sans-serif; }
        H3 { font-size: medium; font-family: Arial, Helvetica, sans-serif; }
        H4 { font-size: small; font-family: Arial, Helvetica, sans-serif; }
        H5 { font-size: x-small; font-family: Arial, Helvetica, sans-serif; }
        H6 { font-size: xx-small; font-family: Arial, Helvetica, sans-serif; }
      
        PRE,TT { font-family: "Courier New", Courier, monospace; }
      
        A:link,A:visited,A:active { text-decoration:none;color:#000000}
        A:hover { text-decoration:none;color:#FF3333 }
      
        /* COLOR TITLE IN TABLES */
        .titlebar { color: #FFFFFF; text-decoration: none; font-weight: bold; }
        A.tablink { color: #000000; text-decoration: none; font-weight: bold; font-size: 10; }
        A.tablink:visited { color: #000000; text-decoration: none; font-weight: bold; font-size: 10 }
        A.tablink:hover { text-decoration: none; color: #000000; font-weight: bold; font-size: 10 }
        A.tabsellink { color: #000000; text-decoration: none; font-weight: bold; font-size: 10 }
        A.tabsellink:visited { color: #000000; text-decoration: none; font-weight: bold; font-size: 10 }
        A.tabsellink:hover { text-decoration: none; color: #000000; font-weight: bold; font-size: 10 }
      
      -->
        </STYLE>

        <!--- /* Include CLF Specific Styles - delete the section that is not required */ --->
        <!--- IF USING PHP (server side):
          <link rel="stylesheet" type="text/css" href = "http://salt.cose.gc.ca/site/css/ie6.css" />
        --->
        <!--- ELSE USE Javascript (client site):--->

        <SCRIPT LANGUAGE = "Javascript" TYPE = "text/javascript"
                SRC = "../docs/css-browser.js"></SCRIPT>
	        
    <link rel="StyleSheet" type="text/css" href="../docs/standard.css">

    <!--
     <link rel="stylesheet" type="text/css" href = "../docs/ie6.css" />
    -->
    <!--
     <SCRIPT LANGUAGE="Javascript" TYPE="text/javascript" SRC="http://salt.cose.gc.ca/site/css-browser.js"></SCRIPT>
    -->

    </HEAD>

    <body leftmargin = 0
          topmargin = "2"
          marginwidth = "0"
          marginheight = "2"
          LEFTMARGIN = "0"
          RIGHTMARGIN = "0"
          vlink = "800000"
          bgcolor = "FFFFFF"
          text = "000000"
          link = "000080">
<table width="600" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<a name="Top"><img border="0" src="../docs/tbsfip_e.gif" alt="Treasury Board of Canada Secretariat - Government of Canada" width="600" height="20"></a></td>
</tr>
</tbody></table>
<table width="600" cellspacing="0" cellpadding="0" title="Navigation Menu">
<tr>
<td colspan='6'><a href="#snav"><img src="../docs/blank.gif" alt="Skip to Side Menu" width="14" height="14" border="0"></a><a href="#skipnav"><img src="../docs/blank.gif" alt="Skip to Content Area" width="14" height="14" border="0"></a></td></tr>

<tr>
<td width="150"><img class="compact" src="../docs/blank.gif" width="25" height="10" alt="" border="0"><img src="../docs/blank.gif" class="compact" width="25" height="10" alt="" border="0"></td>
<td class="common" width="90"> 
<a lang='fr-ca' title='Voir cette page en français' class='common'  href="/tbsimScripts/altLanguage.asp?ResourceID=2555&amp;LanguageID=1&amp;FormatID=6&amp;PartNo=1&amp;Status=True&amp;Type=www">Français</a>

</td>
<td class="common" width="90"> 
<a title="Contact Us" class="contactez-nous" href="/tbs-sct/cmn/contact-eng.asp">Contact Us</a>

</td>
<td class="common" width="90"> 
<a title="Help" class="common" href="/tbs-sct/cmn/help-aide-eng.asp">Help</a>

</td>

<td class="common" width="90"> 
<a title='Search' class='common' href='/search-recherche/query-recherche.aspx?lang=en'>Search</a>

</td>
<td class="common" width="90"> 
<a title='Government of Canada Site' class='common' href='http://www.canada.gc.ca/home.html'>Canada&nbsp;Site</a>

</td>
</tr>
<tr>
<td width="150"></td>
<td width="90" class="inst"> 
<a title="What's New" class="inst" href="/tbsimScripts/new-nouveau_e.asp?who=rma">What's New</a>

</td>
<td width="90" class="inst"> 
<a title="About Us" class="inst" href="/tbs-sct/abu-ans/tbs-sct/abu-ans-eng.asp">About Us</a>

</td>
<td width="90" class="inst"> 
<a title="Policies" class="inst" href="/tbs-sct/cmn/policies-politiques-eng.asp">Policies</a>

</td>
<td width="90" class="inst"> 
<a title="Site Map" class="inst" href="/tbs-sct/cmn/map-carte-eng.asp">Site Map</a>

</td>

<td width="90" class="inst"> 
<a title='Home page for Treasury Board of Canada Secretariat' class='inst' href='/tbs-sct/index-eng.asp'>Home</a>

</td>
</tr>
</table>
</BODY>
</HTML>
