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
import com.kia.pay.service.Pay01Service;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;

@Controller
@RequestMapping("/service/pay01")
public class Pay01Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Pay01Service pay01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/saveResultWriteVenue_err")
	public ModelAndView saveResultWriteVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			pay01Service.saveResultWriteVenue_err(grlt01mt);
			
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
	
	@RequestMapping("/requestAppResultVenue_err")
	public ModelAndView requestAppResultVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pay01Service.requestAppResultVenue_err(grlt01mt);
			
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
	
	@RequestMapping("/clearRequestAppResultVenue_err")
	public ModelAndView clearRequestAppResultVenue_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pay01Service.clearRequestAppResultVenue_err(grlt01mt);
			
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
	
	@RequestMapping("/saveResultWriteBrand_err")
	public ModelAndView saveResultWriteBrand_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT02MT grlt02mt = new GRLT02MT();
		ResultMessage rm = new ResultMessage();

		String check_yn ="";
		String message ="";
		
		String prdCD ="";
		String venueCD ="";
		String prdNM ="";
		String venueNM ="";
		
		bind(request, grlt02mt);
		
		try {
			grlt02mt.clean();
			grlt02mt.validate(grlt02mt.ACTION_SAVE);
			
			for(int i=0; i<grlt02mt.getSize_prd(); i++) {
				
				GRLT02MT grlt02mt_a = grlt02mt.getObject_prd(i);
				
				
				 
				if((Integer.parseInt(grlt02mt_a.getResultQty())*Integer.parseInt(grlt02mt_a.getResultUnitAmt())) 
						!=Integer.parseInt(grlt02mt_a.getPayAmt()))
				{
					check_yn ="Y";
					
					message =grlt02mt_a.getVenueCD()+" "+grlt02mt_a.getVenueNM()+" "+grlt02mt_a.getPrdNM()+" 지급금액 "+grlt02mt_a.getPayAmt()+"을 다시 확인해주세요!";
					
					venueCD =grlt02mt_a.getVenueCD();
					prdCD = grlt02mt_a.getPrdCD();
					
					throw new Exception();  
				}
				
				
			}
			
			pay01Service.saveResultWriteBrand_err(grlt02mt);
			
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
			
			if(check_yn.equals("Y")){
				rm.setMessage(message);
				rm.setSystemMessage(venueCD+prdCD);
			}else {
				rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			}
			
			//rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/requestAppResultBrand_err")
	public ModelAndView requestAppResultBrand_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pay01Service.requestAppResultBrand_err(grlt02mt);
			
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
	
	@RequestMapping("/clearRequestAppResultBrand_err")
	public ModelAndView clearRequestAppResultBrand_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pay01Service.clearRequestAppResultBrand_err(grlt02mt);
			
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

	@RequestMapping("/saveResultWriteMileage_err")
	public ModelAndView saveResultWriteMileage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GMIL01MT gmil01mt = new GMIL01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gmil01mt);
		
		try {
			gmil01mt.clean();
			gmil01mt.validate(gmil01mt.ACTION_SAVE);
			
			pay01Service.saveResultWriteMileage_err(gmil01mt);
			
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
	
	@RequestMapping("/requestAppResultMileage_err")
	public ModelAndView requestAppResultMileage(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pay01Service.requestAppResultMileage_err(gmil01mt);
			
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
	
	@RequestMapping("/clearRequestAppResultMileage_err")
	public ModelAndView clearRequestAppResultMileage_err(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			pay01Service.clearRequestAppResultMileage_err(gmil01mt);
			
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