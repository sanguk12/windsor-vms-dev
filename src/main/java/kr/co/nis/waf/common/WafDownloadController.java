// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.util.Map;
import java.util.HashMap;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import kr.co.nis.waf.mvc.SystemController;

public class WafDownloadController extends SystemController
{
    private String uploadDir;
    
    public WafDownloadController() {
        this.uploadDir = null;
    }
    
    public void setUploadDir(final String uploadDir) {
        this.uploadDir = uploadDir;
    }
    
    public ModelAndView defaultAction(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final Map parameters = new HashMap();
        this.bind(request, parameters);
        parameters.put("uploadDir", this.uploadDir);
        return new ModelAndView("downloadView", parameters);
    }
}
