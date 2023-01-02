// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf;

import java.io.IOException;
import java.util.Iterator;
import java.io.PrintWriter;
import kr.co.nis.waf.util.StringUtil;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.AbstractView;

public class ResultView extends AbstractView
{
    protected final Log logger;
    
    public ResultView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void renderMergedOutputModel(final Map map, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        final ResultMessage resultMsg = (ResultMessage) map.get("resultMsg");
        final Map parameters = (Map) map.get("parameters");
        response.setContentType("text/xml; charset=utf-8");
        final PrintWriter out = response.getWriter();
        out.println("<rows>");
        out.println("\t<row>");
        if (resultMsg != null) {
            out.println("\t\t<code>" + StringUtil.nullToBlank(resultMsg.getCode()) + "</code>");
            out.println("\t\t<message>" + StringUtil.nullToBlank(resultMsg.getMessage()) + "</message>");
            out.println("\t\t<sysmessage>" + StringUtil.nullToBlank(resultMsg.getSystemMessage()) + "</sysmessage>");
            for (int i = 0; i < resultMsg.getParametersSize(); ++i) {
                if (this.logger.isDebugEnabled()) {
                    this.logger.debug((Object)resultMsg.getParameters(i));
                }
                out.println("\t<parameter" + i + ">" + StringUtil.nullToBlank(resultMsg.getParameters(i)) + "</parameter" + i + ">");
            }
        }
        if (parameters != null) {
            parameters.keySet();
            final Iterator paramKey = parameters.keySet().iterator();
            while (paramKey.hasNext()) {
                final String keyString = paramKey.next().toString();
                out.println("\t\t<" + keyString + ">" + StringUtil.nullToBlank(parameters.get(keyString)) + "</" + keyString + ">");
            }
        }
        out.println("\t</row>");
        out.println("</rows>");
    }
}
