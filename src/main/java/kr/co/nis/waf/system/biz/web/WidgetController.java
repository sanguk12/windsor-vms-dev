package kr.co.nis.waf.system.biz.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.model.UserWidget;
import kr.co.nis.waf.system.biz.model.UserWidgetList;
import kr.co.nis.waf.system.biz.model.Widget;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.biz.service.WidgetService;
import kr.co.nis.waf.system.cms.service.MenuConstructService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/widget")
public class WidgetController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Value("#{appenv['app.system.version']}")
	private String systemVersion;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private WidgetService widgetService;
	
	@Resource
	private SimpleService simpleService;
	
	@Resource
	private MenuConstructService menuConstructService;
	
	@RequestMapping("/getContent")
	public ModelAndView getContent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map params = new HashMap();
		bind(request, params);

		//F_Widget
		Map data = simpleService.queryForMap("CMP0101401S", params);
		
		if (logger.isDebugEnabled()) {
			logger.debug(data.get("bodyScript").toString());
		}

		ModelAndView mv = new ModelAndView("simpleHtmlView");
		mv.addObject("html", data.get("bodyScript").toString());

		return mv;
	}

	@RequestMapping("/removeUserWidget")
	public ModelAndView removeUserWidget(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserWidget userWidget = new UserWidget();
		ResultMessage rm = new ResultMessage();

		bind(request, userWidget);

		try {
			userWidget.clean();
			userWidget.validate(userWidget.ACTION_SAVE);

			//F_UserWidget
			simpleService.delete("CMP0101503D", userWidget);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
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
			}
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/removeWidget")
	public ModelAndView removeWidget(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Widget widget = new Widget();
		ResultMessage rm = new ResultMessage();

		bind(request, widget);

		try {
			widget.clean();
			widget.validate(widget.ACTION_REMOVE);

			//F_Widget
			simpleService.update("CMP0101402U", widget);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
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
			}
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}	

	@RequestMapping("/saveUserWidget")
	public ModelAndView saveUserWidget(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		UserWidget userWidget = new UserWidget();
		ResultMessage rm = new ResultMessage();

		bind(request, userWidget);
		
		try {

			userWidget.clean();
			userWidget.validate(userWidget.ACTION_SAVE);

			//F_UserWidget
			simpleService.update("CMP0101502U", userWidget);
			
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
			}
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/saveUserWidgetOwn")
	public ModelAndView saveUserWidgetOwn(HttpServletRequest request, HttpServletResponse response) throws Exception {

		UserWidgetList userWidgetList = new UserWidgetList();
		ResultMessage rm = new ResultMessage();

		bind(request, userWidgetList);

		try {

			userWidgetList.clean();
			userWidgetList.validate(userWidgetList.ACTION_SAVE);

			widgetService.saveUserWidget(userWidgetList);

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
			}
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/saveWidget")
	public ModelAndView saveWidget(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Widget widget = new Widget();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, widget);
		bind(request, seqID);

		try {

			widget.clean();
			widget.validate(widget.ACTION_SAVE);
			widget.setActiveFlg("U");

			if (widget.getWidgetID() == null || widget.getWidgetID().equals("")) {
				seqID.setSeqDiv("WIDGETID");
				String widgetID = (codeService.getSeqID(seqID)).get("seqID").toString();

				widget.setWidgetID(widgetID);

				//F_Widget
				simpleService.insert("CMP0101403I", widget);
			}
			else {
				//F_Widget
				simpleService.update("CMP0101404U", widget);
			}

			rm.setParameters(widget.getWidgetID());

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
			}
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/viewUserWidget")
	public ModelAndView viewUserWidget(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		
		User user = new User();
		Map params = new HashMap();

		bind(request, user);
		bind(request, params);

		//F_UserWidget
		List widgetList = simpleService.queryForList("CMP0101504S", user);
		
		ModelAndView mv = new ModelAndView(systemVersion+"/main");
		mv.addObject("widgetList", widgetList);
		setObjectAll(mv, request, response, params);

		return mv;
	}
	
}
