// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import java.util.Set;
import org.springframework.web.context.WebApplicationContext;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import kr.co.nis.waf.util.StringUtil;
import org.springframework.context.support.MessageSourceAccessor;
import java.util.Map;
import java.util.HashMap;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.apache.commons.logging.LogFactory;
import java.util.List;
import org.apache.commons.logging.Log;

public class ButtonSet extends WebControl
{
    protected final Log logger;
    private List data;
    
    public ButtonSet() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.data = null;
    }
    
    public List getData() {
        return this.data;
    }
    
    public void setData(final List data) {
        this.data = data;
    }
    
    public int doStartTag() {
        try {
            final JspWriter out = this.pageContext.getOut();
            String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
            final StringBuffer html = new StringBuffer();
            final HttpSession session = this.pageContext.getSession();
            final WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
            Map map = new HashMap();
            if (super.getHeight() <= 0) {
                super.setHeight(22);
            }
            if (super.getAlign() == null) {
                super.setAlign("center");
            }
            if (super.getCssClass() == null) {
                if (super.getPreset().equals("widget")) {
                    super.setCssclass("table_btn");
                }
                else if (super.getPreset().equals("button")) {
                    super.setCssclass("btnGreen");
                }
            }
            if (this.getData() != null) {
                if (!super.getPreset().equals("widget") || super.getValign() != null) {
                    html.append("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
                    html.append("<tr><td width=\"100%\" height=\"" + super.getHeight() + "\" align=\"" + super.getAlign() + "\">");
                }
                for (int i = 0; i < this.getData().size(); ++i) {
                    map = (Map) this.getData().get(i);
                    final Set set = map.keySet();
                    final Object[] keys = set.toArray();
                    final String functionKey = keys[0].toString();
                    if (super.getPreset().equals("widget")) {
                        html.append("<span id=\"" + map.get(functionKey).toString() + "\"></span>");
                        html.append("<script type=\"text/javascript\">");
                        html.append("var " + map.get(functionKey).toString() + " = new AW.UI.Button;");
                        html.append(map.get(functionKey).toString() + ".setId(\"" + map.get(functionKey).toString() + "\");");
                        html.append(map.get(functionKey).toString() + ".setControlText(\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button." + map.get(functionKey).toString()) + "\");");
                        html.append(map.get(functionKey).toString() + ".setControlImage(\"" + map.get(functionKey).toString() + "\");");
                        html.append(map.get(functionKey).toString() + ".refresh();");
                        html.append(map.get(functionKey).toString() + ".onClick = function(){" + StringUtil.nullToBlank(super.getEventProc()) + map.get(functionKey).toString() + "();}");
                        html.append("</script>");
                    }
                    else if (super.getPreset().equals("images")) {
                        html.append("<img src=\""+ appContextPath +"/images/btn/btn" + map.get(functionKey).toString() + ".gif\" name=\"btn" + map.get(functionKey).toString() + "\" id=\"btn" + map.get(functionKey).toString() + "\" onclick=\"" + map.get(functionKey).toString() + "();\" onfocus=\"this.blur();\" class=\"" + super.getCssClass() + "\" alt=\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button." + map.get(functionKey).toString()) + "\" />");
                    }
                    else {
                        html.append("<input type=\"button\" name=\"btn" + map.get(functionKey).toString() + "\" id=\"btn" + map.get(functionKey).toString() + "\" onclick=\"" + map.get(functionKey).toString() + "();\" onfocus=\"this.blur();\" class=\"" + super.getCssClass() + "\" value=\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button." + map.get(functionKey).toString()) + "\" />");
                    }
                }
                html.append("</td></tr></table>");
                html.append("<script language=\"javascript\">try{if(saveType==\"insert\"){document.all.btnDelete.style.display=\"none\";}}catch(e){}</script>");
                out.print(html.toString());
            }
        }
        catch (final IOException e) {
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("Error : " + e));
            }
        }
        return 0;
    }
}
