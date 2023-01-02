package com.kia.com.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.util.DateUtil;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.com.model.GRLT10IF;
import com.kia.com.model.GSYS10MT;
import com.kia.mdm.model.GDAT01MT;

//import components4developers.client.TkbmMWSimpleClient;

@Controller
@RequestMapping("/service/simpleBatch")
/**
 * angelnet interface
 * @author jangtaejoon
 *
 * 2015.02.12, taejoon.jang, BOX/BON 두개 단위로 인터페이스 변경
 * 							 BOX와 BON 로직은 똑같으나 BON에는 해당날짜의 삭제 로직이 없다.
 */
public class SimpleBatchController extends SimpleMultiActionController {
	
	private final Log logger = LogFactory.getLog(getClass());
	
	private final String rowSplit = "0d0a";
	private final String colSplit = "1c";
	
	@Resource
	private SimpleService simpleService;
	
	private EmailSender emailSender;
	
	//엔젤넷 업소별 판매현황 배치
	@RequestMapping("/request_salesInfo_batch")
	public void request_salesInfo_batch() throws Exception {
//		angelnetInterface_salesInfo("20140501", "20140531");
//		angelnetInterface_salesInfo_box("", "");
//		angelnetInterface_salesInfo_bon("", "");
	}
	
	//엔젤넷 업소별 판매현황 화면액션
	@RequestMapping("/request_salesInfo_action")
	public ModelAndView request_salesInfo_action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ResultMessage rm = new ResultMessage();
		Map map = new HashMap();
		
		bind(request, map);
		
