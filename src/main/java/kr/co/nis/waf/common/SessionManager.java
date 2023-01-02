// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.util.Enumeration;
import kr.co.nis.waf.util.DateUtil;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import java.util.Locale;
import org.apache.commons.logging.LogFactory;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;

public class SessionManager
{
    protected final Log logger;
    public final String KR = "KR";
    public final String EN = "EN";
    public final String JP = "JP";
    public final String CN = "CN";
    public final String TW = "TW";
    public final String WATERFALL_MENUSTYLE = "WATERFALL";
    public final String TREE_MENUSTYLE = "TREE";
    protected HttpSession session;
    
    public SessionManager(final HttpServletRequest request, final HttpServletResponse response) {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.session = request.getSession(false);
    }
    
    public String getAuthType() {
        return (String)this.session.getAttribute("AUTHTYPE");
    }
    
    public void setAuthType(final String authType) {
        this.session.setAttribute("AUTHTYPE", (Object)authType);
    }
    
    public String getUserID() {
        return (String)this.session.getAttribute("USERID");
    }
    
    public void setUserID(final String userID) {
        this.session.setAttribute("USERID", (Object)userID);
    }
    
    public String getUserName() {
        return (String)this.session.getAttribute("USERNAME");
    }
    
    public void setUserName(final String userName) {
        this.session.setAttribute("USERNAME", (Object)userName);
    }
    
    public String getGrpID() {
        return (String)this.session.getAttribute("GRPID");
    }
    
    public void setGrpID(final String grpID) {
        this.session.setAttribute("GRPID", (Object)grpID);
    }
    
    public String getMnuConstructID() {
        return (String)this.session.getAttribute("MNUCONSTRUCTID");
    }
    
    public void setMnuConstructID(final String mnuConstructID) {
        this.session.setAttribute("MNUCONSTRUCTID", (Object)mnuConstructID);
    }
    
    public String getSystemTimezone() {
        return (String)this.session.getAttribute("SYSTEMTIMEZONE");
    }
    
    public void setSystemTimezone(final String systemTimezone) {
        this.session.setAttribute("SYSTEMTIMEZONE", (Object)systemTimezone);
    }
    
    public String getSystemTimezoneDesc() {
        return (String)this.session.getAttribute("SYSTEMTIMEZONEDESC");
    }
    
    public void setSystemTimezoneDesc(final String systemTimezoneDesc) {
        this.session.setAttribute("SYSTEMTIMEZONEDESC", (Object)systemTimezoneDesc);
    }
    
    public String getCurrency() {
        return (String)this.session.getAttribute("CURRENCY");
    }
    
    public void setCurrency(final String currency) {
        this.session.setAttribute("CURRENCY", (Object)currency);
    }
    
    public String getLanguage() {
        return (String)this.session.getAttribute("LANGUAGE");
    }
    
    public void setLanguage(final String language) {
        Locale locale = null;
        if (language.equals("KR")) {
            locale = Locale.KOREAN;
        }
        else if (language.equals("EN")) {
            locale = Locale.ENGLISH;
        }
        else if (language.equals("JP")) {
            locale = Locale.JAPANESE;
        }
        else if (language.equals("CN")) {
            locale = Locale.CHINESE;
        }
        else if (language.equals("TW")) {
            locale = Locale.TAIWAN;
        }
        else {
            locale = Locale.KOREAN;
        }
        this.session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, (Object)locale);
        this.session.setAttribute("LANGUAGE", (Object)language);
    }
    
    public String getLocale() {
        return (String)this.session.getAttribute("LOCALE");
    }
    
    public void setLocale(final String locale) {
        this.session.setAttribute("LOCALE", (Object)locale);
    }
    
    public String getMenuStyle() {
        return (String)this.session.getAttribute("MENUSTYLE");
    }
    
    public void setMenuStyle(final String menuStyle) {
        this.session.setAttribute("MENUSTYLE", (Object)menuStyle);
    }
    
    public String getTheme() {
        return (String)this.session.getAttribute("THEME");
    }
    
    public void setTheme(final String theme) {
        this.session.setAttribute("THEME", (Object)theme);
    }
    
    public String getThemeURL() {
        return (String)this.session.getAttribute("THEMEDEFAULTPATH") + (String)this.session.getAttribute("THEME");
    }
    
    public void setThemeDefaultPath(final String themeDefaultPath) {
        this.session.setAttribute("THEMEDEFAULTPATH", (Object)themeDefaultPath);
    }
    
    public String getTimezone() {
        return (String)this.session.getAttribute("TIMEZONE");
    }
    
    public void setTimezone(final String timezone) {
        this.session.setAttribute("TIMEZONE", (Object)timezone);
    }
    
    public String getTimezoneDesc() {
        return (String)this.session.getAttribute("TIMEZONEDESC");
    }
    
    public void setTimezoneDesc(final String timezoneDesc) {
        this.session.setAttribute("TIMEZONEDESC", (Object)timezoneDesc);
    }
    
    public String getDateFormat() {
        return (String)this.session.getAttribute("DATEFORMAT");
    }
    
    public void setDateFormat(final String dateFormat) {
        this.session.setAttribute("DATEFORMAT", (Object)dateFormat);
    }
    
    public String getAmtFormat() {
        return (String)this.session.getAttribute("AMTFORMAT");
    }
    
    public void setAmtFormat(final String amtFormat) {
        this.session.setAttribute("AMTFORMAT", (Object)amtFormat);
    }
    
    public String getSystemLanguage() {
        return (String)this.session.getAttribute("SYSTEMLANGUAGE");
    }
    
    public void setSystemLanguage(final String systemLanguage) {
        this.session.setAttribute("SYSTEMLANGUAGE", (Object)systemLanguage);
    }
    
    public String getClientDate() {
        return DateUtil.getConvertDate(DateUtil.getDate(), this.getSystemTimezoneDesc(), this.getTimezoneDesc(), "YMD", "");
    }
    
    public void setClientDate(final String clientDate) {
        this.session.setAttribute("CLIENTDATE", (Object)clientDate);
    }
    
    public void killSession() {
        try {
            final Enumeration keys = this.session.getAttributeNames();
            String key = null;
            while (keys.hasMoreElements()) {
                key = keys.nextElement().toString();
                this.session.removeAttribute(key);
            }
        }
        catch (final Exception ex) {}
    }
    
    public void setMaxInactiveInterval(final int time) {
        this.session.setMaxInactiveInterval(time);
    }
    
    public void removeAttribute(final String key) {
        this.session.removeAttribute(key);
    }
    
    public void setAttribute(final String key, final Object value) {
        this.session.setAttribute(key, value);
    }
}
