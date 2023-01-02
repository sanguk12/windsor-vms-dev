// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SimpleDispatcherServlet extends DispatcherServlet
{
    protected final Log logger;
    
    public SimpleDispatcherServlet() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }

    protected void doService(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        try {
            super.doService(request, response);
        }
        catch (Exception e) {
            logger.error(e);
        }
    }
}
