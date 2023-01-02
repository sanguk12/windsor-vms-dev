package com.kia.cvr.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.cvr.model.GCVR01MTs;
import com.kia.cvr.service.Cvr01Service;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

@Controller
@RequestMapping("/service/cvr01")
public class Cvr01Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Cvr01Service cvr01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/saveRate")
	public ModelAndView saveRate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		GCVR01MTs gcvr01mts = new GCVR01MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gcvr01mts);
		
		try {
			gcvr01mts.clean();
			
			cvr01Service.addRate(gcvr01mts);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
		
		return mv;
	}
}