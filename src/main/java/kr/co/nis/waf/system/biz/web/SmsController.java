package kr.co.nis.waf.system.biz.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.system.biz.model.SmsSend;
import kr.co.nis.waf.system.biz.service.SmsService;
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
@RequestMapping("/sms")
public class SmsController extends SimpleMultiActionController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SmsService smsService;
	
	/*
	public void setSmsService(SmsService smsService) {
		this.smsService = smsService;
	}
	*/

	//SMS
	@RequestMapping("/saveSmsSend")
	public ModelAndView saveSmsSend(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		SmsSend smsSend = new SmsSend();
		ResultMessage rm = new ResultMessage();

		bind(request, smsSend);
	 
		smsSend.setUserID(session.getUserID());
		
		try {
			//emTran.clean(); //?��??????
			//emTran.validate(emTran.ACTION_SAVE); //validate
			
			smsService.addSmsSend(smsSend);
			
			//rm.setParameters(emTran.getDocID());
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e)
		{
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e)
		{
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
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
}
