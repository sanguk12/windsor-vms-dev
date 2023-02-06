package com.kia.ad.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.ad.model.GAD01MT;
import com.kia.ad.model.GME01MT;
import com.kia.rlt.model.GRLT01MT;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.util.FormatUtil;

@Service("ad01Service")
public class Ad01ServiceImpl implements Ad01Service {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	@Resource
	private EmailSender emailSender;

	@Override
	public void requestAppResultAD(GAD01MT gad01mt) throws Exception {

		String[] apAmts = gad01mt.getApAmts();
		String[] contractMonths = gad01mt.getContractMonths();
		int monthAdAmt[] = new int[apAmts.length];
		for(int i = 0; i < apAmts.length; i++) {
			String apAmt = apAmts[i];
			String contractMonth = contractMonths[i];
			monthAdAmt[i] = Integer.parseInt(apAmt.replace(",",""))/Integer.parseInt(contractMonth.replace(",",""));
		}

		//AD 승인요청 정보 갱신
		for (int i = 0; i < gad01mt.getSize(); i++) {
			GAD01MT gad01mt_a = gad01mt.getObject_request(i);

//			if (gad01mt_a.getApprExpc().equals("2")) {
//				gad01mt_a.setApprTpID("000006"); //Exception2
//			} else {
//				gad01mt_a.setApprTpID("000004"); //No Exception
//			}
			if (monthAdAmt[i] >= 3000) {
				gad01mt_a.setApprTpID("000006"); // TLA
			} else if(monthAdAmt[i] >= 1000){
				gad01mt_a.setApprTpID("000005"); // RLA
			} else if(monthAdAmt[i] >= 200){
				gad01mt_a.setApprTpID("000004"); // Simple AD
			} else{
				gad01mt_a.setApprTpID("000004"); // Simple AD
			}


			simpleDao.delete("AD0100201D", gad01mt_a);
			simpleDao.insert("AD0100201I", gad01mt_a);
			simpleDao.update("AD0100201U", gad01mt_a);

			Map mailMap = simpleDao.queryForMap("AD0100205S", gad01mt_a);

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
			content+="<table width='700' cellpadding='0' cellspacing='0' border='1'> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>TYPE</td> \n";
			content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+" 업소 등록 건이 승인요청 되었습니다.</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>NAME</td> \n";
			content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+"</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";
			content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
			content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gad01mt.getClientDate())+"</td> \n";
			content+="	</tr> \n";
			content+="	<tr> \n";

			String sender = "";
			sender = gad01mt.getEmpNm();

			content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
			content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+sender+"</td> \n";
			content+="	</tr> \n";
			content+="</table> \n";
			content+="</body> \n";
			content+="</html> \n";

			map.put("to", mailMap.get("EMAILADDR"));
			map.put("subject", FormatUtil.formatMonth(gad01mt_a.getAdSupportID())+"["+mailMap.get("VENUENM")+"], AD 승인요청 메일");
			map.put("content", content);
			map.put("from", gad01mt.getEmailAddr());
			System.out.println(content);
			System.out.println("AdSupportID:::::"+gad01mt_a.getAdSupportID());
			System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
			System.out.println("sender::::"+sender);
			System.out.println("to:::::"+mailMap.get("EMAILADDR"));
			System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt_a.getAdSupportID())+"["+mailMap.get("VENUENM")+"], AD 승인요청 메일");
			System.out.println("from::::"+gad01mt.getEmailAddr());
			emailSender.sendMail(map);
		}
	}

	@Override
	public void clearRequestAppResultAD(GAD01MT gad01mt) throws Exception {

		String[] apAmts = gad01mt.getApAmts();
		String[] contractMonths = gad01mt.getContractMonths();
		int monthAdAmt[] = new int[apAmts.length];
		for(int i = 0; i < apAmts.length; i++) {
			String apAmt = apAmts[i];
			String contractMonth = contractMonths[i];
			monthAdAmt[i] = Integer.parseInt(apAmt.replace(",",""))/Integer.parseInt(contractMonth.replace(",",""));
		}

		//AD 승인요청취소 정보 갱신
		for (int i = 0; i < gad01mt.getSize(); i++) {
			GAD01MT gad01mt_a = gad01mt.getObject_request(i);

//			if (gad01mt_a.getApprExpc().equals("2")) {
//				gad01mt_a.setApprTpID("000006"); //Exception 2
//			} else {
//				gad01mt_a.setApprTpID("000004"); //No Exception
//			}
			if (monthAdAmt[i] >= 3000) {
				gad01mt_a.setApprTpID("000006"); // TLA
			} else if(monthAdAmt[i] >= 1000){
				gad01mt_a.setApprTpID("000005"); // RLA
			} else if(monthAdAmt[i] >= 200){
				gad01mt_a.setApprTpID("000004"); // Simple AD
			} else{
				gad01mt_a.setApprTpID("000004"); // Simple AD
			}


			simpleDao.delete("AD0100202D", gad01mt_a);
			simpleDao.update("AD0100202U", gad01mt_a);
		}

	}

	@Override
	public String insertSupport(GAD01MT gad01mt) {
		String adSupportID = "";
		String [] eventYms;
		adSupportID = simpleDao.queryForMap("AD0100100S", gad01mt).get("adSupportID").toString();
		gad01mt.setAdSupportID(adSupportID);

		simpleDao.insert("AD0100101I", gad01mt);
		simpleDao.insert("AD0100105I", gad01mt);

		for(int i=0; i<gad01mt.getSize_prd(); i++) {
			if(gad01mt.getObject_prd(i,adSupportID).getActiveFlg().equals("D")) {
				simpleDao.delete("AD0100103D", gad01mt.getObject_prd(i,adSupportID));
			}
			else if(gad01mt.getObject_prd(i,adSupportID).getActiveFlg().equals("I")) {
				simpleDao.insert("AD0100102I", gad01mt.getObject_prd(i,adSupportID));
			}
			else if(gad01mt.getObject_prd(i,adSupportID).getActiveFlg().equals("U")) {
				simpleDao.update("AD0100102U", gad01mt.getObject_prd(i,adSupportID));
			}
		}

		eventYms = new String[Integer.parseInt(gad01mt.getContractMonth())];
		for(int j=0; j<eventYms.length;j++){
			if(j==0){
				eventYms[j] = gad01mt.getStartDT();
			}else{
				int yyyy = Integer.parseInt(eventYms[j-1].substring(0, 4));
				int mm = Integer.parseInt(eventYms[j-1].substring(4, 6))+1;
				String year = null;
				String month = null;
				if(mm>12){
					year=String.valueOf(yyyy+1);
					month=String.valueOf(mm-12);

				}else{
					year=String.valueOf(yyyy);
					month=String.valueOf(mm);
				}
				if (month.length() < 2){month = "0" + month;}
				eventYms[j] = year + month;
			}
		}

		for(int k=0; k<Integer.parseInt(gad01mt.getContractMonth()); k++) {
			gad01mt.setEventYm(eventYms[k]);
			simpleDao.insert("AD0100103I", gad01mt);
			for(int m=0; m<gad01mt.getSize_prd(); m++) {
				GAD01MT tmp = gad01mt.getObject_prd(m,adSupportID);
				tmp.setEventYm(eventYms[k]);
				tmp.setContractMonth(gad01mt.getContractMonth());
				if(!tmp.getActiveFlg().equals("D")) {
					simpleDao.insert("AD0100104I", tmp);
				}
			}
		}
		return adSupportID;
	}

	@Override
	public void updateSupport(GAD01MT gad01mt) {
		String [] eventYms;
		gad01mt.setApprStateCD("10");
		simpleDao.update("AD0100101U", gad01mt);
		simpleDao.update("AD0100103U", gad01mt);

		for(int i=0; i<gad01mt.getSize_prd(); i++) {
			if(gad01mt.getObject_prd(i,gad01mt.getAdSupportID()).getActiveFlg().equals("D")) {
				simpleDao.delete("AD0100103D", gad01mt.getObject_prd(i,gad01mt.getAdSupportID()));
			}
			else if(gad01mt.getObject_prd(i,gad01mt.getAdSupportID()).getActiveFlg().equals("I")) {
				simpleDao.insert("AD0100102I", gad01mt.getObject_prd(i,gad01mt.getAdSupportID()));
			}
			else if(gad01mt.getObject_prd(i,gad01mt.getAdSupportID()).getActiveFlg().equals("U")) {
				simpleDao.update("AD0100102U", gad01mt.getObject_prd(i,gad01mt.getAdSupportID()));
			}
		}

		simpleDao.delete("AD0100101D", gad01mt);
		simpleDao.delete("AD0100102D", gad01mt);
		eventYms = new String[Integer.parseInt(gad01mt.getContractMonth())];
		for(int j=0; j<eventYms.length;j++){
			if(j==0){
				eventYms[j] = gad01mt.getStartDT();
			}else{
				int yyyy = Integer.parseInt(eventYms[j-1].substring(0, 4));
				int mm = Integer.parseInt(eventYms[j-1].substring(4, 6))+1;
				String year = null;
				String month = null;
				if(mm>12){
					year=String.valueOf(yyyy+1);
					month=String.valueOf(mm-12);

				}else{
					year=String.valueOf(yyyy);
					month=String.valueOf(mm);
				}
				if (month.length() < 2){month = "0" + month;}
				eventYms[j] = year + month;
			}
		}

		for(int k=0; k<Integer.parseInt(gad01mt.getContractMonth()); k++) {
			gad01mt.setEventYm(eventYms[k]);
			simpleDao.insert("AD0100103I", gad01mt);

			for(int m=0; m<gad01mt.getSize_prd(); m++) {
				GAD01MT tmp = gad01mt.getObject_prd(m,gad01mt.getAdSupportID());

				tmp.setEventYm(eventYms[k]);
				tmp.setContractMonth(gad01mt.getContractMonth());

				if(!tmp.getActiveFlg().equals("D")){
					simpleDao.insert("AD0100104I", tmp);
				}
			}
		}
	}

}