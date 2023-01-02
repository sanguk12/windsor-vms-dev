package kr.co.nis.waf.system.cms.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.cms.model.Program;
import kr.co.nis.waf.system.cms.model.ProgramViewList;
import kr.co.nis.waf.system.cms.service.ProgramService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/program")
public class ProgramController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private ProgramService programService;
	
	@Resource
	private SimpleService simpleService;

	@RequestMapping("/removeProgram")
	public ModelAndView removeProgram(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		Program program = new Program();
		ResultMessage rm = new ResultMessage();

		bind(request, program);

		try
		{
			program.validate(program.ACTION_REMOVE);

			programService.removeProgram(program);

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

	@RequestMapping("/saveProgram")
	public ModelAndView saveProgram(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		Program program = new Program();
		ProgramViewList programViewList = new ProgramViewList();
		ResultMessage rm = new ResultMessage();

		bind(request, program);
		bind(request, programViewList);

		try
		{
			program.clean();
			programViewList.clean();

			program.validate(program.ACTION_SAVE);
			programViewList.validate(programViewList.ACTION_SAVE);

			program.load(programViewList);

			Map condition = new HashMap();
			condition.put("companyID", session.getCompanyID());
			condition.put("pgmIDs", program.getPgmIDs());
			if ((simpleService.queryForMap("CMP0100601S", condition)).get("count").toString().equals("0")) {
				programService.addProgram(program);
			}
			else {
				programService.modifyProgram(program);
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