		try {
			String startDate = "";
			String endDate = "";
			if(map.get("startDate")!=null) {
				startDate = map.get("startDate").toString();
			}
			if(map.get("endDate")!=null) {
				endDate = map.get("endDate").toString();
			}
//			angelnetInterface_salesInfo_box(startDate, endDate);
//			angelnetInterface_salesInfo_bon(startDate, endDate);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.interface"));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.interface"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	//2015.02.12. taejoon.jang, BOX
//	public Map angelnetInterface_salesInfo_box(String startDate, String endDate) throws Exception {
//		TkbmMWSimpleClient SimpleClient = new TkbmMWSimpleClient();
//		SimpleClient.Connect("211.191.179.43", 3307);		// IDC 실망
//		Map resultMap = new HashMap();
//		GSYS10MT gsys10mt = new GSYS10MT();
//
//		List log_rfidDates = new ArrayList();
//		List log_venueCDs = new ArrayList();
//		List log_rfidQtys = new ArrayList();
//
//		try {
//			SimpleClient.RequestTimeout=5000;
//			String recv_data = null;
//			GRLT10IF grlt10if = new GRLT10IF();
//
//
//			// 서비스 파라메터 지정  (터미널ID , 조회시작일자, 조회종료일자 )
//		    Object[] p = null;
//
//		    if(startDate.equals("") && endDate.equals("")) {
//		    	startDate = FormatUtil.unFormat(DateUtil.getFirstDate(0));
//		    	endDate = FormatUtil.unFormat(DateUtil.getCurrentDate());
//		    	//2014.08.01, taejoon.jang, 매월1일이면 지난달 한달치 전부 가져오기
//		    	if(startDate.equals(endDate)) {
//		    		startDate = FormatUtil.unFormat(DateUtil.getFirstDate(-1));
//			    	endDate = FormatUtil.unFormat(DateUtil.getCurrentDate());
//		    	}
//		    	logger.debug("startDate : "+startDate);
//		    	logger.debug("endDate : "+endDate);
//		    	p = new Object[] {"D000000001", startDate, endDate};
//		    	grlt10if.setStartDate(startDate);
//		    	grlt10if.setEndDate(endDate);
//		    }
//		    else {
//		    	p = new Object[] {"D000000001", startDate, endDate};
//		    	grlt10if.setStartDate(startDate);
//		    	grlt10if.setEndDate(endDate);
//		    }
//
//		    // 서비스 요청
//			Object[] v = (Object[])SimpleClient.SendRequest("DIAGEO_AMS", "1.0", "REQUEST_SALESINFO_BOX", new Object[] {p});
//
//			// 서버응답 추출
//			resultMap.put("resultCD", v[0]);
//			resultMap.put("resultMsg", v[1]);
//			resultMap.put("resultRows", v[2]);
//			logger.debug("응답코드 :  " + v[0]);
//			logger.debug("응답메시지 : " + v[1]);
//			logger.debug("레코드합계 :  " + v[2]);
//
//			int record_cnt = Integer.valueOf(String.valueOf(v[2]));
//
//			String[] rfidDates = null;
//			String[] venueCDs = null;
//			String[] angelPrd16CDs = null;
//			String[] angelPrdMlCDs = null;
//			String[] rfidQtys = null;
//
//			//log
//			gsys10mt.setIfNm("엔젤넷판매현황BOX");
//			gsys10mt.setResultCD(v[0].toString());
//			gsys10mt.setResultMsg(v[1].toString());
//
//			if (record_cnt > 0) {
//				// 판매추이자료 추출 ....
//				SimpleClient.Transport.BeginRead();
//				SimpleClient.Transport.EndRead();
//				recv_data = new String(SimpleClient.GetResponseStream());
//
////				logger.debug(" ------------ Received Data Start --------------");
////				logger.debug(recv_data);
////				logger.debug(" ------------ End ............... --------------");
//
//				String recv_data_str = byteArrayToHex(SimpleClient.GetResponseStream()).toString();
////				logger.debug("byte->hex : "+recv_data_str);
//
//				String[] rows = recv_data_str.split(rowSplit);
//				rfidDates = new String[rows.length];
//				venueCDs = new String[rows.length];
//				angelPrd16CDs = new String[rows.length];
//				angelPrdMlCDs = new String[rows.length];
//				rfidQtys = new String[rows.length];
//
//				for(int i=0; i<rows.length; i++) {
//					String[] cols = rows[i].split(colSplit);
//					rfidDates[i] = new String(hexToByteArray(cols[0]));
//					venueCDs[i] = new String(hexToByteArray(cols[1]));
//					if(hexToByteArray(cols[2])!=null) {
//						angelPrd16CDs[i] = new String(hexToByteArray(cols[2]));
//					}
//					if(hexToByteArray(cols[3])!=null) {
//						angelPrdMlCDs[i] = new String(hexToByteArray(cols[3]));
//					}
//					rfidQtys[i] = new String(hexToByteArray(cols[4]));
//				}
//
//				grlt10if.setRfidDates(rfidDates);
//				grlt10if.setVenueCDs(venueCDs);
//				grlt10if.setAngelPrd16CDs(angelPrd16CDs);
//				grlt10if.setAngelPrdMlCDs(angelPrdMlCDs);
//				grlt10if.setRfidQtys(rfidQtys);
//
//				int count = 0;
//
//				simpleService.delete("COM03001D", grlt10if);
//				for(int i=0; i<grlt10if.getSize(); i++) {
//					if(grlt10if.getObject(i).getAngelPrd16CD()!=null
//							|| grlt10if.getObject(i).getAngelPrdMlCDs()!=null) {
//						simpleService.insert("COM03001I", grlt10if.getObject(i));
//					}
//					else {
//						log_rfidDates.add(count, grlt10if.getObject(i).getRfidDate().toString());
//						log_venueCDs.add(count, grlt10if.getObject(i).getVenueCD().toString());
//						log_rfidQtys.add(count, grlt10if.getObject(i).getRfidQty().toString());
//						count++;
//					}
//				}
//
//			}
//			gsys10mt.setIfResultCD("S");
//		}
//		catch (Exception e)
//		{
//			logger.debug(e.toString());
//			e.printStackTrace();
//
//			gsys10mt.setIfResultCD("E");
//		}
//		finally
//		{
//			//패스된 데이터 로그
//			for(int i=0; i<log_rfidDates.size(); i++) {
//				logger.error("##rfidDate : "+log_rfidDates.get(i)+", venuecd : "+log_venueCDs.get(i)+", rfidqty : "+log_rfidQtys.get(i));
//			}
//
//			simpleService.insert("COM03002I", gsys10mt);
//
//			SimpleClient.Disconnect();
//			return resultMap;
//		}
//	}
	
	//2015.02.12. taejoon.jang, BON
//	public Map angelnetInterface_salesInfo_bon(String startDate, String endDate) throws Exception {
//		TkbmMWSimpleClient SimpleClient = new TkbmMWSimpleClient();
//		SimpleClient.Connect("211.191.179.43", 3307);		// IDC 실망
//		Map resultMap = new HashMap();
//		GSYS10MT gsys10mt = new GSYS10MT();
//
//		List log_rfidDates = new ArrayList();
//		List log_venueCDs = new ArrayList();
//		List log_rfidQtys = new ArrayList();
//
//		try {
//			SimpleClient.RequestTimeout=5000;
//			String recv_data = null;
//			GRLT10IF grlt10if = new GRLT10IF();
//
//
//			// 서비스 파라메터 지정  (터미널ID , 조회시작일자, 조회종료일자 )
//		    Object[] p = null;
//
//		    if(startDate.equals("") && endDate.equals("")) {
//		    	startDate = FormatUtil.unFormat(DateUtil.getFirstDate(0));
//		    	endDate = FormatUtil.unFormat(DateUtil.getCurrentDate());
//		    	//2014.08.01, taejoon.jang, 매월1일이면 지난달 한달치 전부 가져오기
//		    	if(startDate.equals(endDate)) {
//		    		startDate = FormatUtil.unFormat(DateUtil.getFirstDate(-1));
//			    	endDate = FormatUtil.unFormat(DateUtil.getCurrentDate());
//		    	}
//		    	logger.debug("startDate : "+startDate);
//		    	logger.debug("endDate : "+endDate);
//		    	p = new Object[] {"D000000001", startDate, endDate};
//		    	grlt10if.setStartDate(startDate);
//		    	grlt10if.setEndDate(endDate);
//		    }
//		    else {
//		    	p = new Object[] {"D000000001", startDate, endDate};
//		    	grlt10if.setStartDate(startDate);
//		    	grlt10if.setEndDate(endDate);
//		    }
//
//		    // 서비스 요청
//			Object[] v = (Object[])SimpleClient.SendRequest("DIAGEO_AMS", "1.0", "REQUEST_SALESINFO_BON", new Object[] {p});
//
//			// 서버응답 추출
//			resultMap.put("resultCD", v[0]);
//			resultMap.put("resultMsg", v[1]);
//			resultMap.put("resultRows", v[2]);
//			logger.debug("응답코드 :  " + v[0]);
//			logger.debug("응답메시지 : " + v[1]);
//			logger.debug("레코드합계 :  " + v[2]);
//
//			int record_cnt = Integer.valueOf(String.valueOf(v[2]));
//
//			String[] rfidDates = null;
//			String[] venueCDs = null;
//			String[] angelPrd16CDs = null;
//			String[] angelPrdMlCDs = null;
//			String[] rfidQtys = null;
//
//			//log
//			gsys10mt.setIfNm("엔젤넷판매현황BON");
//			gsys10mt.setResultCD(v[0].toString());
//			gsys10mt.setResultMsg(v[1].toString());
//
//			if (record_cnt > 0) {
//				// 판매추이자료 추출 ....
//				SimpleClient.Transport.BeginRead();
//				SimpleClient.Transport.EndRead();
//				recv_data = new String(SimpleClient.GetResponseStream());
//
////				logger.debug(" ------------ Received Data Start --------------");
////				logger.debug(recv_data);
////				logger.debug(" ------------ End ............... --------------");
//
//				String recv_data_str = byteArrayToHex(SimpleClient.GetResponseStream()).toString();
////				logger.debug("byte->hex : "+recv_data_str);
//
//				String[] rows = recv_data_str.split(rowSplit);
//				rfidDates = new String[rows.length];
//				venueCDs = new String[rows.length];
//				angelPrd16CDs = new String[rows.length];
//				angelPrdMlCDs = new String[rows.length];
//				rfidQtys = new String[rows.length];
//
//				for(int i=0; i<rows.length; i++) {
//					String[] cols = rows[i].split(colSplit);
//					rfidDates[i] = new String(hexToByteArray(cols[0]));
//					venueCDs[i] = new String(hexToByteArray(cols[1]));
//					if(hexToByteArray(cols[2])!=null) {
//						angelPrd16CDs[i] = new String(hexToByteArray(cols[2]));
//					}
//					if(hexToByteArray(cols[3])!=null) {
//						angelPrdMlCDs[i] = new String(hexToByteArray(cols[3]));
//					}
//					rfidQtys[i] = new String(hexToByteArray(cols[4]));
//				}
//
//				grlt10if.setRfidDates(rfidDates);
//				grlt10if.setVenueCDs(venueCDs);
//				grlt10if.setAngelPrd16CDs(angelPrd16CDs);
//				grlt10if.setAngelPrdMlCDs(angelPrdMlCDs);
//				grlt10if.setRfidQtys(rfidQtys);
//
//				int count = 0;
//
////				2015.02.12, taejoon.jang, BON method가 나중에 타기때문에 삭제하면 안됨.
////				simpleService.delete("COM03001D", grlt10if);
//				for(int i=0; i<grlt10if.getSize(); i++) {
//					if(grlt10if.getObject(i).getAngelPrd16CD()!=null
//							|| grlt10if.getObject(i).getAngelPrdMlCDs()!=null) {
//						simpleService.insert("COM03001I", grlt10if.getObject(i));
//					}
//					else {
//						log_rfidDates.add(count, grlt10if.getObject(i).getRfidDate().toString());
//						log_venueCDs.add(count, grlt10if.getObject(i).getVenueCD().toString());
//						log_rfidQtys.add(count, grlt10if.getObject(i).getRfidQty().toString());
//						count++;
//					}
//				}
//
//			}
//			gsys10mt.setIfResultCD("S");
//		}
//		catch (Exception e)
//		{
//			logger.debug(e.toString());
//			e.printStackTrace();
//
//			gsys10mt.setIfResultCD("E");
//		}
//		finally
//		{
//			//패스된 데이터 로그
//			for(int i=0; i<log_rfidDates.size(); i++) {
//				logger.error("##rfidDate : "+log_rfidDates.get(i)+", venuecd : "+log_venueCDs.get(i)+", rfidqty : "+log_rfidQtys.get(i));
//			}
//
//			simpleService.insert("COM03002I", gsys10mt);
//
//			SimpleClient.Disconnect();
//			return resultMap;
//		}
//	}
	
	// hex to byte[]
	public static byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() == 0) {
			return null;
		}
	
