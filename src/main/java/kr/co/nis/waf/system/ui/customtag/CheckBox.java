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
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class CheckBox extends WebControl {
	protected final Log logger = LogFactory.getLog(getClass());
	private List data = null;
	private String category = null;
	private String queryKey = null;
	private String paramKey = null;
	private String paramValue = null;
	private String direction;
	private boolean selectall = false;
	
	public boolean isSelectall() {
		return selectall;
	}

	public void setSelectall(boolean selectall) {
		this.selectall = selectall;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}
	
	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}	
	
	public String getQueryKey() {
		return queryKey;
	}

	public void setQueryKey(String queryKey) {
		this.queryKey = queryKey;
	}

	public String getParamKey() {
		return paramKey;
	}

	public void setParamKey(String paramKey) {
		this.paramKey = paramKey;
	}

	public String getParamValue() {
		return paramValue;
	}

	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}

	public Log getLogger() {
		return logger;
	}

	public int doStartTag() {
		if(getData()!=null) {
			outTag(getData());
			
		} else if(getCategory()!=null) {
			HttpSession session = pageContext.getSession();
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			Map param = new HashMap();			

			param.put("companyID", (String)session.getAttribute("COMPANYID"));
			param.put("codeDiv", getCategory());
			param.put("languageCD", (String)session.getAttribute("LANGUAGE"));
			
			try {
				List result = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
				outTag(result);
			} catch (Exception e) {
				if(logger.isDebugEnabled()) {
					logger.debug("Error : " + e);
				}
			}
			
		} else if(getQueryKey() != null) {
			
			Map command = new HashMap();
			
			String[] keys = null;
			String[] values = null;
			
			if (getParamKey() != null) {
				keys = getParamKey().split(";");
			}
			
			if (getParamValue() != null) {
				values = getParamValue().split(";");
			}
			
			command.put("queryKey", getQueryKey());
			
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
		JspWriter out = pageContext.getOut();
		StringBuffer html = new StringBuffer();
		Map map = new HashMap();
		
		try {
			for(int i=0;i<list.size();i++) {
				map = (Map)list.get(i);
				Set set = map.keySet();
				Object[] keys = set.toArray();
				String valueKey = keys[0].toString();
				String nameKey = keys[1].toString();
				
				html.append("<input type=\"checkbox\" class=\"checkbox\"");
				if(super.getId()==null && super.getName()==null) {
					html.append(" id=\"control\" name=\"control\"");
				} else if(super.getId()!=null && super.getName()==null) {
					html.append(" id=\""+super.getId()+"\" name=\""+super.getId()+"\"");
				} else if(super.getId()==null && super.getName()!=null) {
					html.append(" id=\""+super.getName()+"\" name=\""+super.getName()+"\"");
				} else if(super.getId()!=null && super.getName()!=null) {
					html.append(" id=\""+super.getId()+"\" name=\""+super.getName()+"\"");
				}
				html.append(" value=\""+map.get(valueKey).toString()+"\" ");
				if(super.getEvent()!=null && super.getEventProc()!=null) {
					html.append(super.getEvent()+"=\""+super.getEventProc()+"\" ");
				}
				
				if(this.isSelectall()) {
					html.append(" checked ");
					
				} else {
					if(super.getValue()!=null && super.getValue()!="") {
						if(map.get(valueKey).toString().equals(super.getValue())) {
							html.append(" checked ");
						}
					} else {
						if(super.getDefaultValue()!=null) {
							if(map.get(valueKey).toString().equals(super.getDefaultValue())) {
								html.append(" checked ");
							}
						}
					}
				}
				
				html.append(">");
				html.append(map.get(nameKey).toString());
				if (getDirection() != null) {
					if (getDirection().equals("vertical")){
						html.append("<br>");
					}
					else {
						html.append("&nbsp;&nbsp;");
					}
				}
				else {
					html.append("&nbsp;&nbsp;");
				}
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
}
