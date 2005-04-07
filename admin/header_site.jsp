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
            <c:set var = "lang" scope = "session" value = "${q.rows[0].default_lang}"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test = "${!empty param.lang}">
    <c:set var = "lang" value = "${param.lang}" scope = "session"/>
</c:if>

<HTML LANG = "en">
    <HEAD>
        <TITLE>CoSE - The &quot;Collaborative Software Engineering&quot; Worksite Initiative</TITLE>
        <!-- GoC CLF METADATA PROFILE: START-->
        <meta http-equiv = "Content-Type" content = "text/html; charset=UTF-8">
        <meta name = "MSSmartTagsPreventParsing" content = "TRUE">
        <link rel = "schema.dc" href = "http://purl.org/dc/elements/1.1/">
        <meta name = "dc.title" lang = "eng"
              content = "CoSE - The &quot;Collaborative Software Engineering&quot; Worksite Initiative">
        <meta name = "dc.subject" scheme = "gccore" lang = "eng" content = "">
        <meta name = "description" lang = "eng" content = "">
        <meta name = "keywords" lang = "eng" content = "">
        <meta name = "dc.language" scheme = "ISO639-2" content = "eng">
        <meta name = "dc.creator" lang = "eng"
              content = "Government of Canada, Public Works and Government Services Canada">
        <meta name = "dc.publisher" lang = "eng" content = "Public Works and Government Services Canada">
        <meta name = "pwgsc.contact.email" content = "questions@pwgsc.gc.ca">
        <meta name = "dc.rights" lang = "eng"
              content = "http://cose.gc.ca/site/setlang.php?lang=e&url=http://salt.cose.gc.ca/site/notice-avis.php">
        <meta name = "dc.date.created" lang = "fra" content = "2005-04-01">
        <meta name = "dc.date.modified" content = "2005-04-01">
        <meta name = "dc.date.published" content = "2005-04-01">
        <meta name = "dc.date.reviewed" content = "2005-04-01">
        <meta name = "pwgsc.date.retention" content = "2010-12-31">
        <!-- leave blank -->
        <meta name = "dc.contributor" lang = "eng" content = "">
        <meta name = "dc.identifier" content = "">
        <meta name = "dc.audience" lang = "eng" content = "general public">
        <meta name = "dc.audience" lang = "eng" content = "business">
        <meta name = "dc.audience" lang = "eng" content = "government">
        <meta name = "dc.type" lang = "eng" content = "application">
        <meta name = "dc.format" lang = "eng" content = "">
        <meta name = "dc.coverage" lang = "eng" content = "">
        <!--GoC CLF METADATA PROFILE: END-->

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
	
     <SCRIPT LANGUAGE = "Javascript" TYPE = "text/javascript" SRC = "../docs/css-browser.js"></SCRIPT> 


    <!--
     <link rel="stylesheet" type="text/css" href = "../docs/ie6.css" />
    -->
    <!--
     <SCRIPT LANGUAGE="Javascript" TYPE="text/javascript" SRC="http://salt.cose.gc.ca/site/css-browser.js"></SCRIPT>
    -->

    </HEAD>

    <BODY TOPMARGIN = "2" MARGINHEIGHT = "2" MARGINWIDTH = "0" LEFTMARGIN = "0" RIGHTMARGIN = "0" BGCOLOR = "#FFFFFF">

        <!-- GoC CLF HEADER: START -->
        <TABLE BORDER = "0" CELLPADDING = "0" CELLSPACING = "0" WIDTH = 600 SUMMARY = "LOGO" CLASS = "FullWidth">
            <TR>
                <TD WIDTH = "92" VALIGN = TOP ALIGN = RIGHT CLASS = "noPrint">
                    <a name = "Top">

                    <IMG SRC = "../docs/blank.gif" WIDTH = 92 HEIGHT = 1 ALT = ""/></A>
                </TD>

                <TD WIDTH = "40" VALIGN = TOP ALIGN = RIGHT>
                    <IMG SRC = "../docs/canada.gif" WIDTH = 40 HEIGHT = 20 ALT = "Canada Flag"/>
                </TD>

                <TD WIDTH = "18" VALIGN = TOP>
                    <IMG SRC = "../docs/blank.gif" HEIGHT = "1" WIDTH = "18" ALT = ""/>
                </TD>

                <TD WIDTH = "225" VALIGN = TOP>
                    <IMG SRC = "../docs/goc-e.gif" WIDTH = "225" HEIGHT = "20" ALT = "Government of Canada"
                         BORDER = "0"/>
                </TD>

                <TD WIDTH="142" VALIGN=TOP CLASS="FullWidth"></TD>
		<!--<TD WIDTH="142" VALIGN=TOP CLASS="FullWidth"><IMG SRC="../docs/blank.gif" WIDTH=142 HEIGHT=20 ALT="" /></TD>  -->

                <TD WIDTH = "83" VALIGN = TOP>
                    <IMG SRC = "../docs/wordmark.gif" WIDTH = "83" HEIGHT = "21"
                         ALT = "Symbol of the Government of Canada"/>
                </TD>
            </TR>

            <TR>
                <TD>
                    <IMG SRC = "../docs/blank.gif" HEIGHT = "14" WIDTH = "1" ALT = ""/>
                </TD>
            </TR>
        </TABLE>

	

	
        <TABLE BORDER = "0" CELLPADDING = "0" CELLSPACING = "0" WIDTH = "600" SUMMARY = "TOP MENU" CLASS = "noPrint">
            <TR>
                <TD WIDTH = "150">
                </TD>

                <TD WIDTH = "450">
                    <TABLE BORDER = "0" CELLPADDING = "0" CELLSPACING = "0" WIDTH = "100%">
                        <TR>
                            <c:choose>
                                <c:when test = "${sessionScope.user=='reviewer'}">
                                    <TD WIDTH = "83" CLASS = "barBlack">
                                        <a href = "http://www.leapfrogindex.com:8090/coseopa/admin/index.jsp?fuseaction=main&lang=<c:out value="${lang}" />"
                                           STYLE = "color:#FFFFFF;" >Fran&ccedil;ais</A>
                                    </TD>
                                </c:when>

                                <c:when test = "${sessionScope.user=='coordinator'}">
                                    <TD WIDTH = "83" CLASS = "barBlack">
                                        <a href = "http://www.leapfrogindex.com:8090/coseopa/admin/index.jsp?fuseaction=proposals&lang=<c:out value="${lang}" />"
                                          STYLE = "color:#FFFFFF;" >Fran&ccedil;ais</A>
                                    </TD>
                                </c:when>

                                <c:otherwise>
                                    <TD WIDTH = "83" CLASS = "barBlack">
                                        <a href = "http://www.leapfrogindex.com:8090/coseopa/admin/index.jsp?fuseaction=proposals&lang=<c:out value="${lang}" />"
                                          STYLE = "color:#FFFFFF;" >Fran&ccedil;ais</A>
                                    </TD>
                                </c:otherwise>
                            </c:choose>

                            <TD WIDTH = "1" CLASS = "barSpacer">
                            </TD>

                            <TD WIDTH = "90" CLASS = "barBlack">
                                <a href = "http://salt.cose.gc.ca/site/contact.php" STYLE = "color:#FFFFFF;">Contact Us</A>
                            </TD>

                            <TD WIDTH = "1" CLASS = "barSpacer">
                            </TD>

                            <TD WIDTH = "89" CLASS = "barBlack">
                                <a href = "http://www.leapfrogindex.com:8090/coseopa/admin/index.jsp?fuseaction=help"
                                   STYLE = "color:#FFFFFF;">Help</A>
                            </TD>

                            <TD WIDTH = "1" CLASS = "barSpacer">
                            </TD>

                            <TD WIDTH = "95" CLASS = "barBlack">
                                <a href = "http://www.leapfrogindex.com:8090/coseopa/admin/index.jsp?fuseaction=proposals"
                                  STYLE = "color:#FFFFFF;">Search</A>
                            </TD>

                            <TD WIDTH = "1" CLASS = "barSpacer">
                            </TD>

                            <TD WIDTH = "89" CLASS = "barBlack">
                                <a href = "http://canada.gc.ca/main_e.html" STYLE = "color:#FFFFFF;">Canada Site</A>
                            </TD>
                        </TR>

                        <TR>
                            <TD HEIGHT = "2" COLSPAN = "9" CLASS = "barSpacer">
                            </TD>
                        </TR>

                        <TR>
                            <TD CLASS = "barColour" colspan = 3>
                                <a href = "http://salt.cose.gc.ca/site/sla.php" STYLE = "color:#FFFFFF;">Service Level
                                Agreement</A>
                            </TD>

                            <TD WIDTH = "1" CLASS = "barSpacer">
                            </TD>

                            <TD CLASS = "barColour">
                                <a href = "http://salt.cose.gc.ca/site/about.php" STYLE = "color:#FFFFFF;">About Us</A>
                            </TD>

                            <TD WIDTH = "1" CLASS = "barSpacer">
                            </TD>

                            <TD CLASS = "barColour">
                                <a href = "http://www.leapfrogindex.com:8090/coseopa/admin/dsp_login_type.jsp"
                                   STYLE = "color:#FFFFFF;">Login</A>
                            </TD>

                            <TD WIDTH = "1" CLASS = "barSpacer">
                            </TD>

                            <TD CLASS = "barColour">
                                <a href = "https://salt.cose.gc.ca/site/index.html" STYLE = "color:#FFFFFF;">Home</A>
                            </TD>
                        </TR>

                        <TR>
                            <TD HEIGHT = "2" COLSPAN = "9" CLASS = "barSpacer">
                            </TD>
                        </TR>


                    </TABLE>
                </TD>
            </TR>
        </TABLE>

        <!-- GoC CLF HEADER: END -->
        <TABLE BORDER = "0" CELLSPACING = "0" CELLPADDING = "0" WIDTH = "600" class = "FullWidth">
            <TR>

                <!-- GoC CLF SIDE MENU: START -->

                <TD WIDTH = "132" VALIGN = "top" CLASS = "noPrint">
                    <TABLE BORDER = "0" CELLSPACING = "0" CELLPADDING = "0" WIDTH = "132">
                        <TR>
                            <TD VALIGN = "top">
                                <a href = "http://salt.cose.gc.ca/site/aboutus.php">

                                <IMG SRC = "../docs/cose-e.jpg"
                                     HEIGHT = "74"
                                     WIDTH = "132"
                                     BORDER = "0"
                                     ALT = "CoSE Worksite Initiative"
                                     TITLE = "CoSE - The &quot;Collaborative Software Engineering&quot; Worksite Initiative"/></A>
                            </TD>
                        </TR>

                    <!--- NO SIDE MENU FOR THIS PAGE --->

                    </TABLE>
                </TD>

                <!-- GoC CLF SIDE MENU: END -->

                <TD WIDTH = "18" CLASS = "LeftWidth">
                    <IMG SRC = "../docs/blank.gif" HEIGHT = "1" WIDTH = "18" ALT = "" CLASS = "LeftWidth"/>
                </TD>

                <TD COLSPAN = "3" WIDTH = "100%" VALIGN = "top">

                    <!-- MAIN BODY CONTENT: START -->
                    <!--- ENGLISH CONTENT:START --->

                    <H2>CoSE - The &quot;Collaborative Software Engineering&quot; Worksite Initiative</H2>

                    <table>
                        <tr>
                            <td align = "center" bgcolor = "E8E8E8">
                                <font face = "Arial" size = "3"><b>

                                <cf:GetPhrase phrase_id = "1039" lang_id = "${lang}"/></b></font>
                            </td>
                        </tr>
                    </table>

                    <br>
                <!--- ENGLISH CONTENT:END --->
                <!-- MAIN BODY CONTENT: END -->
                </TD>
            </TR>
        </TABLE>

        </font>
    </BODY>
</HTML>