		byte[] ba = new byte[hex.length() / 2];
		for (int i = 0; i < ba.length; i++) {
			ba[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
		}
		return ba;
	}

	// byte[] to hex
	public static String byteArrayToHex(byte[] ba) {
		if (ba == null || ba.length == 0) {
			return null;
		}
	
		StringBuffer sb = new StringBuffer(ba.length * 2);
		String hexNumber;
		for (int x = 0; x < ba.length; x++) {
			hexNumber = "0" + Integer.toHexString(0xff & ba[x]);
			sb.append(hexNumber.substring(hexNumber.length() - 2));
		}
		return sb.toString();
	}
	
	@RequestMapping("/create_datfile_batch")
	public void create_datfile_batch() throws Exception {
		GSYS10MT gsys10mt = new GSYS10MT();
		Map param = new HashMap();
		List<Map> data = new ArrayList();
		data =simpleService.queryForList("COM03013S",param);
		
		for (int i=0; i<data.size();i++){
			createDatFile(data.get(i));
		}
		        
	}
	
	@RequestMapping("/approve_email_batch")
	public void approve_email_batch() throws Exception {
		GSYS10MT gsys10mt = new GSYS10MT();
		Map param = new HashMap();
		List<Map> data = new ArrayList();
		
		String to_emailAddr = "";
		String to_empID = "";
		
		data =simpleService.queryForList("MAIL00001S",param);
		
		for (int i=0; i<data.size();i++){
			
			param =(Map)data.get(i);
			
			to_empID = param.get("empID").toString()+";";
			to_emailAddr = param.get("emailAddr").toString()+";";
			
			sendEmail(param);
		}
		        
	}
	
