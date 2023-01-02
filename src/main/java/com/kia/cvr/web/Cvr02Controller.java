package com.kia.cvr.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.cvr.model.GCVR02MTs;
import com.kia.cvr.service.Cvr02Service;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

@Controller
@RequestMapping("/service/cvr02")
public class Cvr02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Cvr02Service cvr02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/requestApp")
	public ModelAndView saveRate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		GCVR02MTs gcvr02mts = new GCVR02MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gcvr02mts);
		
		try {
			gcvr02mts.clean();
			
			cvr02Service.requestApp(gcvr02mts);
			
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
	
	@RequestMapping("/saveApprReq")
	public ModelAndView saveApprReq(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GCVR02MTs gcvr02mts = new GCVR02MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gcvr02mts);
		
		try {
			gcvr02mts.clean();
			
			cvr02Service.saveApprReq(gcvr02mts);
			
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
	
	@RequestMapping("/saveApprReqCancel")
	public ModelAndView saveApprReqCancel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GCVR02MTs gcvr02mts = new GCVR02MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gcvr02mts);
		
		try {
			gcvr02mts.clean();
			
			cvr02Service.saveApprReqCancel(gcvr02mts);
			
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
	
	@RequestMapping("/saveApproval")
	public ModelAndView saveApproval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GCVR02MTs gcvr02mts = new GCVR02MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gcvr02mts);
		
		try {
			gcvr02mts.clean();
			
			cvr02Service.saveApproval(gcvr02mts);
			
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
	
	@RequestMapping("/saveApprReject")
	public ModelAndView saveApprReject(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GCVR02MTs gcvr02mts = new GCVR02MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gcvr02mts);
		
		try {
			gcvr02mts.clean();
			
			cvr02Service.saveApprReject(gcvr02mts);
			
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