// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class FileManager extends WebControl
{
    protected final Log logger;
    private String linkDivCD;
    private String uploadEnable;
    private String gridEnable;
    private String galleryEnable;
    private String width;
    private String height;
    
    public FileManager() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.linkDivCD = null;
        this.uploadEnable = null;
        this.gridEnable = null;
        this.galleryEnable = null;
        this.width = null;
        this.height = null;
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
            final String height = String.valueOf(this.getHeight());
            final String width = String.valueOf(this.getWidth());
            if (width != null && !width.equals("0")) {
                html.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"" + width + "\" height=\"100%\">");
            }
            else {
                html.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"536\" height=\"100%\">");
            }
            if (height != null && !height.equals("0")) {
                html.append("<tr><td height=\"" + height + "\">");
            }
            else {
                html.append("<tr><td height=\"200\">");
            }
            html.append("<iframe ");
            if (super.getId() == null && super.getName() == null) {
                html.append(" id=\"_code\" name=\"_code\"");
            }
            else if (super.getId() != null && super.getName() == null) {
                html.append(" id=\"_" + super.getId() + "\" name=\"_" + super.getId() + "\"");
            }
            else if (super.getId() == null && super.getName() != null) {
                html.append(" id=\"_" + super.getName() + "\" name=\"_" + super.getName() + "\"");
            }
            else if (super.getId() != null && super.getName() != null) {
                html.append(" id=\"_" + super.getId() + "\" name=\"_" + super.getName() + "\"");
            }
            html.append(" style=\"width:100%; height:100%;\" frameborder=\"0\" scrolling=\"no\" src=\"/cms/filemanager.page?id=" + super.getId() + "&linkDivCD=" + this.getLinkDivCD() + "&uploadEnable=" + this.getUploadEnable() + "&gridEnable=" + this.getGridEnable() + "&galleryEnable=" + this.getGalleryEnable() + "\"></iframe>");
            html.append("</td></tr>");
            if (this.getGalleryEnable().toUpperCase().equals("YES") || this.getGalleryEnable().toUpperCase().equals("Y")) {
                html.append("<tr><td height=\"*\" style=\"padding-top:10px;\" valign=\"top\">");
                html.append("<div id=\"" + super.getId() + "\"><ul id=\"" + super.getId() + "_image\"></ul></div>");
                html.append("</td></tr></table>");
                html.append("<style type=\"text/css\"> ");
                if (width != null && !width.equals("0")) {
                    html.append("#" + super.getId() + " {background-color:#444; padding:10px; width:" + width + "px;} ");
                }
                else {
                    html.append("#" + super.getId() + " {background-color:#444; padding:10px; width:536px;} ");
                }
                html.append("#" + super.getId() + " ul {list-style:none;} ");
                html.append("#" + super.getId() + " ul li {display:inline;} ");
                html.append("#" + super.getId() + " ul img {border:5px solid #3e3e3e; border-width:5px 5px 20px;} ");
                html.append("#" + super.getId() + " ul a:hover img {border:5px solid #fff; border-width:5px 5px 20px; color:#fff;} ");
                html.append("#" + super.getId() + " ul a:hover {color:#fff;} ");
                html.append("</style>");
                html.append("<script type=\"text/javascript\"> function event_" + super.getId() + "(){$(\"#" + super.getId() + " a\").lightBox();} </script>");
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
    
    public String getLinkDivCD() {
        return this.linkDivCD;
    }
    
    public void setLinkDivCD(final String linkDivCD) {
        this.linkDivCD = linkDivCD;
    }
    
    public String getUploadEnable() {
        return this.uploadEnable;
    }
    
    public void setUploadEnable(final String uploadEnable) {
        this.uploadEnable = uploadEnable;
    }
    
    public String getGridEnable() {
        return this.gridEnable;
    }
    
    public void setGridEnable(final String gridEnable) {
        this.gridEnable = gridEnable;
    }
    
    public String getGalleryEnable() {
        return this.galleryEnable;
    }
    
    public void setGalleryEnable(final String galleryEnable) {
        this.galleryEnable = galleryEnable;
    }
}
