// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import javax.servlet.http.HttpServletRequestWrapper;

public class WafHttpServletRequest extends HttpServletRequestWrapper
{
    private Map paramValues;

    public WafHttpServletRequest(final HttpServletRequest arg) {
        super(arg);
        this.paramValues = new HashMap();
    }

    public void setParameter(final String param, final String val) {
        this.paramValues.put(param, val);
    }

    public String getParameter(final String param) {
        if (param.equals("method")) {
            return (String) this.paramValues.get(param);
        }
        return super.getParameter(param);
    }
}
