package kr.co.nis.waf.system.common.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.mvc.Configure;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class AuthorityInjectionInterceptor extends HandlerInterceptorAdapter {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Configure configure;
	
	@Resource
	private SimpleService simpleService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		SessionManager sessionManager = new SessionManager(request, response);
		Map param = sessionManager.getAttributeAll(request);
		Map programResult = new HashMap();

		try
		{

			if (!param.get("pgmID").toString().equals(""))
			{

				//F_MenuConstructGroup
				request.setAttribute("menuConstructPath", simpleService.queryForList("SYS0010S", param));
				
				//F_ProgramView
				programResult = simpleService.queryForMap("SYS0011S", param);
				request.setAttribute("programAuthResult", programResult);
			

				if (request.getParameter("viewID") == null || param.get("viewID").toString().equals("")) {
					param.put("viewID", programResult.get("viewID").toString());
					param.put("appPositionCD", programResult.get("appPositionCD").toString());
					param.put("appDisRate", programResult.get("appDisRate").toString());
					param.put("appDisUnitCD", programResult.get("appDisUnitCD").toString());
					//2013.02.13. taejoon.jang, for soultionSwitch
					request.setAttribute("viewID", param.get("viewID"));
				}
				
				if (logger.isDebugEnabled()){
					logger.debug("programResult ==================>");
					logger.debug(programResult);
				}

				try {
					//F_ViewFunction
					request.setAttribute("functionList", simpleService.queryForList("SYS0012S", param));
				}
				catch (Exception ex) {
					request.setAttribute("functionList", new ArrayList());
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			ModelAndView mv = new ModelAndView(configure.getNoAuthorityViewUrl());
			mv.addObject("configure", configure);
			mv.addObject("params", param);
			throw new ModelAndViewDefiningException(mv);
		}

		return true;
	}

}