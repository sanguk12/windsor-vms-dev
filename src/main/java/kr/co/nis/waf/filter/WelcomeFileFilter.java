// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.filter;

import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.FilterChain;
import javax.servlet.ServletResponse;
import javax.servlet.ServletRequest;
import javax.servlet.FilterConfig;
import javax.servlet.Filter;

public class WelcomeFileFilter implements Filter
{
    private String welcomeFile;
    protected FilterConfig filterConfig;
    
    public WelcomeFileFilter() {
        this.welcomeFile = null;
        this.filterConfig = null;
    }
    
    public void destroy() {
    }
    
    public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain) throws IOException, ServletException {
        if (this.welcomeFile != null) {
            final HttpServletRequest httpRequest = (HttpServletRequest)request;
            final HttpServletResponse httpResponse = (HttpServletResponse)response;
            if (this.isWelcomePage(httpRequest)) {
                httpResponse.sendRedirect("");
            }
        }
        chain.doFilter(request, response);
    }
    
    public boolean isWelcomePage(final HttpServletRequest request) {
        final String uri = request.getRequestURI();
        if (uri.endsWith("/")) {
            return true;
        }
        final int index = uri.lastIndexOf("/");
        final String fileName = uri.substring(index);
        return fileName.indexOf(".") != -1;
    }
    
    public void init(final FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        this.welcomeFile = filterConfig.getInitParameter("welcomeFile");
    }
    
    public FilterConfig getFilterConfig() {
        return this.filterConfig;
    }
    
    public void setFilterConfig(final FilterConfig cfg) {
        this.filterConfig = cfg;
    }
}
