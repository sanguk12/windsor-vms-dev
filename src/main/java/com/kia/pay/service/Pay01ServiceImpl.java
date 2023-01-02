package com.kia.pay.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.common.web.EmailSender;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mil.model.GMIL01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;

@Service("pay01Service")
public class Pay01ServiceImpl implements Pay01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void saveResultWriteVenue_err(GRLT01MT grlt01mt) throws Exception {
		//검증상태가 반려, 검증오류일경우
		if(grlt01mt.getVerifyStateCD().equals("40") || grlt01mt.getVerifyStateCD().equals("ERR")) {
			simpleDao.update("PAY0100102U", grlt01mt);
			for(int i=0; i<grlt01mt.getSize_prd(); i++) {
				simpleDao.update("RLT0100105U", grlt01mt.getObject_prd(i));
			}
			simpleDao.delete("RLT0100105D", grlt01mt);
		}
		else {
			simpleDao.update("PAY0100101U", grlt01mt);
			for(int i=0; i<grlt01mt.getSize_prd(); i++) {
				simpleDao.update("RLT0100105U", grlt01mt.getObject_prd(i));
			}
		}
	}
	
	public void requestAppResultVenue_err(GRLT01MT grlt01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		toMap.put("empID", grlt01mt.getEmpID());
//		toMap.put("apprTpID", grlt01mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 검증승인정보갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			simpleDao.delete("PAY0100201D", grlt01mt.getObject_request(i));
			simpleDao.insert("PAY0100201I", grlt01mt.getObject_request(i));
			simpleDao.update("PAY0100201U", grlt01mt.getObject_request(i));
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender += grlt01mt.getRageSphereCDName().equals("")?"":"["+grlt01mt.getRageSphereCDName()+"]";
//		sender += grlt01mt.getOfficeCDName().equals("")?"":"["+grlt01mt.getOfficeCDName()+"]";
//		sender += grlt01mt.getTeamCDName().equals("")?"":"["+grlt01mt.getTeamCDName()+"]";
//		sender += grlt01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청 메일");
//		map.put("content", content);
//		map.put("from", grlt01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void clearRequestAppResultVenue_err(GRLT01MT grlt01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		toMap.put("empID", grlt01mt.getEmpID());
//		toMap.put("apprTpID", grlt01mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		String to_emailAddr = "";
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 검증승인정보갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			simpleDao.delete("PAY0100201D", grlt01mt.getObject_request(i));
			simpleDao.insert("PAY0100201U", grlt01mt.getObject_request(i));
		}
		
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청취소</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender += grlt01mt.getRageSphereCDName().equals("")?"":"["+grlt01mt.getRageSphereCDName()+"]";
//		sender += grlt01mt.getOfficeCDName().equals("")?"":"["+grlt01mt.getOfficeCDName()+"]";
//		sender += grlt01mt.getTeamCDName().equals("")?"":"["+grlt01mt.getTeamCDName()+"]";
//		sender += grlt01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청취소 메일");
//		map.put("content", content);
//		map.put("from", grlt01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void saveResultWriteBrand_err(GRLT02MT grlt02mt) throws Exception {
		//검증상태가 반려, 검증오류일경우
		for(int i=0; i<grlt02mt.getSize_prd(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_prd(i);
			if(grlt02mt_a.getVerifyStateCD().equals("40") || grlt02mt_a.getVerifyStateCD().equals("ERR")) {
				simpleDao.update("PAY0100304U", grlt02mt_a);
				simpleDao.delete("PAY0100305D", grlt02mt_a);
			} else {
				simpleDao.update("PAY0100301U", grlt02mt_a);
			}
		}
	}
	
	public void requestAppResultBrand_err(GRLT02MT grlt02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		toMap.put("empID", grlt02mt.getEmpID());
//		toMap.put("apprTpID", grlt02mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt02mt.getSize(); i++) {
			simpleDao.delete("PAY0100401D", grlt02mt.getObject_request(i));
			simpleDao.insert("PAY0100401I", grlt02mt.getObject_request(i));
			simpleDao.update("PAY0100401U", grlt02mt.getObject_request(i));
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
	
	public void clearRequestAppResultBrand_err(GRLT02MT grlt02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		toMap.put("empID", grlt02mt.getEmpID());
//		toMap.put("apprTpID", grlt02mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		String to_emailAddr = "";
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt02mt.getSize(); i++) {
			simpleDao.delete("PAY0100401D", grlt02mt.getObject_request(i));
			simpleDao.insert("PAY0100401U", grlt02mt.getObject_request(i));
		}
		
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 승인요청취소</td> \n";
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
//		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", Result 승인요청취소 메일");
//		map.put("content", content);
//		map.put("from", grlt02mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}

	public void saveResultWriteMileage_err(GMIL01MT gmil01mt) throws Exception {
		//검증상태가 반려, 검증오류일경우
		if(gmil01mt.getVerifyStateCD().equals("40") || gmil01mt.getVerifyStateCD().equals("ERR")) {
			simpleDao.update("PAY0100502U", gmil01mt);
			for(int i=0; i<gmil01mt.getSize(); i++) {
				simpleDao.update("MIL0100202U", gmil01mt.getObject(i));
			}
			simpleDao.delete("MIL0100206D", gmil01mt);
		}
		else {
			simpleDao.update("PAY0100501U", gmil01mt);
			for(int i=0; i<gmil01mt.getSize(); i++) {
				simpleDao.update("MIL0100202U", gmil01mt.getObject(i));
			}
		}
	}
	
	public void requestAppResultMileage_err(GMIL01MT gmil01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		toMap.put("empID", grlt01mt.getEmpID());
//		toMap.put("apprTpID", grlt01mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 검증승인정보갱신
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.delete("PAY0100601D", gmil01mt.getObject_req(i));
			simpleDao.insert("PAY0100601I", gmil01mt.getObject_req(i));
			simpleDao.update("PAY0100601U", gmil01mt.getObject_req(i));
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender += grlt01mt.getRageSphereCDName().equals("")?"":"["+grlt01mt.getRageSphereCDName()+"]";
//		sender += grlt01mt.getOfficeCDName().equals("")?"":"["+grlt01mt.getOfficeCDName()+"]";
//		sender += grlt01mt.getTeamCDName().equals("")?"":"["+grlt01mt.getTeamCDName()+"]";
//		sender += grlt01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청 메일");
//		map.put("content", content);
//		map.put("from", grlt01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void clearRequestAppResultMileage_err(GMIL01MT gmil01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		toMap.put("empID", grlt01mt.getEmpID());
//		toMap.put("apprTpID", grlt01mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		String to_emailAddr = "";
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//Result정보, 검증승인정보갱신
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.delete("PAY0100601D", gmil01mt.getObject_req(i));
			simpleDao.insert("PAY0100601U", gmil01mt.getObject_req(i));
		}
		
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청취소</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		content+="		<td style='width:200px;height:50px;'>DATE</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
//		content+="	</tr> \n";
//		content+="	<tr> \n";
//		
//		String sender = "";
//		sender += grlt01mt.getRageSphereCDName().equals("")?"":"["+grlt01mt.getRageSphereCDName()+"]";
//		sender += grlt01mt.getOfficeCDName().equals("")?"":"["+grlt01mt.getOfficeCDName()+"]";
//		sender += grlt01mt.getTeamCDName().equals("")?"":"["+grlt01mt.getTeamCDName()+"]";
//		sender += grlt01mt.getEmpNm();
//		
//		content+="		<td style='width:200px;height:50px;'>SENDER</td> \n";
//		content+="		<td style='width:400px;height:50px;'>"+sender+"</td> \n";
//		content+="	</tr> \n";
//		content+="</table> \n";
//		content+="</body> \n";
//		content+="</html> \n";
//		
//		map.put("to", to_emailAddr);
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 검증오류수정 승인요청취소 메일");
//		map.put("content", content);
//		map.put("from", grlt01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
}