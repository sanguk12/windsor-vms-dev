package kr.co.nis.waf.system.common.web;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/dataManager")
public class DataManagerController extends SimpleMultiActionController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleService simpleService;

	/*
	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}
	*/

	@RequestMapping("/runQuery")
	public ModelAndView runQuery(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		HashMap parameter = new LinkedHashMap();
		List data = null;
		HashMap status = new HashMap();
		ResultMessage rm = new ResultMessage();

		bind(request, parameter);

		try {
			data = simpleService.queryForList("system.runQuery", parameter);
			status.put("statusCode", "S");
			status.put("statusMessage", "Success...");
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				e.printStackTrace();
			}
			status.put("statusCode", "E");
			status.put("statusMessage", e.toString());
		}

		ModelAndView mv = new ModelAndView("dynamicResultXmlView");
		mv.addObject("data", data);
		mv.addObject("status", status);

		return mv;
	}

	@RequestMapping("/downloadExcel")
	public ModelAndView downloadExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		HashMap parameter = new LinkedHashMap();
		List data = null;
		ResultMessage rm = new ResultMessage();

		bind(request, parameter);

		try {
			data = simpleService.queryForList("system.runQuery", parameter);
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				e.printStackTrace();
			}
		}

		ModelAndView mv = new ModelAndView("dynamicResultExcelView");
		mv.addObject("data", data);
		mv.addObject("dataType", ((String) parameter.get("dataType")).split(";"));
		mv.addObject("fileName", "prm_data");

		return mv;
	}
}
