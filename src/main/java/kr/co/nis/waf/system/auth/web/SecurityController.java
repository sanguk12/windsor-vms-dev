package kr.co.nis.waf.system.auth.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.model.PasswordPolicy;
import kr.co.nis.waf.system.auth.service.SecurityService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/security")
public class SecurityController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SecurityService securityService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/savePasswordPolicy")
	public ModelAndView savePasswordPolicy(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PasswordPolicy passwordPolicy = new PasswordPolicy();
		ResultMessage rm = new ResultMessage();
		
		bind(request, passwordPolicy);
		
		try {
			
			passwordPolicy.clean();
			passwordPolicy.validate(passwordPolicy.ACTION_SAVE);
			
			if (simpleService.queryForInt("CMP0102304S", passwordPolicy) == 0) {
				securityService.addPasswordPolicy(passwordPolicy);
			}
			else {
				securityService.modifyPasswordPolicy(passwordPolicy);
			}
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
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
