package com.kia.mdm.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.mdm.model.GDAT01MT;
import com.kia.mdm.model.GEVN01MTs;
import com.kia.mdm.model.GEVN02MTs;
import com.kia.mdm.service.Mdm04Service;

@Controller
@RequestMapping("/service/mdm04")
public class Mdm04Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Mdm04Service mdm04Service;
	
	@Resource
	private SimpleService simpleService;

	@Value("#{system['docLink.realDownloadPath']}")
	private String realDownloadPath;
	
	@RequestMapping("/saveEventRegDate")
	public ModelAndView saveEventRegDate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		GEVN01MTs gevn01mts = new GEVN01MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gevn01mts);
		
		try {
			gevn01mts.clean();
			gevn01mts.validate(gevn01mts.ACTION_ADD);
			
			mdm04Service.saveEventRegDate(gevn01mts);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
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
	
	@RequestMapping("/saveResultRegDate")
	public ModelAndView saveResultRegDate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		GEVN02MTs gevn02mts = new GEVN02MTs();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gevn02mts);
		
		try {
			gevn02mts.clean();
			gevn02mts.validate(gevn02mts.ACTION_ADD);
			
			mdm04Service.saveResultRegDate(gevn02mts);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
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
	
	@RequestMapping("/saveBatFileList")
	public ModelAndView saveStockSurvey(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map param = new HashMap();
		List<Map> data = new ArrayList();
		GDAT01MT gdat01mt = new GDAT01MT();
		ResultMessage rm = new ResultMessage();
		bind(request,param);
		int cnt=0;
		String type="";
		
		Date nowDate =new Date();
		DateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		String sysdate=formatter.format(nowDate);
		String fileDate=sysdate.substring(0,8);
				
		String STARTDATE = (String) param.get("startDate");
		String ENDDATE = (String) param.get("endDate");
		String REGEMPID =(String) session.getUserID();
		
		gdat01mt.setSTARTDATE(STARTDATE);
		gdat01mt.setENDDATE(ENDDATE);
		gdat01mt.setREGEMPID(REGEMPID);
		
		try{
			if(param.get("planResultTpCD").equals("")){
				//Plan_업소단위
				gdat01mt.setPlanResultTpCD("01");
				gdat01mt.setGDATID(sysdate+"_"+gdat01mt.getPlanResultTpCD());
				
				param.put("planResultTpCD","01");
				param.put("cnt", simpleService.queryForInt("MDM0400208S", gdat01mt));
				param.put("rstype", simpleService.queryForMap("MDM0400209S",param).get("rstype"));
				cnt=(Integer) param.get("cnt");
				
				if(cnt==0){
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+".dat");
				}else{
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+"("+cnt+").dat");
					
				}
				
				mdm04Service.insertBatSchedule(gdat01mt);
				
				//Result_업소단위
				gdat01mt.setPlanResultTpCD("02");
				gdat01mt.setGDATID(sysdate+"_"+gdat01mt.getPlanResultTpCD());
				
				param.put("planResultTpCD","02");
				param.put("cnt", simpleService.queryForInt("MDM0400208S", gdat01mt));
				param.put("rstype", simpleService.queryForMap("MDM0400209S",param).get("rstype"));
				cnt=(Integer) param.get("cnt");
				
				if(cnt==0){
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+".dat");
				}else{
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+"("+cnt+").dat");
					
				}
				mdm04Service.insertBatSchedule(gdat01mt);
				
				//Plan_브랜드단위
				gdat01mt.setPlanResultTpCD("03");
				gdat01mt.setGDATID(sysdate+"_"+gdat01mt.getPlanResultTpCD());
				
				param.put("planResultTpCD","03");
				param.put("cnt", simpleService.queryForInt("MDM0400208S", gdat01mt));
				param.put("rstype", simpleService.queryForMap("MDM0400209S",param).get("rstype"));
				cnt=(Integer) param.get("cnt");
				
				if(cnt==0){
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+".dat");
				}else{
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+"("+cnt+").dat");
					
				}
				mdm04Service.insertBatSchedule(gdat01mt);
				
				//Result_브랜드단위
				gdat01mt.setPlanResultTpCD("04");
				gdat01mt.setGDATID(sysdate+"_"+gdat01mt.getPlanResultTpCD());
				
				param.put("planResultTpCD","04");
				param.put("cnt", simpleService.queryForInt("MDM0400208S", gdat01mt));
				param.put("rstype", simpleService.queryForMap("MDM0400209S",param).get("rstype"));
				cnt=(Integer) param.get("cnt");
				
				if(cnt==0){
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+".dat");
				}else{
					gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+"("+cnt+").dat");
					
				}
				mdm04Service.insertBatSchedule(gdat01mt);
				
			}else{
				String getPlanResultTpCD=(String) param.get("planResultTpCD");
				gdat01mt.setPlanResultTpCD(getPlanResultTpCD);
				gdat01mt.setGDATID(sysdate+"_"+gdat01mt.getPlanResultTpCD());
				param.put("cnt", simpleService.queryForInt("MDM0400208S", gdat01mt));
				param.put("rstype", simpleService.queryForMap("MDM0400209S",param).get("rstype"));
				cnt=(Integer) param.get("cnt");
				
				if(cnt==0){
						gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+".dat");
				}else{
						gdat01mt.setFILENAME(param.get("rstype")+"_"+fileDate+"("+cnt+").dat");
						
				}
				mdm04Service.insertBatSchedule(gdat01mt);
			}
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
			
		} catch(InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		} catch (Exception e){
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
	
	
	@RequestMapping("/downloadFile")
	public ModelAndView downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map content = new HashMap();
		Map parameters = new HashMap();
		GDAT01MT gdat01mt = new GDAT01MT();
		bind(request,gdat01mt);
		content=simpleService.queryForMap("MDM0400210S",gdat01mt);
		
		String fileName = content.get("FILENAME").toString();
		parameters.put("fileName", fileName);//파일 원본 이름
		String downloadPath = realDownloadPath;
		parameters.put("tempFileName", fileName);//서버에 저장되는 파일 이름 
		parameters.put("uploadDir", "D:/DWFlatFile/");//파일이 올라가 있는 경로를 선택해 주어야 한다. 
		
		//return new ModelAndView("downloadView", parameters);
		return new ModelAndView("downloadView", parameters);
	}
	
}