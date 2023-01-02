package com.kia.key.web;

import java.util.ArrayList;
import java.util.HashMap;

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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.key.model.GKEY01MT;
import com.kia.key.service.Key03Service;

@Controller
@RequestMapping("/service/key03")
public class Key03Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Key03Service key03Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@Value("#{appenv['app.SMS.Callback']}")
	private String SMS_Callback;
	
	@Value("#{appenv['app.SMS.URL']}")
	private String smsURL;
	
	@RequestMapping("/completeAccreKeymanID")
	public ModelAndView completeAccreKeymanID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			gkey01mt.setEmpID(session.getEmpID());
			gkey01mt.setEmpNm(session.getEmpNm());

			key03Service.completeAccreKeymanID(gkey01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.completeAccre"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.completeAccre"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/errorAccreKeymanID")
	public ModelAndView errorAccreKeymanID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			gkey01mt.setClientDate(session.getClientDate());
			
			key03Service.errorAccreKeymanID(gkey01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.errorAccre"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.errorAccre"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/saveKeymanActiveYN")
	public ModelAndView saveKeymanActiveYN(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			key03Service.saveKeymanActiveYN(gkey01mt);
			
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
	
	@RequestMapping("/updateKeymanDocComp")
	public ModelAndView updateKeymanDocComp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			gkey01mt.setEmpID(session.getUserID());

			key03Service.updateKeymanDocComp(gkey01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.update"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.completeAccre"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/updateKeymanDocMngFl")
	public ModelAndView updateKeymanDocMngFl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY01MT gkey01mt = new GKEY01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gkey01mt);
		
		try {
			gkey01mt.clean();
			gkey01mt.validate(gkey01mt.ACTION_SAVE);
			
			gkey01mt.setEmpID(session.getUserID());

			key03Service.updateKeymanDocMngFl(gkey01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.update"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.completeAccre"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/smsSend")
	public ModelAndView smsSend(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//TODO : SMS 발송 메시지 및 URL 보내기
		ArrayList<HashMap<String,String>> smsList = new ArrayList<HashMap<String,String>>();
		String[] appIDs = request.getParameterValues("appIDs");
		String[] phoneNos = request.getParameterValues("phoneNos");
		String[] counts = request.getParameterValues("counts");
		ResultMessage rm = new ResultMessage();
		
		try{
			String text = getMessageSourceAccessor().getMessage("KEY03004A.SMS.Message");
			
			for(int i=0;i<phoneNos.length;i++){
				HashMap<String, String> map = new HashMap<String, String>();
				
				map.put("appID", appIDs[i]);
				map.put("phoneNo", phoneNos[i]);
				map.put("callback", SMS_Callback);
				map.put("text", text + "["+ counts[i] +"]"+ "\n" + smsURL);
				
				smsList.add(map);
			}
			
			key03Service.sendSMS(smsList);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.smsSend"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.smsSend"));
			rm.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
		
		return mv;
	}
	
}