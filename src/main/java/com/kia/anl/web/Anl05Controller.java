package com.kia.anl.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.anl.model.VENUE_INFO_LOG;
import com.kia.anl.service.Anl05Service;


@Controller
@RequestMapping("/service/anl05")
public class Anl05Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Anl05Service anl05Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/changeEmpID")
	public ModelAndView changeEmpID(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		VENUE_INFO_LOG venue_info_log=new VENUE_INFO_LOG();
		ResultMessage rm =new ResultMessage();
		
		bind(request,venue_info_log);
		
		try{
			venue_info_log.clean();
			venue_info_log.validate(venue_info_log.ACTION_SAVE);
			
			if(venue_info_log.getEmpID().equals("")){
				
			}else{
				anl05Service.changeEmpID(venue_info_log);
			}
			
			rm.setParameters(venue_info_log.getVenueCD());
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch(InputRequiredException e){
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[]{getMessageSourceAccessor().getMessage(e.getMessage())}));
		}
		catch(SelectRequiredException e){
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[]{getMessageSourceAccessor().getMessage(e.getMessage())}));
		}
		catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.debug(e.toString());
				e.printStackTrace();
			}
			
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}
		
		ModelAndView mv=new ModelAndView("resultView");
		mv.addObject("resultMsg",rm);
		
		return mv;
	}
	
}