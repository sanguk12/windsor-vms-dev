// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class SearchArea extends WebControl
{
    protected final Log logger;
    private String searchType;
    
    public SearchArea() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.searchType = null;
    }
    
    public String getSitleType() {
        return this.searchType;
    }
    
    public void setSitleType(final String searchType) {
        this.searchType = searchType;
    }
    
    public int doStartTag() {
        try {
            final JspWriter out = this.pageContext.getOut();
            if ("normal".equals(this.getSitleType())) {
                out.print("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"tblCaptionOut\" style=\"margin-bottom:3px;\" >");
                out.print("\t<tr height=\"28\">");
                out.print("\t\t<td class=\"tblCaptionTd\" style=\"padding-left:10px;padding:4px 4px 4px 4px;\">");
                out.print("\t\t\t<input type=\"text\" name=\"searchValue\" value=\"\" class=\"txtNormal\" />");
                out.print("\t\t\t<input type=\"button\" name=\"btnSearch\" class=\"btnBlue01\" onclick=\"fnSearch();\" onfocus=\"this.blur();\" value=\"<fmt:message key=\"button.Search\" />\" />");
                out.print("\t\t</td>");
                out.print("\t</tr>");
                out.print("</table>");
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
