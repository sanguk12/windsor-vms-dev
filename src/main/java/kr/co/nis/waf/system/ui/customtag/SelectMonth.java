package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class SelectMonth extends WebControl {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private String monthId = null;
	private String yearCategory = null;
	private String monthCategory = null;
	
	public int doStartTag() {
		if(getYearCategory()!=null && getMonthCategory()!=null) {
			HttpSession session = pageContext.getSession();
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			
			Map param = new HashMap();			

			param.put("companyID", (String)session.getAttribute("COMPANYID"));
			param.put("codeDiv", getYearCategory());
			param.put("languageCD", (String)session.getAttribute("LANGUAGE"));
			
			try {
				List resultYear = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
				param.put("codeDiv", getMonthCategory());
				List resultMonth = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
				
				outTag(resultYear, resultMonth);
			} catch (Exception e) {
				if(logger.isDebugEnabled()) {
					e.printStackTrace();
				}
			}
			
		}
		return SKIP_BODY;
	}
	
	private void outTag(List yearList, List monthList) {
		try {
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			StringBuffer yearHtml = new StringBuffer();
			StringBuffer monthHtml = new StringBuffer();
			HttpSession session = pageContext.getSession();
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			
			Map yearMap = new HashMap();
			yearHtml.append("<select");
			if(super.getId()==null && super.getName()==null) {
				yearHtml.append(" id=\"control\" name=\"control\"");
			} else if(super.getId()!=null && super.getName()==null) {
				yearHtml.append(" id=\""+super.getId()+"\" name=\""+super.getId()+"\"");
			} else if(super.getId()==null && super.getName()!=null) {
				yearHtml.append(" id=\""+super.getName()+"\" name=\""+super.getName()+"\"");
			} else if(super.getId()!=null && super.getName()!=null) {
				yearHtml.append(" id=\""+super.getId()+"\" name=\""+super.getName()+"\"");
			}
			
			if(super.getCssClass()!=null) {
				yearHtml.append(" class=\""+super.getCssClass()+"\" ");
			}
			
			if(super.getStyle()!=null && !super.getStyle().equals("")) {
				yearHtml.append(" style=\""+super.getStyle()+"\" ");
			}
			
			
			if(super.getEvent()!=null && super.getEventProc()!=null) {
				yearHtml.append(" "+super.getEvent()+"=\""+super.getEventProc()+"\"");
			}
			
			if(!super.isVisible()) {
				yearHtml.append(" style=\"visibility:hidden\"");
			}
			
			if(!super.isEnable()) {
				yearHtml.append(" disabled style=\"background:#EEEEEE\"");
			}
			
			if(super.getToolTip()!=null) {
				yearHtml.append(" alt=\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getToolTip())+"\" ");
			}
			yearHtml.append(">");
			
			if (super.getDefaultText()!=null && super.getDefaultText().equals("blank")) {
				yearHtml.append("   <option value=\"\"></option>");
			}
			else if (super.getDefaultText()!=null && super.getDefaultText().equals("none")) {
			}
			else if(super.getDefaultText()!=null && !super.getDefaultText().equals("")) {
				yearHtml.append("	<option value=\"\" selected>"+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getDefaultText())+"</option>");
			} else {
				yearHtml.append("   <option value=\"\"></option>");
			}
				
			if(yearList!=null) {
				for(int i=0;i<yearList.size();i++) {
					yearMap = (Map)yearList.get(i);
					Set set = yearMap.keySet();
					Object[] keys = set.toArray();
					String valueKey = "";
					String nameKey = "";
					valueKey = keys[0].toString();
					nameKey = keys[1].toString();
					
					if(super.getValue()!=null && super.getValue().equals(yearMap.get(valueKey).toString())) {
						yearHtml.append("	<option value=\""+yearMap.get(valueKey).toString()+"\" selected>"+yearMap.get(nameKey).toString()+"</option>");
					} else {
						yearHtml.append("	<option value=\""+yearMap.get(valueKey).toString()+"\">"+yearMap.get(nameKey).toString()+"</option>");
					}
				}
			}
			yearHtml.append("</select>");
			
			Map monthMap = new HashMap();
			monthHtml.append("<select");
			if(getMonthId()==null) {
				monthHtml.append(" id=\"control\" name=\"control\"");
			} else if(getMonthId()!=null) {
				monthHtml.append(" id=\""+getMonthId()+"\" name=\""+getMonthId()+"\"");
			}
			
			if(super.getCssClass()!=null) {
				monthHtml.append(" class=\""+super.getCssClass()+"\" ");
			}
			
			if(super.getStyle()!=null && !super.getStyle().equals("")) {
				monthHtml.append(" style=\""+super.getStyle()+"\" ");
			}
			
			
			if(super.getEvent()!=null && super.getEventProc()!=null) {
				monthHtml.append(" "+super.getEvent()+"=\""+super.getEventProc()+"\"");
			}
			
			if(!super.isVisible()) {
				monthHtml.append(" style=\"visibility:hidden\"");
			}
			
			if(!super.isEnable()) {
				monthHtml.append(" disabled style=\"background:#EEEEEE\"");
			}
			
			if(super.getToolTip()!=null) {
				monthHtml.append(" alt=\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getToolTip())+"\" ");
			}
			monthHtml.append(">");
			
			if (super.getDefaultText()!=null && super.getDefaultText().equals("blank")) {
				monthHtml.append("   <option value=\"\"></option>");
			}
			else if (super.getDefaultText()!=null && super.getDefaultText().equals("none")) {
			}
			else if(super.getDefaultText()!=null && !super.getDefaultText().equals("")) {
				monthHtml.append("	<option value=\"\" selected>"+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getDefaultText())+"</option>");
			} else {
				monthHtml.append("   <option value=\"\"></option>");
			}
				
			if(monthList!=null) {
				for(int i=0;i<monthList.size();i++) {
					monthMap = (Map)monthList.get(i);
					Set set = monthMap.keySet();
					Object[] keys = set.toArray();
					String valueKey = "";
					String nameKey = "";
					valueKey = keys[0].toString();
					nameKey = keys[1].toString();
					
					monthHtml.append("	<option value=\""+monthMap.get(valueKey).toString()+"\">"+monthMap.get(nameKey).toString()+"</option>");
				}
			}
			monthHtml.append("</select>");
			
			String dateFormat = (String)session.getAttribute("DATEFORMAT");
			
			if (dateFormat.substring(0,3).equals("YMD")) {
				html.append(yearHtml);
				html.append("&nbsp;");
				html.append(monthHtml);
			}
			else if (dateFormat.substring(0,3).equals("MDY")) {
				html.append(monthHtml);
				html.append("&nbsp;");
				html.append(yearHtml);
			}
			else if (dateFormat.substring(0,3).equals("DMY")) {
				html.append(monthHtml);
				html.append("&nbsp;");
				html.append(yearHtml);
			}
			else {
				html.append(yearHtml);
				html.append("&nbsp;");
				html.append(monthHtml);
			}
			
			if(super.getPreset()!=null && super.getPreset().equals("aw")) {
				out.print(html.toString().replace("\"", "\\\""));
			} else {
				out.print(html.toString());
			}
			
		} catch (IOException e) {
			if(logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
	}

	
	public String getMonthId() {
		return monthId;
	}

	public void setMonthId(String monthId) {
		this.monthId = monthId;
	}

	public String getYearCategory() {
		return yearCategory;
	}

	public void setYearCategory(String yearCategory) {
		this.yearCategory = yearCategory;
	}

	public String getMonthCategory() {
		return monthCategory;
	}

	public void setMonthCategory(String monthCategory) {
		this.monthCategory = monthCategory;
	}
	
}
