// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import java.util.Locale;
import javax.servlet.ServletRequest;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.mvc.Controller;

public class SessionLocaleController implements Controller
{
    public static final int KOREA_LOCALE = 1;
    public static final int ENGLISH_LOCALE = 2;
    
    public ModelAndView handleRequest(final HttpServletRequest request, final HttpServletResponse response) {
        final int localeMode = ServletRequestUtils.getIntParameter((ServletRequest)request, "lang", 1);
        Locale locale = null;
        if (localeMode == 1) {
            locale = Locale.KOREAN;
        }
        else if (localeMode == 2) {
            locale = Locale.ENGLISH;
        }
        else {
            locale = Locale.KOREAN;
        }
        final HttpSession session = request.getSession();
        session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, (Object)locale);
        return new ModelAndView("main");
    }
}
