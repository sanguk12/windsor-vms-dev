package com.kia.pay.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.util.FormatUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.kia.mil.model.GMIL01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;

@Service("pay03Service")
public class Pay03ServiceImpl implements Pay03Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	@Value("#{appenv['velex.mail']}")
	private String velex_mail;

	@Value("#{appenv['velex.name']}")
	private String velex_name;
	
	public void verifyFinishVenue(GRLT01MT grlt01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		
//		list = simpleDao.queryForList("PAY0300102S", grlt01mt);
//		if(list.size() > 0) {
//			for(int i=0; i<list.size(); i++) {
//				toMap = (Map)list.get(i);
//				to_emailAddr += toMap.get("emailAddr").toString()+";";
//			}
//		}
		
		//검증완료 갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_verify(i);
			grlt01mt_a.setVerifyStateCD("OK");		//검증상태 : 검증완료(OK)
			
			//선지원일경우 지급상태를 차감완료(70)로
			if(grlt01mt_a.getActivityCD().equals("20")) {
				grlt01mt_a.setPayStateCD("70");			//지급상태 : 차감완료(70)
			}
			else {
				grlt01mt_a.setPayStateCD("10");			//지급상태 : 지급대기(10)
			}
			
			simpleDao.update("PAY0300101U", grlt01mt_a);
			//선지원인경우 검증완료시 선지원의 차감내역 업데이트
			if(grlt01mt_a.getActivityCD().equals("20")) {
				simpleDao.update("PAY0300102U", grlt01mt_a);
			}
		}
		
