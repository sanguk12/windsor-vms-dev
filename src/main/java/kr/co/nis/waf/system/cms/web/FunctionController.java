package kr.co.nis.waf.system.cms.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.cms.model.Function;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/function")
public class FunctionController extends SimpleMultiActionController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;

	/*
	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}
	
	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}
	*/

	@RequestMapping("/removeFunction")
	public ModelAndView removeFunction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Function function = new Function();
		ResultMessage rm = new ResultMessage();

		bind(request, function);

		try
		{
			function.clean();
			function.validate(function.ACTION_REMOVE);

			// F_Function
			simpleService.delete("CMP0100105D", function);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
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
		catch (Exception e)
		{
			if (logger.isDebugEnabled())
			{
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/saveFunction")
	public ModelAndView saveFunction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Function function = new Function();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, function);
		bind(request, seqID);

		try
		{
			function.clean();
			function.validate(function.ACTION_SAVE);

			if (function.getFuncID().equals("")) {
				seqID.setSeqDiv("FUNCID");
				function.setFuncID(codeService.getSeqID(seqID).get("seqID").toString());
				
				// F_Function
				simpleService.insert("CMP0100103I", function);
			}
			else {
				// F_Function
				simpleService.update("CMP0100104U", function);
			}

			rm.setParameters(function.getFuncID());

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
