package com.kia.rlt.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT05MT;
import com.kia.rlt.service.Rlt03Service;

@Controller
@RequestMapping("/service/rlt03")
public class Rlt03Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Rlt03Service rlt03Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/saveResultDiffNo_G2")
	public ModelAndView saveResultDiffNo_G2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT05MT grlt05mt = new GRLT05MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, grlt05mt);
		
		try {
			grlt05mt.clean();
			grlt05mt.validate(grlt05mt.ACTION_SAVE);
			
			int count = 0;
			count = simpleService.queryForInt("RLT0300104S", grlt05mt);
			logger.debug("count :"+count);
			
			if(count == 0) {
				
				int count2 = 0;
				count2 = simpleService.queryForInt("RLT0300102S", grlt05mt);
				
				if(count2 == 0) {
					if(grlt05mt.getActiveFlg().equals("I")) {
						rlt03Service.insertResultDiffNo_G2(grlt05mt);
					}
					else if(grlt05mt.getActiveFlg().equals("U")) {
						rlt03Service.updateResultDiffNo_G2(grlt05mt);
					}
					rm.setCode(rm.RESULT_SUCCESS);
					rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
				}
				else {
					rm.setCode(rm.RESULT_ERROR);
					rm.setMessage("실적반영기간이 기 등록된 기간과 중복되어서 저장할 수 없습니다.");
				}
			}
			else {
				rm.setCode(rm.RESULT_ERROR);
				rm.setMessage("해당 행사년월의 Result데이터가 존재해 저장할 수 없습니다.");
			}
			
			
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
	
	@RequestMapping("/deleteResultDiffNo_G2")
	public ModelAndView deleteResultDiffNo_G2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT05MT grlt05mt = new GRLT05MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, grlt05mt);
		
		try {
			grlt05mt.clean();
			grlt05mt.validate(grlt05mt.ACTION_SAVE);
			
			
			int count = 0;
			count = simpleService.queryForInt("RLT0300104S", grlt05mt);
			
			if(count == 0) {
				rlt03Service.deleteResultDiffNo_G2(grlt05mt);
				
				rm.setCode(rm.RESULT_SUCCESS);
				rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
			}
			else {
				rm.setCode(rm.RESULT_ERROR);
				rm.setMessage("해당 행사년월의 Result데이터가 존재해 삭제할 수 없습니다.");
			}
			
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
	
	@RequestMapping("/resultCreation")
	public ModelAndView resultCreation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			rlt03Service.resultCreation(grlt01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.resultCreation"));
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
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.resultCreation"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/determineResult")
	public ModelAndView determineResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			rlt03Service.determineResult(grlt01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.determine"));
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
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.determine"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/determineCancelResult")
	public ModelAndView determineCancelResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GRLT01MT grlt01mt = new GRLT01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, grlt01mt);
		
		try {
			grlt01mt.clean();
			grlt01mt.validate(grlt01mt.ACTION_SAVE);
			
			rlt03Service.determineCancelResult(grlt01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.determineCancel"));
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
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.determineCancel"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
}