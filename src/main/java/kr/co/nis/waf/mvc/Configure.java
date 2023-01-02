// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import kr.co.nis.waf.BaseObject;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

public class Configure extends BaseObject
{
    private String expiredSessionViewUrl;
    private String leftMenuScroll;
    private String leftMenuType;
    private String locale;
    private String loginViewUrl;
    private String mainViewUrl;
    private String mainPageViewUrl;
    private String menuStyle;
    private String noAuthorityViewUrl;
    private int sessionMaxInActiveInterval;
    private String sessionValidationCheckKey;
    private String themeDefaultPath;
    private String theme;
    private String uploadDefaultUrl;
    private ArrayList noSessionCheckUri;
    private ArrayList noSessionCheckAction;
    private String timezone;
    private String timezoneDesc;
    private String systemTimezone;
    private String systemTimezoneDesc;
    private String language;
    private String currency;
    private String dateFormat;
    private String amtFormat;
    private String webEditor;
    private String loginOverlapViewUrl;
    private String saasServiceAdminMenuConstructID;
    private String uploadDirUse;
    private String uploadFileNameOption;

    public String encryptSHA256(final String str) {
        String SHA = "";
        try {
            final MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str.getBytes());
            final byte[] byteData = sh.digest();
            final StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; ++i) {
                sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
            }
            SHA = sb.toString();
        }
        catch (final NoSuchAlgorithmException e) {
            e.printStackTrace();
            SHA = null;
        }
        return SHA;
    }

    public String getExpiredSessionViewUrl() {
        return this.expiredSessionViewUrl;
    }
    
    public void setExpiredSessionViewUrl(final String expiredSessionViewUrl) {
        this.expiredSessionViewUrl = expiredSessionViewUrl;
    }
    
    public String getLeftMenuScroll() {
        return this.leftMenuScroll;
    }
    
    public void setLeftMenuScroll(final String leftMenuScroll) {
        this.leftMenuScroll = leftMenuScroll;
    }
    
    public String getLeftMenuType() {
        return this.leftMenuType;
    }
    
    public void setLeftMenuType(final String leftMenuType) {
        this.leftMenuType = leftMenuType;
    }
    
    public String getLocale() {
        return this.locale;
    }
    
    public void setLocale(final String locale) {
        this.locale = locale;
    }
    
    public String getLoginViewUrl() {
        return this.loginViewUrl;
    }
    
    public void setLoginViewUrl(final String loginViewUrl) {
        this.loginViewUrl = loginViewUrl;
    }
    
    public String getMainViewUrl() {
        return this.mainViewUrl;
    }
    
    public void setMainViewUrl(final String mainViewUrl) {
        this.mainViewUrl = mainViewUrl;
    }
    
    public String getMainPageViewUrl() {
        return this.mainPageViewUrl;
    }
    
    public void setMainPageViewUrl(final String mainPageViewUrl) {
        this.mainPageViewUrl = mainPageViewUrl;
    }
    
    public String getMenuStyle() {
        return this.menuStyle;
    }
    
    public void setMenuStyle(final String menuStyle) {
        this.menuStyle = menuStyle;
    }
    
    public String getNoAuthorityViewUrl() {
        return this.noAuthorityViewUrl;
    }
    
    public void setNoAuthorityViewUrl(final String noAuthorityViewUrl) {
        this.noAuthorityViewUrl = noAuthorityViewUrl;
    }
    
    public int getSessionMaxInActiveInterval() {
        return this.sessionMaxInActiveInterval;
    }
    
    public void setSessionMaxInActiveInterval(final int sessionMaxInActiveInterval) {
        this.sessionMaxInActiveInterval = sessionMaxInActiveInterval;
    }
    
    public String getSessionValidationCheckKey() {
        return this.sessionValidationCheckKey;
    }
    
    public void setSessionValidationCheckKey(final String sessionValidationCheckKey) {
        this.sessionValidationCheckKey = sessionValidationCheckKey;
    }
    
    public String getThemeDefaultPath() {
        return this.themeDefaultPath;
    }
    
    public void setThemeDefaultPath(final String themeDefaultPath) {
        this.themeDefaultPath = themeDefaultPath;
    }
    
    public String getTheme() {
        return this.theme;
    }
    
    public void setTheme(final String theme) {
        this.theme = theme;
    }
    
    public String getUploadDefaultUrl() {
        return this.uploadDefaultUrl;
    }
    
    public void setUploadDefaultUrl(final String uploadDefaultUrl) {
        this.uploadDefaultUrl = uploadDefaultUrl;
    }
    
    public ArrayList getNoSessionCheckUri() {
        return this.noSessionCheckUri;
    }
    
    public void setNoSessionCheckUri(final ArrayList noSessionCheckUri) {
        this.noSessionCheckUri = noSessionCheckUri;
    }
    
    public ArrayList getNoSessionCheckAction() {
        return this.noSessionCheckAction;
    }
    
    public void setNoSessionCheckAction(final ArrayList noSessionCheckAction) {
        this.noSessionCheckAction = noSessionCheckAction;
    }
    
    public String getTimezone() {
        return this.timezone;
    }
    
    public void setTimezone(final String timezone) {
        this.timezone = timezone;
    }
    
    public String getTimezoneDesc() {
        return this.timezoneDesc;
    }
    
    public void setTimezoneDesc(final String timezoneDesc) {
        this.timezoneDesc = timezoneDesc;
    }
    
    public String getSystemTimezone() {
        return this.systemTimezone;
    }
    
    public void setSystemTimezone(final String systemTimezone) {
        this.systemTimezone = systemTimezone;
    }
    
    public String getSystemTimezoneDesc() {
        return this.systemTimezoneDesc;
    }
    
    public void setSystemTimezoneDesc(final String systemTimezoneDesc) {
        this.systemTimezoneDesc = systemTimezoneDesc;
    }
    
    public String getLanguage() {
        return this.language;
    }
    
    public void setLanguage(final String language) {
        this.language = language;
    }
    
    public String getCurrency() {
        return this.currency;
    }
    
    public void setCurrency(final String currency) {
        this.currency = currency;
    }
    
    public String getDateFormat() {
        return this.dateFormat;
    }
    
    public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }
    
    public String getAmtFormat() {
        return this.amtFormat;
    }
    
    public void setAmtFormat(final String amtFormat) {
        this.amtFormat = amtFormat;
    }
    
    public String getWebEditor() {
        return this.webEditor;
    }
    
    public void setWebEditor(final String webEditor) {
        this.webEditor = webEditor;
    }
    
    public String getLoginOverlapViewUrl() {
        return this.loginOverlapViewUrl;
    }
    
    public void setLoginOverlapViewUrl(final String loginOverlapViewUrl) {
        this.loginOverlapViewUrl = loginOverlapViewUrl;
    }
    
    public String getSaasServiceAdminMenuConstructID() {
        return this.saasServiceAdminMenuConstructID;
    }
    
    public void setSaasServiceAdminMenuConstructID(final String saasServiceAdminMenuConstructID) {
        this.saasServiceAdminMenuConstructID = saasServiceAdminMenuConstructID;
    }
    
    public String getUploadDirUse() {
        return this.uploadDirUse;
    }
    
    public void setUploadDirUse(final String uploadDirUse) {
        this.uploadDirUse = uploadDirUse;
    }
    
    public String getUploadFileNameOption() {
        return this.uploadFileNameOption;
    }
    
    public void setUploadFileNameOption(final String uploadFileNameOption) {
        this.uploadFileNameOption = uploadFileNameOption;
    }
}
