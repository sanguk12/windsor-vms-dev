// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import java.util.Map;
import kr.co.nis.waf.common.SessionManager;
import java.util.HashMap;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping({ "/service/system" })
public class SystemController extends WafMultiActionController
{
    protected final Log logger;
    
    public SystemController() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    @RequestMapping({ "/expiredSession" })
    public ModelAndView expiredSession(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final String expiredSessionPage = this.configure.getExpiredSessionViewUrl();
        final Map params = new HashMap();
        this.bind(request, params);
        final SessionManager session = new SessionManager(request, response);
        session.killSession();
        final ModelAndView mv = new ModelAndView(expiredSessionPage);
        this.setObjectAll(mv, request, params);
        return mv;
    }
    
    @RequestMapping({ "/noAuthorityProgram" })
    public ModelAndView noAuthorityProgram(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final String noAuthorityProgramPage = this.configure.getNoAuthorityViewUrl();
        final Map params = new HashMap();
        this.bind(request, params);
        final ModelAndView mv = new ModelAndView(noAuthorityProgramPage);
        this.setObjectAll(mv, request, params);
        return mv;
    }
}
