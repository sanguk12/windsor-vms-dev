// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import java.util.Set;
import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import java.util.Map;
import org.springframework.web.context.WebApplicationContext;
import javax.servlet.http.HttpSession;
import kr.co.nis.waf.dao.SimpleService;
import java.util.HashMap;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.apache.commons.logging.LogFactory;
import java.util.List;
import org.apache.commons.logging.Log;

public class RadioButton extends WebControl
{
    protected final Log logger;
    private List data;
    private String category;
    private String queryKey;
    private String paramKey;
    private String paramValue;
    private String direction;
    
    public RadioButton() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.data = null;
        this.category = null;
        this.queryKey = null;
        this.paramKey = null;
        this.paramValue = null;
    }
    
    public String getQueryKey() {
        return this.queryKey;
    }
    
    public void setQueryKey(final String queryKey) {
        this.queryKey = queryKey;
    }
    
    public String getParamKey() {
        return this.paramKey;
    }
    
    public void setParamKey(final String paramKey) {
        this.paramKey = paramKey;
    }
    
    public String getParamValue() {
        return this.paramValue;
    }
    
    public void setParamValue(final String paramValue) {
        this.paramValue = paramValue;
    }
    
    public Log getLogger() {
        return this.logger;
    }
    
    public String getCategory() {
        return this.category;
    }
    
    public void setCategory(final String category) {
        this.category = category;
    }
    
    public List getData() {
        return this.data;
    }
    
    public void setData(final List data) {
        this.data = data;
    }
    
    public String getDirection() {
        return this.direction;
    }
    
    public void setDirection(final String direction) {
        this.direction = direction;
    }
    
    public int doStartTag() {
        if (this.getData() != null) {
            this.outTag(this.getData());
        }
        else if (this.getCategory() != null) {
            final HttpSession session = this.pageContext.getSession();
            final WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
            final Map param = new HashMap();
            param.put("companyID", session.getAttribute("COMPANYID"));
            param.put("codeDiv", this.getCategory());
            param.put("languageCD", session.getAttribute("LANGUAGE"));
            try {
                final List result = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
                this.outTag(result);
            }
            catch (final Exception e) {
                if (this.logger.isDebugEnabled()) {
                    this.logger.debug((Object)("Error : " + e));
                }
            }
        }
        else if (this.getQueryKey() != null) {
            final Map command = new HashMap();
            String[] keys = null;
            String[] values = null;
            if (this.getParamKey() != null) {
                keys = this.getParamKey().split(";");
            }
            if (this.getParamValue() != null) {
                values = this.getParamValue().split(";");
            }
            command.put("queryKey", this.getQueryKey());
            if (keys != null) {
                for (int i = 0; i < keys.length; ++i) {
                    try {
                        command.put(keys[i], values[i]);
                    }
                    catch (final ArrayIndexOutOfBoundsException e2) {
                        command.put(keys[i], "");
                    }
                }
            }
            try {
                final HttpSession session2 = this.pageContext.getSession();
                final WebApplicationContext wac2 = WebApplicationContextUtils.getRequiredWebApplicationContext(session2.getServletContext());
                command.put("companyID", session2.getAttribute("COMPANYID"));
                final List result2 = ((SimpleService)wac2.getBean("simpleService")).queryForList(command);
                this.outTag(result2);
            }
            catch (final Exception e) {
                if (this.logger.isDebugEnabled()) {
                    this.logger.debug((Object)("Error : " + e));
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }
    
    private void outTag(final List list) {
        final JspWriter out = this.pageContext.getOut();
        final StringBuffer html = new StringBuffer();
        Map map = new HashMap();
        try {
            for (int i = 0; i < list.size(); ++i) {
                map = (Map) list.get(i);
                final Set set = map.keySet();
                final Object[] keys = set.toArray();
                final String valueKey = keys[0].toString();
                final String nameKey = keys[1].toString();
                html.append("<input type=\"radio\" class=\"radio\"");
                if (super.getId() == null && super.getName() == null) {
                    html.append(" id=\"control\" name=\"control\"");
                }
                else if (super.getId() != null && super.getName() == null) {
                    html.append(" id=\"" + super.getId() + "\" name=\"" + super.getId() + "\"");
                }
                else if (super.getId() == null && super.getName() != null) {
                    html.append(" id=\"" + super.getName() + "\" name=\"" + super.getName() + "\"");
                }
                else if (super.getId() != null && super.getName() != null) {
                    html.append(" id=\"" + super.getId() + "\" name=\"" + super.getName() + "\"");
                }
                html.append(" value=\"" + map.get(valueKey).toString() + "\" ");
                if (super.getEvent() != null && super.getEventProc() != null) {
                    html.append(super.getEvent() + "=\"" + super.getEventProc() + "\" ");
                }
                if (super.getValue() != null && super.getValue() != "") {
                    if (map.get(valueKey).toString().equals(super.getValue())) {
                        html.append(" checked ");
                    }
                }
                else if (super.getDefaultValue() != null) {
                    if (map.get(valueKey).toString().equals(super.getDefaultValue())) {
                        html.append(" checked ");
                    }
                }
                else if (i == 0) {
                    html.append(" checked ");
                }
                html.append(">");
                html.append(map.get(nameKey).toString());
                if (this.getDirection() != null) {
                    if (this.getDirection().equals("vertical")) {
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
            if (super.getPreset() != null && super.getPreset().equals("aw")) {
                out.print(html.toString().replace("\"", "\\\""));
            }
            else {
                out.print(html.toString());
            }
        }
        catch (final IOException e) {
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("Error : " + e));
            }
        }
    }
}
