// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class PageNavigator extends WebControl
{
    protected final Log logger;
    private String titleDisable;
    
    public PageNavigator() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.titleDisable = null;
    }
    
    public int doStartTag() {
        try {
            final JspWriter out = this.pageContext.getOut();
            final StringBuffer html = new StringBuffer();
            if (this.getTitleDisable() != null && (this.getTitleDisable().toUpperCase().equals("YES") || this.getTitleDisable().toUpperCase().equals("Y"))) {
                html.append("G.P ");
            }
            else {
                html.append("Go to page ");
            }
            html.append("<input type=\"text\" id=\"" + super.getId() + "_pageNum\" value=\"1\" style=\"width:50px;text-align:right;\" onkeypress=\"if (event.keyCode==13){pagingGrid('" + super.getId() + "','GOTO', '" + super.getCallback() + "'); return false;}\">");
            html.append("<input type=\"hidden\" id=\"" + super.getId() + "_totalCount\">");
            html.append("&nbsp;&nbsp;");
            if (this.getTitleDisable() != null && (this.getTitleDisable().toUpperCase().equals("YES") || this.getTitleDisable().toUpperCase().equals("Y"))) {
                html.append("S.R ");
            }
            else {
                html.append("Show rows ");
            }
            html.append("<select id=\"" + super.getId() + "_displayNum\" class=\"select\" style=\"width:50px;\" onchange=\"pagingGrid('" + super.getId() + "','PAGE', '" + super.getCallback() + "')\">");
            html.append("    <option value=\"10\">10</option>");
            html.append("    <option value=\"20\">20</option>");
            html.append("    <option value=\"30\">30</option>");
            html.append("    <option value=\"40\">40</option>");
            html.append("    <option value=\"50\">50</option>");
            html.append("    <option value=\"60\">60</option>");
            html.append("    <option value=\"70\">70</option>");
            html.append("    <option value=\"80\">80</option>");
            html.append("    <option value=\"90\">90</option>");
            html.append("    <option value=\"100\">100</option>");
            html.append("</select>");
            html.append("&nbsp;&nbsp;");
            html.append("<span id=\"" + super.getId() + "_pageInfo\">0-0 of 0</span>");
            html.append("&nbsp;&nbsp;");
            html.append("<script type=\"text/javascript\">");
            html.append("    var btnBegin = new AW.UI.Button;");
            html.append("    btnBegin.setControlText(\"\u25c0\u25c0\");");
            html.append("    document.write(btnBegin);");
            html.append("    btnBegin.onControlClicked = function() {");
            html.append("        pagingGrid('" + super.getId() + "','BEGIN', '" + super.getCallback() + "')");
            html.append("    };");
            html.append("    var btnPrev = new AW.UI.Button;");
            html.append("    btnPrev.setControlText(\"\u25c0\");");
            html.append("    document.write(btnPrev);");
            html.append("    btnPrev.onControlClicked = function() {");
            html.append("        pagingGrid('" + super.getId() + "','PREV', '" + super.getCallback() + "')");
            html.append("    };");
            html.append("    var btnNext = new AW.UI.Button;");
            html.append("    btnNext.setControlText(\"\u25b6\");");
            html.append("    document.write(btnNext);");
            html.append("    btnNext.onControlClicked = function() {");
            html.append("        pagingGrid('" + super.getId() + "','NEXT', '" + super.getCallback() + "')");
            html.append("    };");
            html.append("    var btnEnd = new AW.UI.Button;");
            html.append("    btnEnd.setControlText(\"\u25b6\u25b6\");");
            html.append("    document.write(btnEnd);");
            html.append("    btnEnd.onControlClicked = function() {");
            html.append("        pagingGrid('" + super.getId() + "','END', '" + super.getCallback() + "')");
            html.append("    };");
            html.append("</script>");
            out.print(html.toString());
        }
        catch (final IOException e) {
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("Error : " + e));
            }
        }
        return 0;
    }
    
    public String getTitleDisable() {
        return this.titleDisable;
    }
    
    public void setTitleDisable(final String titleDisable) {
        this.titleDisable = titleDisable;
    }
}
