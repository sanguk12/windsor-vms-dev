package com.kia.ltc.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.ltc.model.GLTC01MT;
import com.kia.ltc.service.Ltc01Service;

@Controller
@RequestMapping("/service/ltc01")
public class Ltc01Controller extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	private Ltc01Service ltc01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/saveSupport")
	public ModelAndView saveSupport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GLTC01MT gltc01mt = new GLTC01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gltc01mt);
		
		try {
			gltc01mt.clean();
			gltc01mt.validate(gltc01mt.ACTION_SAVE);
			
			if(gltc01mt.getSupportID().equals("")) {
				gltc01mt.setSupportID(ltc01Service.insertSupport(gltc01mt));
			}
			else {
				ltc01Service.updateSupport(gltc01mt);
			}
			
			rm.setParameters(gltc01mt.getSupportID());
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
	
	@RequestMapping("/deleteSupport")
	public ModelAndView deleteSupport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GLTC01MT gltc01mt = new GLTC01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gltc01mt);
		try {
			gltc01mt.clean();
			gltc01mt.validate(gltc01mt.ACTION_SAVE);
		
			ltc01Service.deleteSupport(gltc01mt);
		
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/requestApp")
	public ModelAndView requestApp (HttpServletRequest request, HttpServletResponse response) throws Exception {
		GLTC01MT gltc01mt = new GLTC01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gltc01mt);
		
		try{
			gltc01mt.clean();
			gltc01mt.validate(gltc01mt.ACTION_SAVE);
			
			ltc01Service.requestApp(gltc01mt);
			
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
	
	@RequestMapping("/clearRequestApp")
	public ModelAndView clearRequestApp (HttpServletRequest request, HttpServletResponse response) throws Exception {
		GLTC01MT gltc01mt = new GLTC01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gltc01mt);
		
		try{
			gltc01mt.clean();
			gltc01mt.validate(gltc01mt.ACTION_SAVE);
			
			ltc01Service.clearRequestApp(gltc01mt);
			
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
	
	@RequestMapping("/contractCancel")
	public ModelAndView contractCancel (HttpServletRequest request, HttpServletResponse response) throws Exception {
		GLTC01MT gltc01mt = new GLTC01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gltc01mt);
		
		try{
			gltc01mt.validate(gltc01mt.ACTION_SAVE);
			
			ltc01Service.contractCancel(gltc01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.contractCancel"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.contractCancel"));
			rm.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
		
		return mv;
	}
	
	@RequestMapping("/updatePlanQty")
	public ModelAndView updatePlanQty (HttpServletRequest request, HttpServletResponse response) throws Exception {
		ResultMessage rm = new ResultMessage();
		String venueCD = request.getParameter("venueCD").toString();
		String[] prdCDs = request.getParameterValues("prdCDs");
		String[] planQtys = request.getParameterValues("planQtys");
		String[] eventYMs = request.getParameterValues("eventYMs");
		
		Map<String,String[]> plnParam = new HashMap();
		
		plnParam.put("prdCDs", prdCDs);
		plnParam.put("planQtys", planQtys);
		plnParam.put("eventYMs", eventYMs);
		
		
		try{
			ltc01Service.updatePlanQty(venueCD,plnParam);
			
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
}
