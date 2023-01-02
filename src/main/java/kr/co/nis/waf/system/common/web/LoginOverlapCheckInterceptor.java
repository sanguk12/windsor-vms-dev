package kr.co.nis.waf.system.common.web;

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
public class LoginOverlapCheckInterceptor extends HandlerInterceptorAdapter {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Configure configure;
	
	@Resource
	private SimpleService simpleService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		boolean overlapCheck = true;
		String uri = request.getRequestURI();

		if (uri != null) {
			if (configure.getNoSessionCheckUri().contains(uri))
				overlapCheck = false;

		}

		if (overlapCheck) {
			SessionManager session = new SessionManager(request, response);
			Map param = new HashMap();
			param.put("companyID", session.getCompanyID());
			param.put("userID", session.getUserID());
			param = simpleService.queryForMap("CMP0100803S", param);
			if(param != null){
				if (!param.get("currentClientIp").toString().equals(request.getRemoteAddr())) {
					throw new ModelAndViewDefiningException(new ModelAndView(configure.getLoginOverlapViewUrl()));
				}
			}
		}
		return true;
	}

}