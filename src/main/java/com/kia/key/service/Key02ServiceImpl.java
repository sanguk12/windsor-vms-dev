package com.kia.key.service;

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

import com.kia.api.model.GAPI01MT;
import com.kia.key.model.GKEY01MT;

@Service("key02Service")
public class Key02ServiceImpl implements Key02Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void approvalKeymanID(GKEY01MT gkey01mt) throws Exception {
		//키맨신청정보, 승인정보갱신
		for(int i=0; i<gkey01mt.getSize(); i++) {
			GKEY01MT gkey01mt_b = gkey01mt.getObject_approval(i);
			if(gkey01mt_b.getLevelNo().equals("2")) {
				//키맨신청정보 승인중
				gkey01mt_b.setRequestStateCD("20");
				simpleDao.update("KEY0200101U", gkey01mt_b);
				//키맨신청승인정보 갱신
				simpleDao.update("KEY0200102U", gkey01mt_b);
				simpleDao.update("KEY0200103U", gkey01mt_b);
			}
			else {
				//키맨신청승인정보 갱신
				simpleDao.update("KEY0200102U", gkey01mt_b);
				simpleDao.update("KEY0200103U", gkey01mt_b);
			}
		}
	}
	
	public void lastApprovalKeymanID(GKEY01MT gkey01mt) throws Exception {
		//키맨신청정보, 승인정보갱신
		for(int i=0; i<gkey01mt.getSize(); i++) {
			GKEY01MT gkey01mt_a = gkey01mt.getObject_approval(i);
			GKEY01MT gkey01mt_b = new GKEY01MT();
			//키맨신청정보 승인
			gkey01mt_a.setRequestStateCD("40");
			simpleDao.update("KEY0200101U", gkey01mt_a);
			//키맨신청승인정보 갱신
			simpleDao.update("KEY0200102U", gkey01mt_a);
			
			//개인 , 주민번호 null , 010일때
            if(simpleDao.queryForInt("KEY0200111S",gkey01mt_a) > 0) {
		        //키맨신청정보 인증완료
				gkey01mt_a.setRequestStateCD("60");
				simpleDao.update("KEY0300101U", gkey01mt_a);
				
				List list = new ArrayList();
				     list = simpleDao.queryForList("KEY0200112S", gkey01mt_a);
				Map Map = new HashMap();
				    Map = (Map)list.get(0);
				if(list.size() > 0) {
					
					gkey01mt_b.setKeymanID( Map.get("KEYMANID").toString() );
					gkey01mt_b.setVenueCD ( Map.get("VENUECD").toString() );
					gkey01mt_b.setKeymanNm( Map.get("KEYMANNM").toString() );
					gkey01mt_b.setKeymanTypeCD( Map.get("KEYMANTYPECD").toString() );
					gkey01mt_b.setBirthDate( Map.get("BIRTHDATE").toString() );
					gkey01mt_b.setAddr( Map.get("ADDR").toString() );
					gkey01mt_b.setPhoneNo( Map.get("PHONENO").toString() );
					
					if(Map.get("BANKCD") != null){
					    gkey01mt_b.setBankCD( Map.get("BANKCD").toString() );
					}
					
					if(Map.get("ACCOUNTNO") != null){
					    gkey01mt_b.setAccountNo( Map.get("ACCOUNTNO").toString() );
					}
					
					if(Map.get("HOLDERNM") != null){
					    gkey01mt_b.setHolderNm( Map.get("HOLDERNM").toString() );
					}
					
					gkey01mt_b.setDutyCD( Map.get("DUTYCD").toString() );
					
					if(Map.get("NOTE") != null){
					    gkey01mt_b.setNote( Map.get("NOTE").toString() );
					}
					gkey01mt_b.setPkeymanYN( Map.get("PKEYMANYN").toString() );
					
					if(Map.get("EMAILADDR") != null){
					    gkey01mt_b.setEmailAddr( Map.get("EMAILADDR").toString() );
					}
					gkey01mt_b.setRequestTpCD( Map.get("REQUESTTPCD").toString() );
					
				}
				System.out.println("gkey01mt_b.getRequestTpCD() : "+gkey01mt_b.getRequestTpCD().toString());
				if(gkey01mt_b.getRequestTpCD().equals("NEW")) {
					//키맨정보 갱신
					simpleDao.insert("KEY0300101I", gkey01mt_b);
					//simpleDao.update("MOB01S01P", gkey01mt_b);
				}
				else {
					//키맨정보 갱신
					simpleDao.update("KEY0300102U", gkey01mt_b);
				}
            }		
		}		
	}
	
	public void rejectKeymanID(GKEY01MT gkey01mt) throws Exception {
		
		//키맨신청정보, 반려정보갱신
		for(int i=0; i<gkey01mt.getSize(); i++) {
			GKEY01MT gkey01mt_a = gkey01mt.getObject_reject(i);
			
			//하위승인자들 메일정보
			List list = new ArrayList();
			Map toMap = new HashMap();
			String to_emailAddr = "";
			list = simpleDao.queryForList("KEY0200102S", gkey01mt_a);
			if(list.size() > 0) {
				for(int j=0; j<list.size(); j++) {
					toMap = (Map)list.get(j);
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
			
			//키맨신청정보 반려
			gkey01mt_a.setRequestStateCD("30");
			simpleDao.update("KEY0200101U", gkey01mt_a);
			//키맨신청승인정보 반려
			simpleDao.update("KEY0200104U", gkey01mt_a);
			
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
			content+="<table width='400' cellpadding='0' cellspacing='0' border='1'> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>TYPE</td> \n";
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gkey01mt_a.getRequestDate())+" 신청, Customer 승인 반려</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>구분</td> \n";
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+gkey01mt_a.getRequestTpCDName()+"</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>업소</td> \n";
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+gkey01mt_a.getVenueCD()+", "+gkey01mt_a.getVenueNm()+"</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>Customer</td> \n";
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+gkey01mt_a.getKeymanNm()+"</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gkey01mt_a.getClientDate())+"</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";
			
			String sender = "";
			sender = gkey01mt_a.getEmpNm();
			
			content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
			content+="	</tr> \n";
			content+="</table> \n";
			content+="</body> \n";
			content+="</html> \n";
			
			map.put("to", to_emailAddr);
			map.put("subject", FormatUtil.formatDate(gkey01mt_a.getRequestDate())+", Customer 승인 반려 메일");
			map.put("content", content);
			map.put("from", gkey01mt_a.getEmailAddr());
			emailSender.sendMail(map);
		}
	}
}