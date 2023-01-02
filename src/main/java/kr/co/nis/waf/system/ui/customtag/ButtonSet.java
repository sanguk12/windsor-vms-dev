package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import kr.co.nis.waf.system.ui.customtag.WebControl;
import kr.co.nis.waf.util.StringUtil;

public class ButtonSet extends WebControl {
	protected final Log logger = LogFactory.getLog(getClass());
	private List data = null;
	
	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}
	
	public int doStartTag() {
		try {
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
			HttpSession session = pageContext.getSession();
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			
			Map map = new HashMap();
			
			if(super.getHeight()<=0) {
				super.setHeight(22);
			}
			
			if(super.getAlign()==null) {
				super.setAlign("center");
			}
			
			if(super.getCssClass()==null) {
				if(super.getPreset().equals("widget")) {
					super.setCssclass("table_btn");
				} else if(super.getPreset().equals("button")) {
					super.setCssclass("btnGreen");
				}
			}
			
			if(getData()!=null) {
				if(super.getPreset().equals("widget") && super.getValign()==null) {
				} else {
					html.append("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
					html.append("<tr><td width=\"100%\" height=\""+super.getHeight()+"\" align=\""+super.getAlign()+"\">");
				}
				for(int i=0;i<getData().size();i++) {
					map = (Map)getData().get(i);
					Set set = map.keySet();
					Object[] keys = set.toArray();
					String functionKey = keys[0].toString();
					if(super.getPreset().equals("widget")) {
						html.append("<span id=\""+map.get(functionKey).toString()+"\"></span>");
						html.append("<script type=\"text/javascript\">");
						html.append("var "+map.get(functionKey).toString()+" = new AW.UI.Button;");
						html.append(map.get(functionKey).toString()+".setId(\""+map.get(functionKey).toString()+"\");");
						html.append(map.get(functionKey).toString()+".setControlText(\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button."+map.get(functionKey).toString())+"\");");
						html.append(map.get(functionKey).toString()+".setControlImage(\""+map.get(functionKey).toString()+"\");");
						html.append(map.get(functionKey).toString()+".refresh();");
						html.append(map.get(functionKey).toString()+".onClick = function(){"+StringUtil.nullToBlank(super.getEventProc())+map.get(functionKey).toString()+"();}");
						html.append("</script>");
					} else if(super.getPreset().equals("images")) {
						html.append("<img src=\""+ appContextPath +"/images/btn/btn"+map.get(functionKey).toString()+".gif\" name=\"btn"+map.get(functionKey).toString()+"\" id=\"btn"+map.get(functionKey).toString()+"\" onclick=\""+map.get(functionKey).toString()+"();\" onfocus=\"this.blur();\" class=\""+super.getCssClass()+"\" alt=\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button."+map.get(functionKey).toString())+"\" />");
					} else {
						html.append("<input type=\"button\" name=\"btn"+map.get(functionKey).toString()+"\" id=\"btn"+map.get(functionKey).toString()+"\" onclick=\""+map.get(functionKey).toString()+"();\" onfocus=\"this.blur();\" class=\""+super.getCssClass()+"\" value=\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage("button."+map.get(functionKey).toString())+"\" />");
					}
				}
				html.append("</td></tr></table>");
				html.append("<script language=\"javascript\">try{if(saveType==\"insert\"){document.all.btnDelete.style.display=\"none\";}}catch(e){}</script>");
				
				out.print(html.toString());
			}
		} catch (IOException e) {
			if(logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
		return SKIP_BODY;
	}
}
