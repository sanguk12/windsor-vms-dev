// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import java.io.IOException;
import java.util.Iterator;
import java.io.PrintWriter;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;
import java.util.List;
import kr.co.nis.waf.common.SessionManager;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.AbstractView;

public class SimpleXmlView extends AbstractView
{
    protected final Log logger;
    
    public SimpleXmlView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void renderMergedOutputModel(final Map model, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        try {
            final SessionManager session = new SessionManager(request, response);
            final List<Map> data = (List<Map>)model.get("data");
            String[] format = null;
            try {
                format = (String[]) model.get("format");
            }
            catch (final Exception ex) {}
            response.setContentType("text/xml; charset=utf-8");
            final PrintWriter out = response.getWriter();
            final StringBuffer sb = new StringBuffer();
            sb.append("<rows>");
            if (data.size() > 0) {
                final Iterator header = data.get(0).keySet().iterator();
                final String[] messagekey = new String[data.get(0).keySet().size()];
                int keyindex = 0;
                while (header.hasNext()) {
                    messagekey[keyindex++] = header.next().toString();
                }
                Map resultSet = null;
                for (int i = 0; i < data.size(); ++i) {
                    resultSet = data.get(i);
                    sb.append("<row>");
                    for (keyindex = 0; keyindex < messagekey.length; ++keyindex) {
                        if (format == null) {
                            sb.append("<" + messagekey[keyindex] + "><![CDATA[" + StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])) + "]]></" + messagekey[keyindex] + ">");
                        }
                        else if (format[keyindex].equals("str")) {
                            sb.append("<r" + String.valueOf(keyindex) + "><![CDATA[" + StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])) + "]]></r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("date")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.convertDate(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), "YMD", session.getDateFormat()) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("datetime")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDateTime(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("time")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatTime(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("num")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatNum(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("num1")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDecimal(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), 1) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("num2")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDecimal(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), 2) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("num3")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDecimal(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), 3) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("num4")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDecimal(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), 4) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("num5")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDecimal(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), 5) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("num6")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDecimal(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), 6) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("amt")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatDecimal(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), 2) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("tel")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatTelNo(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("zip")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatZipCode(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("bizno")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatBizRegNo(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("idno")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatIDNo(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("idno*")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatIDNo(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), "*") + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("cardno")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatCardNo(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else if (format[keyindex].equals("password")) {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + FormatUtil.formatPassword(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) + "</r" + String.valueOf(keyindex) + ">");
                        }
                        else {
                            sb.append("<r" + String.valueOf(keyindex) + ">" + StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])) + "</r" + String.valueOf(keyindex) + ">");
                        }
                    }
                    sb.append("</row>");
                }
            }
            sb.append("</rows>");
            out.print(sb);
        }
        catch (final Exception e) {
            if (this.logger.isDebugEnabled()) {
                e.printStackTrace();
            }
        }
    }
}
