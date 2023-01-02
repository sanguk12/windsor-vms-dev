package com.kia.anl.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

@Controller
public class EsltController extends MultiActionController{
	
	@RequestMapping("/eslt")
	public ModelAndView mobile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map params = new HashMap();
		
		ModelAndView mv = new ModelAndView("eslt/ESLT01001A");
		
		return mv;
	}
}
