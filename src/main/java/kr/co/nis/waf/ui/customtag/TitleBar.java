// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class TitleBar extends WebControl
{
    protected final Log logger;
    
    public TitleBar() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public int doStartTag() {
        try {
            final JspWriter out = this.pageContext.getOut();
            String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
            if ("list".equals(this.getPreset())) {
                out.println("<table width=\"100%\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-bottom:8px;\">");
                out.println("\t<tr><td width=\"100%\" height=\"22\" class=\"txDarkgray\" valign=\"middle\">");
                out.println("\t\t<img src=\""+ appContextPath +"/images/lblBlue03.gif\" width=\"16\" height=\"17\" align=\"absmiddle\" class=\"lbl02\"><label id=\"" + super.getId() + "\">" + super.getValue() + "</label>");
                out.println("\t</td></tr>");
                out.println("</table>");
            }
            else {
                out.println("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-bottom:8px;\">");
                out.println("\t<tr><td height=\"29\" class=\"tblViewTh\"><label id=\"" + super.getId() + "\">" + super.getValue() + "</label></td></tr>");
                out.println("</table>");
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
