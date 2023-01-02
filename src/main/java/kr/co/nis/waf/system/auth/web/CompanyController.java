package kr.co.nis.waf.system.auth.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.model.Company;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/company")
public class CompanyController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;

	/*
	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}
	
	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}
	*/

	@RequestMapping("/saveCompany")
	public ModelAndView saveCompany(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Company company = new Company();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, company);
		bind(request, seqID);
		
		try {
			company.validate(company.ACTION_SAVE);
			company.setActiveFlg("U");

			if (company.getCompanyID().equals("")) {
				seqID.setSeqDiv("COMPANYID");
				company.setCompanyID((codeService.getSeqID(seqID)).get("seqID").toString());
				simpleService.insert("commonservice.auth.company.insert", company);
			}
			else {
				simpleService.update("commonservice.auth.company.update", company);
			}
			
			rm.setParameters(company.getCompanyID());
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
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

	@RequestMapping("/removeCompany")
	public ModelAndView removeCompany(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Company company = new Company();
		ResultMessage rm = new ResultMessage();

		bind(request, company);
		
		try {
			company.setActiveFlg("D");
			
			simpleService.update("commonservice.auth.company.delete", company);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
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
}