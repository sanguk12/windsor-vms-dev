package com.kia.mdm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.mdm.model.GPRD01MT;
import com.kia.mdm.model.GPRD02MTs;
import com.kia.mdm.service.Mdm03Service;

@Controller
@RequestMapping("/service/mdm03")
public class Mdm03Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Mdm03Service mdm03Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/savePrdinfo")
	public ModelAndView savePrdinfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		GPRD01MT gprd01mt = new GPRD01MT();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, gprd01mt);
		bind(request, seqID);

		try {
			gprd01mt.clean();
			
			if(gprd01mt.getPrdCD() == null || gprd01mt.getPrdCD() == "") {
				gprd01mt.validate(gprd01mt.ACTION_ADD);
				
				seqID.setSeqDiv("PRDCD");
				String prdCD = codeService.getSeqIDNoComp(seqID).get("seqID").toString();
				gprd01mt.setPrdCD(prdCD);
				
//				//제품코드채번
//				String prdCD = (String) simpleService.queryForObject("MDM0300102S",gprd01mt);
//				gprd01mt.setPrdCD(prdCD);
				
				mdm03Service.addPrdinfo(gprd01mt);
			}
			else {
				gprd01mt.validate(gprd01mt.ACTION_MODIFY);
				mdm03Service.modifyPrdinfo(gprd01mt);
			}

			rm.setParameters(gprd01mt.getPrdCD());
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
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
	
	@RequestMapping("/savePrdGuidAmt")
	public ModelAndView savePrdGuidAmt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		GPRD02MTs gprd02mts = new GPRD02MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gprd02mts);
		
		try {
			gprd02mts.clean();
			
			mdm03Service.addPrdGuidAmt(gprd02mts);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
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