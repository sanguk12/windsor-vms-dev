package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class Button extends WebControl {
	protected final Log logger = LogFactory.getLog(getClass());
	
	public int doStartTag() {
		try {
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
			HttpSession session = pageContext.getSession();
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			
			if(super.getCssClass()==null) {
				if(super.getPreset().equals("widget")) {
					super.setCssclass("table_btn");
				} else if(super.getPreset().equals("button")) {
					super.setCssclass("btnGreen");
				}
			}
			
			if(super.getPreset().equals("widget")) {
				html.append("<span id=\""+super.getId()+"\"></span>");
				html.append("<script type=\"text/javascript\">");
				html.append("var "+super.getId()+" = new AW.UI.Button;");
				html.append(super.getId()+".setId(\""+super.getId()+"\");");
				html.append(super.getId()+".setControlText(\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button."+super.getId())+"\");");
				html.append(super.getId()+".setControlImage(\""+super.getId()+"\");");
				html.append(super.getId()+".refresh();");
				html.append(super.getId()+".onClick = function(){");
				if(super.getEventProc()!=null) {
					html.append(super.getEventProc());
				} else {
					html.append(super.getId()+"();");
				}
				html.append("}");
				html.append("</script>");
			} else if(super.getPreset().equals("image")) {
				html.append("<img src=\""+ appContextPath +"/images/btn/"+super.getId()+".gif\" name=\"btn"+super.getId()+"\" id=\"btn"+super.getId()+"\"");
				if(super.getEventProc()!=null) {
					html.append(" onclick=\""+super.getEventProc()+"();\"");
				} else {
					html.append(" onclick=\""+super.getId()+"();\"");
				}
				html.append(" onfocus=\"this.blur();\" class=\""+super.getCssClass()+"\" alt=\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button."+super.getId())+"\" />");
			} else {
				html.append("<input type=\"button\" name=\"btn"+super.getId()+"\" id=\"btn"+super.getId()+"\"");
				if(super.getEventProc()!=null) {
					html.append(" onclick=\""+super.getEventProc()+"();\"");
				} else {
					html.append(" onclick=\""+super.getId()+"();\"");
				}
				html.append(" onfocus=\"this.blur();\" class=\""+super.getCssClass()+"\" value=\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button."+super.getId())+"\" />");
			}
			
			out.print(html.toString());
		} catch (IOException e) {
			if(logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
		return SKIP_BODY;
	}
}
