package kr.co.nis.waf.system.biz.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/code")
public class CodeController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;

	@RequestMapping("/insertCode")
	public ModelAndView insertCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav;
		Map content = new HashMap();
		Code code = new Code();

		bind(request, code);
		bind(request, content);

		try {
			code.setActiveFlg("U");
			code.clean();
			
			if(simpleService.queryForInt("CMP0100303S", code)==0) {
				simpleService.insert("CMP0100303I", code);
			}
			else {
				code.setOrgComCode(code.getComCode());
				simpleService.update("CMP0100304U", code);
			}
			
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}

		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/updateCode")
	public ModelAndView updateCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav;
		Code code = new Code();
		Map content = new HashMap();

		bind(request, code);
		bind(request, content);

		try {
			code.setActiveFlg("U");
			code.clean();
			
			// F_Code
			simpleService.update("CMP0100304U", code);
			
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e) {
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/deleteCode")
	public ModelAndView deleteCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		Code code = new Code();
		bind(request, code);
		bind(request, content);

		try
		{
			code.setActiveFlg("D");
			
			codeService.deleteCode(code);
			
			content.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
			mav = new ModelAndView(super.getViewUrl(request));
		}
		catch (Exception e)
		{
			if (logger.isDebugEnabled())
			{
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}

		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/deleteListCode")
	public ModelAndView deleteListCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav;
		Map content = new HashMap();
		Code code = new Code();

		bind(request, code);
		bind(request, content);

		try
		{
			codeService.deleteCode(code);
			
			mav = new ModelAndView(super.getViewUrl(request));
			content.put("msg", getMessageSourceAccessor().getMessage("success.delete"));
		}
		catch (Exception e)
		{
			content.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		code.setCodeDiv("ROOT");
		//F_Code
		mav.addObject("codeTreeView", simpleService.queryForList("CMP0100308S", code));
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/detailCode")
	public ModelAndView detailCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Code code = new Code();
		Map content = new HashMap();

		bind(request, code);

		if (!code.getComCode().equals("")) {
			//F_Code
			content = simpleService.queryForMap("CMP0100306S", code);
			content.put("saveType", "update");
		}
		else {
			content.put("saveType", "insert");
			content.put("codeDiv", code.getCodeDiv());
			if ("ROOT".equals(code.getCodeDiv())) {
				content.put("codeDivName", code.getCodeDiv());
			}
			else {
				//F_Code
				content.put("codeDivName", simpleService.queryForMap("CMP0100307S", code).get("codeDivName"));
			}
		}
		
		bind(request, content);
		setObjectAll(mav, request, response, content);
		return mav;
	}

	@RequestMapping("/initCodeList")
	public ModelAndView initCodeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map content = new HashMap();
		Code code = new Code();
		bind(request, code);
		bind(request, content);

		//F_Code
		mav.addObject("codeTreeView", simpleService.queryForList("CMP0100308S", code));
		setObjectAll(mav, request, response, content);
		return mav;
	}	
}