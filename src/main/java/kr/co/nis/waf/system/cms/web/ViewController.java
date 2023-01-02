package kr.co.nis.waf.system.cms.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.cms.model.View;
import kr.co.nis.waf.system.cms.model.ViewFunctionList;
import kr.co.nis.waf.system.cms.service.ViewService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/view")
public class ViewController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private ViewService viewService;
	
	@Resource
	private SimpleService simpleService;

	@RequestMapping("/removeView")
	public ModelAndView removeView(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		View view = new View();
		ResultMessage rm = new ResultMessage();

		bind(request, view);

		try
		{
			view.validate(view.ACTION_REMOVE);

			viewService.removeView(view);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.remove"));
		}
		catch (InputRequiredException e)
		{
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e)
		{
			if (logger.isDebugEnabled())
			{
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.remove"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/saveView")
	public ModelAndView saveView(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		View view = new View();
		ViewFunctionList viewFunctionList = new ViewFunctionList();
		ResultMessage rm = new ResultMessage();

		bind(request, view);
		bind(request, viewFunctionList);

		try {
			view.clean();
			viewFunctionList.clean();

			view.validate(view.ACTION_SAVE);
			viewFunctionList.validate(viewFunctionList.ACTION_SAVE);

			view.load(viewFunctionList);

			Map parameter = new HashMap();
			parameter.put("companyID", session.getCompanyID());
			parameter.put("viewID", view.getViewID());
			if (simpleService.queryForMap("CMP0100201S", parameter).get("count").toString().equals("0")) {
				viewService.addView(view);
			}
			else {
				viewService.modifyView(view);
			}

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e)
		{
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e)
		{
			if (logger.isDebugEnabled())
			{
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
