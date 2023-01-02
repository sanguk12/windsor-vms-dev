package kr.co.nis.waf.system.biz.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Notice;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/notice")
public class NoticeController extends SimpleMultiActionController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleService simpleService;
	
	/*
	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}
	*/

	@RequestMapping("/saveNotice")
	public ModelAndView saveNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Notice notice = new Notice();
		ResultMessage rm = new ResultMessage();

		bind(request, notice);

		notice.setUserID(session.getUserID());
		notice.setActiveFlg("U");
		
		try {

			notice.clean();
			Map result;
			if (notice.getNoticeID().equals("")){
				notice.validate("ZCWCOMMC05_WCM_145");
				
				Map inParam = new HashMap();
				inParam.put("SEQDIV", "NOTICEID");
				inParam.put("LOGONID", session.getUserID());
				List outParamKey = new ArrayList();
				outParamKey.add("SEQID");

				Map seqID = null; //simpleService.queryForMap("ZCWCOMMC03_WCM_001", inParam, outParamKey);
				String newsID = seqID.get("SEQID").toString();

				notice.setNoticeID(newsID);
				
				result = null; //simpleService.execute("ZCWCOMMC05_WCM_159", notice);
			}
			else {
				notice.validate("ZCWCOMMC05_WCM_160");
				result = null; //simpleService.execute("ZCWCOMMC05_WCM_160", notice);
			}

			rm.setParameters(notice.getNoticeID());
			rm.setCode(result.get("RETURN_TYPE").toString());
			rm.setMessage(result.get("RETURN_MESSAGE").toString());
			
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
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/removeNotice")
	public ModelAndView removeNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Notice notice = new Notice();
		ResultMessage rm = new ResultMessage();

		bind(request, notice);

		notice.setUserID(session.getUserID());
		notice.setActiveFlg("D");
		
		try {

			notice.clean();
			notice.validate("ZCWCOMMC05_WCM_161");
			Map result = null; // simpleService.execute("ZCWCOMMC05_WCM_161", notice);

			rm.setCode(result.get("RETURN_TYPE").toString());
			rm.setMessage(result.get("RETURN_MESSAGE").toString());
			
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
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
}
