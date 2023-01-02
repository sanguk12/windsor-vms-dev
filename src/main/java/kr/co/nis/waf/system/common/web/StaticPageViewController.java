package kr.co.nis.waf.system.common.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.mvc.Configure;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class StaticPageViewController implements org.springframework.web.servlet.mvc.Controller {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Configure configure;
	
	//private CompositeConfiguration propertyConfiguration;

	/*
	public void setConfigure(Configure configure) {
		this.configure = configure;
	}
	*/

//	public void setPropertyConfiguration(CompositeConfiguration propertyConfiguration) {
//		this.propertyConfiguration = propertyConfiguration;
//	}

	@RequestMapping("**/*.page")
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {

		String contextPath = request.getContextPath();
		String uri = request.getRequestURI();

		if (logger.isDebugEnabled()) {
			logger.debug("URI : " + uri);
			logger.debug("ContextPath : " + contextPath);
		}

		int begin = 0;
		if ((contextPath == null) || (contextPath.equals(""))) {
			begin = 1;
		}
		else {
			begin = contextPath.length() + 1;
		}

		if (logger.isDebugEnabled()) {
			logger.debug("Begin : " + begin);
		}

		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		}
		else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		}
		else {
			end = uri.length();
		}
		
		String fileName = uri.substring(begin, end);
		if (fileName.indexOf(".") != -1) {
			fileName = fileName.substring(0, fileName.lastIndexOf("."));
		}

		for (Enumeration en = request.getParameterNames(); en.hasMoreElements();) {
			String attribute = (String) en.nextElement();
			Object attributeValue = request.getParameter(attribute);

			if (logger.isDebugEnabled()) {
				logger.debug("set Attribute in Request : " + attribute + "=" + attributeValue);
			}

			request.setAttribute(attribute, attributeValue);
		}

		ModelAndView mv;
		Map params = new HashMap();
		Map appenv = new HashMap();
		SessionManager session = new SessionManager(request, response);
		
		try
		{
			params = session.getAttributeAll(request);
			
			if (logger.isDebugEnabled()) {
				logger.debug("StaticPageViewController.session.getAttributeAll()=============>\n"+params);
			}
			
			/*
			Iterator properyKeys = propertyConfiguration.getKeys();
			while (properyKeys.hasNext()) {
				String key = properyKeys.next().toString();
				appenv.put(key, propertyConfiguration.getString(key));
			}
			*/
			
			if (logger.isDebugEnabled()) {
				logger.debug("StaticPageViewController.appenv=============>\n"+appenv);
			}
			
		}
		catch (Exception e) {
			fileName = configure.getExpiredSessionViewUrl();
		}

		mv = new ModelAndView(fileName);
		mv.addObject("params", params);
		mv.addObject("appenv", appenv);

		return mv;
	}
}
