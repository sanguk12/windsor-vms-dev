package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Calendar extends WebControl {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private String selectBefore = null;

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

			html.append("<input");

			if (super.getId() == null && super.getName() == null)
			{
				// id, name  null   control ?
				html.append(" id=\"control\" name=\"control\"");
			}
			else if (super.getId() != null && super.getName() == null)
			{
				// name null   id u
				html.append(" id=\"" + super.getId() + "\" name=\"" + super.getId() + "\"");
			}
			else if (super.getId() == null && super.getName() != null)
			{
				// id null   name u
				html.append(" id=\"" + super.getName() + "\" name=\"" + super.getName() + "\"");
			}
			else if (super.getId() != null && super.getName() != null)
			{
				// id, name ? null  ? 
				html.append(" id=\"" + super.getId() + "\" name=\"" + super.getName() + "\"");
			}

			if (super.getCssClass() != null)
			{
				html.append(" class=\"" + super.getCssClass() + "\" ");
			}

			if (super.getStyle() != null && !super.getStyle().equals(""))
			{
				html.append(" style=\"width:80px; ime-mode:disabled; " + super.getStyle() + "\"");
			}
			else {
				html.append(" style=\"width:80px; ime-mode:disabled;\" ");
			}

			if (super.getValue() != null && !super.getValue().equals(""))
			{
				html.append(" value=\"" + super.getValue() + "\" ");
			}
			
			if (super.getReadOnly() != null && super.getReadOnly().equals("yes"))
			{
				html.append(" readonly=\"readonly\" ");
			}

			
			//html.append(" onfocus=\"this.value=unformat(this.value);this.select();openCal(this,this,'");

			if (super.getEventProc() != null && !super.getEventProc().equals(""))
			{
				html.append(" onchange=\""+super.getEventProc() + "\" ");
			}
			
			html.append(" onfocus=\"if(this.readOnly==false){this.value=unformat(this.value);this.select();}\" maxlength=\"8\" ");
			
			if (super.getExtend() != null && super.getExtend().equals("time")){
				html.append(" onblur=\"if(this.readOnly==false){this.value=formatDateTime(this.value);}\"><img id=\""+super.getId()+"_popup\" src=\""+pageContext.getServletContext().getContextPath()+"/images/common/calendar.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:hand\" onclick=\"pickDateTime(this,document.getElementById('" + super.getId() + "'),'" + super.getCallback() + "');\"> ");
			}
			else
			{
				html.append(" onblur=\"if(this.readOnly==false){if(checkValidDate(this)){this.value=formatDate(this.value);}}\"><img id=\""+super.getId()+"_popup\" src=\""+pageContext.getServletContext().getContextPath()+"/images/common/calendar.gif\" hspace=\"3\" style=\"vertical-align:middle;cursor:hand\" onclick=\"pickDate(this,document.getElementById('" + super.getId() + "'),'" + super.getCallback() + "','"+ getSelectBefore() + "');\"> ");
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

	public String getSelectBefore() {
		return selectBefore;
	}

	public void setSelectBefore(String selectBefore) {
		this.selectBefore = selectBefore;
	}

}
