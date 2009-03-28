package opa.filter;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import opa.model.InitiativeSetup;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Chris Longtin
 * @email chris.longtin@gmail.com
 * 
 * 
 *        This filter will not allow processing of certain types of files that
 *        are found in the upload directory. Notably, .jsp, which would be
 *        executed on the server!
 * 
 *        TODO: give better error page/message instead of just sending back a
 *        response of 500.
 *        
 *        TODO: bypass .gif, .jsp, .css, .png, etc.
 * 
 */
public class BlockProcessing implements Filter {
    
    private final static Log log = LogFactory.getLog(BlockProcessing.class);

    private Pattern pattern;

    @Override
    public void init(FilterConfig fc) throws ServletException {
        /*
         * build a regex of the form:
         * ^.+\\.((jsp)|(js)|(sh)|(cmd)|(exe)|(com)|(pl)|(cgi))$
         */
        String[] extensions = fc.getInitParameter("extensions").split(",");

        StringBuffer buf = new StringBuffer();
        buf.append("^.+\\.(");
        
        for(int i = 0 ; i != extensions.length ; ++i) {
            buf.append("(");
            buf.append(extensions[i]);
            buf.append(")");
            
            if(i + 1 != extensions.length)
                buf.append("|");
        }
        
        buf.append(")$");
        
        String extMatch = buf.toString();
        
        pattern = Pattern.compile(buf.toString());
        log.info("extensions to be filtered from upload directory: " + extMatch);
    }

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest)req;
        HttpServletResponse response = (HttpServletResponse)res;

        InitiativeSetup setup = 
            (InitiativeSetup)request.getSession().getAttribute("initiativeSetup");
        
        if(setup == null) {
            log.error("could not get InitiativeSetup from application context");
            response.sendError(500);
        }
        
        String contextRoot = 
            request.getSession().getServletContext().getContextPath();
        
        String uri = request.getRequestURI();
        String path = contextRoot + "/" + setup.getHost_doc_dir();
        
        /*
         * We want don't want the server to execute user uploaded files. We
         * probably also don't want the client to either. This isn't a
         * comprehensive list of files, and a better solution is to have the
         * upload directory non-executable by the tomcat process. For each file
         * you add to the uri regex, make sure there is a filter-mapping that will
         * catch that type in the web.xml file.
         */
        if(uri.startsWith(path)) {
            Matcher matcher = pattern.matcher(uri);
            
            if(matcher.find()) {
                log.warn("Users can not view type of file: " + uri);
                response.sendError(500);
                return;
            }
        }
    
        fc.doFilter(req, res);
    }
}