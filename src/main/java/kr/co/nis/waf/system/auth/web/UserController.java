package kr.co.nis.waf.system.auth.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.model.GroupUser;
import kr.co.nis.waf.system.auth.model.PasswordPolicy;
import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.system.auth.model.UserExtend;
import kr.co.nis.waf.system.auth.service.SecurityService;
import kr.co.nis.waf.system.auth.service.UserService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/user")
public class UserController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleService simpleService;
	
	@Resource
	private UserService userService;
	
	@Resource
	private SecurityService securityService;
	
	@RequestMapping("/removeUser")
	public ModelAndView removeUser(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		User user = new User();
		GroupUser groupUser = new GroupUser();
		ResultMessage rm = new ResultMessage();

		bind(request, user);
		bind(request, groupUser);

		try {
			user.clean();
			user.validate(user.ACTION_REMOVE);
			groupUser.validate(user.ACTION_REMOVE);
			
			user.setWorkerID(session.getUserID());
			user.setUserID(request.getParameter("userID").toString());
			groupUser.setUserID(request.getParameter("userID").toString());

			userService.removeUser(user, groupUser);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
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

	@RequestMapping("/saveUser")
	public ModelAndView saveUser(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		UserExtend userExtend = new UserExtend();
		GroupUser groupUser = new GroupUser();
		ResultMessage rm = new ResultMessage();

		bind(request, userExtend);
		bind(request, groupUser);

		userExtend.setUserID(request.getParameter("userID").toString());
		groupUser.setUserID(request.getParameter("userID").toString());
		
		try
		{
			userExtend.setPasswd(userExtend.getUserID()+"123");
			userExtend.clean();
			groupUser.clean();
			userExtend.validate(userExtend.ACTION_SAVE);
			groupUser.validate(groupUser.ACTION_DEFAULT);
			userExtend.setWorkerID(session.getUserID());
			/*암호방식변경 ==>F_MD5_CRIPT 
			if (!userExtend.getPasswd().equals("")) {
				userExtend.setPasswd(configure.encryptSHA256(userExtend.getPasswd()));
			}
			*/

			userService.saveUser(userExtend, groupUser);

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
	
	@RequestMapping("/saveTheme")
	public ModelAndView saveTheme(HttpServletRequest request, HttpServletResponse response) throws Exception{

		SessionManager session = new SessionManager(request, response);
		UserExtend userExtend = new UserExtend();
		ResultMessage rm = new ResultMessage();

		bind(request, userExtend);
		
		userExtend.setWorkerID(session.getUserID());
		
		try {
			simpleService.update("commonservice.auth.userTheme.update", userExtend);
			
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
	
	@RequestMapping("/savePassword")
	public ModelAndView savePassword(HttpServletRequest request, HttpServletResponse response) throws Exception{

		SessionManager session = new SessionManager(request, response);
		UserExtend userExtend = new UserExtend();
		PasswordPolicy passwordPolicy = new PasswordPolicy();
		Map params = new HashMap();
		ResultMessage rm = new ResultMessage();

		bind(request, userExtend);
		bind(request, params);
		
		/*암호방식변경 ==>F_MD5_CRIPT 
		if (!userExtend.getPasswd().equals("")) {
			userExtend.setPasswd(configure.encryptSHA256(userExtend.getPasswd()));
		}
		*/
		userExtend.setWorkerID(session.getUserID());
		
		if (request.getParameter("userID") != null) {
			userExtend.setUserID(request.getParameter("userID").toString());
		}
				
		try {
			if (!userExtend.getPasswd().equals("")) {
				//F_User
				userExtend.setInitPasswdYN("N");
				simpleService.update("SYS0007S", userExtend);
				//F_PasswordHistory. diageo, 비밀번호이력
				simpleService.insert("SYS0016I", userExtend);
				
			}
			if (!userExtend.getTimezoneCD_info().equals("")) {
				//F_User_X_Package
				simpleService.update("SYS0008U", userExtend);
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
			rm.setMessage(getMessageSourceAccessor().getMessage("CMP01020A.msg4"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/initPassword")
	public ModelAndView initPassword(HttpServletRequest request, HttpServletResponse response) throws Exception{

		SessionManager session = new SessionManager(request, response);
		UserExtend userExtend = new UserExtend();
		ResultMessage rm = new ResultMessage();

		bind(request, userExtend);
		
		userExtend.setWorkerID(session.getUserID());
		
		if (request.getParameter("userID") != null) {
			userExtend.setUserID(request.getParameter("userID").toString());
		}
				
		try {
			if (!userExtend.getPasswd().equals("")) {
				//F_User
				userExtend.setPasswd(userExtend.getUserID()+"123");
				userExtend.setInitPasswdYN("Y");
				simpleService.update("SYS0007S", userExtend);
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
	
	@RequestMapping("/unlockPassword")
	public ModelAndView unlockPassword(HttpServletRequest request, HttpServletResponse response) throws Exception{

		SessionManager session = new SessionManager(request, response);
		UserExtend userExtend = new UserExtend();
		ResultMessage rm = new ResultMessage();

		bind(request, userExtend);
		
		try {
			userExtend.setUserID(request.getParameter("userID").toString());
			simpleService.update("SYS0009U", userExtend);
			
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