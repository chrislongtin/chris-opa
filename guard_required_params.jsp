<%@ page import = "java.lang.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.StringWriter"%>
<%@ page import = "java.io.PrintWriter"%>

<%
    class GuardRequiredParams
        {
        private Map params;
        private ArrayList missed;

        GuardRequiredParams(ServletRequest request)
            {
            params = request.getParameterMap();
            }

        GuardRequiredParams(com.jspsmart.upload.Request request)
            {
            params = new Hashtable();

            for (Enumeration e = request.getParameterNames(); e.hasMoreElements(); )
                {
                String key = (String)e.nextElement();
                params.put(key, request.getParameterValues(key));
                }
            }

        boolean isParameterMissed()
            {
            missed = new ArrayList();

            for (Iterator it = params.entrySet().iterator(); it.hasNext(); )
                {
                Map.Entry param  = (Map.Entry)it.next();
                String paramname = (String)param.getKey();

                if (paramname.endsWith("_required"))
                    {
                    String reqname = paramname.substring(0, paramname.length() - 9);

                    if (!params.containsKey(reqname))
                        {
                        missed.add(reqname);
                        }

                    else
                        {
                        String [] paramvals = (String [])params.get(reqname);

                        if ((paramvals == null) || (paramvals.length <= 0)
                                || ((paramvals.length == 1) && (paramvals[0].length() <= 0)))
                            {
                            missed.add(reqname);
                            }
                        }
                    }
                }

            return (missed.size() > 0);
            }

        String getSplashScreen()
            throws JspException
            {
            if (missed == null)
                throw new JspException("GuardRequiredParams::isParameterMissed() method never called.");

            if (missed.size() <= 0)
                return "";

            StringWriter buffer = new StringWriter();
            PrintWriter out = new PrintWriter(buffer);
%>

            <html>
                <head>
                    <title>Form entries incomplete or invalid.</title>
                </head>

                <body>
                    <table border = "1" cellpadding = "3" bordercolor = "#000808" bgcolor = "#e7e7e7">
                        <tr>
                            <td>
                                <table cellpadding = "0" cellspacing = "0" border = "0" width = "500">
                                    <tr>
                                        <td id = "tableProps2" align = "left" valign = "middle">
                                            <h1 id = "textSection1" style = "COLOR: black; FONT: 13pt/15pt verdana">
                                            Form entries incomplete or invalid. </h1>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td id = "tablePropsWidth" colspan = "2">
                                            <font style = "COLOR: black; FONT: 8pt/11pt verdana">

                                            <ul>
<%
                                                for (Iterator it = missed.iterator(); it.hasNext(); )
                                                    {
                                                    String reqfield = (String)it.next();
%>

                                                    <li>A value must be entered for the <%= reqfield.toUpperCase() %>
                                                    field.

<%
                                                    }
%>
                                            </ul>

                                            Please go <a STYLE="text-decoration: underline"  href = "javascript: history.back()">back</a> and correct the
                                            problem. </font>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </body>
            </html>

<%
            return buffer.toString();
            }
        }
%>
