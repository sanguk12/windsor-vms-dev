// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.AbstractView;

public class SimpleHtmlView extends AbstractView
{
    protected final Log logger;
    
    public SimpleHtmlView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void renderMergedOutputModel(final Map map, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        final PrintWriter out = response.getWriter();
        out.println(map.get("html"));
    }
}
