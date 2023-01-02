// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class Calendar extends WebControl
{
    protected final Log logger;
    
    public Calendar() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public int doStartTag() {
        try {
            this.outTag();
        }
        catch (final Exception e) {
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("Error : " + e));
                e.printStackTrace();
            }
        }
        return 0;
    }
    
    private void outTag() {
        try {
            final JspWriter out = this.pageContext.getOut();
            final StringBuffer html = new StringBuffer();
            html.append("<input");
            if (super.getId() == null && super.getName() == null) {
                html.append(" id=\"control\" name=\"control\"");
            }
            else if (super.getId() != null && super.getName() == null) {
                html.append(" id=\"" + super.getId() + "\" name=\"" + super.getId() + "\"");
            }
            else if (super.getId() == null && super.getName() != null) {
                html.append(" id=\"" + super.getName() + "\" name=\"" + super.getName() + "\"");
            }
            else if (super.getId() != null && super.getName() != null) {
                html.append(" id=\"" + super.getId() + "\" name=\"" + super.getName() + "\"");
            }
            if (super.getCssClass() != null) {
                html.append(" class=\"" + super.getCssClass() + "\" ");
            }
            if (super.getStyle() != null && !super.getStyle().equals("")) {
                html.append(" style=\"width:80px; ime-mode:disabled; " + super.getStyle() + "\"");
            }
            else {
                html.append(" style=\"width:80px; ime-mode:disabled;\" ");
            }
            if (super.getValue() != null && !super.getValue().equals("")) {
                html.append(" value=\"" + super.getValue() + "\" ");
            }
            if (super.getReadOnly() != null && super.getReadOnly().equals("yes")) {
                html.append(" readonly=\"readonly\" ");
            }
            if (super.getEventProc() != null && !super.getEventProc().equals("")) {
                html.append(" onchange=\"" + super.getEventProc() + "\" ");
            }
            html.append(" onfocus=\"if(this.readOnly==false){this.value=unformat(this.value);this.select();}\" maxlength=\"8\" ");
            if (super.getExtend() != null && super.getExtend().equals("time")) {
                html.append(" onblur=\"if(this.readOnly==false){this.value=formatDateTime(this.value);}\"><img id=\"" + super.getId() + "_popup\" src=\"" + this.pageContext.getServletContext().getContextPath() + "/images/common/calendar.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:hand\" onclick=\"pickDateTime(this,document.getElementById('" + super.getId() + "'),'" + super.getCallback() + "');\"> ");
            }
            else {
                html.append(" onblur=\"if(this.readOnly==false){if(checkValidDate(this)){this.value=formatDate(this.value);}}\"><img id=\"" + super.getId() + "_popup\" src=\"" + this.pageContext.getServletContext().getContextPath() + "/images/common/calendar.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:hand\" onclick=\"pickDate(this,document.getElementById('" + super.getId() + "'),'" + super.getCallback() + "');\"> ");
            }
            if (super.getPreset() != null && super.getPreset().equals("aw")) {
                out.print(html.toString().replace("\"", "\\\""));
            }
            else {
                out.print(html.toString());
            }
        }
        catch (final IOException e) {
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("Error : " + e));
            }
        }
    }
}
