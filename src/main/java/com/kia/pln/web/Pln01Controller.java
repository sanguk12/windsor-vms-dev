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
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02DT;
import com.kia.pln.model.GPLN02DTs;
import com.kia.pln.model.GPLN02MT;
import com.kia.pln.model.GPLN02MTs;
import com.kia.pln.service.Pln01Service;

@Controller
@RequestMapping("/service/pln01")
public class Pln01Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Pln01Service pln01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/savePlanVenue")
	public ModelAndView savePlanVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			pln01Service.savePlanVenue(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/copyBefMonPlanVenue")
	public ModelAndView copyBefMonPlanVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			pln01Service.copyBefMonPlanVenue(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.copy"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.copy"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/savePlanVenueWrite")
	public ModelAndView savePlanWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			pln01Service.savePlanVenueWrite(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/copyBefMonPlanVenueWrite")
	public ModelAndView copyBefMonPlanWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN01MT gpln01mt = new GPLN01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln01mt);
		
		try {
			gpln01mt.clean();
			gpln01mt.validate(gpln01mt.ACTION_SAVE);
			
			pln01Service.copyBefMonPlanVenueWrite(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.copy"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.copy"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/requestAppPlanVenue")
	public ModelAndView requestAppPlanVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pln01Service.requestAppPlanVenue(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.requestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.requestAppr"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/clearRequestAppPlanVenue")
	public ModelAndView clearRequestAppPlanVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pln01Service.clearRequestAppPlanVenue(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.clearRequestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.clearRequestAppr"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/savePlanBrand")
	public ModelAndView savePlanBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN02MTs gpln02mts = new GPLN02MTs();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln02mts);
		
		try {
			gpln02mts.clean();
			gpln02mts.validate(gpln02mts.ACTION_SAVE);
			
			pln01Service.savePlanBrand(gpln02mts);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/copyBefMonPlanBrand")
	public ModelAndView copyBefMonPlanBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN02MT gpln02mt = new GPLN02MT();
		GPLN02DT gpln02dt = new GPLN02DT();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln02mt);
		bind(request, gpln02dt);
		
		try {
			gpln02dt.clean();
			gpln02dt.validate(gpln02dt.ACTION_SAVE);
			
			pln01Service.copyBefMonPlanBrand(gpln02mt, gpln02dt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.copy"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.copy"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/savePlanBrandWrite")
	public ModelAndView savePlanBrandWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN02DTs gpln02dts = new GPLN02DTs();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln02dts);
		
		try {
			gpln02dts.clean();
			gpln02dts.validate(gpln02dts.ACTION_SAVE);
			
			pln01Service.savePlanBrandWrite(gpln02dts);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (DuplicateKeyException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("PLN01005A.msg7"));
			rm.setSystemMessage(e.toString());
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
	
	@RequestMapping("/copyBefMonPlanBrandWrite")
	public ModelAndView copyBefMonPlanBrandWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GPLN02DT gpln02dt = new GPLN02DT();
		ResultMessage rm = new ResultMessage();

		bind(request, gpln02dt);
		
		try {
			gpln02dt.clean();
			gpln02dt.validate(gpln02dt.ACTION_SAVE);
			
			pln01Service.copyBefMonPlanBrandWrite(gpln02dt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.copy"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.copy"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/requestAppPlanBrand")
	public ModelAndView requestAppPlanBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pln01Service.requestAppPlanBrand(gpln02mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.requestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.requestAppr"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/clearRequestAppPlanBrand")
	public ModelAndView clearRequestAppPlanBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pln01Service.clearRequestAppPlanBrand(gpln02mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.clearRequestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.clearRequestAppr"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/requestAppPlan")
	public ModelAndView requestAppPlan(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			
			pln01Service.requestAppPlan(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.requestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.requestAppr"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/clearRequestAppPlan")
	public ModelAndView clearRequestAppPlan(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pln01Service.clearRequestAppPlan(gpln01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.clearRequestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.clearRequestAppr"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
}