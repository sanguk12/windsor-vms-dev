// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class Space extends WebControl
{
    protected final Log logger;
    private int length;
    
    public Space() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.length = 0;
    }
    
    public int getLength() {
        return this.length;
    }
    
    public void setLength(final int length) {
        this.length = length;
    }
    
    public int doStartTag() {
        try {
            final JspWriter out = this.pageContext.getOut();
            String space = "";
            for (int i = 0; i < this.length; ++i) {
                space += "&nbsp;";
            }
            out.print(space);
        }
        catch (final IOException e) {
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("Error : " + e));
            }
        }
        return 0;
    }
}
