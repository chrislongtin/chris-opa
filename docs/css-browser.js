/* Applies one of the following style sheets depending on the browser.
· netscape.css: Netscape 4, Lynx (text)
· ns7: Netscape 6 and 7, Mozilla 1, Konqueror 3.3.1
· explorer.css: Internet Explorer 4 & 5, Opera 5 & 6, WebTV 2.6
· ie6.css: Internet Explorer 6
*/
var css = "netscape.css";
var nua = navigator.userAgent;

if (document.layers)
    ;

// NS4
else if (nua.indexOf('Gecko') != -1)
    css = "ns7.css";

else if (document.all)
    {
    css = "explorer.css";

    if (document.getElementById)
        {
        str_pos = nua.indexOf('MSIE');
        var nu = nua.substr((str_pos + 5), 3);

        if ((str_pos != -1) && (nu.substring(0, 1) >= 6))
            css = "ie6.css";
        }
    }

document.write('<link rel = "stylesheet" type = "text\/css" href = "../docs/'+css+'" />');
