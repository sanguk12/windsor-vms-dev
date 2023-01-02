package com.kia.key.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/app")
public class Application extends SimpleMultiActionController{
	
	@Value("#{appenv['file.appInstallGuide']}")
	private String appInstallGuideFile;
	
//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
	@RequestMapping("/download")
	public ModelAndView mobile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map params = new HashMap();
		
		ModelAndView mv = new ModelAndView("application/APP01001A");
		
		return mv;
	}
	
	@RequestMapping("/guideDownload")
	public ModelAndView guideDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		parameters.put("fileName", appInstallGuideFile);
		parameters.put("tempFileName", appInstallGuideFile);
		parameters.put("uploadDir", templateFilePath);

		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/testApkDownload")
	public ModelAndView testApkDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		parameters.put("fileName", "diageo.apk");
		parameters.put("tempFileName", "diageo.apk");
		parameters.put("uploadDir", templateFilePath);

		return new ModelAndView("downloadView", parameters);
	}
	
}
