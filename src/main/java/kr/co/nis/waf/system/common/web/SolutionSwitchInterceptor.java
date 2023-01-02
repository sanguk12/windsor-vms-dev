package kr.co.nis.waf.system.common.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.mvc.Configure;
import kr.co.nis.waf.system.common.model.SwitchObject;
import kr.co.nis.waf.view.SimpleDoc;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class SolutionSwitchInterceptor extends HandlerInterceptorAdapter {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	private Configure configure;
	
	@Resource
	private SimpleService simpleService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		SessionManager sessionManager = new SessionManager(request, response);
		Map param = sessionManager.getAttributeAll(request);
		
		SwitchObject switchObject = new SwitchObject();
		String uri = request.getRequestURI();
		String pgmID = param.get("pgmID").toString();
		String viewID = request.getAttribute("viewID")!=null?request.getAttribute("viewID").toString():request.getParameter("viewID");
		
		logger.debug("$$$$$$$$$uri : "+uri);
		logger.debug("$$$$$$$$$pgmID : "+pgmID);
		logger.debug("$$$$$$$$$viewID : "+viewID);

		try {
		
			if(switchObject.getTestModuleYN().equals("N")) {
				
				if (!param.get("pgmID").toString().equals("")) {
					logger.debug("$$$$$$$$$switchObject.getTestModule_views() : "+switchObject.getTestModule_views());
					
					if(switchObject.getTestModule_views().contains(viewID) || switchObject.getTestModule_views().contains(uri)) {
						logger.debug("$$$$$$$$$view in");
						ModelAndView mv = new ModelAndView("/sys3/cms/nosoultion");
						mv.addObject("configure", configure);
						mv.addObject("params", param);
						throw new ModelAndViewDefiningException(mv);
					}
				}
				else if(switchObject.getTestModule_queryKeys().contains(uri) && uri.contains("simpleAction")) {
					logger.debug("$$$$$$$$$switchObject.getTestModule_queryKeys() : "+switchObject.getTestModule_queryKeys());
					List list = new ArrayList();
					SimpleDoc simpleDoc = new SimpleDoc("XML", list);
					throw new ModelAndViewDefiningException(simpleDoc.create());
				}
				
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return true;
	}
	
}