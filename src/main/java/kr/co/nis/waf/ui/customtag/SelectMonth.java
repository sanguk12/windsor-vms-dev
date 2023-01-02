// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import java.util.Set;
import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import org.springframework.context.support.MessageSourceAccessor;
import java.util.List;
import java.util.Map;
import org.springframework.web.context.WebApplicationContext;
import javax.servlet.http.HttpSession;
import kr.co.nis.waf.dao.SimpleService;
import java.util.HashMap;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class SelectMonth extends WebControl
{
    protected final Log logger;
    private String monthId;
    private String yearCategory;
    private String monthCategory;
    
    public SelectMonth() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.monthId = null;
        this.yearCategory = null;
        this.monthCategory = null;
    }
    
    public int doStartTag() {
        if (this.getYearCategory() != null && this.getMonthCategory() != null) {
            final HttpSession session = this.pageContext.getSession();
            final WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
            final Map param = new HashMap();
            param.put("companyID", session.getAttribute("COMPANYID"));
            param.put("codeDiv", this.getYearCategory());
            param.put("languageCD", session.getAttribute("LANGUAGE"));
            try {
                final List resultYear = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
                param.put("codeDiv", this.getMonthCategory());
                final List resultMonth = ((SimpleService)wac.getBean("simpleService")).queryForList("SYS0001S", param);
                this.outTag(resultYear, resultMonth);
            }
            catch (final Exception e) {
                if (this.logger.isDebugEnabled()) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }
    
    private void outTag(final List yearList, final List monthList) {
        try {
            final JspWriter out = this.pageContext.getOut();
            final StringBuffer html = new StringBuffer();
            final StringBuffer yearHtml = new StringBuffer();
            final StringBuffer monthHtml = new StringBuffer();
            final HttpSession session = this.pageContext.getSession();
            final WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
            Map yearMap = new HashMap();
            yearHtml.append("<select");
            if (super.getId() == null && super.getName() == null) {
                yearHtml.append(" id=\"control\" name=\"control\"");
            }
            else if (super.getId() != null && super.getName() == null) {
                yearHtml.append(" id=\"" + super.getId() + "\" name=\"" + super.getId() + "\"");
            }
            else if (super.getId() == null && super.getName() != null) {
                yearHtml.append(" id=\"" + super.getName() + "\" name=\"" + super.getName() + "\"");
            }
            else if (super.getId() != null && super.getName() != null) {
                yearHtml.append(" id=\"" + super.getId() + "\" name=\"" + super.getName() + "\"");
            }
            if (super.getCssClass() != null) {
                yearHtml.append(" class=\"" + super.getCssClass() + "\" ");
            }
            if (super.getStyle() != null && !super.getStyle().equals("")) {
                yearHtml.append(" style=\"" + super.getStyle() + "\" ");
            }
            if (super.getEvent() != null && super.getEventProc() != null) {
                yearHtml.append(" " + super.getEvent() + "=\"" + super.getEventProc() + "\"");
            }
            if (!super.isVisible()) {
                yearHtml.append(" style=\"visibility:hidden\"");
            }
            if (!super.isEnable()) {
                yearHtml.append(" disabled style=\"background:#EEEEEE\"");
            }
            if (super.getToolTip() != null) {
                yearHtml.append(" alt=\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getToolTip()) + "\" ");
            }
            yearHtml.append(">");
            if (super.getDefaultText() != null && super.getDefaultText().equals("blank")) {
                yearHtml.append("   <option value=\"\"></option>");
            }
            else if (super.getDefaultText() == null || !super.getDefaultText().equals("none")) {
                if (super.getDefaultText() != null && !super.getDefaultText().equals("")) {
                    yearHtml.append("\t<option value=\"\" selected>" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getDefaultText()) + "</option>");
                }
                else {
                    yearHtml.append("   <option value=\"\"></option>");
                }
            }
            if (yearList != null) {
                for (int i = 0; i < yearList.size(); ++i) {
                    yearMap = (Map) yearList.get(i);
                    final Set set = yearMap.keySet();
                    final Object[] keys = set.toArray();
                    String valueKey = "";
                    String nameKey = "";
                    valueKey = keys[0].toString();
                    nameKey = keys[1].toString();
                    if (super.getValue() != null && super.getValue().equals(yearMap.get(valueKey).toString())) {
                        yearHtml.append("\t<option value=\"" + yearMap.get(valueKey).toString() + "\" selected>" + yearMap.get(nameKey).toString() + "</option>");
                    }
                    else {
                        yearHtml.append("\t<option value=\"" + yearMap.get(valueKey).toString() + "\">" + yearMap.get(nameKey).toString() + "</option>");
                    }
                }
            }
            yearHtml.append("</select>");
            Map monthMap = new HashMap();
            monthHtml.append("<select");
            if (this.getMonthId() == null) {
                monthHtml.append(" id=\"control\" name=\"control\"");
            }
            else if (this.getMonthId() != null) {
                monthHtml.append(" id=\"" + this.getMonthId() + "\" name=\"" + this.getMonthId() + "\"");
            }
            if (super.getCssClass() != null) {
                monthHtml.append(" class=\"" + super.getCssClass() + "\" ");
            }
            if (super.getStyle() != null && !super.getStyle().equals("")) {
                monthHtml.append(" style=\"" + super.getStyle() + "\" ");
            }
            if (super.getEvent() != null && super.getEventProc() != null) {
                monthHtml.append(" " + super.getEvent() + "=\"" + super.getEventProc() + "\"");
            }
            if (!super.isVisible()) {
                monthHtml.append(" style=\"visibility:hidden\"");
            }
            if (!super.isEnable()) {
                monthHtml.append(" disabled style=\"background:#EEEEEE\"");
            }
            if (super.getToolTip() != null) {
                monthHtml.append(" alt=\"" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getToolTip()) + "\" ");
            }
            monthHtml.append(">");
            if (super.getDefaultText() != null && super.getDefaultText().equals("blank")) {
                monthHtml.append("   <option value=\"\"></option>");
            }
            else if (super.getDefaultText() == null || !super.getDefaultText().equals("none")) {
                if (super.getDefaultText() != null && !super.getDefaultText().equals("")) {
                    monthHtml.append("\t<option value=\"\" selected>" + ((MessageSourceAccessor)wac.getBean("messageSourceAccessor")).getMessage(super.getDefaultText()) + "</option>");
                }
                else {
                    monthHtml.append("   <option value=\"\"></option>");
                }
            }
            if (monthList != null) {
                for (int j = 0; j < monthList.size(); ++j) {
                    monthMap = (Map) monthList.get(j);
                    final Set set2 = monthMap.keySet();
                    final Object[] keys2 = set2.toArray();
                    String valueKey2 = "";
                    String nameKey2 = "";
                    valueKey2 = keys2[0].toString();
                    nameKey2 = keys2[1].toString();
                    monthHtml.append("\t<option value=\"" + monthMap.get(valueKey2).toString() + "\">" + monthMap.get(nameKey2).toString() + "</option>");
                }
            }
            monthHtml.append("</select>");
            final String dateFormat = (String)session.getAttribute("DATEFORMAT");
            if (dateFormat.substring(0, 3).equals("YMD")) {
                html.append(yearHtml);
                html.append("&nbsp;");
                html.append(monthHtml);
            }
            else if (dateFormat.substring(0, 3).equals("MDY")) {
                html.append(monthHtml);
                html.append("&nbsp;");
                html.append(yearHtml);
            }
            else if (dateFormat.substring(0, 3).equals("DMY")) {
                html.append(monthHtml);
                html.append("&nbsp;");
                html.append(yearHtml);
            }
            else {
                html.append(yearHtml);
                html.append("&nbsp;");
                html.append(monthHtml);
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
    
    public String getMonthId() {
        return this.monthId;
    }
    
    public void setMonthId(final String monthId) {
        this.monthId = monthId;
    }
    
    public String getYearCategory() {
        return this.yearCategory;
    }
    
    public void setYearCategory(final String yearCategory) {
        this.yearCategory = yearCategory;
    }
    
    public String getMonthCategory() {
        return this.monthCategory;
    }
    
    public void setMonthCategory(final String monthCategory) {
        this.monthCategory = monthCategory;
    }
}
