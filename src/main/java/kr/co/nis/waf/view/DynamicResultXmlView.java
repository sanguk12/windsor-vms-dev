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

public class DynamicResultXmlView extends AbstractView
{
    protected final Log logger;
    
    public DynamicResultXmlView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void renderMergedOutputModel(final Map map, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        try {
            final List<Map> data = (List<Map>)map.get("data");
            final Map status = (Map) map.get("status");
            response.setContentType("text/xml; charset=utf-8");
            final PrintWriter out = response.getWriter();
            out.println("<rows>");
            if (status.get("statusCode").toString().equals("S")) {
                this.logger.debug((Object)data.size());
                if (data.size() > 0) {
                    final Iterator header = data.get(0).keySet().iterator();
                    final String[] messagekey = new String[data.get(0).keySet().size()];
                    int keyindex = 0;
                    while (header.hasNext()) {
                        messagekey[keyindex++] = header.next().toString();
                    }
                    out.println("<row>");
                    if (status.get("statusCode").toString().equals("S")) {
                        for (keyindex = 0; keyindex < messagekey.length; ++keyindex) {
                            if (keyindex == 0) {
                                out.println("<" + messagekey[keyindex] + ">" + "<![CDATA[" + status.get("statusCode").toString() + ";]]>" + "<![CDATA[" + status.get("statusMessage").toString() + ";]]>" + "<![CDATA[" + String.valueOf(messagekey.length) + ";]]>" + "</" + messagekey[keyindex] + ">");
                            }
                            else {
                                out.println("<" + messagekey[keyindex] + ">" + "<![CDATA[" + "0" + "]]>" + "</" + messagekey[keyindex] + ">");
                            }
                        }
                    }
                    else {
                        out.println("<" + messagekey[keyindex] + ">" + "<![CDATA[" + status.get("statusCode").toString() + ";]]>" + "</" + messagekey[keyindex] + ">");
                        out.println("<" + messagekey[keyindex] + ">" + "<![CDATA[" + status.get("statusMessage").toString() + "]]>" + "</" + messagekey[keyindex] + ">");
                    }
                    out.println("</row>");
                    out.println("<row>");
                    for (keyindex = 0; keyindex < messagekey.length; ++keyindex) {
                        out.println("<" + messagekey[keyindex] + ">" + "<![CDATA[" + messagekey[keyindex] + "]]>" + "</" + messagekey[keyindex] + ">");
                    }
                    out.println("</row>");
                    Map resultSet = null;
                    for (int i = 0; i < data.size(); ++i) {
                        resultSet = data.get(i);
                        out.println("<row>");
                        for (keyindex = 0; keyindex < messagekey.length; ++keyindex) {
                            out.println("<" + messagekey[keyindex] + ">" + "<![CDATA[" + StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])) + "]]>" + "</" + messagekey[keyindex] + ">");
                        }
                        out.println("</row>");
                    }
                }
            }
            else {
                out.println("<row>");
                for (int keyindex2 = 0; keyindex2 < 3; ++keyindex2) {
                    if (keyindex2 == 0) {
                        out.println("<statusCode><![CDATA[" + status.get("statusCode").toString() + "]]>" + "</statusCode>");
                    }
                    else if (keyindex2 == 1) {
                        out.println("<statusMessage><![CDATA[" + status.get("statusMessage").toString() + "]]>" + "</statusMessage>");
                    }
                    else if (keyindex2 == 2) {
                        out.println("<columnCount><![CDATA[0]]></columnCount>");
                    }
                }
                out.println("</row>");
            }
            out.println("</rows>");
        }
        catch (final Exception e) {
            if (this.logger.isDebugEnabled()) {
                e.printStackTrace();
            }
        }
    }
}
