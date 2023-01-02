package com.kia.key.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.key.model.GKEY01MT;
import com.kia.key.service.Key01Service;

@Controller
@RequestMapping("/service/key01")
public class Key01Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Key01Service key01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	/*
	
	@RequestMapping("/saveKeyport")
	public ModelAndView saveKeyport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			if(gkey01mt.getKeyportID().equals("")) {
				String keyportID = "";
				keyportID = key01Service.getKeyportID(gkey01mt);
				gkey01mt.setKeyportID(keyportID);
				key01Service.insertKeyport(gkey01mt);
			}
			else {
				key01Service.updateKeyport(gkey01mt);
			}
			
			rm.setParameters(gkey01mt.getKeyportID());
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
	*/
	
	@RequestMapping("/saveKeymanID")
	public ModelAndView saveKeymanID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		bind(request, seqID);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			if(gkey01mt.getVenueCD().equals("") || gkey01mt.getVenueCD().equals(null)) {
				throw new InputRequiredException("업소를 확인해 주십시오.");
			}
			
			if(gkey01mt.getRequestTpCD().equals("NEW")) {
				if(gkey01mt.getKeymanID().equals("")) {
					//키맨ID채번
					seqID.setSeqDiv("KEYMANID");
					String keymanID = codeService.getSeqIDNoComp(seqID).get("seqID").toString();
					gkey01mt.setKeymanID(keymanID);
					
					//requestSeq채번
					String requestSeq = (String) simpleService.queryForObject("KEY0100106S",gkey01mt);
					gkey01mt.setRequestSeq(requestSeq);
					
					key01Service.addKeymanID(gkey01mt);
				}
				else {
					key01Service.updateKeymanID(gkey01mt);
				}
			}
			else {
				if(gkey01mt.getRequestSeq().equals("")) {
					//requestSeq채번
					String requestSeq = (String) simpleService.queryForObject("KEY0100106S",gkey01mt);
					gkey01mt.setRequestSeq(requestSeq);
					
					key01Service.modifyKeymanID(gkey01mt);
				}
				else {
					key01Service.updateKeymanID(gkey01mt);
				}
			}
			
			rm.setParameters(gkey01mt.getKeymanID());
			rm.setParameters(gkey01mt.getRequestDate());
			rm.setParameters(gkey01mt.getRequestSeq());
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
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
	
	@RequestMapping("/deleteKeymanID")
	public ModelAndView deleteKeymanID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			key01Service.deleteKeymanID(gkey01mt);
			
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
	
	@RequestMapping("/saveKeymanID_m")
	public ModelAndView saveKeymanID_m(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gkey01mt);
		bind(request, seqID);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			if(gkey01mt.getVenueCD().equals("") || gkey01mt.getVenueCD().equals(null)) {
				throw new InputRequiredException("업소를 확인해 주십시오.");
			}
			
			if(gkey01mt.getRequestTpCD().equals("NEW")) {
				if(gkey01mt.getKeymanID().equals("")) {
					//키맨ID채번
					seqID.setSeqDiv("KEYMANID");
					String keymanID = codeService.getSeqIDNoComp(seqID).get("seqID").toString();
					gkey01mt.setKeymanID(keymanID);
					
					//requestSeq채번
					String requestSeq = (String) simpleService.queryForObject("KEY0100106S",gkey01mt);
					gkey01mt.setRequestSeq(requestSeq);
					
					key01Service.addKeymanID_m(gkey01mt);
				}
				else {
					key01Service.updateKeymanID_m(gkey01mt);
				}
			}
			else {
				if(gkey01mt.getRequestSeq().equals("")) {
					//requestSeq채번
					String requestSeq = (String) simpleService.queryForObject("KEY0100106S",gkey01mt);
					gkey01mt.setRequestSeq(requestSeq);
					
					key01Service.modifyKeymanID_m(gkey01mt);
				}
				else {
					key01Service.updateKeymanID_m(gkey01mt);
				}
			}
			
			rm.setParameters(gkey01mt.getKeymanID());
			rm.setParameters(gkey01mt.getRequestDate());
			rm.setParameters(gkey01mt.getRequestSeq());
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
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
	
	@RequestMapping("/deleteKeymanID_m")
	public ModelAndView deleteKeymanID_m(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			key01Service.deleteKeymanID_m(gkey01mt);
			
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
	/*
	@RequestMapping("/requestPayKeyport")
	public ModelAndView requestPayKeyport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			key01Service.requestPayKeyport(gkey01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.requestPay"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.requestPay"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/clearRequestPayKeyport")
	public ModelAndView clearRequestPayKeyport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			key01Service.clearRequestPayKeyport(gkey01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.clearRequestPay"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.clearRequestPay"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/saveKeyportKeyman_add")
	public ModelAndView saveKeyportKeyman_add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			key01Service.saveKeyportKeyman_add(gkey01mt);
			
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
	
	@RequestMapping("/deleteKeyportKeyman_add")
	public ModelAndView deleteKeyportKeyman_add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			key01Service.deleteKeyportKeyman_add(gkey01mt);
			
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
	
	*/
}