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
import com.kia.sup.model.GSUP01MT;

@Service("pay04Service")
public class Pay04ServiceImpl implements Pay04Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private EmailSender emailSender;
	
	@Value("#{appenv['velex.mail']}")
	private String velex_mail;

	@Value("#{appenv['velex.name']}")
	private String velex_name;

	@Resource
	private SimpleDao simpleDao;
	
	public void applicationPayVenue(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			grlt01mt_a.setPayStateCD("20");			//지급상태 : 지급신청(20)
			simpleDao.update("PAY0400101U", grlt01mt_a);
		}
	}
	
	public void reVerifyReq(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			grlt01mt_a.setVerifyStateCD("REQ");			//검증상태 : 검증요청
			simpleDao.update("PAY0400102U", grlt01mt_a);
		}
	}

	public void payDueDateSave(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			simpleDao.update("PAY0400103U", grlt01mt_a);
		}
	}

	public void approvalPayVenue(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			grlt01mt_a.setPayStateCD("30");			//지급상태 : 지급승인(30)
			simpleDao.update("PAY0400201U", grlt01mt_a);
		}
	}
	
	public void rejectPayVenue(GRLT01MT grlt01mt) throws Exception {
		//하위승인자들 메일정보
		/*
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0400203S", grlt01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}
		*/

		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			grlt01mt_a.setPayStateCD("40");			//지급상태 : 지급반려(40)
			simpleDao.update("PAY0400202U", grlt01mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 지급 반려</td> \n";
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
		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 지급 반려 메일");
		map.put("content", content);
		map.put("from", grlt01mt.getEmailAddr());
		emailSender.sendMail(map);
		*/
	}
	
	public void finishPayVenue(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			grlt01mt_a.setPayStateCD("60");			//지급상태 : 지급완료(60)
			simpleDao.update("PAY0400301U", grlt01mt_a);
		}
	}
	
	public void holdPayVenue(GRLT01MT grlt01mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0400203S", grlt01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}

		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			grlt01mt_a.setPayStateCD("50");			//지급상태 : 지급보류(50)
			simpleDao.update("PAY0400302U", grlt01mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 지급 보류</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(grlt01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		//String sender = "";
		//sender = grlt01mt.getEmpNm();
		String sender = "";
		sender = velex_name;
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 지급 보류 메일");
		map.put("content", content);
		//map.put("from", grlt01mt.getEmailAddr());
		map.put("from", velex_mail);
		emailSender.sendMail(map);
	}
	
	public void savePayCommVenue(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			GRLT01MT grlt01mt_a = grlt01mt.getObject_pay(i);
			simpleDao.update("PAY0400303U", grlt01mt_a);
		}
	}
	
	public void saveKeymanVenue_G2(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			simpleDao.update("PAY0400701U", grlt01mt.getObject_payKeyman(i));
		}
	}
	
	public void finishPaySupport(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			GSUP01MT gsup01mt_a = gsup01mt.getObject_pay(i);
			gsup01mt_a.setSupportStateCD("60");			//선지원상태 : 지급완료(60)
			if(gsup01mt_a.getPayTpCD().equals("ORG")) {
				simpleDao.update("PAY0401001U", gsup01mt_a);
			}
			else if(gsup01mt_a.getPayTpCD().equals("ADD")) {
				simpleDao.update("PAY0401003U", gsup01mt_a);
			}
		}
	}
	
	public void holdPaySupport(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			GSUP01MT gsup01mt_a = gsup01mt.getObject_pay(i);
			gsup01mt_a.setSupportStateCD("50");			//선지원상태 : 지급보류(50)
			if(gsup01mt_a.getPayTpCD().equals("ORG")) {
				simpleDao.update("PAY0401002U", gsup01mt_a);
			}
			else if(gsup01mt_a.getPayTpCD().equals("ADD")) {
				simpleDao.update("PAY0401004U", gsup01mt_a);
			}
		}
	}
	
	public void savePayCommSupport(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			GSUP01MT gsup01mt_a = gsup01mt.getObject_pay(i);
			if(gsup01mt_a.getPayTpCD().equals("ORG")) {
				simpleDao.update("PAY0401005U", gsup01mt_a);
			}
			else if(gsup01mt_a.getPayTpCD().equals("ADD")) {
				simpleDao.update("PAY0401006U", gsup01mt_a);
			}
		}
	}

	public void payDueDateSaveSupport(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			//simpleDao.update("PAY0400107U", gsup01mt.getObject_pay(i));
			GSUP01MT gsup01mt_a = gsup01mt.getObject_pay(i);
			if(gsup01mt_a.getPayTpCD().equals("ORG")) {
				simpleDao.update("PAY0400107U", gsup01mt_a);
			}
			else if(gsup01mt_a.getPayTpCD().equals("ADD")) {
				simpleDao.update("PAY0400108U", gsup01mt_a);
			}
		}
	}

	public void saveKeymanBrand(GRLT02MT grlt02mt) throws Exception {
		for(int i=0; i<grlt02mt.getSize(); i++) {
			simpleDao.update("PAY0400401U", grlt02mt.getObject_pay(i));
		}
	}
	
	public void applicationPayBrand(GRLT02MT grlt02mt) throws Exception {
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_pay(i);
			grlt02mt_a.setPayStateCD("20");			//지급상태 : 지급신청(20)
			simpleDao.update("PAY0400402U", grlt02mt_a);
		}
	}
	
	public void reVerifyReqBrand(GRLT02MT grlt02mt) throws Exception {
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_pay(i);
			grlt02mt_a.setVerifyStateCD("REQ");			//검증상태 : 검증요청
			simpleDao.update("PAY0400403U", grlt02mt_a);
		}
	}

	public void payDueDateSaveBrand(GRLT02MT grlt02mt) throws Exception {
		for(int i=0; i<grlt02mt.getSize(); i++) {
			simpleDao.update("PAY0400404U", grlt02mt.getObject_pay(i));
		}
	}

	public void approvalPayBrand(GRLT02MT grlt02mt) throws Exception {
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_pay(i);
			grlt02mt_a.setPayStateCD("30");			//지급상태 : 지급승인(30)
			simpleDao.update("PAY0400501U", grlt02mt_a);
		}
	}
	
	public void rejectPayBrand(GRLT02MT grlt02mt) throws Exception {
		//하위승인자들 메일정보
		/*
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0400203S", grlt02mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}
		*/
		//to_emailAddr += velex_mail +";";

		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_pay(i);
			grlt02mt_a.setPayStateCD("40");			//지급상태 : 지급반려(40)
			simpleDao.update("PAY0400502U", grlt02mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", 지급 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(grlt02mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = grlt02mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", 지급 반려 메일");
		map.put("content", content);
		map.put("from", grlt02mt.getEmailAddr());
		emailSender.sendMail(map);
		*/
		
	}
	
	public void finishPayBrand(GRLT02MT grlt02mt) throws Exception {
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_pay(i);
			grlt02mt_a.setPayStateCD("60");			//지급상태 : 지급완료(60)
			simpleDao.update("PAY0400601U", grlt02mt_a);
		}
	}
	
	public void holdPayBrand(GRLT02MT grlt02mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0400503S", grlt02mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}
				
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_pay(i);
			grlt02mt_a.setPayStateCD("50");			//지급상태 : 지급보류(50)
			simpleDao.update("PAY0400602U", grlt02mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt02mt.getEventYM())+", 지급  보류(브랜드 단위)</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(grlt02mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		//String sender = "";
		//sender = grlt02mt.getEmpNm();
		String sender = "";
		sender = velex_name;
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(grlt02mt.getEventYM())+", 지급 보류 메일(브랜드 단위)");
		map.put("content", content);
		//map.put("from", grlt02mt.getEmailAddr());
		map.put("from", velex_mail);
		emailSender.sendMail(map);

	}
	
	public void savePayCommBrand(GRLT02MT grlt02mt) throws Exception {
		for(int i=0; i<grlt02mt.getSize(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_pay(i);
			simpleDao.update("PAY0400603U", grlt02mt_a);
		}
	}

	public void finishPayMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			gmil01mt_a.setMileageStateCD("60");			//마일리지지급상태 : 지급완료(60)
			simpleDao.update("PAY0401101U", gmil01mt_a);
		}
	}
	
	public void holdPayMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			gmil01mt_a.setMileageStateCD("50");			//마일리지지급상태 : 지급보류(50)
			simpleDao.update("PAY0401102U", gmil01mt_a);
		}
	}
	
	public void savePayCommMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			simpleDao.update("PAY0401105U", gmil01mt_a);
		}
	}

	public void payDueDateSaveMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			//simpleDao.update("PAY0400107U", gsup01mt.getObject_pay(i));
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			simpleDao.update("PAY0401107U", gmil01mt_a);
		}
	}

	public void applicationPayMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			gmil01mt_a.setPayStateCD("20");			//지급상태 : 지급신청(20)
			simpleDao.update("PAY0401201U", gmil01mt_a);
		}
	}
	
	public void reVerifyReqMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			gmil01mt_a.setVerifyStateCD("REQ");			//검증상태 : 검증요청
			simpleDao.update("PAY0401202U", gmil01mt_a);
		}
	}

	public void approvalPayMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			gmil01mt_a.setPayStateCD("30");			//지급상태 : 지급승인(30)
			simpleDao.update("PAY0401301U", gmil01mt_a);
		}
	}
	
	public void rejectPayMileage(GMIL01MT gmil01mt) throws Exception {
		//하위승인자들 메일정보
		/*
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("PAY0400203S", grlt01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
		}
		*/

		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			GMIL01MT gmil01mt_a = gmil01mt.getObject_pay(i);
			gmil01mt_a.setPayStateCD("40");			//지급상태 : 지급반려(40)
			simpleDao.update("PAY0401302U", gmil01mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", 지급 반려(마일리지)</td> \n";
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
		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", 지급 반려 메일(마일리지)");
		map.put("content", content);
		map.put("from", grlt01mt.getEmailAddr());
		emailSender.sendMail(map);
		*/
	}
}