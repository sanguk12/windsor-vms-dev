// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import org.springframework.web.context.WebApplicationContext;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class Button extends WebControl
{
    protected final Log logger;
    
    public Button() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public int doStartTag() {
        try {
            final JspWriter out = this.pageContext.getOut();
            String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
            final StringBuffer html = new StringBuffer();
            final HttpSession session = this.pageContext.getSession();
            final WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
            if (super.getCssClass() == null) {
                if (super.getPreset().equals("widget")) {
                    super.setCssclass("table_btn");
                }
                else if (super.getPreset().equals("button")) {
                    super.setCssclass("btnGreen");
                }
            }
            if (super.getPreset().equals("widget")) {
                html.append("<span id=\"" + super.getId() + "\"></span>");
                html.append("<script type=\"text/javascript\">");
                html.append("var " + super.getId() + " = new AW.UI.Button;");
                html.append(super.getId() + ".setId(\"" + super.getId() + "\");");
                html.append(super.getId() + ".setControlText(\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button." + super.getId()) + "\");");
                html.append(super.getId() + ".setControlImage(\"" + super.getId() + "\");");
                html.append(super.getId() + ".refresh();");
                html.append(super.getId() + ".onClick = function(){");
                if (super.getEventProc() != null) {
                    html.append(super.getEventProc());
                }
                else {
                    html.append(super.getId() + "();");
                }
                html.append("}");
                html.append("</script>");
            }
            else if (super.getPreset().equals("image")) {
                html.append("<img src=\""+ appContextPath +"/images/btn/" + super.getId() + ".gif\" name=\"btn" + super.getId() + "\" id=\"btn" + super.getId() + "\"");
                if (super.getEventProc() != null) {
                    html.append(" onclick=\"" + super.getEventProc() + "();\"");
                }
                else {
                    html.append(" onclick=\"" + super.getId() + "();\"");
                }
                html.append(" onfocus=\"this.blur();\" class=\"" + super.getCssClass() + "\" alt=\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button." + super.getId()) + "\" />");
            }
            else {
                html.append("<input type=\"button\" name=\"btn" + super.getId() + "\" id=\"btn" + super.getId() + "\"");
                if (super.getEventProc() != null) {
                    html.append(" onclick=\"" + super.getEventProc() + "();\"");
                }
                else {
                    html.append(" onclick=\"" + super.getId() + "();\"");
                }
                html.append(" onfocus=\"this.blur();\" class=\"" + super.getCssClass() + "\" value=\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button." + super.getId()) + "\" />");
            }
            out.print(html.toString());
        }
        catch (final IOException e) {
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("Error : " + e));
            }
        }
        return 0;
    }
}
