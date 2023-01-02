// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import java.util.Enumeration;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.mvc.Controller;

public class StaticPageViewController implements Controller
{
    protected final Log logger;
    
    public StaticPageViewController() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public ModelAndView handleRequest(final HttpServletRequest request, final HttpServletResponse response) {
        final String contextPath = request.getContextPath();
        final String uri = request.getRequestURI();
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)("URI : " + uri));
            this.logger.debug((Object)("ContextPath : " + contextPath));
        }
        int begin = 0;
        if (contextPath == null || contextPath.equals("")) {
            begin = 1;
        }
        else {
            begin = contextPath.length() + 1;
        }
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)("Begin : " + begin));
        }
        int end;
        if (uri.indexOf(";") != -1) {
            end = uri.indexOf(";");
        }
        else if (uri.indexOf("?") != -1) {
            end = uri.indexOf("?");
        }
        else {
            end = uri.length();
        }
        String fileName = uri.substring(begin, end);
        if (fileName.indexOf(".") != -1) {
            fileName = fileName.substring(0, fileName.lastIndexOf("."));
        }
        final Enumeration en = request.getParameterNames();
        while (en.hasMoreElements()) {
            final String attribute = (String) en.nextElement();
            final Object attributeValue = request.getParameter(attribute);
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("set Attribute in Request : " + attribute + "=" + attributeValue));
            }
            request.setAttribute(attribute, attributeValue);
        }
        return new ModelAndView(fileName);
    }
}
