package com.kia.pln.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02MT;
import com.kia.pln.service.Pln02Service;

@Controller
@RequestMapping("/service/pln02")
public class Pln02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Pln02Service pln02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/approvalPlanVenue")
	public ModelAndView approvalPlanVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			gpln01mt.setEmpID(session.getEmpID());
			gpln01mt.setEmpNm(session.getEmpNm());
			gpln01mt.setEmailAddr(session.getEmailAddr());
			gpln01mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln01mt.setOfficeCDName(session.getOfficeCDName());
			gpln01mt.setTeamCDName(session.getTeamCDName());
			gpln01mt.setClientDate(session.getClientDate());
			
			GPLN01MT gpln01mt_a = gpln01mt.getObject_approval(0);
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gpln01mt_a.getLastApprYN().equals("Y")) {
				pln02Service.lastApprovalPlanVenue(gpln01mt);
			}
			else {
				pln02Service.approvalPlanVenue(gpln01mt);
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
	
	@RequestMapping("/rejectPlanVenue")
	public ModelAndView rejectPlanVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			gpln01mt.setEmpID(session.getEmpID());
			gpln01mt.setEmpNm(session.getEmpNm());
			gpln01mt.setEmailAddr(session.getEmailAddr());
			gpln01mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln01mt.setOfficeCDName(session.getOfficeCDName());
			gpln01mt.setTeamCDName(session.getTeamCDName());
			gpln01mt.setClientDate(session.getClientDate());
			
			pln02Service.rejectPlanVenue(gpln01mt);
			
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
	
	@RequestMapping("/approvalPlanBrand")
	public ModelAndView approvalPlanBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN02MT gpln02mt = new GPLN02MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln02mt);
		
		try {
			gpln02mt.clean();
			gpln02mt.validate(gpln02mt.ACTION_SAVE);
			
			gpln02mt.setEmpID(session.getEmpID());
			gpln02mt.setEmpNm(session.getEmpNm());
			gpln02mt.setEmailAddr(session.getEmailAddr());
			gpln02mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln02mt.setOfficeCDName(session.getOfficeCDName());
			gpln02mt.setTeamCDName(session.getTeamCDName());
			gpln02mt.setClientDate(session.getClientDate());
			
			GPLN02MT gpln02mt_a = gpln02mt.getObject_approval(0);
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gpln02mt_a.getLastApprYN().equals("Y")) {
				pln02Service.lastApprovalPlanBrand(gpln02mt);
			}
			else {
				pln02Service.approvalPlanBrand(gpln02mt);
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
	
	@RequestMapping("/rejectPlanBrand")
	public ModelAndView rejectPlanBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN02MT gpln02mt = new GPLN02MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln02mt);
		
		try {
			gpln02mt.clean();
			gpln02mt.validate(gpln02mt.ACTION_SAVE);
			
			gpln02mt.setEmpID(session.getEmpID());
			gpln02mt.setEmpNm(session.getEmpNm());
			gpln02mt.setEmailAddr(session.getEmailAddr());
			gpln02mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln02mt.setOfficeCDName(session.getOfficeCDName());
			gpln02mt.setTeamCDName(session.getTeamCDName());
			gpln02mt.setClientDate(session.getClientDate());
			
			pln02Service.rejectPlanBrand(gpln02mt);
			
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
	
	@RequestMapping("/approvalPlanVenue_new")
	public ModelAndView approvalPlanVenue_new(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			gpln01mt.setEmpID(session.getEmpID());
			gpln01mt.setEmpNm(session.getEmpNm());
			gpln01mt.setEmailAddr(session.getEmailAddr());
			gpln01mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln01mt.setOfficeCDName(session.getOfficeCDName());
			gpln01mt.setTeamCDName(session.getTeamCDName());
			gpln01mt.setClientDate(session.getClientDate());
			
			GPLN01MT gpln01mt_a = gpln01mt.getObject_approval_new(0);
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gpln01mt_a.getLastApprYN().equals("Y")) {
				pln02Service.lastApprovalPlanVenue_new(gpln01mt);
			}
			else {
				pln02Service.approvalPlanVenue_new(gpln01mt);
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
	
	@RequestMapping("/rejectPlanVenue_new")
	public ModelAndView rejectPlanVenue_new(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			gpln01mt.setEmpID(session.getEmpID());
			gpln01mt.setEmpNm(session.getEmpNm());
			gpln01mt.setEmailAddr(session.getEmailAddr());
			gpln01mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln01mt.setOfficeCDName(session.getOfficeCDName());
			gpln01mt.setTeamCDName(session.getTeamCDName());
			gpln01mt.setClientDate(session.getClientDate());
			
			pln02Service.rejectPlanVenue_new(gpln01mt);
			
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
	
	@RequestMapping("/approvalPlan")
	public ModelAndView approvalPlan(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			gpln01mt.setEmpID(session.getEmpID());
			gpln01mt.setEmpNm(session.getEmpNm());
			gpln01mt.setEmailAddr(session.getEmailAddr());
			gpln01mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln01mt.setOfficeCDName(session.getOfficeCDName());
			gpln01mt.setTeamCDName(session.getTeamCDName());
			gpln01mt.setClientDate(session.getClientDate());
			
			if(gpln01mt.getLastApprYN().equals("Y")) {
				pln02Service.lastApprovalPlan(gpln01mt);
			}
			else {
				pln02Service.approvalPlan(gpln01mt);
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
	
	@RequestMapping("/rejectPlan")
	public ModelAndView rejectPlan(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			gpln01mt.setEmpID(session.getEmpID());
			gpln01mt.setEmpNm(session.getEmpNm());
			gpln01mt.setEmailAddr(session.getEmailAddr());
			gpln01mt.setRageSphereCDName(session.getRageSphereCDName());
			gpln01mt.setOfficeCDName(session.getOfficeCDName());
			gpln01mt.setTeamCDName(session.getTeamCDName());
			gpln01mt.setClientDate(session.getClientDate());
			
			pln02Service.rejectPlan(gpln01mt);
			
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