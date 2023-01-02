package com.kia.mil.web;

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

import com.kia.mil.model.GMIL01MT;
import com.kia.mil.service.Mil02Service;

@Controller
@RequestMapping("/service/mil02")
public class Mil02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Mil02Service mil02Service;
	
	@RequestMapping("/approvalMileage")
	public ModelAndView approvalMileage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);

			//mil02Service.approvalMileage(gmil01mt);
			if(gmil01mt.getLastApprYN().equals("Y")) {
				mil02Service.lastApprovalMileage(gmil01mt);
			}
			else {
				mil02Service.approvalMileage(gmil01mt);
			}
			
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
	
	@RequestMapping("/rejectMileage")
	public ModelAndView rejectMileage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);
			
			gmil01mt.setEmpNm(session.getEmpNm());
			gmil01mt.setEmailAddr(session.getEmailAddr());
			gmil01mt.setClientDate(session.getClientDate());
			mil02Service.rejectMileage(gmil01mt);
			
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

	@RequestMapping("/approvalMileageRlt")
	public ModelAndView approvalMileageRlt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);

			//mil02Service.approvalMileage(gmil01mt);
			if(gmil01mt.getLastApprYN().equals("Y")) {
				mil02Service.lastApprovalMileageRlt(gmil01mt);
			}
			else {
				mil02Service.approvalMileageRlt(gmil01mt);
			}
			
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
	
	@RequestMapping("/rejectMileageRlt")
	public ModelAndView rejectMileageRlt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);
			
			gmil01mt.setEmpNm(session.getEmpNm());
			gmil01mt.setEmailAddr(session.getEmailAddr());
			gmil01mt.setClientDate(session.getClientDate());
			mil02Service.rejectMileageRlt(gmil01mt);
			
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

	/*
	@RequestMapping("/approvalMileage_add")
	public ModelAndView approvalMileage_add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);

			mil02Service.approvalMileage_add(gmil01mt);
			
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
	
	@RequestMapping("/rejectMileage_add")
	public ModelAndView rejectMileage_add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);
			
			gmil01mt.setEmpNm(session.getEmpNm());
			gmil01mt.setEmailAddr(session.getEmailAddr());
			gmil01mt.setClientDate(session.getClientDate());
			mil02Service.rejectMileage_add(gmil01mt);
			
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
	*/
}