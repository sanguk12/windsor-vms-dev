package com.kia.key.web;

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

import com.kia.key.model.GKEY01MT;
import com.kia.key.service.Key02Service;

@Controller
@RequestMapping("/service/key02")
public class Key02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Key02Service key02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/approvalKeymanID")
	public ModelAndView approvalKeymanID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			gkey01mt.setEmpID(session.getEmpID());
			gkey01mt.setEmpNm(session.getEmpNm());
			gkey01mt.setClientDate(session.getClientDate());
			
			GKEY01MT gkey01mt_a = gkey01mt.getObject_approval(0);
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gkey01mt_a.getLastApprYN().equals("Y")) {
				key02Service.lastApprovalKeymanID(gkey01mt);
			}
			else {
				key02Service.approvalKeymanID(gkey01mt);
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
	
	@RequestMapping("/rejectKeymanID")
	public ModelAndView rejectKeymanID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			gkey01mt.setEmpID(session.getEmpID());
			gkey01mt.setEmpNm(session.getEmpNm());
			gkey01mt.setEmailAddr(session.getEmailAddr());
			gkey01mt.setClientDate(session.getClientDate());
			
			key02Service.rejectKeymanID(gkey01mt);
			
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