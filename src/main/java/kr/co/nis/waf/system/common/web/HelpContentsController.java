package kr.co.nis.waf.system.common.web;

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
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.HelpContents;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/helpContents")
public class HelpContentsController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleService simpleService;
	
	@Resource
	private CodeService codeService;
	
	/*
	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}

	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}
	*/

	@RequestMapping("/initHelpContentsList")
	public ModelAndView initHelpContentsList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map params = new HashMap();

		bind(request, params);

		List list = simpleService.queryForList("system.helpContentsChart.select", params);

		params.put("initAction", "Search");

		ModelAndView mv = new ModelAndView(getViewUrl(request));
		setObjectAll(mv, request, response, params);
		mv.addObject("helpContentsChart", list);

		return mv;
	}
	
	@RequestMapping("/removeHelpContents")
	public ModelAndView removeHelpContents(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HelpContents helpContents = new HelpContents();
		ResultMessage rm = new ResultMessage();

		bind(request, helpContents);

		helpContents.setActiveFlg("D");
		
		try {
			simpleService.update("system.helpContents.delete", helpContents);

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

		ModelAndView mv = new ModelAndView(new ResultView());
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/saveHelpContents")
	public ModelAndView saveHelpContents(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		HelpContents helpContents = new HelpContents();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, helpContents);
		bind(request, seqID);

		helpContents.setUserID(session.getUserID());
		helpContents.setActiveFlg("U");
		try {
			if (helpContents.getHelpContentsID().equals("")) {
				seqID.setSeqDiv("HELPCONTENTSID");
				helpContents.setHelpContentsID((codeService.getSeqID(seqID)).get("seqID").toString());
				simpleService.insert("system.helpContents.insert", helpContents);
			}
			else {
				simpleService.update("system.helpContents.update", helpContents);
			}

			rm.setParameters(helpContents.getHelpContentsID());
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
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

		ModelAndView mv = new ModelAndView(new ResultView());
		mv.addObject("resultMsg", rm);

		return mv;
	}


}
