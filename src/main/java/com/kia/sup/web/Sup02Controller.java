package com.kia.sup.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.sup.model.GSUP01MT;
import com.kia.sup.service.Sup02Service;

@Controller
@RequestMapping("/service/sup02")
public class Sup02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Sup02Service sup02Service;
	
	@RequestMapping("/approvalSupport")
	public ModelAndView approvalSupport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GSUP01MT gsup01mt = new GSUP01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gsup01mt);
		
		try {
			gsup01mt.clean();
			gsup01mt.validate(gsup01mt.ACTION_SAVE);
			
			sup02Service.approvalSupport(gsup01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.approval"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.approval"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/rejectSupport")
	public ModelAndView rejectSupport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GSUP01MT gsup01mt = new GSUP01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, gsup01mt);
		
		try {
			gsup01mt.clean();
			gsup01mt.validate(gsup01mt.ACTION_SAVE);
			
			gsup01mt.setEmpNm(session.getEmpNm());
			gsup01mt.setEmailAddr(session.getEmailAddr());
			gsup01mt.setClientDate(session.getClientDate());
			sup02Service.rejectSupport(gsup01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.reject"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.reject"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/approvalSupport_add")
	public ModelAndView approvalSupport_add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GSUP01MT gsup01mt = new GSUP01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gsup01mt);
		
		try {
			gsup01mt.clean();
			gsup01mt.validate(gsup01mt.ACTION_SAVE);
			
			sup02Service.approvalSupport_add(gsup01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.approval"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.approval"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/rejectSupport_add")
	public ModelAndView rejectSupport_add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GSUP01MT gsup01mt = new GSUP01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, gsup01mt);
		
		try {
			gsup01mt.clean();
			gsup01mt.validate(gsup01mt.ACTION_SAVE);
			
			gsup01mt.setEmpNm(session.getEmpNm());
			gsup01mt.setEmailAddr(session.getEmailAddr());
			gsup01mt.setClientDate(session.getClientDate());
			sup02Service.rejectSupport_add(gsup01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.reject"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.reject"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
}