// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.util.Hashtable;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

public interface MultipartRequestHandler
{
    void handleRequest(final HttpServletRequest p0) throws ServletException;
    
    Hashtable getTextElements();
    
    Hashtable getFileElements();
    
    Hashtable getAllElements();
    
    void rollback();
    
    void finish();
}
