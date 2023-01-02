// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import org.springframework.web.servlet.ModelAndView;
import java.util.List;
import java.util.Enumeration;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.LogFactory;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class WafMultiActionController extends MultiActionController
{
    protected final Log logger;
    @Resource
    protected Configure configure;
    
    public WafMultiActionController() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void bind(final HttpServletRequest request, final Model model) throws Exception {
        super.bind(request, (Object)model);
        if (request.getSession(false).getAttribute("USERID") != null) {
            model.setCompanyID((String)request.getSession(false).getAttribute("COMPANYID"));
            model.setUserID((String)request.getSession(false).getAttribute("USERID"));
            model.setTimezoneCD((String)request.getSession(false).getAttribute("TIMEZONE"));
            model.setLanguageCD((String)request.getSession(false).getAttribute("LANGUAGE"));
            model.setCurrencyCD((String)request.getSession(false).getAttribute("CURRENCY"));
            model.setLocaleCD((String)request.getSession(false).getAttribute("LOCALE"));
            model.setDateFormatCD((String)request.getSession(false).getAttribute("DATEFORMAT"));
            model.setAmtFormatCD((String)request.getSession(false).getAttribute("AMTFORMAT"));
            model.setClientDate((String)request.getSession(false).getAttribute("CLIENTDATE"));
        }
    }
    
    protected void bind(final HttpServletRequest request, final Map command) throws Exception {
        final Enumeration parameters = request.getParameterNames();
        String parameterName = "";
        String[] values = null;
        while (parameters.hasMoreElements()) {
            parameterName = parameters.nextElement().toString();
            values = request.getParameterValues(parameterName);
            if (values.length == 1) {
                command.put(parameterName, values[0]);
            }
            else {
                command.put(parameterName, values);
            }
        }
        if (request.getAttribute("programAuthResult") != null) {
            command.put("viewID", this.getViewID(request));
            command.put("viewName", this.getViewName(request));
            command.put("viewTitle", this.getViewTitle(request));
            command.put("appPositionCD", this.getAppPositionCD(request));
            command.put("appDisRate", this.getAppDisRate(request));
            command.put("appDisUnitCD", this.getAppDisUnitCD(request));
        }
        if (request.getSession(false).getAttribute("USERID") != null) {
            command.put("companyID", request.getSession(false).getAttribute("COMPANYID"));
            command.put("userID", request.getSession(false).getAttribute("USERID"));
            command.put("timezoneCD", request.getSession(false).getAttribute("TIMEZONE"));
            command.put("languageCD", request.getSession(false).getAttribute("LANGUAGE"));
            command.put("currencyCD", request.getSession(false).getAttribute("CURRENCY"));
            command.put("localeCD", request.getSession(false).getAttribute("LOCALE"));
            command.put("dateFormatCD", request.getSession(false).getAttribute("DATEFORMATCD"));
            command.put("amtFormatCD", request.getSession(false).getAttribute("AMTFORMATCD"));
            command.put("clientDate", request.getSession(false).getAttribute("CLIENTDATE"));
        }
    }
    
    protected void bind(final HttpServletRequest request, final Object model, final Map command) throws Exception {
        super.bind(request, model);
        final Enumeration parameters = request.getParameterNames();
        String parameterName = "";
        String[] values = null;
        while (parameters.hasMoreElements()) {
            parameterName = parameters.nextElement().toString();
            values = request.getParameterValues(parameterName);
            if (values.length == 1) {
                command.put(parameterName, values[0]);
            }
            else {
                command.put(parameterName, values);
            }
        }
        if (request.getAttribute("programAuthResult") != null) {
            command.put("viewID", this.getViewID(request));
            command.put("viewName", this.getViewName(request));
            command.put("viewTitle", this.getViewTitle(request));
            command.put("appPositionCD", this.getAppPositionCD(request));
            command.put("appDisRate", this.getAppDisRate(request));
            command.put("appDisUnitCD", this.getAppDisUnitCD(request));
        }
        if (request.getSession(false).getAttribute("USERID") != null) {
            command.put("companyID", request.getSession(false).getAttribute("COMPANYID"));
            command.put("userID", request.getSession(false).getAttribute("USERID"));
            command.put("timezoneCD", request.getSession(false).getAttribute("TIMEZONE"));
            command.put("languageCD", request.getSession(false).getAttribute("LANGUAGE"));
            command.put("currencyCD", request.getSession(false).getAttribute("CURRENCY"));
            command.put("localeCD", request.getSession(false).getAttribute("LOCALE"));
            command.put("dateFormatCD", request.getSession(false).getAttribute("DATEFORMATCD"));
            command.put("amtFormatCD", request.getSession(false).getAttribute("AMTFORMATCD"));
            command.put("clientDate", request.getSession(false).getAttribute("CLIENTDATE"));
        }
    }
    
    public String getViewID(final HttpServletRequest request) {
        return ((Map)request.getAttribute("programAuthResult")).get("viewID").toString();
    }
    
    public String getViewName(final HttpServletRequest request) {
        return ((Map)request.getAttribute("programAuthResult")).get("viewName").toString();
    }
    
    public String getViewTitle(final HttpServletRequest request) {
        return ((Map)request.getAttribute("programAuthResult")).get("viewTitle").toString();
    }
    
    public String getViewUrl(final HttpServletRequest request) {
        return ((Map)request.getAttribute("programAuthResult")).get("viewURL").toString();
    }
    
    public String getAppPositionCD(final HttpServletRequest request) {
        return ((Map)request.getAttribute("programAuthResult")).get("appPositionCD").toString();
    }
    
    public String getAppDisRate(final HttpServletRequest request) {
        return ((Map)request.getAttribute("programAuthResult")).get("appDisRate").toString();
    }
    
    public String getAppDisUnitCD(final HttpServletRequest request) {
        return ((Map)request.getAttribute("programAuthResult")).get("appDisUnitCD").toString();
    }
    
    public List getMenuConstructPath(final HttpServletRequest request) {
        return (List)request.getAttribute("menuConstructPath");
    }
    
    public List getFunctionList(final HttpServletRequest request) {
        return (List)request.getAttribute("functionList");
    }
    
    protected void setObjectAll(final ModelAndView mv, final HttpServletRequest request, final Map params) {
        mv.addObject("menuConstructPath", (Object)this.getMenuConstructPath(request));
        mv.addObject("funcList", (Object)this.getFunctionList(request));
        mv.addObject("params", (Object)params);
        mv.addObject("configure", (Object)this.configure);
    }
}
