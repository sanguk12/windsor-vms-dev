package com.kia.rlt.web;

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

import org.apache.commons.beanutils.converters.IntegerArrayConverter;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.pln.model.GPLN01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;
import com.kia.rlt.service.Rlt01Service;

@Controller
@RequestMapping("/service/rlt01")
public class Rlt01Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Rlt01Service rlt01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/resultCreationVenue")
	public ModelAndView resultCreationVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			rlt01Service.resultCreationVenue(grlt01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.resultCreation"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.resultCreation"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/saveResultKeymanVenue")
	public ModelAndView saveResultKeymanVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			rlt01Service.saveResultKeymanVenue(grlt01mt);
			
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
	
	@RequestMapping("/saveResultWriteVenue")
	public ModelAndView saveResultWriteVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			rlt01Service.saveResultWriteVenue(grlt01mt);
			
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
	
	@RequestMapping("/requestAppResultVenue")
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
			rlt01Service.requestAppResultVenue(grlt01mt);
			
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
	
	@RequestMapping("/clearRequestAppResultVenue")
	public ModelAndView clearRequestAppResultVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			rlt01Service.clearRequestAppResultVenue(grlt01mt);
			
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
	
	@RequestMapping("/resultCreationBrand")
	public ModelAndView resultCreationBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT02MT grlt02mt = new GRLT02MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt02mt);
		
		try {
			grlt02mt.clean();
			grlt02mt.validate(grlt02mt.ACTION_SAVE);
			
			rlt01Service.resultCreationBrand(grlt02mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.resultCreation"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.resultCreation"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/saveResultWriteBrand")
	public ModelAndView saveResultWriteBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			
			rlt01Service.saveResultWriteBrand(grlt02mt);
			
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
			
			if(check_yn.equals("Y"))
				{rm.setMessage(message);
			
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
	
	@RequestMapping("/requestAppResultBrand")
	public ModelAndView requestAppResultBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			rlt01Service.requestAppResultBrand(grlt02mt);
			
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
	
	@RequestMapping("/clearRequestAppResultBrand")
	public ModelAndView clearRequestAppResultBrand(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			rlt01Service.clearRequestAppResultBrand(grlt02mt);
			
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
	
	@RequestMapping("/requestAppResult")
	public ModelAndView requestAppResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			
			rlt01Service.requestAppResult(grlt01mt);
			
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
	
	@RequestMapping("/clearRequestAppResult")
	public ModelAndView clearRequestAppResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			rlt01Service.clearRequestAppResult(grlt01mt);
			
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