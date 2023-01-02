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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.kia.key.dao.Key03Dao;
import com.kia.key.model.GKEY01MT;

@Service("key03Service")
public class Key03ServiceImpl implements Key03Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	@Resource
	private Key03Dao key03Dao;
	
	@Value("#{appenv['velex.mail']}")
	private String velex_mail;

	@Value("#{appenv['velex.name']}")
	private String velex_name;
	
	public void setKey03Dao(Key03Dao key03Dao){
		this.key03Dao = key03Dao;
	}
	
	public void completeAccreKeymanID(GKEY01MT gkey01mt) throws Exception {
		//키맨신청정보, 승인정보갱신
		for(int i=0; i<gkey01mt.getSize(); i++) {
			GKEY01MT gkey01mt_a = gkey01mt.getObject_completeAccre(i);
			
			//키맨신청정보 인증완료
			gkey01mt_a.setRequestStateCD("60");
			simpleDao.update("KEY0300101U", gkey01mt_a);
			
			if(gkey01mt_a.getRequestTpCD().equals("NEW")) {
				//키맨정보 갱신
				simpleDao.insert("KEY0300101I", gkey01mt_a);
				//simpleDao.update("MOB01S01P", gkey01mt_a);
			}
			else {
				//키맨정보 갱신
				simpleDao.update("KEY0300102U", gkey01mt_a);
			}
		}
	}

	public void errorAccreKeymanID(GKEY01MT gkey01mt) throws Exception {
		//키맨신청정보, 인증오류정보갱신
		for(int i=0; i<gkey01mt.getSize(); i++) {
			GKEY01MT gkey01mt_a = gkey01mt.getObject_errorAccre(i);
			
			//하위승인자들 메일정보(VALEX담당자 사용)
			List list = new ArrayList();
			Map toMap = new HashMap();
			String to_emailAddr = "";
			list = simpleDao.queryForList("KEY0300102S", gkey01mt_a);
			if(list.size() > 0) {
				for(int j=0; j<list.size(); j++) {
					toMap = (Map)list.get(j);
					to_emailAddr += toMap.get("emailAddr").toString()+";";
				}
			}
			
			//키맨신청정보 인증오류
			gkey01mt_a.setRequestStateCD("50");
			simpleDao.update("KEY0300101U", gkey01mt_a);
			
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
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gkey01mt_a.getRequestDate())+" 신청, Customer 인증 오류</td> \n";
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
			sender = velex_name;
			
			content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
			content+="		<td style='width:300px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
			content+="	</tr> \n";
			content+="</table> \n";
			content+="</body> \n";
			content+="</html> \n";
			
			map.put("to", to_emailAddr);
			map.put("subject", FormatUtil.formatDate(gkey01mt_a.getRequestDate())+", Customer 인증 오류 메일");
			map.put("content", content);
			map.put("from", velex_mail);
			emailSender.sendMail(map);
		}
		
	}
	
	public void saveKeymanActiveYN(GKEY01MT gkey01mt) throws Exception {
		for(int i=0; i<gkey01mt.getSize(); i++) {
			GKEY01MT gkey01mt_a = gkey01mt.getObject_activeYN(i);
			gkey01mt_a.setRegIDNo(gkey01mt.getRegIDNos()[i]);
			gkey01mt_a.setBirthDate(gkey01mt.getBirthDates()[i]);
			simpleDao.update("KEY0300201U", gkey01mt_a);
		}
		
	}
	
	public void updateKeymanDocComp(GKEY01MT gkey01mt) throws Exception {
			simpleDao.update("KEY0300301U", gkey01mt);
	}
	
	public void updateKeymanDocMngFl(GKEY01MT gkey01mt) throws Exception {
		simpleDao.update("KEY0300302U", gkey01mt);
	}
	
	public void sendSMS(ArrayList<HashMap<String, String>> smsList) throws Exception{
		int insertCount = key03Dao.smsSend(smsList);
		
		logger.debug("insertCount : "+insertCount);
	}
}