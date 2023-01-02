package kr.co.nis.waf.system.common.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.mvc.Configure;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class SessionCheckInterceptor extends HandlerInterceptorAdapter {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Configure configure;


	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		String sessionValidKey = configure.getSessionValidationCheckKey();

		String checkKey = (String) request.getSession().getAttribute(sessionValidKey);
		String uri = request.getRequestURI();
		String url = request.getRequestURL().toString();
		String action = uri.substring(uri.indexOf(".") + 1, uri.length());
		boolean sessionCheck = true;

		if (logger.isDebugEnabled())
		{
			logger.debug("uri ==>" + uri);
			logger.debug("url ==>" + request.getRequestURL().toString());
			logger.debug("action ==>" + action);
			logger.debug("configure.getNoSessionCheckAction() ==>" + configure.getNoSessionCheckAction());
		}

		if (uri != null)
		{
			if (configure.getNoSessionCheckUri().contains(uri))
				sessionCheck = false;
			else if (configure.getNoSessionCheckAction().contains(action))
			{
				sessionCheck = false;
			}
		}

		if (sessionCheck)
		{
			if (checkKey == null || checkKey.equals(""))
			{
				if (logger.isDebugEnabled())
				{
					logger.debug(configure);
				}
				throw new ModelAndViewDefiningException(new ModelAndView(configure.getExpiredSessionViewUrl()));
			}
		}

		return true;
	}

}