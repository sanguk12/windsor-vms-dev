package com.kia.ltc.web;

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
import com.kia.ltc.service.Ltc02Service;

@Controller
@RequestMapping("/service/ltc02")
public class Ltc02Controller extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	private Ltc02Service ltc02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/approvalSupport")
	public ModelAndView approvalSupport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GLTC01MT gltc01mt = new GLTC01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gltc01mt);
		
		try {
			if(gltc01mt.getApprStateCD().equals("50")){
				if(gltc01mt.getLastApprYN().equals("Y")) {
					ltc02Service.lastApprovalContractCancel(gltc01mt);
				}
				else {
					ltc02Service.approvalContractCancel(gltc01mt);
				}
			}else{
				if(gltc01mt.getLastApprYN().equals("Y")) {
					ltc02Service.lastApprovalSupport(gltc01mt);
				}
				else {
					ltc02Service.approvalSupport(gltc01mt);
				}
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
	
	@RequestMapping("/rejectSupport")
	public ModelAndView rejectSupport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GLTC01MT gltc01mt = new GLTC01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gltc01mt);
		
		try {
			if(gltc01mt.getApprStateCD().equals("50")){
				ltc02Service.rejectContractCancel(gltc01mt);
			}else{
				ltc02Service.rejectSupport(gltc01mt);
			}
			
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
