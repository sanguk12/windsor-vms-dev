// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.filter;

import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletResponse;
import javax.servlet.ServletRequest;
import javax.servlet.FilterConfig;
import javax.servlet.Filter;

public class EncodingFilter implements Filter
{
    private String encoding;
    protected FilterConfig filterConfig;
    
    public EncodingFilter() {
        this.encoding = null;
        this.filterConfig = null;
    }
    
    public void destroy() {
        this.encoding = null;
        this.filterConfig = null;
    }
    
    public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain) throws IOException, ServletException {
        if (request.getCharacterEncoding() == null && this.encoding != null) {
            request.setCharacterEncoding(this.encoding);
        }
        chain.doFilter(request, response);
    }
    
    public void init(final FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        this.encoding = filterConfig.getInitParameter("encoding");
    }
    
    public FilterConfig getFilterConfig() {
        return this.filterConfig;
    }
    
    public void setFilterConfig(final FilterConfig cfg) {
        this.filterConfig = cfg;
    }
}
