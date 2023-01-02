package com.kia.mdm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.mdm.model.GVEN02MT;
import com.kia.mdm.model.GVEN03MT;
import com.kia.mdm.service.Mdm07Service;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

@Controller
@RequestMapping("/service/mdm07")
public class Mdm07Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
	@Value("#{appenv['file.temporaryVenueUpload']}")
	private String venueUploadFile;

	@Resource
	private Mdm07Service mdm07Service;
	
	@Resource	
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	//requestApprRmTmpVenue
	@RequestMapping("/saveRmTmpVenue")
	public ModelAndView saveTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			mdm07Service.saveRmTmpVenue(gven02mt);
			
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
	
	@RequestMapping("/requestApprRmTmpVenue") //승인요청
	public ModelAndView requestApprRmTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);

			mdm07Service.requestApprRmTmpVenue(gven02mt);
			
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
	
	@RequestMapping("/clearRequestApprRmTmpVenue") //승인요청취소
	public ModelAndView clearRequestApprRmTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			mdm07Service.clearRequestApprRmTmpVenue(gven02mt);
			
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
	
	@RequestMapping("/approvalRmTmpVenue") //승인
	public ModelAndView approvalRmTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			GVEN02MT gven02mt_a = gven02mt.getObject_approval(0);
			
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gven02mt_a.getLastApprYN().equals("Y")) {
				mdm07Service.lastApprovalRmTmpVenue(gven02mt);
			}
			else {
				mdm07Service.approvalRmTmpVenue(gven02mt);
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
	
	@RequestMapping("/rejectRmTmpVenue") //반려
	public ModelAndView rejectRmTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			gven02mt.setEmpID(session.getEmpID());
			gven02mt.setEmpNm(session.getEmpNm());
			gven02mt.setEmailAddr(session.getEmailAddr());
			gven02mt.setClientDate(session.getClientDate());
			
			mdm07Service.rejectRmTmpVenue(gven02mt);
			
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
	
	@RequestMapping("/updatePrintYN") 
	public ModelAndView updatePrintYN(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			mdm07Service.updatePrintYN(gven02mt);
			
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