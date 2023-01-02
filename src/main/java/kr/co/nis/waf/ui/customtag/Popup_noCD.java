// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class Popup_noCD extends WebControl
{
    protected final Log logger;
    private String nameID;
    private String nameName;
    private String nameStyle;
    
    public Popup_noCD() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.nameID = null;
        this.nameName = null;
        this.nameStyle = null;
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
            String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
            final StringBuffer html = new StringBuffer();
            html.append(" <input type='text'");
            if (this.getNameID() == null && this.getNameName() == null) {
                html.append(" id=\"name\" name=\"name\"");
            }
            else if (this.getNameID() != null && this.getNameName() == null) {
                html.append(" id=\"" + this.getNameID() + "\" name=\"" + this.getNameID() + "\"");
            }
            else if (this.getNameID() == null && this.getNameName() != null) {
                html.append(" id=\"" + this.getNameName() + "\" name=\"" + this.getNameName() + "\"");
            }
            else if (this.getNameID() != null && this.getNameName() != null) {
                html.append(" id=\"" + this.getNameID() + "\" name=\"" + this.getNameName() + "\"");
            }
            if (this.getNameStyle() != null && !this.getNameStyle().equals("")) {
                html.append(" style=\"width:100px; " + this.getNameStyle() + "\" ");
            }
            else {
                html.append(" style=\"width:100px; \" ");
            }
            html.append(" class=\"input-readonly\" readonly=\"readonly\" />");
            html.append("<img id=\"" + super.getId() + "_popup\" src=\""+ appContextPath +"/images/common/search_popup.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:pointer\" />");
            if (this.getId() != null) {
                html.append(" <input type='hidden'");
                if (this.getId() == null && this.getName() == null) {
                    html.append(" id=\"id\" name=\"id\"");
                }
                else if (this.getId() != null && this.getName() == null) {
                    html.append(" id=\"" + this.getId() + "\" name=\"" + this.getId() + "\"");
                }
                else if (this.getId() == null && this.getName() != null) {
                    html.append(" id=\"" + this.getId() + "\" name=\"" + this.getName() + "\"");
                }
                else if (this.getId() != null && this.getName() != null) {
                    html.append(" id=\"" + this.getId() + "\" name=\"" + this.getName() + "\"");
                }
                html.append(" />");
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
    
    public String getNameID() {
        return this.nameID;
    }
    
    public void setNameID(final String nameID) {
        this.nameID = nameID;
    }
    
    public String getNameName() {
        return this.nameName;
    }
    
    public void setNameName(final String nameName) {
        this.nameName = nameName;
    }
    
    public String getNameStyle() {
        return this.nameStyle;
    }
    
    public void setNameStyle(final String nameStyle) {
        this.nameStyle = nameStyle;
    }
}
