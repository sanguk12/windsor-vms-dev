// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

public interface Model
{
    void setCompanyID(final String p0) throws Exception;
    
    void setUserID(final String p0) throws Exception;
    
    void setTimezoneCD(final String p0) throws Exception;
    
    void setLanguageCD(final String p0) throws Exception;
    
    void setCurrencyCD(final String p0) throws Exception;
    
    void setLocaleCD(final String p0) throws Exception;
    
    void setDateFormatCD(final String p0) throws Exception;
    
    void setAmtFormatCD(final String p0) throws Exception;
    
    void setClientDate(final String p0) throws Exception;
    
    void clean() throws Exception;
    
    void validate(final int p0) throws Exception;
}
