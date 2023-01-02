package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Popup_noCD extends WebControl {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private String nameID = null;
	private String nameName = null;
	private String nameStyle = null;

	public int doStartTag()
	{

		try
		{
			outTag();
		}
		catch (Exception e)
		{
			if (logger.isDebugEnabled())
			{
				logger.debug("Error : " + e);
				e.printStackTrace();
			}
		}

		return SKIP_BODY;
	}

	private void outTag()
	{
		try
		{
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();

			html.append(" <input type='text'");
			
			if (getNameID() == null && getNameName() == null)
			{
				html.append(" id=\"name\" name=\"name\"");
			}
			else if (getNameID() != null && getNameName() == null)
			{
				html.append(" id=\"" + getNameID() + "\" name=\"" + getNameID() + "\"");
			}
			else if (getNameID() == null && getNameName() != null)
			{
				html.append(" id=\"" + getNameName() + "\" name=\"" + getNameName() + "\"");
			}
			else if (getNameID() != null && getNameName() != null)
			{
				html.append(" id=\"" + getNameID() + "\" name=\"" + getNameName() + "\"");
			}
			
			if (getNameStyle() != null && !getNameStyle().equals(""))
			{
				html.append(" style=\"width:100px; " + getNameStyle() +"\" ");
			}
			else {
				html.append(" style=\"width:100px; \" ");
			}
			
			html.append(" class=\"input-readonly\" readonly=\"readonly\" />");
			
			html.append("<img id=\""+super.getId()+"_popup\" src=\""+ appContextPath +"/images/common/search_popup.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:pointer\" />");
			
			if (getId() != null)
			{
				html.append(" <input type='hidden'");
				if (getId() == null && getName() == null)
				{
					html.append(" id=\"id\" name=\"id\"");
				}
				else if (getId() != null && getName() == null)
				{
					html.append(" id=\"" + getId() + "\" name=\"" + getId() + "\"");
				}
				else if (getId() == null && getName() != null)
				{
					html.append(" id=\"" + getId() + "\" name=\"" + getName() + "\"");
				}
				else if (getId() != null && getName() != null)
				{
					html.append(" id=\"" + getId() + "\" name=\"" + getName() + "\"");
				}
				html.append(" />");
			}
			
			if(super.getPreset()!=null && super.getPreset().equals("aw")) {
				out.print(html.toString().replace("\"", "\\\""));
			} else {
				out.print(html.toString());
			}
			
		}
		catch (IOException e)
		{
			if (logger.isDebugEnabled())
			{
				logger.debug("Error : " + e);
			}
		}
	}
	
	public String getNameID() {
		return nameID;
	}
	
	public void setNameID(String nameID) {
		this.nameID = nameID;
	}

	public String getNameName() {
		return nameName;
	}

	public void setNameName(String nameName) {
		this.nameName = nameName;
	}

	public String getNameStyle() {
		return nameStyle;
	}

	public void setNameStyle(String nameStyle) {
		this.nameStyle = nameStyle;
	}

}