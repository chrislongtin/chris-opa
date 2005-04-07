<%@ page import = "java.lang.*" %> 


<%
try
{
 if (System.getProperty("os.name").indexOf("Windows") > -1 ) 
     {
     Runtime rt = Runtime.getRuntime();       
     //Process prcs = rt.exec("hh.exe c:\\WINDOWS\\opa.chm::/Quick Start Guides.htm");
     Process prcs = rt.exec("hh.exe c:\\WINNT\\opa.chm");
     }
 else
 {
 String[] cmd = {"/bin/sh","-c", "ls > hello"};
 Runtime.getRuntime().exec(cmd);
 }
 }catch(Exception exc){}
%>