	private void sendEmail(Map inputData) throws Exception {
		//메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		
		Map param = inputData;
		String to_emailAddr = "";
		
		String cnt = "";
		String apprStateCDName = "";
		String eventym = "";
		
		list = simpleService.queryForList("MAIL00002S", param);
		
		to_emailAddr = param.get("emailAddr").toString()+";";
		
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				cnt = toMap.get("CNT").toString()+";";
				apprStateCDName = toMap.get("apprStateCDName").toString()+";";
				eventym = toMap.get("EVENTYM").toString()+";";
			}
		}
		
		//mail send
				Map map = new HashMap();
				String content = "";
				content+="<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> \n";
				content+="<html xmlns='http://www.w3.org/1999/xhtml' lang='ko' xml:lang='ko'> \n";
				content+="<head> \n";
				content+="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> \n";
				content+="<meta http-equiv='Content-Script-Type' content='text/javascript' /> \n";
				content+="<meta http-equiv='Content-Style-Type' content='text/css' /> \n";
				content+="<style> \n";
				content+="body {word-wrap:break-word;margin:0;padding:0} \n";
				content+="body {line-height:1.5; border:0 none;font-size:12px; font-family:'돋움',Dotum, AppleGothic, Helvetica, sans-serif; color:#444444;} \n";
				content+="img {border:0 none;} \n";
				content+="ul, ol, li {list-style:none;} \n";
				content+="a {text-decoration:none; color:#444444;} \n";
				content+="a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n";
				content+="a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n";
				content+="</style> \n";
				content+="<title>----</title> \n";
				content+="</head> \n";
				content+="<body> \n";
				content+="<table width='300' cellpadding='0' cellspacing='0' border='1'> \n";
				content+="	<tr> \n";
				content+="		<td style='width:100px;height:50px;text-align:center;'>TYPE</td> \n";
				content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+to_emailAddr+", 검증오류(브랜드 단위)</td> \n";
				content+="	</tr> \n";
				content+="	<tr> \n";
				content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
				content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+to_emailAddr+"</td> \n";
				content+="	</tr> \n";
				content+="	<tr> \n";
				
				String sender = "";
				sender = "junhak@nis.co.kr";
				
				content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
				content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
				content+="	</tr> \n";
				content+="</table> \n";
				content+="</body> \n";
				content+="</html> \n";
				
				map.put("to", to_emailAddr);
				map.put("subject", "테스트");
				map.put("content", content);
				map.put("from", sender);
				emailSender.sendMail(map);
	}

	private void createDatFile(Map inputData) throws Exception {
		GSYS10MT gsys10mt = new GSYS10MT();
		GDAT01MT gdat01mt = new GDAT01MT();
		Map param = inputData;
		List<Map> data = new ArrayList();
		
		gdat01mt.setGDATID((String) param.get("GDATID"));
		gdat01mt.setFILENAME((String) param.get("FILENAME"));
		
		gsys10mt.setIfNm("자료생성 Bat Scheduling");
		gsys10mt.setResultCD("Start");
		gsys10mt.setResultMsg("S");
		gsys10mt.setIfResultCD("s");
		
		//일괄 작업 시작 로그 추가
		simpleService.insert("COM03002I", gsys10mt);
		
		String tmp="";
		if(inputData.get("PLANRESULTCD").equals("01")){
			data =simpleService.queryForList("COM03015S",param);
		}else {
			data =simpleService.queryForList("COM03014S",param);
		}
		tmp=(String) param.get("FILENAME");
		
		try{
		 //생성할 파일 명
	    String fileName = "D:/DWFlatFile/" + tmp;//로컬에 만들 백업파일의 경로와 이름
	    File file = new File(fileName) ;
		BufferedWriter fw = new BufferedWriter(new FileWriter(fileName, false));
		String str = "";
			if (data.size() > 0) {
		        Iterator header = data.get(0).keySet().iterator();
		        String[] messagekey = new String[data.get(0).keySet().size()] ;
		        int keyindex = 0;
		        
		        while (header.hasNext()) {
		        	messagekey[keyindex++] = header.next().toString();
		        }
	
		        Map resultSet = null;
				for (int i=0; i < data.size(); i++) {
					str = "";
					resultSet = data.get(i);
	
					for (keyindex=0; keyindex < messagekey.length; keyindex++) {
						if (keyindex == 0) {
							str = StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])).replace(',', ' ');
						} else {
							str = str+"\t"+StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])).replace(',', ' ');
						}
					}
					fw.write(str);
					fw.newLine();
					fw.flush();
				}
				
				
			}
			fw.close();
		simpleService.update("COM03016U", gdat01mt);
		}catch(Exception ex) {
            logger.error("Error: " + ex.getMessage());
            ex.printStackTrace();
            gsys10mt.setIfResultCD("E");    		
        }
		
        gsys10mt.setResultCD("end");
		gsys10mt.setResultMsg("End");

		
		//일괄 작업 종료 로그 추가
		simpleService.insert("COM03002I", gsys10mt);
		
	}
	
}