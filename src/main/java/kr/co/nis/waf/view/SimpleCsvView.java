// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import java.io.IOException;
import java.util.Iterator;
import java.io.PrintWriter;
import kr.co.nis.waf.util.StringUtil;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.AbstractView;

public class SimpleCsvView extends AbstractView
{
    protected final Log logger;
    
    public SimpleCsvView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void renderMergedOutputModel(final Map map, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        try {
            final List<Map> data = (List<Map>)map.get("data");
            final String[] headerText = (String[]) map.get("headerText");
            String fileName = (String) map.get("fileName");
            final String strClient = request.getHeader("user-agent");
            if ("".equals(fileName) || fileName == null) {
                fileName = "Csv";
            }
            if (strClient.indexOf("MSIE 5.5") != -1) {
                response.setContentType("application/CSV; charset=euc-kr");
                response.setHeader("Content-Disposition", "inline; filename=" + URLEncoder.encode(fileName, "utf-8") + ".csv");
            }
            else {
                response.setContentType("application/CSV; charset=euc-kr");
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "utf-8") + ".csv");
            }
            final PrintWriter out = response.getWriter();
            String str = "";
            if (data.size() > 0) {
                final Iterator header = data.get(0).keySet().iterator();
                final String[] messagekey = new String[data.get(0).keySet().size()];
                int keyindex = 0;
                while (header.hasNext()) {
                    messagekey[keyindex++] = header.next().toString();
                    if (headerText == null || headerText.length == 0 || headerText[0].equals("")) {
                        if (keyindex - 1 == 0) {
                            str = StringUtil.nullToBlank(messagekey[keyindex - 1]).replace(',', ' ');
                        }
                        else {
                            str = str + "," + StringUtil.nullToBlank(messagekey[keyindex - 1]).replace(',', ' ');
                        }
                    }
                    else if (keyindex - 1 == 0) {
                        str = StringUtil.nullToBlank(headerText[keyindex - 1]).replace(',', ' ');
                    }
                    else {
                        str = str + "," + StringUtil.nullToBlank(headerText[keyindex - 1]).replace(',', ' ');
                    }
                }
                out.println(str);
                Map resultSet = null;
                for (int i = 0; i < data.size(); ++i) {
                    str = "";
                    resultSet = data.get(i);
                    for (keyindex = 0; keyindex < messagekey.length; ++keyindex) {
                        if (keyindex == 0) {
                            str = StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])).replace(',', ' ');
                        }
                        else {
                            str = str + "," + StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])).replace(',', ' ');
                        }
                    }
                    out.println(str);
                }
            }
            else {
                if (headerText != null) {
                    if (headerText.length != 0) {
                        for (int j = 0; j < headerText.length; ++j) {
                            if (j == 0) {
                                str = StringUtil.nullToBlank(headerText[j]).replace(',', ' ');
                            }
                            else {
                                str = str + "," + StringUtil.nullToBlank(headerText[j]).replace(',', ' ');
                            }
                        }
                    }
                }
                out.println(str);
            }
        }
        catch (final Exception e) {
            if (this.logger.isDebugEnabled()) {
                e.printStackTrace();
            }
        }
    }
}
