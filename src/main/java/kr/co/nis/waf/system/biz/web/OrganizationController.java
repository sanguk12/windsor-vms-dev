package kr.co.nis.waf.system.biz.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.ResultView;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.model.OrganizationList;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.biz.service.OrganizationService;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/organization")
public class OrganizationController extends SimpleMultiActionController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private CodeService codeService;

	@Resource
	private OrganizationService organizationService;

	@Resource
	private SimpleService simpleService;

	@RequestMapping("/initOrgList")
	public ModelAndView initOrgList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map params = new HashMap();

		bind(request, params);

		List list = simpleService.queryForList("commonservice.biz.organizationChart.select", params);

		params.put("initAction", "Search");

		ModelAndView mv = new ModelAndView(getViewUrl(request));
		setObjectAll(mv, request, response, params);
		mv.addObject("orgChart", list);

		return mv;
	}

	@RequestMapping("/saveOrganization")
	public ModelAndView saveOrganization(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		OrganizationList organizationList = new OrganizationList();
		Map params = new HashMap();
		Code seqID = new Code();
		ResultMessage resultMsg = new ResultMessage();

		bind(request, organizationList);
		bind(request, params);

		seqID.setCompanyID(organizationList.getCompanyID());
		seqID.setUserID(organizationList.getUserID());
		
		params.put("userID", session.getUserID());

		try {
			String[] orgID = organizationList.getOrgID();
			seqID.setSeqDiv("ORGID");
			for (int i = 0; i < orgID.length; i++) {
				if (orgID[i].equals("")) {
					orgID[i] = (codeService.getSeqID(seqID)).get("seqID").toString();
				}
			}
			organizationList.setOrgID(orgID);

			organizationService.saveOrganization(params, organizationList);

			resultMsg.setCode(resultMsg.RESULT_SUCCESS);
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}

			resultMsg.setCode(resultMsg.RESULT_ERROR);
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			resultMsg.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView(new ResultView());
		mv.addObject("resultMsg", resultMsg);

		return mv;
	}

	@RequestMapping("/modifySessionOrganization")
	public ModelAndView modifySessionOrganization(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map params = new HashMap();
		ResultMessage rm = new ResultMessage();

		bind(request, params);

		if (logger.isDebugEnabled()) {
			logger.debug("OrganizationController.modifySessionOrganization==>\n" + params);
		}

		try {
			if (params.containsKey("companyID") && params.get("companyID") != null) {
				session.setCompanyID(params.get("companyID").toString());
			}
			else {
				new Exception();
			}

			if (params.containsKey("partnerID") && params.get("partnerID") != null) {
				session.setRpartnerID(params.get("partnerID").toString());
			}
			else {
				session.setRpartnerID("");
			}

			Map partner = simpleService.queryForMap("basic.partner.select", params);

			if (partner != null && partner.get("partnerDivCD") != null) {
				session.setPartnerDiv(partner.get("partnerDivCD").toString());
			}

			rm.setCode(rm.RESULT_SUCCESS);
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView(new ResultView());
		mv.addObject("resultMsg", rm);

		return mv;
	}
}