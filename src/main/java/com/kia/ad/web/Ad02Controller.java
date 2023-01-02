package com.kia.ad.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kia.ad.model.GAD01MT;
import com.kia.ad.model.GME01DT;
import com.kia.ad.model.GME01MT;
import com.kia.ad.service.Ad02Service;
import com.kia.key.model.GKEY01MT;
import com.kia.pln.model.GPLN01MT;
import com.kia.rlt.model.GRLT01MT;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.common.FileInfo;
import kr.co.nis.waf.common.FileUploadUtil;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.view.SimpleDoc;

@Controller
@RequestMapping("/service/ad02")
public class Ad02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
	@Value("#{appenv['file.prdListUpload']}")
	private String prdListUpload;

	@Resource
	private Ad02Service ad02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	

	@RequestMapping("/downloadFile")
	public ModelAndView downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		parameters.put("fileName", prdListUpload);
		parameters.put("tempFileName", prdListUpload);
		parameters.put("uploadDir", templateFilePath);

		return new ModelAndView("downloadView", parameters);
	}

	@RequestMapping("/approvalResultAD") //승인
	public ModelAndView approvalResultAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			for(int i = 0; i < gad01mt.getSize(); i++) {
				GAD01MT gad01mt_a = gad01mt.getObject_approval(i);
				gad01mt_a.setEmailAddr(session.getEmailAddr());
				gad01mt_a.setEmpNm(session.getEmpNm());
				gad01mt_a.setClientDate(session.getClientDate());
				
				if (gad01mt_a.getApprExpc().equals("2")) {
					gad01mt_a.setApprTpID("000006");
				} else {
					gad01mt_a.setApprTpID("000004");
				}
			
				if(gad01mt_a.getLastApprYN().equals("Y")) {
					ad02Service.lastApprovalResultAD(gad01mt_a);
				}
				else {
					ad02Service.approvalResultAD(gad01mt_a);
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
	
	@RequestMapping("/rejectResultAD") //반려
	public ModelAndView rejectResultVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			for(int i = 0; i < gad01mt.getSize(); i++) {
				GAD01MT gad01mt_a = gad01mt.getObject_reject(i);
				gad01mt_a.setEmailAddr(session.getEmailAddr());
				gad01mt_a.setEmpNm(session.getEmpNm());
				gad01mt_a.setClientDate(session.getClientDate());
				
				if(gad01mt_a.getApprExpc().equals("2")) {
					gad01mt_a.setApprTpID("000006");
				}else {
					gad01mt_a.setApprTpID("000004");
				}
				ad02Service.rejectResultAD(gad01mt_a);
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
	
	@RequestMapping("/finishContractAD") //계약완료
	public ModelAndView finishContractAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);

			ad02Service.finishContractAD(gad01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.finishContract"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.finishContract"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/finishPayAD") //지급완료
	public ModelAndView finishPayAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			ad02Service.finishPayAD(gad01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.finishPay"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.finishPay"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/contractTmpSaveAD") //계약 해지및 수정[임시테이블] 저장 
	public ModelAndView cancelSaveAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			if(gad01mt.getAdChgFlg().equals("Y")){
				gad01mt.setApprTpID("000010");
			} else{
				if(gad01mt.getApprExpc().equals("2")) {
					gad01mt.setApprTpID("000006");
				}else {
					gad01mt.setApprTpID("000004");
				}
			}
			
			if(gad01mt.getAdSeq().length() > 0) {
				ad02Service.tmpModifySupport(gad01mt);
			}else {
				ad02Service.tmpInsertSupport(gad01mt);
			}
			
			rm.setParameters(gad01mt.getAdSupportID());
			rm.setParameters(gad01mt.getAdSeq());
			
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
	
	@RequestMapping("/contractTmpSaveRequiredAD") //계약 해지및 수정[임시테이블] 저장 - 필수광고물만 수정시
	public ModelAndView contractTmpSaveRequiredAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			ad02Service.tmpSaveSupportRequestAD(gad01mt);
			
			rm.setParameters(gad01mt.getAdSupportID());
			rm.setParameters(gad01mt.getAdSeq());
			
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

	@RequestMapping("/requestContractAppResultAD") // 계약 해지및 수정 승인요청 
	public ModelAndView requestContractAppResultAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
	
		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			for(int i = 0; i < gad01mt.getSize(); i++) {
				GAD01MT gad01mt_a = gad01mt.getObject_request(i);
				gad01mt_a.setEmailAddr(session.getEmailAddr());
				gad01mt_a.setEmpNm(session.getEmpNm());
				gad01mt_a.setClientDate(session.getClientDate());
				ad02Service.requestContractAppResultAD(gad01mt_a);
			}

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
	
	@RequestMapping("/clearRequestContractAppResultAD") //계약 해지및 수정 승인요청취소
	public ModelAndView clearRequestContractAppResultAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			ad02Service.clearRequestContractAppResultAD(gad01mt);
			
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
	
	@RequestMapping("/contractApprovalAD") // 계약 해지/수정 승인
	public ModelAndView contractApprovalAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			
			for(int i = 0; i < gad01mt.getSize(); i++) {
				GAD01MT gad01mt_a = gad01mt.getObject_approval(i);
				gad01mt_a.setEmailAddr(session.getEmailAddr());
				gad01mt_a.setEmpNm(session.getEmpNm());
				gad01mt_a.setClientDate(session.getClientDate());
				
				if(gad01mt_a.getAdChgFlg().equals("Y")){
					gad01mt_a.setApprTpID("000010");
				} else{
					if(gad01mt_a.getApprExpc().equals("2")) {
						gad01mt_a.setApprTpID("000006");
					}else {
						gad01mt_a.setApprTpID("000004");
					}
				}
				
				if(gad01mt_a.getLastApprYN().equals("Y")) {
					ad02Service.lastContractApprovalAD(gad01mt_a);
				}
				else {
					ad02Service.contractApprovalAD(gad01mt_a);
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
	
	@RequestMapping("/contractRejectAD") // 계약 해지및 수정 반려
	public ModelAndView contractRejectAD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			
			for(int i = 0; i < gad01mt.getSize(); i++) {
				GAD01MT gad01mt_a = gad01mt.getObject_reject(i);
				gad01mt_a.setEmailAddr(session.getEmailAddr());
				gad01mt_a.setEmpNm(session.getEmpNm());
				gad01mt_a.setClientDate(session.getClientDate());
				
				if(gad01mt_a.getAdChgFlg().equals("Y")){
					gad01mt_a.setApprTpID("000010");
				} else{
					if(gad01mt_a.getApprExpc().equals("2")) {
						gad01mt_a.setApprTpID("000006");
					}else {
						gad01mt_a.setApprTpID("000004");
					}
				}
				ad02Service.contractRejectAD(gad01mt_a);
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
	
	@RequestMapping("/afterDateDelay") // 계약 해지및 수정 반려
	public ModelAndView afterDateDelay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAD01MT gad01mt = new GAD01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gad01mt);
		
		try {
			gad01mt.clean();
			gad01mt.validate(gad01mt.ACTION_SAVE);
			gad01mt.setClientDate(session.getClientDate());
			ad02Service.afterDateDelay(gad01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("AD02007A.msg3"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("AD02007A.msg4"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
}