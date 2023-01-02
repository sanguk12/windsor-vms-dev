// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import org.springframework.web.bind.annotation.RequestMapping;
import java.util.Map;
import java.util.HashMap;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.LogFactory;
import javax.annotation.Resource;
import javax.sql.DataSource;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Controller;

@Controller
public class SimpleReportController extends WafMultiActionController
{
    protected final Log logger;
    @Resource
    private DataSource dataSource;
    
    public SimpleReportController() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.dataSource = null;
    }
    
    @RequestMapping({ "/service/simpleReport" })
    public ModelAndView defaultAction(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final Map model = new HashMap();
        this.bind(request, model);
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)model);
        }
        model.put("jdbcDataSource", this.dataSource);
        model.put("servletContext", request.getSession().getServletContext());
        final ModelAndView mv = new ModelAndView((String)model.get("report"), model);
        return mv;
    }
}
