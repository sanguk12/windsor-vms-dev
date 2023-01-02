package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.dao.SimpleService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class SelectBox extends WebControl {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private List data = null;
	private String category = null;
	private String queryKey = null;
	private String paramKey = null;
	private String paramValue = null;
	private String valuePosition = null;
	private String orderbyName = null;
	
	public String getOrderbyName() {
		return orderbyName;
	}

	public void setOrderbyName(String orderbyName) {
		this.orderbyName = orderbyName;
	}

	public String getQuery() {
		return queryKey;
	}

	public void setQueryKey(String queryKey) {
		this.queryKey = queryKey;
	}
	
	public String getQuerykey() {
		return queryKey;
	}
	
	public void setQuerykey(String queryKey) {
		this.queryKey = queryKey;
	}
	
	public String getQueryKey() {
		return queryKey;
	}

	public void setQuery(String queryKey) {
		this.queryKey = queryKey;
	}
	
	public String getParamKey() {
		return paramKey;
	}

	public void setParamKey(String paramKey) {
		this.paramKey = paramKey;
	}
	public void setParamkey(String paramKey) {
		this.paramKey = paramKey;
	}
	
	public String getParamValue() {
		return paramValue;
	}

	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}
	public void setParamvalue(String paramValue) {
		this.paramValue = paramValue;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getValuePosition() {
		return valuePosition;
	}

	public void setValuePosition(String valuePosition) {
		this.valuePosition = valuePosition;
	}
	
	public void setValueposition(String valuePosition) {
		this.valuePosition = valuePosition;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}
	
	public int doStartTag() {
		if(getData()!=null) {
			try {
				outTag(getData());
			} catch (Exception e) {
				if(logger.isDebugEnabled()) {
					logger.debug("Error : " + e);
				}
			}
		} else if(getCategory()!=null) {
			HttpSession session = pageContext.getSession();
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			
			Map param = new HashMap();			

			param.put("companyID", (String)session.getAttribute("COMPANYID"));
			param.put("codeDiv", getCategory());
			param.put("languageCD", (String)session.getAttribute("LANGUAGE"));
			
			try {
				List result = null;
				if(getOrderbyName()==null) {
					result = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
				}
				else if(getOrderbyName().equals("Y")) {
					result = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS000102S", param);
				}
				else {
					result = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
				}
				outTag(result);
			} catch (Exception e) {
				if(logger.isDebugEnabled()) {
					e.printStackTrace();
				}
			}
			
		} else if(getQuery()!=null || getQueryKey() != null) {
			
			Map command = new HashMap();
			
			String[] keys = null;
			String[] values = null;
			
			if (getParamKey() != null) {
				keys = getParamKey().split(";");
			}
			
			if (getParamValue() != null) {
				values = getParamValue().split(";");
			}
			
			if (getQuery() != null) {
				command.put("queryKey", getQuery());
			}
			else {
				command.put("queryKey", getQueryKey());
			}	
			
			if (keys != null) {
				for (int i = 0; i < keys.length; i++) {
					try {
						command.put(keys[i], values[i]);
					}
					catch (ArrayIndexOutOfBoundsException e) {
						command.put(keys[i], "");
					}
				}
			}
			
			try {
				HttpSession session = pageContext.getSession();
				WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
				
				command.put("companyID", (String)session.getAttribute("COMPANYID"));
				
				List result = ((SimpleService)wac.getBean("simpleService")).queryForList(command);
				outTag(result);
			} catch (Exception e) {
				if(logger.isDebugEnabled()) {
					logger.debug("Error : " + e);
					e.printStackTrace();
				}
			}
			
		}
		return SKIP_BODY;
	}
	
	private void outTag(List list) {
		try {
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			HttpSession session = pageContext.getSession();
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			
			Map map = new HashMap();
			html.append("<select");
			if(super.getId()==null && super.getName()==null) {
				html.append(" id=\"control\" name=\"control\"");
			} else if(super.getId()!=null && super.getName()==null) {
				html.append(" id=\""+super.getId()+"\" name=\""+super.getId()+"\"");
			} else if(super.getId()==null && super.getName()!=null) {
				html.append(" id=\""+super.getName()+"\" name=\""+super.getName()+"\"");
			} else if(super.getId()!=null && super.getName()!=null) {
				html.append(" id=\""+super.getId()+"\" name=\""+super.getName()+"\"");
			}
			
			if(super.getCssClass()!=null) {
				html.append(" class=\""+super.getCssClass()+"\" ");
			}
			
			if(super.getStyle()!=null && !super.getStyle().equals("")) {
				html.append(" style=\""+super.getStyle()+"\" ");
			}
			
			
			if(super.getEvent()!=null && super.getEventProc()!=null) {
				html.append(" "+super.getEvent()+"=\""+super.getEventProc()+"\"");
			}
			
			if(!super.isVisible()) {
				html.append(" style=\"visibility:hidden\"");
			}
			
			if(!super.isEnable()) {
				html.append(" disabled style=\"background:#EEEEEE\"");
			}
			
			if(super.getToolTip()!=null) {
				html.append(" alt=\""+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getToolTip())+"\" ");
			}
			html.append(">");
			
			if (super.getDefaultText()!=null && super.getDefaultText().equals("blank")) {
				html.append("   <option value=\"\"></option>");
			}
			else if (super.getDefaultText()!=null && super.getDefaultText().equals("none")) {
			}
			else if(super.getDefaultText()!=null && !super.getDefaultText().equals("")) {
				html.append("	<option value=\"\" selected>"+((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getDefaultText())+"</option>");
			} else {
				html.append("   <option value=\"\"></option>");
			}
				
			if(list!=null) {
				for(int i=0;i<list.size();i++) {
					map = (Map)list.get(i);
					Set set = map.keySet();
					Object[] keys = set.toArray();
					String valueKey = "";
					String nameKey = "";
					if (getValuePosition() != null) {
						String position[] = getValuePosition().split(";");
						valueKey = keys[Integer.parseInt(position[0])].toString();
						nameKey = keys[Integer.parseInt(position[1])].toString();
					}
					else {
						valueKey = keys[0].toString();
						nameKey = keys[1].toString();
					}
					if(super.getValue()!=null && super.getValue().equals(map.get(valueKey).toString())) {
						html.append("	<option value=\""+map.get(valueKey).toString()+"\" selected>"+map.get(nameKey).toString()+"</option>");
					} else {
						html.append("	<option value=\""+map.get(valueKey).toString()+"\">"+map.get(nameKey).toString()+"</option>");
					}
				}
			}
			html.append("</select>");
			
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
}
