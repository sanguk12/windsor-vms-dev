package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Popup extends WebControl {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private String nameID = null;
	private String nameName = null;
	private String nameStyle = null;
	private String keyID = null;
	private String keyName = null;
	private String inputBoxDisable = null;

	public int doStartTag() {

		try {
			outTag();
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
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
			String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
			StringBuffer html = new StringBuffer();

			if (getInputBoxDisable() != null && (getInputBoxDisable().toUpperCase().equals("YES") || getInputBoxDisable().toUpperCase().equals("Y"))) {
				
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
				html.append("<img id=\""+super.getId()+"_clear\" src=\""+ appContextPath +"/images/common/clear_input.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:pointer\" />");
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
			else {
				html.append("<input type='text'");
	
				if (super.getId() == null && super.getName() == null)
				{
					html.append(" id=\"code\" name=\"code\"");
				}
				else if (super.getId() != null && super.getName() == null)
				{
					html.append(" id=\"" + super.getId() + "\" name=\"" + super.getId() + "\"");
				}
				else if (super.getId() == null && super.getName() != null)
				{
					html.append(" id=\"" + super.getName() + "\" name=\"" + super.getName() + "\"");
				}
				else if (super.getId() != null && super.getName() != null)
				{
					html.append(" id=\"" + super.getId() + "\" name=\"" + super.getName() + "\"");
				}
	
				if (super.getCssClass() != null)
				{
					html.append(" class=\"" + super.getCssClass() + "\"");
				}
	
				if (super.getStyle() != null && !super.getStyle().equals(""))
				{
					html.append(" style=\"width:80px; ime-mode:disabled; " + super.getStyle() +"\"");
				}
				else {
					html.append(" style=\"width:80px; ime-mode:disabled;\"");
				}
	
				if (super.getValue() != null && !super.getValue().equals(""))
				{
					html.append(" value=\"" + super.getValue() + "\"");
				}
				
				if (super.getReadOnly() != null && super.getReadOnly().equals("yes"))
				{
					html.append(" readonly=\"readonly\"");
				}
	
				html.append(" />");
				
				html.append("<img id=\""+super.getId()+"_popup\" src=\""+ appContextPath +"/images/common/search_popup.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:pointer\" />");
				
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
					html.append(" style=\"width:150px; " + getNameStyle() +"\" ");
				}
				else {
					html.append(" style=\"width:150px; \" ");
				}
				
				html.append(" class=\"input-readonly\" readonly=\"readonly\" />");
				
				if (getKeyID() != null)
				{
					html.append(" <input type='hidden'");
					if (getKeyID() == null && getKeyName() == null)
					{
						html.append(" id=\"key\" name=\"key\"");
					}
					else if (getKeyID() != null && getKeyName() == null)
					{
						html.append(" id=\"" + getKeyID() + "\" name=\"" + getKeyID() + "\"");
					}
					else if (getKeyID() == null && getKeyName() != null)
					{
						html.append(" id=\"" + getKeyName() + "\" name=\"" + getKeyName() + "\"");
					}
					else if (getKeyID() != null && getKeyName() != null)
					{
						html.append(" id=\"" + getKeyID() + "\" name=\"" + getKeyName() + "\"");
					}
					html.append(" />");
				}
				
				if(super.getPreset()!=null && super.getPreset().equals("aw")) {
					out.print(html.toString().replace("\"", "\\\""));
				} else {
					out.print(html.toString());
				}
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

	public String getKeyID() {
		return keyID;
	}

	public void setKeyID(String keyID) {
		this.keyID = keyID;
	}

	public String getKeyName() {
		return keyName;
	}

	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}

	public String getInputBoxDisable() {
		return inputBoxDisable;
	}

	public void setInputBoxDisable(String inputBoxDisable) {
		this.inputBoxDisable = inputBoxDisable;
	}

}
