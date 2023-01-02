package kr.co.nis.waf.system.common.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SimpleDispatcherController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@RequestMapping("/service/simpleCommand")
	public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		ModelAndView mv = new ModelAndView(getViewUrl(request));
		Map params = new HashMap();

		bind(request, params);
		
		if (logger.isDebugEnabled()) {
			logger.debug("/service/simpleCommand =========>\n" + params);
		}
		
//		Runtime.getRuntime().gc();
//		Runtime.getRuntime().runFinalization();
//		if (logger.isDebugEnabled()) {
//			logger.debug("Runtime.getRuntime().freeMemory simpledispatcher : "+Runtime.getRuntime().freeMemory());
//		}
		
		setObjectAll(mv, request, response, params);
		return mv;
	}
}
