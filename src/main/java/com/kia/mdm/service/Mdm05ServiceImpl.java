package com.kia.mdm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.util.FormatUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.ad.model.GAD01MT;
import com.kia.mdm.model.GVEN01MT;
import com.kia.mdm.model.GVEN03MT;

@Service("mdm05Service")
public class Mdm05ServiceImpl implements Mdm05Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private SimpleService simpleService;
	
	@Resource
	private EmailSender emailSender;
	
	public String insertVenue(GVEN03MT gven03mt) throws Exception {
		String tmpVenueCD = "";
		int maxCnt = 0;
		//임시업소코드 생성
		tmpVenueCD = simpleDao.queryForMap("MDM0500100S", gven03mt).get("tmpVenueCD").toString();
		maxCnt = simpleDao.queryForInt("MDM0500106S", gven03mt);

		gven03mt.setVenSeq(String.valueOf(maxCnt));
		gven03mt.setRequestStateCD("10");
		gven03mt.setTmpVenueCD(tmpVenueCD);
		
		simpleDao.insert("MDM0500101I", gven03mt);
		return tmpVenueCD;
	}
	

	@Override
	public void resetTmpVenue(GVEN03MT gven03mt) throws Exception {
		gven03mt.setRequestStateCD("10");
		
		simpleDao.delete("MDM0500201D", gven03mt);
		simpleDao.update("MDM0500101U", gven03mt);
	}
	
	public void updateVenue(GVEN03MT gven03mt) throws Exception {
		simpleDao.update("MDM0500101U", gven03mt);
	}
	
	public void saveTmpVenueGrid(GVEN03MT gven03mt) throws Exception {
		String tmpVenueCD = "";
		String dkmdTpCD = "";
		int maxCnt = 0;
		
		dkmdTpCD = simpleDao.queryForMap("MDM0500105S", gven03mt).get("dkmdTpCD").toString();
		gven03mt.setRequestStateCD("10");
		gven03mt.setActiveYN("Y");
		gven03mt.setIncntTpCD("VEN");
		//gven03mt.setVenueDivCD("10");
		
		for(int i = 0; i < gven03mt.getSize(); i++) {
			//임시업소코드 생성
			tmpVenueCD = simpleDao.queryForMap("MDM0500100S", gven03mt).get("tmpVenueCD").toString();
			maxCnt = simpleDao.queryForInt("MDM0500106S", gven03mt);
			
			gven03mt.setTmpVenueCD(tmpVenueCD);
			gven03mt.setDkmdTpCD(dkmdTpCD);
			gven03mt.setVenSeq(String.valueOf(maxCnt));
			
			simpleDao.insert("MDM0500101I", gven03mt.getObject(i));
		}
	}

	@Override
	public void requestApprTmpVenue(GVEN03MT gven03mt) throws Exception {

		//임시업소 승인요청 정보 갱신
		for(int i = 0; i < gven03mt.getTmpSize(); i++) {
			GVEN03MT gven03mt_a = gven03mt.getObject_request(i);
			simpleDao.delete("MDM0500201D", gven03mt_a);
			simpleDao.insert("MDM0500201I", gven03mt_a);
			simpleDao.update("MDM0500201U", gven03mt_a);
		}
	}

	@Override
	public void clearRequestApprTmpVenue(GVEN03MT gven03mt) throws Exception {

		//임시 승인요청취소 정보 갱신
		for(int i = 0; i < gven03mt.getTmpSize(); i++) {
			GVEN03MT gven03mt_a = gven03mt.getObject_request(i);
			
			simpleDao.delete("MDM0500201D", gven03mt_a);
			simpleDao.update("MDM0500201U", gven03mt_a);
		}
	}

	@Override
	public void lastApprovalTmpVenue(GVEN03MT gven03mt) throws Exception {

		//임시 최종승인자 승인
		for(int i = 0; i < gven03mt.getTmpSize(); i++) {
			GVEN03MT gven03mt_a = gven03mt.getObject_approval(i);

			//승인상태(승인)
			gven03mt_a.setApprStateCD("50");

			simpleDao.update("MDM0500307U", gven03mt_a);
			simpleDao.update("MDM0500302U", gven03mt_a);
			simpleDao.update("MDM0500301U", gven03mt_a);
		}
		
	}

	@Override
	public void approvalTmpVenue(GVEN03MT gven03mt) throws Exception {

		//임시업소 승인정보 갱신
		for(int i = 0; i < gven03mt.getTmpSize(); i++) {
			GVEN03MT gven03mt_b = gven03mt.getObject_approval(i);
			
			if(gven03mt_b.getLevelNo().equals("2")) {

				//승인상태(승인중)
				gven03mt_b.setApprStateCD("30");
				
				simpleDao.update("MDM0500301U", gven03mt_b);
				simpleDao.update("MDM0500303U", gven03mt_b);
				simpleDao.update("MDM0500302U", gven03mt_b);
			}
			else {
				simpleDao.update("MDM0500302U", gven03mt_b);
				simpleDao.update("MDM0500303U", gven03mt_b);
			}
		}
		
		
	}

	@Override
	public void rejectTmpVenue(GVEN03MT gven03mt) throws Exception {
		//하위승인자들 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		String to_emailAddr = "";
		
		list = simpleDao.queryForList("MDM0500303S", gven03mt);
		
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				to_emailAddr += toMap.get("emailAddr").toString()+";";
			}
		}
		
		//임시 업소 반려 갱신
		for(int i=0; i<gven03mt.getTmpSize(); i++) {
			GVEN03MT gven03mt_a = gven03mt.getObject_reject(i);
			//임시 업소  반려
			gven03mt_a.setApprStateCD("40");
			simpleDao.update("MDM0500304U", gven03mt_a);
			simpleDao.update("MDM0500305U", gven03mt_a);
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatMonth(gven03mt.getTmpVenueCD())+", 산규 임시 업소 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gven03mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		
		String sender = "";
		sender = gven03mt.getEmpNm();
		
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatMonth(gven03mt.getTmpVenueCD())+", 신규 임시 업소  반려 메일");
		map.put("content", content);
		//map.put("from", gad01mt.getEmailAddr());
		map.put("from", gven03mt.getEmailAddr());
		emailSender.sendMail(map);		
	}

	@Override
	public void printChk(GVEN03MT gven03mt) throws Exception {
		
		if (gven03mt.getTmpSize() > 0 || gven03mt.getCdSize() > 0) {
			
			for (int i = 0; i < gven03mt.getTmpSize(); i++) {
				//신규
				if (gven03mt.getGbn().equals("I")) {
					simpleDao.update("MDM0500306U", gven03mt.getObject_printChk_new(i));
				}
				
			}
			
			for (int j = 0; j < gven03mt.getCdSize(); j++) {
				//변경	
				if(gven03mt.getGbn().equals("U")){
					simpleDao.update("MDM0600307U", gven03mt.getObject_printChk_update(j));
				//삭제	
				} else if(gven03mt.getGbn().equals("D")){
					simpleDao.update("MDM0700307U", gven03mt.getObject_printChk_update(j));
				}
				
			}
			
		} else {
			
			//신규
			if (gven03mt.getGbn().equals("I")) {
				simpleDao.update("MDM0500306U", gven03mt);
			//변경	
			} else if(gven03mt.getGbn().equals("U")){
				simpleDao.update("MDM0600307U", gven03mt);
			//삭제
			} else if(gven03mt.getGbn().equals("D")){
				simpleDao.update("MDM0700307U", gven03mt);
			}
			
		}
		
		
	}


	@Override
	public void excelCount(GVEN03MT gven03mt) throws Exception {
		simpleDao.insert("MDM0500306U", gven03mt);
	}


	@Override
	public void excelSeq(GVEN03MT gven03mt) throws Exception {
		simpleDao.insert("MDM0500301I", gven03mt);
	}


}