// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import java.util.Set;
import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.springframework.context.support.MessageSourceAccessor;
import java.util.Map;
import org.springframework.web.context.WebApplicationContext;
import javax.servlet.http.HttpSession;
import kr.co.nis.waf.dao.SimpleService;
import java.util.HashMap;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.apache.commons.logging.LogFactory;
import java.util.List;
import org.apache.commons.logging.Log;

public class SelectBox extends WebControl
{
    protected final Log logger;
    private List data;
    private String category;
    private String queryKey;
    private String paramKey;
    private String paramValue;
    private String valuePosition;
    
    public SelectBox() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.data = null;
        this.category = null;
        this.queryKey = null;
        this.paramKey = null;
        this.paramValue = null;
        this.valuePosition = null;
    }
    
    public String getQuery() {
        return this.queryKey;
    }
    
    public void setQueryKey(final String queryKey) {
        this.queryKey = queryKey;
    }
    
    public String getQuerykey() {
        return this.queryKey;
    }
    
    public void setQuerykey(final String queryKey) {
        this.queryKey = queryKey;
    }
    
    public String getQueryKey() {
        return this.queryKey;
    }
    
    public void setQuery(final String queryKey) {
        this.queryKey = queryKey;
    }
    
    public String getParamKey() {
        return this.paramKey;
    }
    
    public void setParamKey(final String paramKey) {
        this.paramKey = paramKey;
    }
    
    public void setParamkey(final String paramKey) {
        this.paramKey = paramKey;
    }
    
    public String getParamValue() {
        return this.paramValue;
    }
    
    public void setParamValue(final String paramValue) {
        this.paramValue = paramValue;
    }
    
    public void setParamvalue(final String paramValue) {
        this.paramValue = paramValue;
    }
    
    public String getCategory() {
        return this.category;
    }
    
    public void setCategory(final String category) {
        this.category = category;
    }
    
    public String getValuePosition() {
        return this.valuePosition;
    }
    
    public void setValuePosition(final String valuePosition) {
        this.valuePosition = valuePosition;
    }
    
    public void setValueposition(final String valuePosition) {
        this.valuePosition = valuePosition;
    }
    
    public List getData() {
        return this.data;
    }
    
    public void setData(final List data) {
        this.data = data;
    }
    
    public int doStartTag() {
        if (this.getData() != null) {
            try {
                this.outTag(this.getData());
            }
            catch (final Exception e) {
                if (this.logger.isDebugEnabled()) {
                    this.logger.debug((Object)("Error : " + e));
                }
            }
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
            catch (final Exception e2) {
                if (this.logger.isDebugEnabled()) {
                    e2.printStackTrace();
                }
            }
        }
        else if (this.getQuery() != null || this.getQueryKey() != null) {
            final Map command = new HashMap();
            String[] keys = null;
            String[] values = null;
            if (this.getParamKey() != null) {
                keys = this.getParamKey().split(";");
            }
            if (this.getParamValue() != null) {
                values = this.getParamValue().split(";");
            }
            if (this.getQuery() != null) {
                command.put("queryKey", this.getQuery());
            }
            else {
                command.put("queryKey", this.getQueryKey());
            }
            if (keys != null) {
                for (int i = 0; i < keys.length; ++i) {
                    try {
                        command.put(keys[i], values[i]);
                    }
                    catch (final ArrayIndexOutOfBoundsException e3) {
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
            catch (final Exception e2) {
                if (this.logger.isDebugEnabled()) {
                    this.logger.debug((Object)("Error : " + e2));
                    e2.printStackTrace();
                }
            }
        }
        return 0;
    }
    
    private void outTag(final List list) {
        try {
            final JspWriter out = this.pageContext.getOut();
            final StringBuffer html = new StringBuffer();
            final HttpSession session = this.pageContext.getSession();
            final WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
            Map map = new HashMap();
            html.append("<select");
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
            if (super.getCssClass() != null) {
                html.append(" class=\"" + super.getCssClass() + "\" ");
            }
            if (super.getStyle() != null && !super.getStyle().equals("")) {
                html.append(" style=\"" + super.getStyle() + "\" ");
            }
            if (super.getEvent() != null && super.getEventProc() != null) {
                html.append(" " + super.getEvent() + "=\"" + super.getEventProc() + "\"");
            }
            if (!super.isVisible()) {
                html.append(" style=\"visibility:hidden\"");
            }
            if (!super.isEnable()) {
                html.append(" disabled style=\"background:#EEEEEE\"");
            }
            if (super.getToolTip() != null) {
                html.append(" alt=\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getToolTip()) + "\" ");
            }
            html.append(">");
            if (super.getDefaultText() != null && super.getDefaultText().equals("blank")) {
                html.append("   <option value=\"\"></option>");
            }
            else if (super.getDefaultText() == null || !super.getDefaultText().equals("none")) {
                if (super.getDefaultText() != null && !super.getDefaultText().equals("")) {
                    html.append("\t<option value=\"\" selected>" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getDefaultText()) + "</option>");
                }
                else {
                    html.append("   <option value=\"\"></option>");
                }
            }
            if (list != null) {
                for (int i = 0; i < list.size(); ++i) {
                    map = (Map) list.get(i);
                    final Set set = map.keySet();
                    final Object[] keys = set.toArray();
                    String valueKey = "";
                    String nameKey = "";
                    if (this.getValuePosition() != null) {
                        final String[] position = this.getValuePosition().split(";");
                        valueKey = keys[Integer.parseInt(position[0])].toString();
                        nameKey = keys[Integer.parseInt(position[1])].toString();
                    }
                    else {
                        valueKey = keys[0].toString();
                        nameKey = keys[1].toString();
                    }
                    if (super.getValue() != null && super.getValue().equals(map.get(valueKey).toString())) {
                        html.append("\t<option value=\"" + map.get(valueKey).toString() + "\" selected>" + map.get(nameKey).toString() + "</option>");
                    }
                    else {
                        html.append("\t<option value=\"" + map.get(valueKey).toString() + "\">" + map.get(nameKey).toString() + "</option>");
                    }
                }
            }
            html.append("</select>");
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
