// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import org.apache.commons.logging.LogFactory;
import java.lang.reflect.InvocationTargetException;
import org.apache.commons.beanutils.MethodUtils;

import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;
import java.security.Principal;
import javax.servlet.http.Cookie;
import javax.servlet.RequestDispatcher;
import java.util.Locale;
import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletInputStream;
import java.util.Iterator;
import java.util.Collection;
import java.util.Collections;
import java.util.Vector;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import javax.servlet.http.HttpServletRequest;

public class MultipartRequestWrapper extends HttpServletRequestWrapper {
    private static final Log log;
    protected Map parameters;
    protected HttpServletRequest request;

    public MultipartRequestWrapper(HttpServletRequest request) {
        super(request);
        this.request = request;
        this.parameters = new HashMap();
    }

    public void setParameter(final String name, final String value) {
        String[] mValue = (String[]) this.parameters.get(name);
        if (mValue == null) {
            mValue = new String[0];
        }
        final String[] newValue = new String[mValue.length + 1];
        System.arraycopy(mValue, 0, newValue, 0, mValue.length);
        newValue[mValue.length] = value;
        this.parameters.put(name, newValue);
    }

    public String getParameter(final String name) {
        String value = this.request.getParameter(name);
        if (value == null) {
            final String[] mValue = (String[]) this.parameters.get(name);
            if (mValue != null && mValue.length > 0) {
                value = mValue[0];
            }
        }
        return value;
    }

    public Enumeration getParameterNames() {
        final Enumeration baseParams = this.request.getParameterNames();
        final Vector list = new Vector();
        while (baseParams.hasMoreElements()) {
            list.add(baseParams.nextElement());
        }
        final Collection multipartParams = this.parameters.keySet();
        final Iterator iterator = multipartParams.iterator();
        while (iterator.hasNext()) {
            list.add(iterator.next());
        }
        return Collections.enumeration((Collection<Object>)list);
    }

    public String[] getParameterValues(final String name) {
        String[] value = this.request.getParameterValues(name);
        if (value == null) {
            value = (String[]) this.parameters.get(name);
        }
        return value;
    }

    public HttpServletRequest getRequest() {
        return this.request;
    }

    public Object getAttribute(final String name) {
        return this.request.getAttribute(name);
    }

    public Enumeration getAttributeNames() {
        return this.request.getAttributeNames();
    }

    public String getCharacterEncoding() {
        return this.request.getCharacterEncoding();
    }

    public int getContentLength() {
        return this.request.getContentLength();
    }

    public String getContentType() {
        return this.request.getContentType();
    }

    public ServletInputStream getInputStream() throws IOException {
        return this.request.getInputStream();
    }

    public String getProtocol() {
        return this.request.getProtocol();
    }

    public String getScheme() {
        return this.request.getScheme();
    }

    public String getServerName() {
        return this.request.getServerName();
    }

    public int getServerPort() {
        return this.request.getServerPort();
    }

    public BufferedReader getReader() throws IOException {
        return this.request.getReader();
    }

    public String getRemoteAddr() {
        return this.request.getRemoteAddr();
    }

    public String getRemoteHost() {
        return this.request.getRemoteHost();
    }

    public void setAttribute(final String name, final Object o) {
        this.request.setAttribute(name, o);
    }

    public void removeAttribute(final String name) {
        this.request.removeAttribute(name);
    }

    public Locale getLocale() {
        return this.request.getLocale();
    }

    public Enumeration getLocales() {
        return this.request.getLocales();
    }

    public boolean isSecure() {
        return this.request.isSecure();
    }

    public RequestDispatcher getRequestDispatcher(final String path) {
        return this.request.getRequestDispatcher(path);
    }

    public String getRealPath(final String path) {
        return this.request.getRealPath(path);
    }

    public String getAuthType() {
        return this.request.getAuthType();
    }

    public Cookie[] getCookies() {
        return this.request.getCookies();
    }

