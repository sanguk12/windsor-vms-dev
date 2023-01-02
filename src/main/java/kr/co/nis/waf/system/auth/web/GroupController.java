package kr.co.nis.waf.system.auth.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.model.Group;
import kr.co.nis.waf.system.auth.service.GroupService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.cms.model.MenuConstruct;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/group")
public class GroupController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private GroupService groupService;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/insertGroup")
	public ModelAndView insertGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav ;
		Map param = new HashMap();
		Group group = new Group();
		
		bind(request, group);
		bind(request, param);
		
		try {
			simpleService.insert("CMP0100904I", group);
			
			param.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			param.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	@RequestMapping("/updateGroup")
	public ModelAndView updateGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map param = new HashMap();
		Group group = new Group();
		
		bind(request, group);
		bind(request, param);
		
		try {
			
			simpleService.update("CMP0100905U", group);
			
			param.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
			
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			param.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	@RequestMapping("/deleteGroup")
	public ModelAndView deleteGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map param = new HashMap();
		Group group = new Group();
		
		bind(request, group);
		bind(request, param);
		
		try {
			groupService.deleteGroup(group);
			
			param.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
			mav = new ModelAndView(super.getViewUrl(request));
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			param.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	@RequestMapping("/deleteListGroup")
	public ModelAndView deleteListGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map param = new HashMap();
		Group group = new Group();
		
		bind(request, group);
		bind(request, param);
		
		try {
			
			groupService.deleteGroup(group);
			
			mav = new ModelAndView(super.getViewUrl(request));
			//F_Group
			mav.addObject("groupList", simpleService.queryForList("CMP0100907S", group));
			param.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
			
		} 
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			param.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	@RequestMapping("/detailGroup")
	public ModelAndView detailGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map param = new HashMap();
		
		MenuConstruct menuConstruct = new MenuConstruct();
		Group group = new Group();
		Code seqID = new Code();
	
		bind(request, menuConstruct);
		bind(request, group);
		bind(request, seqID);
		
		if(group.getGrpID() != null && !group.getGrpID().equals("")) {
			//F_Group
			param = simpleService.queryForMap("CMP0100908S", group);
			param.put("saveType", "update");
			param.put("regGrpID", param.get("grpID").toString());
		} else {
			seqID.setSeqDiv("GRPID");
			param.put("regGrpID", codeService.getSeqID(seqID).get("seqID").toString());
			param.put("saveType", "insert");
		}
		
		bind(request, param);
		
		//F_MenuConstruct
		mav.addObject("mnuConstructID", simpleService.queryForList("CMP0100703S", menuConstruct));
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	@RequestMapping("/listGroup")
	public ModelAndView listGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map param = new HashMap();
		bind(request, param);
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	@RequestMapping("/treeViewGroup")
	public ModelAndView treeViewGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Group group = new Group();
		Map param = new HashMap();
		
		bind(request, group);
		bind(request, param);
		
		mav.addObject("groupTreeView", simpleService.queryForList("commonservice.auth.groupTreeView.select", group));
		mav.addObject("funcList", super.getFunctionList(request));
		mav.addObject("groupParam", param);
		return mav;
	}
}
