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

public class PageNavigator extends WebControl {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private String titleDisable = null;
	
	
	public int doStartTag() {
		try {
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			
			if (getTitleDisable() != null && (getTitleDisable().toUpperCase().equals("YES") || getTitleDisable().toUpperCase().equals("Y"))) {
				html.append("Page ");
			}
			else {
				html.append("Go to page ");
			}
			html.append("<input type=\"text\" id=\""+super.getId()+"_pageNum\" name=\""+super.getId()+"_pageNum\" value=\"1\" style=\"width:40px;text-align:right;\" onkeypress=\"if (event.keyCode==13){pagingGrid('"+super.getId()+"','GOTO', '"+super.getCallback()+"'); return false;}\">");
			html.append("<input type=\"hidden\" id=\""+super.getId()+"_totalCount\" name=\""+super.getId()+"_totalCount\">");
			html.append("&nbsp;&nbsp;");
			if (getTitleDisable() != null && (getTitleDisable().toUpperCase().equals("YES") || getTitleDisable().toUpperCase().equals("Y"))) {
				html.append("Rows ");
			}
			else {
				html.append("Show rows ");
			}
			html.append("<select id=\""+super.getId()+"_displayNum\" name=\""+super.getId()+"_displayNum\" class=\"select\" style=\"width:50px;\" onchange=\"pagingGrid('"+super.getId()+"','PAGE', '"+super.getCallback()+"')\">");
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
			html.append("    <option value=\"200\">200</option>");
//			html.append("    <option value=\"1000\">1000</option>");
			html.append("</select>");
			html.append("&nbsp;&nbsp;");
			html.append("<span id=\""+super.getId()+"_pageInfo\">0-0 of 0</span>");
			html.append("&nbsp;&nbsp;");
			html.append("<script type=\"text/javascript\">");
			html.append("    var btnBegin = new AW.UI.Button;");
			html.append("    btnBegin.setControlText(\"◀◀\");");
			html.append("    document.write(btnBegin);");
			html.append("    btnBegin.onControlClicked = function() {");
			html.append("        pagingGrid('"+super.getId()+"','BEGIN', '"+super.getCallback()+"')");
			html.append("    };");
			html.append("    var btnPrev = new AW.UI.Button;");
			html.append("    btnPrev.setControlText(\"◀\");");
			html.append("    document.write(btnPrev);");
			html.append("    btnPrev.onControlClicked = function() {");
			html.append("        pagingGrid('"+super.getId()+"','PREV', '"+super.getCallback()+"')");
			html.append("    };");
			html.append("    var btnNext = new AW.UI.Button;");
			html.append("    btnNext.setControlText(\"▶\");");
			html.append("    document.write(btnNext);");
			html.append("    btnNext.onControlClicked = function() {");
			html.append("        pagingGrid('"+super.getId()+"','NEXT', '"+super.getCallback()+"')");
			html.append("    };");
			html.append("    var btnEnd = new AW.UI.Button;");
			html.append("    btnEnd.setControlText(\"▶▶\");");
			html.append("    document.write(btnEnd);");
			html.append("    btnEnd.onControlClicked = function() {");
			html.append("        pagingGrid('"+super.getId()+"','END', '"+super.getCallback()+"')");
			html.append("    };");
			html.append("</script>");
			
	        out.print(html.toString());
		} catch (IOException e) {
			if(logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
        
        return SKIP_BODY;
	}


	public String getTitleDisable() {
		return titleDisable;
	}


	public void setTitleDisable(String titleDisable) {
		this.titleDisable = titleDisable;
	}
	
}