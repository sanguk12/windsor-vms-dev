package kr.co.nis.waf.system.cms.web;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.cms.model.MenuConstruct;
import kr.co.nis.waf.system.cms.service.MenuConstructService;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/menuConstruct")
public class MenuConstructController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Value("#{appenv['app.system.version']}")
	private String systemVersion;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private MenuConstructService menuConstructService;
	
	@Resource
	private SimpleService simpleService;
	
	long time = 0;
	SimpleDateFormat dayTime = null;
	String strDt = null;
	String strDtOld = "";

	@RequestMapping("/copyMenuConstruct")
	public ModelAndView copyMenuConstruct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map params = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, params);
		bind(request, menuConstruct);
		bind(request, seqID);
		
		SessionManager sm = new SessionManager(request, response);
		menuConstruct.setUserID(sm.getUserID());
		
		try {
			seqID.setSeqDiv("MNUCONSTRUCTID");
			menuConstruct.setCopyMenuConstructID(((Map)codeService.getSeqID(seqID)).get("seqID").toString());
			menuConstructService.copyMenuConstruct(menuConstruct);
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.copy"));
			
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				e.printStackTrace();
			}
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.copy"));
		}
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/deleteListMenuConstruct")
	public ModelAndView deleteListMenuConstruct(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav;
		Map param = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		bind(request, menuConstruct);
		try {
			if (logger.isDebugEnabled()) {
				logger.debug(menuConstruct);
			}

			menuConstructService.deleteMenuConstruct(menuConstruct);
			mav = new ModelAndView(super.getViewUrl(request));
			//F_MenuConstruct
			mav.addObject("menuConstructList", simpleService.queryForList("CMP0100703S", menuConstruct));
			param.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			param.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}

		bind(request, param);
		setObjectAll(mav, request, response, param);
		return mav;
	}

	@RequestMapping("/deleteListMenuConstructGroup")
	public ModelAndView deleteListMenuConstructGroup(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();

		bind(request, menuConstruct);
		bind(request, content);

		try {

			menuConstructService.deleteMenuConstructGroup(menuConstruct);

			mav = new ModelAndView(super.getViewUrl(request));
			//F_MenuConstructGroup
			mav.addObject("menuConstructGroupList", simpleService.queryForList("CMP0100704S", menuConstruct));
			content.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}

		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/deleteMenuConstruct")
	public ModelAndView deleteMenuConstruct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();

		bind(request, menuConstruct);
		try {
			if (logger.isDebugEnabled()) {
				logger.debug(menuConstruct);
			}
			menuConstructService.deleteMenuConstruct(menuConstruct);
			content.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/deleteMenuConstructGroup")
	public ModelAndView deleteMenuConstructGroup(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();

		bind(request, menuConstruct);
		bind(request, content);
		menuConstruct.setMnuGrpID(request.getParameter("mnuGrpID2"));
		try {
			if (logger.isDebugEnabled()) {
				logger.debug(menuConstruct);
			}
			menuConstructService.deleteMenuConstructGroup(menuConstruct);
			content.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/detailMenuConstruct")
	public ModelAndView detailMenuConstruct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		Code seqID = new Code();

		bind(request, menuConstruct);
		bind(request, seqID);
		
		if (menuConstruct.getMnuConstructID() != null && !menuConstruct.getMnuConstructID().equals("")) {
			//F_MenuConstruct
			content = simpleService.queryForMap("CMP0100705S", menuConstruct);
			content.put("saveType", "update"); 
		}
		else {
			seqID.setSeqDiv("MNUCONSTRUCTID");
			content.put("mnuConstructID", codeService.getSeqID(seqID).get("seqID"));
			content.put("saveType", "insert"); 
		}
		bind(request, content);
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/detailMenuConstructGroup")
	public ModelAndView detailMenuConstructGroup(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();

		bind(request, menuConstruct);
		menuConstruct.setMnuGrpID(request.getParameter("mnuGrpID2"));
		mav = new ModelAndView(super.getViewUrl(request));

		if (request.getParameter("mnuGrpID2") != null) {
			//F_MenuConstructGroup
			content = simpleService.queryForMap("CMP0100706S", menuConstruct);
			content.put("saveType", "update");
		}
		else {
			content.put("saveType", "insert");
		}

		bind(request, content);
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/init")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map param = new HashMap();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, param);

		MenuConstruct menuConstruct = new MenuConstruct();
		menuConstruct.setCompanyID(session.getCompanyID());
		menuConstruct.setMnuConstructID(StringUtil.nullToBlank(request.getParameter("mnuConstructID"), ""));
		//F_MenuConstruct
		mav.addObject("menuConstructTreeView", simpleService.queryForList("CMP0100707S", menuConstruct));
		setObjectAll(mav, request, response, param);
		return mav;
	}

	@RequestMapping("/initGroup")
	public ModelAndView initGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map content = new HashMap();
		bind(request, content);
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/insertMenuConstruct")
	public ModelAndView insertMenuConstruct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		SessionManager session = new SessionManager(request, response);

		bind(request, menuConstruct);
		bind(request, content);
		menuConstruct.setRegID(session.getUserID());

		try {
			//F_MenuConstruct
			simpleService.insert("CMP0100708I", menuConstruct);
			//F_MenuConstruct
			content = simpleService.queryForMap("CMP0100705S", menuConstruct);
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/insertMenuConstructGroup")
	public ModelAndView insertMenuConstructGroup(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		SessionManager session = new SessionManager(request, response);

		bind(request, menuConstruct);
		menuConstruct.setMnuGrpID(request.getParameter("mnuGrpID2"));
		menuConstruct.setRegID(session.getUserID());

		try {
			//F_MenuConstructGroup
			simpleService.insert("CMP0100709I", menuConstruct);
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		bind(request, content);
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/listMenuConstruct")
	public ModelAndView listMenuConstruct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map param = new HashMap();
		bind(request, param);

		if (logger.isDebugEnabled()) {
			logger.debug(param);
		}

		setObjectAll(mav, request, response, param);
		return mav;
	}

	@RequestMapping("/listMenuConstructGroup")
	public ModelAndView listMenuConstructGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();

		bind(request, menuConstruct);
		bind(request, content);
		//F_Program
		mav.addObject("disagreeProgramList", simpleService.queryForList("CMP0100710S", menuConstruct));
		//F_MenuConstructDetail
		mav.addObject("agreeProgramList", simpleService.queryForList("CMP0100711S", menuConstruct));
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/listMenuConstructGroupProgram")
	public ModelAndView listMenuConstructGroupProgram(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();

		bind(request, menuConstruct);
		bind(request, content);

		content.put("codeDiv","USETYPE1CD");
		
		mav = new ModelAndView(super.getViewUrl(request));
		mav.addObject("funcList", super.getFunctionList(request));
		mav.addObject("useTypeCD", simpleService.queryForList("SYS0001S", content));
		//F_Program
		mav.addObject("disagreeProgramList", simpleService.queryForList("CMP0100710S", menuConstruct));
		//F_MenuConstructDetail
		mav.addObject("agreeProgramList", simpleService.queryForList("CMP0100711S", menuConstruct));
		mav.addObject("paramGroupProgram", content);
		return mav;
	}

	@RequestMapping("/saveMenuConstructGroupProgram")
	public ModelAndView saveMenuConstructGroupProgram(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		Code code = new Code();
		SessionManager session = new SessionManager(request, response);

		bind(request, menuConstruct);
		bind(request, content);
		
		menuConstruct.setMnuGrpID(request.getParameter("pmnuGrpID"));
		menuConstruct.setRegID(session.getUserID());

		try {
			
			menuConstructService.saveMenuConstructProgram(menuConstruct);
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			
			content.put("codeDiv","USETYPE1CD");
			
			mav = new ModelAndView(super.getViewUrl(request));
			mav.addObject("useTypeCD", simpleService.queryForList("SYS0001S", content));
			//F_Program
			mav.addObject("disagreeProgramList", simpleService.queryForList("CMP0100710S", menuConstruct));
			//F_MenuConstructDetail
			mav.addObject("agreeProgramList", simpleService.queryForList("CMP0100711S", menuConstruct));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}

		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/searchMenuTree")
	public ModelAndView searchMenuTree(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map params = new HashMap();
		SessionManager session = new SessionManager(request, response);

		bind(request, params);
		
//		if (logger.isDebugEnabled()) {
//			logger.debug("Runtime.getRuntime().freeMemory 111 : "+Runtime.getRuntime().freeMemory());
//		} 
//		
//		time = System.currentTimeMillis();
//		dayTime = new SimpleDateFormat("yyyy-MM-dd");
//		strDt = dayTime.format(new Date(time));
//		if("".equals(strDtOld) || !strDtOld.equals(strDt)){
//			Runtime.getRuntime().gc();
//			Runtime.getRuntime().runFinalization();
//			if (logger.isDebugEnabled()) {
//				logger.debug("Runtime.getRuntime().freeMemory 222 : "+Runtime.getRuntime().freeMemory());
//			}
//			strDtOld = strDt;
//		}
		
//		Runtime.getRuntime().gc();
//		Runtime.getRuntime().runFinalization();
//		if (logger.isDebugEnabled()) {
//			logger.debug("Runtime.getRuntime().freeMemory searchMenuTree : "+Runtime.getRuntime().freeMemory());
//		}
		
		params.put("mnuConstructID", session.getMnuConstructID());
		params.put("saasYN", session.getSaaSYN());
		if (session.getSaaSYN().equals("Y"))
			params.put("companyID", session.getCompanyID());

		Map map = menuConstructService.searchMenuTree(params);

		ModelAndView mv = new ModelAndView(systemVersion+"/cms/menutree");

		setObjectAll(mv, request, response, params);
		mv.addObject("tree", map.get("tree"));

		return mv;
	}

	@RequestMapping("/subMenuList")
	public ModelAndView subMenuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		SessionManager session = new SessionManager(request, response);
		MenuConstruct menuConstruct = new MenuConstruct();
		Map param = new HashMap();

		bind(request, menuConstruct);
		bind(request, param);

		menuConstruct.setMnuConstructID(session.getMnuConstructID());
		menuConstruct.setPmnuGrpID(StringUtil.nullToBlank(request.getParameter("pmnuGrpID"), "200700000089"));

		//F_MenuConstructGroup
		List menuList = simpleService.queryForList("CMP0100712S", menuConstruct);
		Map result = new HashMap();
		result = (Map) menuList.get(0);
		param.put("pmnuGrpName", result.get("mnuGrpName").toString());
		mav = new ModelAndView(systemVersion+"/cms/auth/menulist");
		mav.addObject("menuList", menuList);
		mav.addObject("paramMenu", param);

		return mav;
	}

	@RequestMapping("/treeViewMenuConstruct")
	public ModelAndView treeViewMenuConstruct(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		MenuConstruct menuConstruct = new MenuConstruct();
		Map param = new HashMap();

		bind(request, menuConstruct);
		bind(request, param);

		if (logger.isDebugEnabled()) {
			logger.debug(menuConstruct);
		}

		menuConstruct.setMnuConstructID(StringUtil.nullToBlank(request.getParameter("mnuConstructID"), ""));
		//F_MenuConstruct
		mav.addObject("menuConstructTreeView", simpleService.queryForList("CMP0100707S", menuConstruct));
		setObjectAll(mav, request, response, param);
		return mav;
	}

	@RequestMapping("/updateMenuConstruct")
	public ModelAndView updateMenuConstruct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		SessionManager session = new SessionManager(request, response);

		bind(request, menuConstruct);
		menuConstruct.setChgID(session.getUserID());

		try {
			simpleService.update("commonservice.cms.menuConstruct.update", menuConstruct);
			//F_MenuConstruct
			content = simpleService.queryForMap("CMP0100705S", menuConstruct);
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/updateMenuConstructGroup")
	public ModelAndView updateMenuConstructGroup(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		SessionManager session = new SessionManager(request, response);

		bind(request, menuConstruct);
		menuConstruct.setMnuGrpID(request.getParameter("mnuGrpID2"));
		menuConstruct.setChgID(session.getUserID());

		try {
			simpleService.update("commonservice.cms.menuConstructGroup.update", menuConstruct);
			//F_MenuConstructGroup
			content = simpleService.queryForMap("CMP0100706S", menuConstruct);
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		bind(request, content);
		setObjectAll(mav, request, response, content);
		return mav;
	}
}