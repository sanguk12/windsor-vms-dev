package com.kia.pln.service;

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
import org.springframework.stereotype.Service;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02MT;

@Service("pln02Service")
public class Pln02ServiceImpl implements Pln02Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void approvalPlanVenue(GPLN01MT gpln01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		GPLN01MT gpln01mt_a = gpln01mt.getObject_approval(0);
//		
//		list = simpleDao.queryForList("PLN0200102S", gpln01mt_a);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//plan정보, 승인정보갱신
		for(int i=0; i<gpln01mt.getSize(); i++) {
			GPLN01MT gpln01mt_b = gpln01mt.getObject_approval(i);
			if(gpln01mt_b.getLevelNo().equals("2")) {
				//plan정보 승인중
				gpln01mt_b.setApprStateCD("30");
				//simpleDao.update("PLN0200101U", gpln01mt_b);
				simpleDao.update("PLN0200401U", gpln01mt_b);
				//plan승인정보 갱신
				//simpleDao.update("PLN0200102U", gpln01mt_b);
				//simpleDao.update("PLN0200103U", gpln01mt_b);
				simpleDao.update("PLN0200402U", gpln01mt_b);
				simpleDao.update("PLN0200403U", gpln01mt_b);
			}
			else {
				//plan승인정보 갱신
				//simpleDao.update("PLN0200102U", gpln01mt_b);
				//simpleDao.update("PLN0200103U", gpln01mt_b);
				simpleDao.update("PLN0200402U", gpln01mt_b);
				simpleDao.update("PLN0200403U", gpln01mt_b);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 승인요청</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(gpln01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = "["+gpln01mt.getRageSphereCDName()+"]"+"["+gpln01mt.getOfficeCDName()+"]"+"["+gpln01mt.getTeamCDName()+"]"+gpln01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 승인요청 메일");
//		map.put("content", content);
//		map.put("from", gpln01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void lastApprovalPlanVenue(GPLN01MT gpln01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//하위승인자들 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		
//		list = simpleDao.queryForList("PLN0200103S", gpln01mt);
//		if(list.size() > 0) {
//			for(int i=0; i<list.size(); i++) {
//				toMap = (Map)list.get(i);
//				to_emailAddr += toMap.get("emailAddr").toString()+";";
//			}
//		}
		
		//plan정보, 승인정보갱신
		for(int i=0; i<gpln01mt.getSize(); i++) {
			GPLN01MT gpln01mt_a = gpln01mt.getObject_approval(i);
			//plan정보 승인
			gpln01mt_a.setApprStateCD("50");
			//simpleDao.update("PLN0200101U", gpln01mt_a);
			simpleDao.update("PLN0200401U", gpln01mt_a);
			//plan승인정보 갱신
			//simpleDao.update("PLN0200102U", gpln01mt_a);
			simpleDao.update("PLN0200402U", gpln01mt_a);
			//마일리지 플랜존재할경우(상태가 '50') 마일리지 여부 업데이트
			//simpleDao.update("PLN0200105U", gpln01mt_a);
			simpleDao.update("PLN0200405U", gpln01mt_a);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 승인완료</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(gpln01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = gpln01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 승인완료 메일");
//		map.put("content", content);
//		map.put("from", gpln01mt.getEmailAddr());
//		emailSender.sendMail(map);
	}
	
	public void rejectPlanVenue(GPLN01MT gpln01mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		//list = simpleDao.queryForList("PLN0200104S", gpln01mt);
		list = simpleDao.queryForList("PLN0200404S", gpln01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}
		
		//plan정보, 반려정보갱신
		for(int i=0; i<gpln01mt.getSize(); i++) {
			GPLN01MT gpln01mt_a = gpln01mt.getObject_reject(i);
			//plan정보 반려
			gpln01mt_a.setApprStateCD("40");
			//simpleDao.update("PLN0200101U", gpln01mt_a);
			simpleDao.update("PLN0200401U", gpln01mt_a);
			//plan승인정보 반려
			//simpleDao.update("PLN0200104U", gpln01mt_a);
			simpleDao.update("PLN0200404U", gpln01mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gpln01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = gpln01mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 반려 메일");
		map.put("content", content);
		map.put("from", gpln01mt.getEmailAddr());
		emailSender.sendMail(map);
	}
	
	public void approvalPlanBrand(GPLN02MT gpln02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		GPLN02MT gpln02mt_a = gpln02mt.getObject_approval(0);
//		
//		list = simpleDao.queryForList("PLN0200202S", gpln02mt_a);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//plan정보, 승인정보갱신
		for(int i=0; i<gpln02mt.getSize(); i++) {
			GPLN02MT gpln02mt_b = gpln02mt.getObject_approval(i);
			if(gpln02mt_b.getLevelNo().equals("2")) {
				//plan정보 승인중
				gpln02mt_b.setApprStateCD("30");
				simpleDao.update("PLN0200201U", gpln02mt_b);
				//plan승인정보 갱신
				simpleDao.update("PLN0200202U", gpln02mt_b);
				simpleDao.update("PLN0200203U", gpln02mt_b);
			}
			else {
				//plan승인정보 갱신
				simpleDao.update("PLN0200202U", gpln02mt_b);
				simpleDao.update("PLN0200203U", gpln02mt_b);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 승인요청</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(gpln02mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = "["+gpln02mt.getRageSphereCDName()+"]"+"["+gpln02mt.getOfficeCDName()+"]"+"["+gpln02mt.getTeamCDName()+"]"+gpln02mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 승인요청 메일");
//		map.put("content", content);
//		map.put("from", gpln02mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void lastApprovalPlanBrand(GPLN02MT gpln02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//하위승인자들 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		
//		list = simpleDao.queryForList("PLN0200203S", gpln02mt);
//		if(list.size() > 0) {
//			for(int i=0; i<list.size(); i++) {
//				toMap = (Map)list.get(i);
//				to_emailAddr += toMap.get("emailAddr").toString()+";";
//			}
//		}
		
		//plan정보, 승인정보갱신
		for(int i=0; i<gpln02mt.getSize(); i++) {
			GPLN02MT gpln02mt_a = gpln02mt.getObject_approval(i);
			//plan정보 승인
			gpln02mt_a.setApprStateCD("50");
			simpleDao.update("PLN0200201U", gpln02mt_a);
			//plan승인정보 갱신
			simpleDao.update("PLN0200202U", gpln02mt_a);
			//마일리지plan상태가 '50'인경우 찾아서  plan 마일리지여부 업데이트
			simpleDao.update("PLN0200205U", gpln02mt_a);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 승인완료</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(gpln02mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = gpln02mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 승인완료 메일");
//		map.put("content", content);
//		map.put("from", gpln02mt.getEmailAddr());
//		emailSender.sendMail(map);
	}
	
	public void rejectPlanBrand(GPLN02MT gpln02mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PLN0200204S", gpln02mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//plan정보, 반려정보갱신
		for(int i=0; i<gpln02mt.getSize(); i++) {
			GPLN02MT gpln02mt_a = gpln02mt.getObject_reject(i);
			//plan정보 반려
			gpln02mt_a.setApprStateCD("40");
			simpleDao.update("PLN0200201U", gpln02mt_a);
			//plan승인정보 반려
			simpleDao.update("PLN0200204U", gpln02mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 반려(브랜드 단위)</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gpln02mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = gpln02mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 반려 메일(브랜드 단위)");
		map.put("content", content);
		map.put("from", gpln02mt.getEmailAddr());
		emailSender.sendMail(map);
	}
	
	public void approvalPlanVenue_new(GPLN01MT gpln01mt) throws Exception {
		//plan정보, 승인정보갱신
		GPLN01MT gpln01mt_b = gpln01mt.getObject_approval_new(0);
		if(gpln01mt_b.getLevelNo().equals("2")) {
			//plan정보 승인중
			gpln01mt_b.setApprStateCD("30");
			simpleDao.update("PLN0200501U", gpln01mt_b);
			//plan승인정보 갱신
			simpleDao.update("PLN0200502U", gpln01mt_b);
			simpleDao.update("PLN0200503U", gpln01mt_b);
		}
		else {
			//plan승인정보 갱신
			simpleDao.update("PLN0200502U", gpln01mt_b);
			simpleDao.update("PLN0200503U", gpln01mt_b);
		}
	}
	
	public void lastApprovalPlanVenue_new(GPLN01MT gpln01mt) throws Exception {
		//plan정보, 승인정보갱신
		GPLN01MT gpln01mt_a = gpln01mt.getObject_approval_new(0);
		//plan정보 승인
		gpln01mt_a.setApprStateCD("50");
		simpleDao.update("PLN0200501U", gpln01mt_a);
		//plan승인정보 갱신
		simpleDao.update("PLN0200502U", gpln01mt_a);
		//마일리지 플랜존재할경우(상태가 '50') 마일리지 여부 업데이트
		simpleDao.update("PLN0200505U", gpln01mt_a);
	}
	
	public void rejectPlanVenue_new(GPLN01MT gpln01mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PLN0200504S", gpln01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}
		
		//plan정보, 반려정보갱신
		//plan정보 반려
		gpln01mt.setApprStateCD("40");
		simpleDao.update("PLN0200501U", gpln01mt);
		//plan승인정보 반려
		simpleDao.update("PLN0200504U", gpln01mt);
		
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gpln01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = gpln01mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 반려 메일");
		map.put("content", content);
		map.put("from", gpln01mt.getEmailAddr());
		emailSender.sendMail(map);
	}

	public void approvalPlan(GPLN01MT gpln01mt) throws Exception {
		
		//plan정보, 승인정보갱신	
		if(gpln01mt.getLevelNo().equals("2")) {
			//plan정보 승인중
			gpln01mt.setApprStateCD("30");
			simpleDao.update("PLN0201101U", gpln01mt);
			//plan승인정보 갱신
			simpleDao.update("PLN0201102U", gpln01mt);
			simpleDao.update("PLN0201103U", gpln01mt);
		}else {
			//plan승인정보 갱신
			simpleDao.update("PLN0201102U", gpln01mt);
			simpleDao.update("PLN0201103U", gpln01mt);
		}
	}

	public void lastApprovalPlan(GPLN01MT gpln01mt) throws Exception {
		//plan정보, 승인정보갱신
		//plan정보 승인
		gpln01mt.setApprStateCD("50");
		simpleDao.update("PLN0201101U", gpln01mt);
		//plan승인정보 갱신
		simpleDao.update("PLN0201102U", gpln01mt);			
		
	}
	
	
	public void rejectPlan(GPLN01MT gpln01mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PLN0201104S", gpln01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}
		
		//plan정보, 반려정보갱신		
		//plan정보 반려
		gpln01mt.setApprStateCD("40");
		simpleDao.update("PLN0201105U", gpln01mt);
		//plan승인정보 반려
		simpleDao.update("PLN0201104U", gpln01mt);
		
	}	
}