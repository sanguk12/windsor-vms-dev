// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import java.io.IOException;
import java.util.Iterator;
import java.io.PrintWriter;
import kr.co.nis.waf.util.StringUtil;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.AbstractView;

public class SimpleJsonView extends AbstractView
{
    protected final Log logger;
    
    public SimpleJsonView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void renderMergedOutputModel(final Map map, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        try {
            final List<Map> data = (List<Map>)map.get("data");
            response.setContentType("text/html; charset=utf-8");
            final PrintWriter out = response.getWriter();
            final StringBuffer sb = new StringBuffer();
            if (data.size() > 0) {
                boolean arry = true;
                boolean sep = false;
                final Map main = data.get(0);
                final Iterator mainKey = main.keySet().iterator();
                Map row = null;
                String keyString = "";
                int idx = 0;
                sb.append("{");
                sep = false;
                while (mainKey.hasNext()) {
                    if (sep) {
                        sb.append(", ");
                    }
                    sep = true;
                    keyString = mainKey.next().toString();
                    arry = true;
                    for (idx = 0; idx < data.size(); ++idx) {
                        row = data.get(idx);
                        if (arry) {
                            sb.append(keyString + ":[");
                        }
                        if (!arry) {
                            sb.append(", ");
                        }
                        arry = false;
                        sb.append("'" + StringUtil.nullToBlank(row.get(keyString)).toString() + "'");
                    }
                    sb.append("]");
                }
                sb.append("}");
            }
            else {
                sb.append("''");
            }
            out.println(sb.toString());
        }
        catch (final Exception e) {
            if (this.logger.isDebugEnabled()) {
                e.printStackTrace();
            }
        }
    }
}
