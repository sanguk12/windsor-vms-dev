package com.kia.pay.web;

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

import com.kia.mil.model.GMIL01MT;
import com.kia.pay.service.Pay02Service;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;

@Controller
@RequestMapping("/service/pay02")
public class Pay02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Pay02Service pay02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/approvalResultVenue_err")
	public ModelAndView approvalResultVenue_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			grlt01mt.setEmpID(session.getEmpID());
			grlt01mt.setEmpNm(session.getEmpNm());
			grlt01mt.setEmailAddr(session.getEmailAddr());
			grlt01mt.setRageSphereCDName(session.getRageSphereCDName());
			grlt01mt.setOfficeCDName(session.getOfficeCDName());
			grlt01mt.setTeamCDName(session.getTeamCDName());
			grlt01mt.setClientDate(session.getClientDate());
			
			GRLT01MT gpln01mt_a = grlt01mt.getObject_approval(0);
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gpln01mt_a.getLastApprYN().equals("Y")) {
				pay02Service.lastApprovalResultVenue_err(grlt01mt);
			}
			else {
				pay02Service.approvalResultVenue_err(grlt01mt);
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
	
	@RequestMapping("/rejectResultVenue_err")
	public ModelAndView rejectResultVenue_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			grlt01mt.setEmpID(session.getEmpID());
			grlt01mt.setEmpNm(session.getEmpNm());
			grlt01mt.setEmailAddr(session.getEmailAddr());
			grlt01mt.setRageSphereCDName(session.getRageSphereCDName());
			grlt01mt.setOfficeCDName(session.getOfficeCDName());
			grlt01mt.setTeamCDName(session.getTeamCDName());
			grlt01mt.setClientDate(session.getClientDate());
			
			pay02Service.rejectResultVenue_err(grlt01mt);
			
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
	
	@RequestMapping("/approvalResultBrand_err")
	public ModelAndView approvalResultBrand_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT02MT grlt02mt = new GRLT02MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, grlt02mt);
		
		try {
			grlt02mt.clean();
			grlt02mt.validate(grlt02mt.ACTION_SAVE);
			
			grlt02mt.setEmpID(session.getEmpID());
			grlt02mt.setEmpNm(session.getEmpNm());
			grlt02mt.setEmailAddr(session.getEmailAddr());
			grlt02mt.setRageSphereCDName(session.getRageSphereCDName());
			grlt02mt.setOfficeCDName(session.getOfficeCDName());
			grlt02mt.setTeamCDName(session.getTeamCDName());
			grlt02mt.setClientDate(session.getClientDate());
			
			GRLT02MT grlt02mt_a = grlt02mt.getObject_approval(0);
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(grlt02mt_a.getLastApprYN().equals("Y")) {
				pay02Service.lastApprovalResultBrand_err(grlt02mt);
			}
			else {
				pay02Service.approvalResultBrand_err(grlt02mt);
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
	
	@RequestMapping("/rejectResultBrand_err")
	public ModelAndView rejectResultBrand_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT02MT grlt02mt = new GRLT02MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, grlt02mt);
		
		try {
			grlt02mt.clean();
			grlt02mt.validate(grlt02mt.ACTION_SAVE);
			
			grlt02mt.setEmpID(session.getEmpID());
			grlt02mt.setEmpNm(session.getEmpNm());
			grlt02mt.setEmailAddr(session.getEmailAddr());
			grlt02mt.setRageSphereCDName(session.getRageSphereCDName());
			grlt02mt.setOfficeCDName(session.getOfficeCDName());
			grlt02mt.setTeamCDName(session.getTeamCDName());
			grlt02mt.setClientDate(session.getClientDate());
			
			pay02Service.rejectResultBrand_err(grlt02mt);
			
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

	@RequestMapping("/approvalResultMileage_err")
	public ModelAndView approvalResultMileage_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);
			
			gmil01mt.setEmpID(session.getEmpID());
			gmil01mt.setEmpNm(session.getEmpNm());
			gmil01mt.setEmailAddr(session.getEmailAddr());
			gmil01mt.setRageSphereCDName(session.getRageSphereCDName());
			gmil01mt.setOfficeCDName(session.getOfficeCDName());
			gmil01mt.setTeamCDName(session.getTeamCDName());
			gmil01mt.setClientDate(session.getClientDate());
			
			GMIL01MT gmil01mt_a = gmil01mt.getObject_approval(0);
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gmil01mt_a.getLastApprYN().equals("Y")) {
				pay02Service.lastApprovalResultMileage_err(gmil01mt);
			}
			else {
				pay02Service.approvalResultMileage_err(gmil01mt);
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
	
	@RequestMapping("/rejectResultMileage_err")
	public ModelAndView rejectResultMileage_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);
			
			gmil01mt.setEmpID(session.getEmpID());
			gmil01mt.setEmpNm(session.getEmpNm());
			gmil01mt.setEmailAddr(session.getEmailAddr());
			gmil01mt.setRageSphereCDName(session.getRageSphereCDName());
			gmil01mt.setOfficeCDName(session.getOfficeCDName());
			gmil01mt.setTeamCDName(session.getTeamCDName());
			gmil01mt.setClientDate(session.getClientDate());
			
			pay02Service.rejectResultMileage_err(gmil01mt);
			
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