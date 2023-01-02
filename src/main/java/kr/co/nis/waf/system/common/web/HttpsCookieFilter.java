package kr.co.nis.waf.system.common.web;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterConfig;
import javax.servlet.FilterChain;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class HttpsCookieFilter implements Filter {

	protected final Log logger = LogFactory.getLog(getClass());
	
    public HttpsCookieFilter() {
        filterConfig = null;
    }

    public void destroy() {
        filterConfig = null;
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		final HttpServletRequest  httpRequest  = (HttpServletRequest)  request;
		final HttpServletResponse httpResponse = (HttpServletResponse) response;
		final HttpSession session = httpRequest.getSession(true);

		if(session != null) {
			final Cookie sessionCookie = new Cookie("JSESSIONID", session.getId());
			sessionCookie.setMaxAge(-1);
			sessionCookie.setSecure(false);
			sessionCookie.setPath("/");
			httpResponse.addCookie(sessionCookie);
			logger.debug("sessionID=" + session.getId() + ", requestURL=" + httpRequest.getRequestURL());
		}
		
		chain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    public FilterConfig getFilterConfig() {
        return filterConfig;
    }

    public void setFilterConfig(FilterConfig cfg) {
        filterConfig = cfg;
    }

    protected FilterConfig filterConfig;
}
