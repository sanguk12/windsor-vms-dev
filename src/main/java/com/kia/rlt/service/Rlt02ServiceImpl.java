package com.kia.rlt.service;

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

import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;

@Service("rlt02Service")
public class Rlt02ServiceImpl implements Rlt02Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void approvalResultVenue(GRLT01MT grlt01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		GRLT01MT grlt01mt_a = grlt01mt.getObject_approval(0);
//		
//		list = simpleDao.queryForList("RLT0200102S", grlt01mt_a);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_b = grlt01mt.getObject_approval(i);
			
			if(grlt01mt_b.getLevelNo().equals("2")) {
				//Result정보 승인중
				grlt01mt_b.setApprStateCD("30");
				grlt01mt_b.setVerifyStateCD("");
				simpleDao.update("RLT0200101U", grlt01mt_b);
				//Result승인정보 갱신
				simpleDao.update("RLT0200102U", grlt01mt_b);
				simpleDao.update("RLT0200103U", grlt01mt_b);
			}
			else {
				//Result승인정보 갱신
				simpleDao.update("RLT0200102U", grlt01mt_b);
				simpleDao.update("RLT0200103U", grlt01mt_b);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 승인요청</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = "["+grlt01mt.getRageSphereCDName()+"]"+"["+grlt01mt.getOfficeCDName()+"]"+"["+grlt01mt.getTeamCDName()+"]"+grlt01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 승인요청 메일");
//		map.put("content", content);
//		map.put("from", grlt01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void lastApprovalResultVenue(GRLT01MT grlt01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//하위승인자들 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		
//		list = simpleDao.queryForList("RLT0200103S", grlt01mt);
//		if(list.size() > 0) {
//			for(int i=0; i<list.size(); i++) {
//				toMap = (Map)list.get(i);
//				to_emailAddr += toMap.get("emailAddr").toString()+";";
//			}
//		}
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_approval(i);
			//Result정보 승인
			grlt01mt_a.setApprStateCD("50");
			grlt01mt_a.setVerifyStateCD("REQ");
			simpleDao.update("RLT0200101U", grlt01mt_a);
			//Result승인정보 갱신
			simpleDao.update("RLT0200102U", grlt01mt_a);
			//중기약정일경우 중기약정 지급금액 갱신
			simpleDao.update("RLT0200114U", grlt01mt_a);
			//중기약정일경우 중기약정 상태값 갱신
			simpleDao.update("RLT0200115U", grlt01mt_a);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 승인완료</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = grlt01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 승인완료 메일");
//		map.put("content", content);
//		map.put("from", grlt01mt.getEmailAddr());
//		emailSender.sendMail(map);
	}
	
	public void rejectResultVenue(GRLT01MT grlt01mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		//list = simpleDao.queryForList("RLT0200104S", grlt01mt);
		list = simpleDao.queryForList("RLT0200404S", grlt01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//Result정보, 반려정보갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_reject_apprType(i);
			
			/*Normal*/
			if(grlt01mt_a.getApprType().equals("10")){
				grlt01mt_a.setApprTpID(grlt01mt_a.getApprTpID_Normal());
				
				/*Special*/
			} else if(grlt01mt_a.getApprType().equals("30")) {
				grlt01mt_a.setApprTpID(grlt01mt_a.getApprTpID());
			}
			
			//Result정보 반려
			grlt01mt_a.setApprStateCD("40");
			grlt01mt_a.setVerifyStateCD("");
			//simpleDao.update("RLT0200101U", grlt01mt_a);
			simpleDao.update("RLT0200401U", grlt01mt_a);
			//Result승인정보 반려
			//simpleDao.update("RLT0200104U", grlt01mt_a);
			simpleDao.update("RLT0200404U", grlt01mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = grlt01mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 반려 메일");
		map.put("content", content);
		map.put("from", grlt01mt.getEmailAddr());
		emailSender.sendMail(map);
	}
	
	public void approvalResultBrand(GRLT02MT grlt02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		GRLT02MT grlt02mt_a = grlt02mt.getObject_approval(0);
//		
//		list = simpleDao.queryForList("RLT0200202S", grlt02mt_a);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_b = grlt02mt.getObject_approval(i);
			if(grlt02mt_b.getLevelNo().equals("2")) {
				//Result정보 승인중
				grlt02mt_b.setApprStateCD("30");
				simpleDao.update("RLT0200201U", grlt02mt_b);
				//Result승인정보 갱신
				simpleDao.update("RLT0200202U", grlt02mt_b);
				simpleDao.update("RLT0200203U", grlt02mt_b);
			}
			else {
				//Result승인정보 갱신
				simpleDao.update("RLT0200202U", grlt02mt_b);
				simpleDao.update("RLT0200203U", grlt02mt_b);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 승인요청</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt02mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = "["+grlt02mt.getRageSphereCDName()+"]"+"["+grlt02mt.getOfficeCDName()+"]"+"["+grlt02mt.getTeamCDName()+"]"+grlt02mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 승인요청 메일");
//		map.put("content", content);
//		map.put("from", grlt02mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void lastApprovalResultBrand(GRLT02MT grlt02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//하위승인자들 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		
//		list = simpleDao.queryForList("RLT0200203S", grlt02mt);
//		if(list.size() > 0) {
//			for(int i=0; i<list.size(); i++) {
//				toMap = (Map)list.get(i);
//				to_emailAddr += toMap.get("emailAddr").toString()+";";
//			}
//		}
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_approval(i);
			//Result정보 승인
			grlt02mt_a.setApprStateCD("50");
			grlt02mt_a.setVerifyStateCD("REQ");
			simpleDao.update("RLT0200201U", grlt02mt_a);
			//Result승인정보 갱신
			simpleDao.update("RLT0200202U", grlt02mt_a);
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 승인완료</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt02mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender = grlt02mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 승인완료 메일");
//		map.put("content", content);
//		map.put("from", grlt02mt.getEmailAddr());
//		emailSender.sendMail(map);
	}
	
	public void rejectResultBrand(GRLT02MT grlt02mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("RLT0200204S", grlt02mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//Result정보, 반려정보갱신
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_reject(i);
			//Result정보 반려
			grlt02mt_a.setApprStateCD("40");
			simpleDao.update("RLT0200201U", grlt02mt_a);
			//Result승인정보 반려
			simpleDao.update("RLT0200204U", grlt02mt_a);
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
		content+="<table width='600' cellpadding='0' cellspacing='0' border='1'> \n";
		content+="	<tr> \n";
		content+="		<td style='width:200px;height:50px;'>TYPE</td> \n";
		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 반려(브랜드 단위)</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt02mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = grlt02mt.getEmpNm();
		
		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 반려 메일(브랜드 단위)");
		map.put("content", content);
		map.put("from", grlt02mt.getEmailAddr());
		emailSender.sendMail(map);
	}
	
	public void approvalResultVenue_apprType(GRLT01MT grlt01mt) throws Exception {
		/*Normal*/
		if(grlt01mt.getApprType().equals("10")){
			grlt01mt.setApprTpID(grlt01mt.getApprTpID_Normal());
			
		/*Special*/
		} else if(grlt01mt.getApprType().equals("30")) {
			grlt01mt.setApprTpID(grlt01mt.getApprTpID());
		}
		
		if(grlt01mt.getLevelNo().equals("2")) {
			//Result정보 승인중
			grlt01mt.setApprStateCD("30");
			grlt01mt.setVerifyStateCD("");
			simpleDao.update("RLT0200401U", grlt01mt);
			//Result승인정보 갱신
			simpleDao.update("RLT0200402U", grlt01mt);
			simpleDao.update("RLT0200403U", grlt01mt);
		}
		else {
			//Result승인정보 갱신
			simpleDao.update("RLT0200402U", grlt01mt);
			simpleDao.update("RLT0200403U", grlt01mt);
		}
	}
	
	public void lastApprovalResultVenue_apprType(GRLT01MT grlt01mt) throws Exception {
		/*Normal*/
		if(grlt01mt.getApprType().equals("10")){
			grlt01mt.setApprTpID(grlt01mt.getApprTpID_Normal());
			
		/*Special*/
		} else if(grlt01mt.getApprType().equals("30")) {
			grlt01mt.setApprTpID(grlt01mt.getApprTpID());
		}
		
		//Result정보, 승인정보갱신
		//Result정보 승인
		grlt01mt.setApprStateCD("50");
		grlt01mt.setVerifyStateCD("REQ");
		simpleDao.update("RLT0200401U", grlt01mt);
		//Result승인정보 갱신
		simpleDao.update("RLT0200402U", grlt01mt);
	}
	
	public void approvalResultVenue_new(GRLT01MT grlt01mt) throws Exception {
		//Result정보, 승인정보갱신
		GRLT01MT grlt01mt_b = grlt01mt.getObject_approval_new(0);
		if(grlt01mt_b.getLevelNo().equals("2")) {
			//Result정보 승인중
			grlt01mt_b.setApprStateCD("30");
			grlt01mt_b.setVerifyStateCD("");
			simpleDao.update("RLT0200501U", grlt01mt_b);
			//Result승인정보 갱신
			simpleDao.update("RLT0200502U", grlt01mt_b);
			simpleDao.update("RLT0200503U", grlt01mt_b);
		}
		else {
			//Result승인정보 갱신
			simpleDao.update("RLT0200502U", grlt01mt_b);
			simpleDao.update("RLT0200503U", grlt01mt_b);
		}
	}
	
	public void lastApprovalResultVenue_new(GRLT01MT grlt01mt) throws Exception {
		//Result정보, 승인정보갱신
		GRLT01MT grlt01mt_a = grlt01mt.getObject_approval_new(0);
		//Result정보 승인
		grlt01mt_a.setApprStateCD("50");
		grlt01mt_a.setVerifyStateCD("REQ");
		simpleDao.update("RLT0200501U", grlt01mt_a);
		//Result승인정보 갱신
		simpleDao.update("RLT0200502U", grlt01mt_a);
	}
	
	public void rejectResultVenue_new(GRLT01MT grlt01mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("RLT0200504S", grlt01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
			
		//Result정보 반려
		grlt01mt.setApprStateCD("40");
		grlt01mt.setVerifyStateCD("");
		simpleDao.update("RLT0200501U", grlt01mt);
		//Result승인정보 반려
		simpleDao.update("RLT0200504U", grlt01mt);
		
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = grlt01mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 반려 메일");
		map.put("content", content);
		map.put("from", grlt01mt.getEmailAddr());
		emailSender.sendMail(map);
	}
	
	public void approvalResult(GRLT01MT grlt01mt) throws Exception {
		
		//Result정보, 승인정보갱신			
		if(grlt01mt.getLevelNo().equals("2")) {
			//Result정보 승인중
			grlt01mt.setApprStateCD("30");
			grlt01mt.setVerifyStateCD("");
			simpleDao.update("RLT0201101U", grlt01mt);
			//Result승인정보 갱신
			simpleDao.update("RLT0201102U", grlt01mt);
			simpleDao.update("RLT0201103U", grlt01mt);
		}else {
			//Result승인정보 갱신
			simpleDao.update("RLT0201102U", grlt01mt);
			simpleDao.update("RLT0201103U", grlt01mt);
		}		
	}
	
	
	public void lastApprovalResult(GRLT01MT grlt01mt) throws Exception {		
		//Result정보, 승인정보갱신				
		//Result정보 승인
		grlt01mt.setApprStateCD("50");
		grlt01mt.setVerifyStateCD("REQ");
		simpleDao.update("RLT0201101U", grlt01mt);
		//Result승인정보 갱신
		simpleDao.update("RLT0201102U", grlt01mt);
		//중기약정일경우 중기약정 지급금액 갱신
		simpleDao.update("RLT0201114U", grlt01mt);
			
	}
	
	public void rejectResult(GRLT01MT grlt01mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
			
		list = simpleDao.queryForList("RLT0201105S", grlt01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//Result정보, 반려정보갱신				
		/*Normal*/
		if(grlt01mt.getApprType().equals("10")){
			grlt01mt.setApprTpID(grlt01mt.getApprTpID_Normal());				
		/*Special*/
		} else if(grlt01mt.getApprType().equals("30")) {
			grlt01mt.setApprTpID(grlt01mt.getApprTpID());
		}
		
		//Result정보 반려
		grlt01mt.setApprStateCD("40");
		grlt01mt.setVerifyStateCD("");			
		simpleDao.update("RLT0201105U", grlt01mt);
		//Result승인정보 반려			
		simpleDao.update("RLT0201106U", grlt01mt);
		
	}
}