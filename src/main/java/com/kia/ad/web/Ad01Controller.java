package com.kia.ad.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.ad.model.GAD01MT;
import com.kia.ad.service.Ad01Service;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

@Controller
@RequestMapping("/service/ad01")
public class Ad01Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
	@Value("#{appenv['file.prdListUpload']}")
	private String prdListUpload;

	@Resource
	private Ad01Service ad01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
		
	@RequestMapping("/requestAppResultAD") //승인요청
	public ModelAndView requestAppResultAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
	
		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			gad01mt.setEmailAddr(session.getEmailAddr());
			gad01mt.setEmpNm(session.getEmpNm());
			gad01mt.setClientDate(session.getClientDate());
			ad01Service.requestAppResultAD(gad01mt);
			
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
	
	@RequestMapping("/clearRequestAppResultAD") //승인요청취소
	public ModelAndView clearRequestAppResultAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			ad01Service.clearRequestAppResultAD(gad01mt);
			
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
	
	@RequestMapping("/saveAD")
	public ModelAndView saveAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			if(gad01mt.getAdSupportID().equals("")) {
				gad01mt.setAdSupportID(ad01Service.insertSupport(gad01mt));
			}
			else {
				ad01Service.updateSupport(gad01mt);
			}
			
			rm.setParameters(gad01mt.getAdSupportID());
			
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