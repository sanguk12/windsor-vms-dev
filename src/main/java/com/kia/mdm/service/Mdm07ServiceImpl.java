package com.kia.mdm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mdm.model.GVEN02MT;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.util.FormatUtil;

@Service("mdm07Service")
public class Mdm07ServiceImpl implements Mdm07Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void saveRmTmpVenue(GVEN02MT gven02mt) throws Exception {
		
		for(int i=0; i < gven02mt.getSize();i++){
			if(gven02mt.getObject_remove(i).getActiveFlg().equals("D")){
				simpleDao.delete("MDM0700101D", gven02mt.getObject_remove(i));
			}else if(gven02mt.getObject_remove(i).getActiveFlg().equals("I")){
				simpleDao.insert("MDM0700101I", gven02mt.getObject_remove(i));
			}else if(gven02mt.getObject_remove(i).getActiveFlg().equals("U")){
				simpleDao.delete("MDM0700101D", gven02mt.getObject_remove(i));
				simpleDao.insert("MDM0700101I", gven02mt.getObject_remove(i));
			}
		}
	}
	
	@Override
	public void requestApprRmTmpVenue(GVEN02MT gven02mt) throws Exception {

		
		//임시업소 승인요청 정보 갱신
		for(int i = 0; i < gven02mt.getSize(); i++) {
			simpleDao.delete("MDM0700201D", gven02mt.getObject_remove(i));
			simpleDao.insert("MDM0700201I", gven02mt.getObject_remove(i));
			simpleDao.update("MDM0700201U", gven02mt.getObject_remove(i));
		}
	}
	
	@Override
	public void clearRequestApprRmTmpVenue(GVEN02MT gven02mt) throws Exception {
		//임시 승인요청취소 정보 갱신
		for(int i = 0; i < gven02mt.getSize(); i++) {
			GVEN02MT gven02mt_a = gven02mt.getObject_remove(i);
			
			simpleDao.delete("MDM0700201D", gven02mt_a);
			simpleDao.update("MDM0700201U", gven02mt_a);
		}
	}

	@Override
	public void lastApprovalRmTmpVenue(GVEN02MT gven02mt) throws Exception {

		//임시 최종승인자 승인
		for(int i = 0; i < gven02mt.getSize(); i++) {
			GVEN02MT gven02mt_a = gven02mt.getObject_approval(i);

			//승인상태(승인)
			gven02mt_a.setApprStateCD("50");

			simpleDao.update("MDM0700301U", gven02mt_a);
			simpleDao.update("MDM0700302U", gven02mt_a);
			simpleDao.update("MDM0700308U", gven02mt_a);
		}
		
	}

	@Override
	public void approvalRmTmpVenue(GVEN02MT gven02mt) throws Exception {

		//임시업소 승인정보 갱신
		for(int i = 0; i < gven02mt.getSize(); i++) {
			GVEN02MT gven02mt_b = gven02mt.getObject_approval(i);
			
			if(gven02mt_b.getLevelNo().equals("2")) {

				//승인상태(승인중)
				gven02mt_b.setApprStateCD("30");
				
				simpleDao.update("MDM0700301U", gven02mt_b);
				simpleDao.update("MDM0700303U", gven02mt_b);
				simpleDao.update("MDM0700302U", gven02mt_b);
			}
			else {
				simpleDao.update("MDM0700302U", gven02mt_b);
				simpleDao.update("MDM0700303U", gven02mt_b);
			}
		}
		
		
	}

	@Override
	public void rejectRmTmpVenue(GVEN02MT gven02mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("MDM0700303S", gven02mt);
		
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//임시 업소 반려 갱신
		for(int i=0; i<gven02mt.getSize(); i++) {
			GVEN02MT gven02mt_a = gven02mt.getObject_reject(i);
			//임시 업소  반려
			gven02mt_a.setApprStateCD("40");
			simpleDao.update("MDM0700304U", gven02mt_a);
			simpleDao.update("MDM0700305U", gven02mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(gven02mt.getVenueCD())+", 임시 업소 삭제 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gven02mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = gven02mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(gven02mt.getVenueCD())+", 임시 업소 삭제 반려 메일");
		map.put("content", content);
		//map.put("from", gad01mt.getEmailAddr());
		map.put("from", gven02mt.getEmailAddr());
		emailSender.sendMail(map);		
	}
	
	@Override
	public void updatePrintYN(GVEN02MT gven02mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map venueCDMap = new HashMap();
		
		list = simpleDao.queryForList("MDM0700305S", gven02mt);
		
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				venueCDMap = (Map)list.get(i);
				simpleDao.update("MDM0700306U", venueCDMap.get("venueCD").toString());
			}
		}
		
	}
}