//		//mail send
//		Map map = new HashMap();
//		String content = "";
//		content+="<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> \n";
//		content+="<html xmlns='http://www.w3.org/1999/xhtml' lang='ko' xml:lang='ko'> \n";
//		content+="<head> \n";
//		content+="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> \n";
//		content+="<meta http-equiv='Content-Script-Type' content='text/javascript' /> \n";
//		content+="<meta http-equiv='Content-Style-Type' content='text/css' /> \n";
//		content+="<style> \n";
//		content+="body {word-wrap:break-word;margin:0;padding:0} \n";
//		content+="body {line-height:1.5; border:0 none;font-size:12px; font-family:'돋움',Dotum, AppleGothic, Helvetica, sans-serif; color:#444444;} \n";
//		content+="img {border:0 none;} \n";
//		content+="ul, ol, li {list-style:none;} \n";
//		content+="a {text-decoration:none; color:#444444;} \n";
//		content+="a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n";
//		content+="a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n";
//		content+="</style> \n";
//		content+="<title>----</title> \n";
//		content+="</head> \n";
//		content+="<body> \n";
//		content+="<table width='600' cellpadding='0' cellspacing='0' border='1'> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>TYPE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증완료</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = velex_name;
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증완료 메일");
//		map.put("content", content);
//		map.put("from", velex_mail);
//		emailSender.sendMail(map);
	}
	
	public void verifyErrorVenue(GRLT01MT grlt01mt) throws Exception {
		//메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0300102S", grlt01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//검증오류 갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_verify(i);
			grlt01mt_a.setVerifyStateCD("ERR");		//검증상태 : 검증오류(ERR)
			grlt01mt_a.setPayStateCD("");			//지급상태 : ""
			simpleDao.update("PAY0300101U", grlt01mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류(업소 단위)</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = velex_name;
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류 메일(업소 단위)");
		map.put("content", content);
		map.put("from", velex_mail);
		emailSender.sendMail(map);
	}
	
	public void verifyFinishBrand(GRLT02MT grlt02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		
//		list = simpleDao.queryForList("PAY0300202S", grlt02mt);
//		if(list.size() > 0) {
//			for(int i=0; i<list.size(); i++) {
//				toMap = (Map)list.get(i);
//				to_emailAddr += toMap.get("emailAddr").toString()+";";
//			}
//		}
		
		//검증완료 갱신
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_verify(i);
			grlt02mt_a.setVerifyStateCD("OK");		//검증상태 : 검증완료(OK)
			
			//선지원일경우 지급상태를 차감완료(70)로
			if(grlt02mt_a.getActivityCD().equals("20")) {
				grlt02mt_a.setPayStateCD("70");			//지급상태 : 차감완료(70)
			}
			else {
				grlt02mt_a.setPayStateCD("10");			//지급상태 : 지급대기(10)
			}
			
			simpleDao.update("PAY0300201U", grlt02mt_a);
			//선지원인경우 검증완료시 선지원의 차감내역 업데이트
			if(grlt02mt_a.getActivityCD().equals("20")) {
				simpleDao.update("PAY0300202U", grlt02mt_a);
			}
		}
		
//		//mail send
//		Map map = new HashMap();
//		String content = "";
//		content+="<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> \n";
//		content+="<html xmlns='http://www.w3.org/1999/xhtml' lang='ko' xml:lang='ko'> \n";
//		content+="<head> \n";
//		content+="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> \n";
//		content+="<meta http-equiv='Content-Script-Type' content='text/javascript' /> \n";
//		content+="<meta http-equiv='Content-Style-Type' content='text/css' /> \n";
//		content+="<style> \n";
//		content+="body {word-wrap:break-word;margin:0;padding:0} \n";
//		content+="body {line-height:1.5; border:0 none;font-size:12px; font-family:'돋움',Dotum, AppleGothic, Helvetica, sans-serif; color:#444444;} \n";
//		content+="img {border:0 none;} \n";
//		content+="ul, ol, li {list-style:none;} \n";
//		content+="a {text-decoration:none; color:#444444;} \n";
//		content+="a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n";
//		content+="a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n";
//		content+="</style> \n";
//		content+="<title>----</title> \n";
//		content+="</head> \n";
//		content+="<body> \n";
//		content+="<table width='600' cellpadding='0' cellspacing='0' border='1'> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>TYPE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", 검증완료</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt02mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = velex_name;
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", 검증완료 메일");
//		map.put("content", content);
//		map.put("from", velex_mail);
//		emailSender.sendMail(map);
	}
	
	public void verifyErrorBrand(GRLT02MT grlt02mt) throws Exception {
		//메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0300202S", grlt02mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//검증오류 갱신
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_verify(i);
			grlt02mt_a.setVerifyStateCD("ERR");		//검증상태 : 검증오류(ERR)
			grlt02mt_a.setPayStateCD("");			//지급상태 : ""
			simpleDao.update("PAY0300201U", grlt02mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", 검증오류(브랜드 단위)</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(grlt02mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = velex_name;
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", 검증오류 메일(브랜드 단위)");
		map.put("content", content);
		map.put("from", velex_mail);
		emailSender.sendMail(map);
	}

	public void verifyFinishMileage(GMIL01MT gmil01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		
//		list = simpleDao.queryForList("PAY0300302S", grlt01mt);
//		if(list.size() > 0) {
//			for(int i=0; i<list.size(); i++) {
//				toMap = (Map)list.get(i);
//				to_emailAddr += toMap.get("emailAddr").toString()+";";
//			}
//		}

		//검증완료 갱신
		for(int i=0; i<gmil01mt.getSize_verify(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_verify(i);
			gmil01mt_a.setVerifyStateCD("OK");		//검증상태 : 검증완료(OK)
			logger.debug("gmil01mt_a.getMileagePayTPCD(): ["+gmil01mt_a.getMileagePayTPCD()+"]");
			//지급상태가 현금일때 지급대기, 이외의 건은 지금완료로 상태변화
			if(gmil01mt_a.getMileagePayTPCD().equals("10")) {
				//gmil01mt_a.setPayStateCD("30");			//지급상태 : 지급승인(30)
				gmil01mt_a.setPayStateCD("10");			//지급상태 : 지급대기(10)
			}
			else{
				gmil01mt_a.setPayStateCD("60");			//지급상태 : 지급완료(60)
			}
			
			simpleDao.update("PAY0300301U", gmil01mt_a);
		}

//		//mail send
//		Map map = new HashMap();
//		String content = "";
//		content+="<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> \n";
//		content+="<html xmlns='http://www.w3.org/1999/xhtml' lang='ko' xml:lang='ko'> \n";
//		content+="<head> \n";
//		content+="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> \n";
//		content+="<meta http-equiv='Content-Script-Type' content='text/javascript' /> \n";
//		content+="<meta http-equiv='Content-Style-Type' content='text/css' /> \n";
//		content+="<style> \n";
//		content+="body {word-wrap:break-word;margin:0;padding:0} \n";
//		content+="body {line-height:1.5; border:0 none;font-size:12px; font-family:'돋움',Dotum, AppleGothic, Helvetica, sans-serif; color:#444444;} \n";
//		content+="img {border:0 none;} \n";
//		content+="ul, ol, li {list-style:none;} \n";
//		content+="a {text-decoration:none; color:#444444;} \n";
//		content+="a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n";
//		content+="a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n";
//		content+="</style> \n";
//		content+="<title>----</title> \n";
//		content+="</head> \n";
//		content+="<body> \n";
//		content+="<table width='600' cellpadding='0' cellspacing='0' border='1'> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>TYPE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증완료(마일리지)</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = velex_name;
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증완료 메일(마일리지)");
//		map.put("content", content);
//		map.put("from", velex_mail);
//		emailSender.sendMail(map);
	}
	
	public void verifyErrorMileage(GMIL01MT gmil01mt) throws Exception {
		//메일정보
		/*
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0300302S", gmil01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		*/
		
		//검증오류 갱신
		for(int i=0; i<gmil01mt.getSize_verify(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_verify(i);
			gmil01mt_a.setVerifyStateCD("ERR");		//검증상태 : 검증오류(ERR)
			gmil01mt_a.setPayStateCD("");			//지급상태 : ""
			simpleDao.update("PAY0300301U", gmil01mt_a);
		}
		
		//mail send
		/*
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(gmil01mt.getEventYM())+", 검증오류(마일리지)</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gmil01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = velex_name;
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(gmil01mt.getEventYM())+", 검증오류 메일(마일리지)");
		map.put("content", content);
		map.put("from", velex_mail);
		emailSender.sendMail(map);
		*/
	}
}