    public long getDateHeader(final String name) {
        return this.request.getDateHeader(name);
    }

    public String getHeader(final String name) {
        return this.request.getHeader(name);
    }

    public Enumeration getHeaders(final String name) {
        return this.request.getHeaders(name);
    }

    public Enumeration getHeaderNames() {
        return this.request.getHeaderNames();
    }

    public int getIntHeader(final String name) {
        return this.request.getIntHeader(name);
    }

    public String getMethod() {
        return this.request.getMethod();
    }

    public String getPathInfo() {
        return this.request.getPathInfo();
    }

    public String getPathTranslated() {
        return this.request.getPathTranslated();
    }

    public String getContextPath() {
        return this.request.getContextPath();
    }

    public String getQueryString() {
        return this.request.getQueryString();
    }

    public String getRemoteUser() {
        return this.request.getRemoteUser();
    }

    public boolean isUserInRole(final String user) {
        return this.request.isUserInRole(user);
    }

    public Principal getUserPrincipal() {
        return this.request.getUserPrincipal();
    }

    public String getRequestedSessionId() {
        return this.request.getRequestedSessionId();
    }

    public String getRequestURI() {
        return this.request.getRequestURI();
    }

    public String getServletPath() {
        return this.request.getServletPath();
    }

    public HttpSession getSession(final boolean create) {
        return this.request.getSession(create);
    }

    public HttpSession getSession() {
        return this.request.getSession();
    }

    public boolean isRequestedSessionIdValid() {
        return this.request.isRequestedSessionIdValid();
    }

    public boolean isRequestedSessionIdFromURL() {
        return this.request.isRequestedSessionIdFromURL();
    }

    public boolean isRequestedSessionIdFromUrl() {
        return this.request.isRequestedSessionIdFromUrl();
    }

    public Map getParameterMap() {
        final Map map = new HashMap(this.parameters);
        final Enumeration names = this.request.getParameterNames();
        while (names.hasMoreElements()) {
            final String name = (String) names.nextElement();
            map.put(name, this.request.getParameterValues(name));
        }
        return map;
    }

    public void setCharacterEncoding(final String encoding) {
        this.invokeRequestMethod("setCharacterEncoding", new Object[] { encoding });
    }

    public StringBuffer getRequestURL() {
        return (StringBuffer)this.invokeRequestMethod("getRequestURL", null);
    }

    public boolean isRequestedSessionIdFromCookie() {
        final Object result = this.invokeRequestMethod("isRequestedSessionIdFromCookie", null);
        return result != null && (boolean)result;
    }

    public String getLocalAddr() {
        return (String)this.invokeRequestMethod("getLocalAddr", null);
    }

    public String getLocalName() {
        return (String)this.invokeRequestMethod("getLocalName", null);
    }

    public int getLocalPort() {
        final Object result = this.invokeRequestMethod("getLocalPort", null);
        return (int)((result == null) ? 0 : result);
    }

    public int getRemotePort() {
        final Object result = this.invokeRequestMethod("getRemotePort", null);
        return (int)((result == null) ? 0 : result);
    }

    private Object invokeRequestMethod(final String name, final Object[] args) {
        try {
            return MethodUtils.invokeExactMethod((Object)this.request, name, args);
        }
        catch (final NoSuchMethodException e) {
            if (MultipartRequestWrapper.log.isDebugEnabled()) {
                MultipartRequestWrapper.log.debug((Object)("Method '" + name + "' not defined for javax.servlet.http.HttpServletRequest"));
            }
        }
        catch (final InvocationTargetException e2) {
            MultipartRequestWrapper.log.error((Object)("Error invoking method '" + name + "' "), e2.getTargetException());
        }
        catch (final IllegalAccessException e3) {
            MultipartRequestWrapper.log.error((Object)("Error invoking method '" + name + "' "), (Throwable)e3);
        }
        return null;
    }

    static {
        log = LogFactory.getLog((Class)MultipartRequestWrapper.class);
    }
}
