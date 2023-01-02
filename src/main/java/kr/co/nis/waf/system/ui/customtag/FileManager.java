package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FileManager extends WebControl {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private String linkDivCD = null;
	private String uploadEnable = null;
	private String gridEnable = null;
	private String galleryEnable = null;
	private String width = null;
	private String height = null;
	private String fixSizeDisable = null;
	private String fileType = null;

	public int doStartTag() {

		try {
			outTag();
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
				e.printStackTrace();
			}
		}

		return SKIP_BODY;
	}

	private void outTag() {
		try {
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			
			String height = String.valueOf(getHeight());
			String width = String.valueOf(getWidth());
			
			if (width != null && !width.equals("0")) {
				html.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\""+width+"\" height=\"100%\">");
			}
			else {
				html.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"536\" height=\"100%\">");
			}
			if (height != null && !height.equals("0")) {
				html.append("<tr><td height=\""+height+"\">");
			}
			else {
				html.append("<tr><td height=\"200\">");
			}
			html.append("<iframe ");
			if (super.getId() == null && super.getName() == null) {
				html.append(" id=\"_code\" name=\"_code\"");
			} else if (super.getId() != null && super.getName() == null) {
				html.append(" id=\"_" + super.getId() + "\" name=\"_"+ super.getId() + "\"");
			} else if (super.getId() == null && super.getName() != null) {
				html.append(" id=\"_" + super.getName() + "\" name=\"_"+ super.getName() + "\"");
			} else if (super.getId() != null && super.getName() != null) {
				html.append(" id=\"_" + super.getId() + "\" name=\"_" + super.getName() + "\"");
			}
			html.append(" style=\"width:100%; height:100%;\" frameborder=\"0\" scrolling=\"no\" src=\"/sys3/cms/filemanager.page?id="+super.getId()+"&linkDivCD="+getLinkDivCD()+"&uploadEnable="+getUploadEnable()+"&gridEnable="+getGridEnable()+"&galleryEnable="+getGalleryEnable()+"&fileType="+getFileType()+"\"></iframe>");
			html.append("</td></tr>");
			if (getGalleryEnable().toUpperCase().equals("YES") || getGalleryEnable().toUpperCase().equals("Y")) {
				html.append("<tr><td height=\"*\" style=\"padding-top:10px;\" valign=\"top\">");
				html.append("<div id=\""+super.getId()+"\"><ul id=\""+super.getId()+"_image\"></ul></div>");
				html.append("</td></tr></table>");
				html.append("<style type=\"text/css\"> ");
				if (width != null && !width.equals("0")) {
					html.append("#"+super.getId()+" {background-color:#444; padding:10px; width:"+width+"px;} ");
				}
				else {
					html.append("#"+super.getId()+" {background-color:#444; padding:10px; width:536px;} ");
				}
				html.append("#"+super.getId()+" ul {list-style:none;} ");
				html.append("#"+super.getId()+" ul li {display:inline;} ");
				html.append("#"+super.getId()+" ul img {border:5px solid #3e3e3e; border-width:5px 5px 20px;} ");
				html.append("#"+super.getId()+" ul a:hover img {border:5px solid #fff; border-width:5px 5px 20px; color:#fff;} ");
				html.append("#"+super.getId()+" ul a:hover {color:#fff;} ");
				html.append("</style>");
				//html.append("<script type=\"text/javascript\"> function event_"+super.getId()+"(){$(\"#"+super.getId()+" a\").lightBox();} </script>");
				
				if (getFixSizeDisable() == null) {
					html.append("<script type=\"text/javascript\"> function event_"+super.getId()+"(){$(\"#"+super.getId()+" a\").lightBox({maxWidth: 500, maxHeight: 500});} </script>");
				}
				else if(getFixSizeDisable().toUpperCase().equals("YES") || getFixSizeDisable().toUpperCase().equals("Y")) {
					html.append("<script type=\"text/javascript\"> function event_"+super.getId()+"(){$(\"#"+super.getId()+" a\").lightBox();} </script>");
				}
				else {
					html.append("<script type=\"text/javascript\"> function event_"+super.getId()+"(){$(\"#"+super.getId()+" a\").lightBox();} </script>");
				}
				
			}
			else {
				html.append("</table>");
			}
			

			if (super.getPreset() != null && super.getPreset().equals("aw")) {
				out.print(html.toString().replace("\"", "\\\""));
			} else {
				out.print(html.toString());
			}

		} catch (IOException e) {
			if (logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
	}

	
	public String getLinkDivCD() {
		return linkDivCD;
	}

	public void setLinkDivCD(String linkDivCD) {
		this.linkDivCD = linkDivCD;
	}
	
	public String getUploadEnable() {
		return uploadEnable;
	}

	public void setUploadEnable(String uploadEnable) {
		this.uploadEnable = uploadEnable;
	}

	public String getGridEnable() {
		return gridEnable;
	}

	public void setGridEnable(String gridEnable) {
		this.gridEnable = gridEnable;
	}

	public String getGalleryEnable() {
		return galleryEnable;
	}

	public void setGalleryEnable(String galleryEnable) {
		this.galleryEnable = galleryEnable;
	}

	public String getFixSizeDisable() {
		return fixSizeDisable;
	}

	public void setFixSizeDisable(String fixSizeDisable) {
		this.fixSizeDisable = fixSizeDisable;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	
}
