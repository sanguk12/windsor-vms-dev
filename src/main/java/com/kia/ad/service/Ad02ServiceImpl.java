package com.kia.ad.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.ad.model.GAD01MT;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.util.FormatUtil;

@Service("ad02Service")
public class Ad02ServiceImpl implements Ad02Service {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	@Resource
	private SimpleService simpleService;

	@Resource
	private EmailSender emailSender;

	@Override
	public void approvalResultAD(GAD01MT gad01mt) throws Exception {


		//처음 승인요청 보낼 시 
		if(gad01mt.getLevelNo().equals("2")) {

			//승인중
			gad01mt.setApprStateCD("30");

			simpleDao.update("AD0200101U", gad01mt);
			simpleDao.update("AD0200102U", gad01mt);
			simpleDao.update("AD0200103U", gad01mt);
		}
		else {
			simpleDao.update("AD0200102U", gad01mt);
			simpleDao.update("AD0200103U", gad01mt);
		}


		Map mailMap = simpleDao.queryForMap("AD0100205S", gad01mt);

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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+" 업소 등록 건이 승인 되었습니다.</td> \n";
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
		//map.put("subject", FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"], AD 승인요청 메일");
		map.put("subject", gad01mt.getEmpID() + " : VMS-AD 승인요청 <" + mailMap.get("EMAILADDR") + ">");
		map.put("content", content);
		map.put("from", gad01mt.getEmailAddr());
		System.out.println("AdSupportID:::::"+gad01mt.getAdSupportID());
		System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
		System.out.println("sender::::"+sender);
		System.out.println("to:::::"+mailMap.get("EMAILADDR"));
		System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"], AD 승인요청 메일");
		System.out.println("from::::"+gad01mt.getEmailAddr());
		emailSender.sendMail(map);

	}

	@Override
	public void lastApprovalResultAD(GAD01MT gad01mt) throws Exception {

		//AD정보 
		gad01mt.setApprStateCD("50");
		//AD계약 Y
		gad01mt.setActiveYN_02("Y");

		simpleDao.update("AD0200101U", gad01mt);
		//AD승인정보 갱신
		simpleDao.update("AD0200102U", gad01mt);
		//AD계약여부
		simpleDao.update("AD0200106U", gad01mt);
		//AD HistoryCD
		simpleDao.insert("AD0200101I", gad01mt);

		Map mailMap = simpleDao.queryForMap("AD0200116S", gad01mt);

// 2021-10-06_AD 승인완료시 메일 발송 주석 처리		
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+" 업소 등록 건이  승인완료 되었습니다.</td> \n";
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
		//map.put("subject", FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"], AD 승인완료 메일");
		map.put("subject", gad01mt.getEmpID() + " : VMS-AD 승인완료 <"  + mailMap.get("EMAILADDR") + ">");
		map.put("content", content);
		map.put("from", gad01mt.getEmailAddr());
		System.out.println("AdSupportID:::::"+gad01mt.getAdSupportID());
		System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
		System.out.println("sender::::"+sender);
		System.out.println("to:::::"+mailMap.get("EMAILADDR"));
		System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"], AD 승인완료 메일");
		System.out.println("from::::"+gad01mt.getEmailAddr());
		emailSender.sendMail(map);

	}

	@Override
	public void rejectResultAD(GAD01MT gad01mt) throws Exception {

		//AD정보 반려
		gad01mt.setApprStateCD("40");

		//AD 계약 정보 변경
		simpleDao.update("AD0200104U", gad01mt);
		//AD 계약 승인 정보 변경
		simpleDao.update("AD0200105U", gad01mt);
		//simpleDao.update("AD0200107U", gad01mt_a);

		Map mailMap = simpleDao.queryForMap("AD0200116S", gad01mt);

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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+"업소 등록 건이 반려 되었습니다.</td> \n";
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
		map.put("subject", gad01mt.getEmpID() + " : VMS-AD 반려 <" + mailMap.get("EMAILADDR") + ">");
		map.put("content", content);
		map.put("from", gad01mt.getEmailAddr());
		System.out.println("AdSupportID:::::"+gad01mt.getAdSupportID());
		System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
		System.out.println("sender::::"+sender);
		System.out.println("to:::::"+mailMap.get("EMAILADDR"));
		System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"], AD 반려 메일");
		System.out.println("from::::"+gad01mt.getEmailAddr());
		emailSender.sendMail(map);
	}

	@Override
	public void finishContractAD(GAD01MT gad01mt) throws Exception {

		String[] apAmts = gad01mt.getApAmts();
		String[] contractMonths = gad01mt.getContractMonths();
		int monthAdAmt[] = new int[apAmts.length];
		for(int i = 0; i < apAmts.length; i++) {
			String apAmt = apAmts[i];
			String contractMonth = contractMonths[i];
			monthAdAmt[i] = Integer.parseInt(apAmt.replace(",",""))/Integer.parseInt(contractMonth.replace(",",""));
		}

		//AD 계약 정보
		for (int i = 0; i < gad01mt.getSize(); i++) {
			GAD01MT gad01mt_a = gad01mt.getObject_finishContract(i);
			//AD 계약 완료
			gad01mt_a.setContractStateCD("10");

			simpleDao.update("AD0200201U", gad01mt_a);

//			if (gad01mt_a.getApprExpc().equals("2")) {
//				gad01mt_a.setApprTpID("000006"); //Exception 2
//			} else {
//				gad01mt_a.setApprTpID("000004"); // No Exception
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


		}

	}

	@Override
	public void finishPayAD(GAD01MT gad01mt) throws Exception {

		//AD 지급 정보
		for(int i = 0; i < gad01mt.getSize(); i++) {
			GAD01MT gad01mt_a = gad01mt.getObject_finishPay(i);
			//AD 지급 완료
			gad01mt_a.setPayStateCD("10");

			simpleDao.update("AD0200202U", gad01mt_a);
		}

	}


	@Override
	public void tmpInsertSupport(GAD01MT gad01mt) throws Exception {
		String[] eventYms;
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMM");
		String adSeq = simpleDao.queryForMap("AD0200428S", gad01mt).get("adSeq").toString();
		int prdCnt = 0;

		gad01mt.setAdSeq(adSeq);
		gad01mt.setApprStateCD("10");

		//임시 데이터 삽입
		simpleDao.insert("AD0200401I", gad01mt);
		simpleDao.insert("AD0200405I", gad01mt);

		for(int i = 0; i < gad01mt.getSize_prd(); i++) {
			prdCnt = simpleDao.queryForInt("AD0200429S",  gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
			if(prdCnt > 0) {
				if(gad01mt.getObject_prd(i,gad01mt.getAdSeq()).getActiveFlg().equals("D")) {
					simpleDao.delete("AD0200403D", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
				}
				else if(gad01mt.getObject_prd(i,gad01mt.getAdSeq()).getActiveFlg().equals("I")) {
					simpleDao.insert("AD0200402I", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
				}
				else if(gad01mt.getObject_prd(i,gad01mt.getAdSeq()).getActiveFlg().equals("U")) {
					simpleDao.update("AD0200402U", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
				}
			}else {
				if(gad01mt.getObject_prd(i,gad01mt.getAdSeq()).getActiveFlg().equals("D")) {
					simpleDao.delete("AD0200403D", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
				}
				else {
					simpleDao.insert("AD0200402I", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
				}
			}
		}

		//기존 행사년월 임시 데이터 삭제
		simpleDao.delete("AD0200401D", gad01mt);
		simpleDao.delete("AD0200402D", gad01mt);
		eventYms = new String[Integer.parseInt(gad01mt.getContractMonth())];
		for(int j = 0; j < eventYms.length; j++) {

			if(j == 0) {
				eventYms[j] = gad01mt.getStartDT();
			}
			else {
				int yyyy = Integer.parseInt(eventYms[j-1].substring(0, 4));
				int mm   = Integer.parseInt(eventYms[j-1].substring(4, 6))+1;
				String year = null;
				String month = null;

				if(mm > 12) {
					year = String.valueOf(yyyy+1);
					month = String.valueOf(mm-12);
				}
				else {
					year = String.valueOf(yyyy);
					month = String.valueOf(mm);
				}


				if(month.length() < 2) {
					month = "0" + month;
				}
				eventYms[j] = year + month;
			}
		}


		for (int k = 0; k < Integer.parseInt(gad01mt.getContractMonth()); k++) {
			gad01mt.setEventYm(eventYms[k]);

			String activeCheck = Integer.parseInt(gad01mt.getEventYm()) >
					Integer.parseInt(date.format(today)) ?	"N" : "Y";

			gad01mt.setActiveYN(activeCheck);

			simpleDao.insert("AD0200403I", gad01mt);

			for(int m = 0; m < gad01mt.getSize_prd(); m++) {
				GAD01MT tmp = gad01mt.getObject_prd(m, gad01mt.getAdSeq());
				tmp.setEventYm(eventYms[k]);
				tmp.setContractMonth(gad01mt.getContractMonth());

				if(!tmp.getActiveFlg().equals("D")) {
					simpleDao.insert("AD0200404I", tmp);
				}

			}
		}
	}

	@Override
	public void tmpModifySupport(GAD01MT gad01mt) throws Exception {
		String[] eventYms;
		gad01mt.setApprStateCD("10");

		simpleDao.update("AD0200401U", gad01mt);
		simpleDao.update("AD0200403U", gad01mt);

		for(int i = 0; i < gad01mt.getSize_prd(); i++) {
			if(gad01mt.getObject_prd(i,gad01mt.getAdSeq()).getActiveFlg().equals("D")) {
				simpleDao.delete("AD0200403D", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
			}
			else if(gad01mt.getObject_prd(i,gad01mt.getAdSeq()).getActiveFlg().equals("I")) {
				simpleDao.insert("AD0200402I", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
			}
			else if(gad01mt.getObject_prd(i,gad01mt.getAdSeq()).getActiveFlg().equals("U")) {
				simpleDao.insert("AD0200402U", gad01mt.getObject_prd(i,gad01mt.getAdSeq()));
			}
		}

		//기존 행사년월 임시 데이터 삭제
		simpleDao.delete("AD0200401D", gad01mt);
		simpleDao.delete("AD0200402D", gad01mt);
		eventYms = new String[Integer.parseInt(gad01mt.getContractMonth())];
		for(int j = 0; j < eventYms.length; j++) {

			if(j == 0) {
				eventYms[j] = gad01mt.getStartDT();
			}
			else {
				int yyyy = Integer.parseInt(eventYms[j-1].substring(0, 4));
				int mm   = Integer.parseInt(eventYms[j-1].substring(4, 6))+1;
				String year = null;
				String month = null;

				if(mm > 12) {
					year = String.valueOf(yyyy+1);
					month = String.valueOf(mm-12);
				}
				else {
					year = String.valueOf(yyyy);
					month = String.valueOf(mm);
				}

				if(month.length() < 2) {
					month = "0" + month;
				}
				eventYms[j] = year + month;
			}
		}

		for(int k = 0; k < Integer.parseInt(gad01mt.getContractMonth()); k++) {
			gad01mt.setEventYm(eventYms[k]);
			simpleDao.insert("AD0200403I", gad01mt);

			for(int m = 0; m < gad01mt.getSize_prd(); m++) {
				GAD01MT tmp = gad01mt.getObject_prd(m, gad01mt.getAdSeq());
				tmp.setEventYm(eventYms[k]);
				tmp.setContractMonth(gad01mt.getContractMonth());

				if(!tmp.getActiveFlg().equals("D")){
					simpleDao.insert("AD0200404I", tmp);
				}
			}
		}
	}

	@Override
	public void requestContractAppResultAD(GAD01MT gad01mt) throws Exception {
//		String[] apAmts = gad01mt.getApAmts();
//		String[] contractMonths = gad01mt.getContractMonths();
//		int monthAdAmt[] = new int[apAmts.length];
//		for(int i = 0; i < apAmts.length; i++) {
//			String apAmt = apAmts[i];
//			String contractMonth = contractMonths[i];
//			monthAdAmt[i] = Integer.parseInt(apAmt.replace(",",""))/Integer.parseInt(contractMonth.replace(",",""));
//		}

		//AD 승인요청 정보 갱신
		if(gad01mt.getAdChgFlg().equals("Y")){
			gad01mt.setApprTpID("000010"); //AD BU 승인라인
		}
//		else{
//			if(gad01mt.getApprExpc().equals("2")) {
//				gad01mt.setApprTpID("000006"); //Exception 2
//			}else {
//				gad01mt.setApprTpID("000004"); //No Exception
//			}

//			for (int i = 0; i < gad01mt.getSize(); i++) {
//				GAD01MT gad01mt_a = gad01mt.getObject_request(i);
//
//				if (monthAdAmt[i] >= 3000000) {
//					gad01mt.setApprTpID("000006"); // TLA
//				} else if (monthAdAmt[i] >= 1000000) {
//					gad01mt.setApprTpID("000005"); // RLA
//				} else if (monthAdAmt[i] >= 200000) {
//					gad01mt.setApprTpID("000004"); // Simple AD
//				} else {
//					gad01mt.setApprTpID("000004"); // Simple AD
//				}
//			}
//		}
		simpleDao.delete("AD0200501D", gad01mt);
		simpleDao.insert("AD0200501I", gad01mt);
		simpleDao.update("AD0200501U", gad01mt);

		Map mailMap = simpleDao.queryForMap("AD0100206S", gad01mt);

		String contents = "";
		String subject = "";
		if (gad01mt.getAdContractDivCD().equals("20")) {
			contents = " 업소 수정 건이 승인요청 되었습니다.";
			subject = " :  VMS-AD 계약수정 승인요청 <";
		} else {
			contents = " 업소 해지 건이 승인요청 되었습니다.";
			subject = " :  VMS-AD 계약해지 승인요청 <";
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
		content+="<table width='700' cellpadding='0' cellspacing='0' border='1'> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>TYPE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+ contents +"\n";
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
		//map.put("subject", FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		map.put("subject", gad01mt.getEmpID() + subject + mailMap.get("EMAILADDR") + ">");
		map.put("content", content);
		map.put("from", gad01mt.getEmailAddr());
		System.out.println("AdSupportID:::::"+gad01mt.getAdSupportID());
		System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
		System.out.println("sender::::"+sender);
		System.out.println("to:::::"+mailMap.get("EMAILADDR"));
		System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		System.out.println("from::::"+gad01mt.getEmailAddr());
		emailSender.sendMail(map);

	}

	@Override
	public void clearRequestContractAppResultAD(GAD01MT gad01mt) throws Exception {

//		String[] apAmts = gad01mt.getApAmts();
//		String[] contractMonths = gad01mt.getContractMonths();
//		int monthAdAmt[] = new int[apAmts.length];
//		for(int i = 0; i < apAmts.length; i++) {
//			String apAmt = apAmts[i];
//			String contractMonth = contractMonths[i];
//			monthAdAmt[i] = Integer.parseInt(apAmt.replace(",",""))/Integer.parseInt(contractMonth.replace(",",""));
//		}
		//AD 승인요청취소 정보 갱신
		for(int i = 0; i < gad01mt.getSize(); i++) {
			GAD01MT gad01mt_a = gad01mt.getObject_request(i);

			if(gad01mt_a.getAdChgFlg().equals("Y")){
				gad01mt_a.setApprTpID("000010"); //AD BU 승인라인
			}
//			else{
//				if(gad01mt_a.getApprExpc().equals("2")) {
//					gad01mt_a.setApprTpID("000006"); // Exception 2
//				}else {
//					gad01mt_a.setApprTpID("000004"); // No Exception
//				}

//				if (monthAdAmt[i] >= 3000000) {
//					gad01mt_a.setApprTpID("000006"); // TLA
//				} else if(monthAdAmt[i] >= 1000000){
//					gad01mt_a.setApprTpID("000005"); // RLA
//				} else if(monthAdAmt[i] >= 200000){
//					gad01mt_a.setApprTpID("000004"); // Simple AD
//				} else{
//					gad01mt_a.setApprTpID("000004"); // Simple AD
//				}
//			}

			simpleDao.delete("AD0200502D", gad01mt_a);
			simpleDao.update("AD0200502U", gad01mt_a);
			simpleDao.update("AD0200502U", gad01mt_a);

		}

	}

	@Override
	public void lastContractApprovalAD(GAD01MT gad01mt) throws Exception {

		//AD정보 승인
		gad01mt.setApprStateCD("50");
		gad01mt.setActiveYN_02("Y");

		simpleDao.update("AD0200601U", gad01mt);
		//AD승인정보 갱신
		simpleDao.update("AD0200602U", gad01mt);
		//AD계약여부
		simpleDao.update("AD0200606U", gad01mt);
		//AD History 승인 정보 갱신
		simpleDao.insert("AD0200607I", gad01mt);

		//기존데이터 삭제
		simpleDao.delete("AD0200601D", gad01mt);
		simpleDao.delete("AD0200602D", gad01mt);
		simpleDao.delete("AD0200603D", gad01mt);
		simpleDao.delete("AD0200604D", gad01mt);
		simpleDao.delete("AD0200605D", gad01mt);
		simpleDao.delete("AD0200606D", gad01mt);

		//임시데이터를 기존 데이블에 엎어침
		simpleDao.insert("AD0200601I", gad01mt);
		simpleDao.insert("AD0200602I", gad01mt);
		simpleDao.insert("AD0200603I", gad01mt);
		simpleDao.insert("AD0200604I", gad01mt);
		simpleDao.insert("AD0200605I", gad01mt);
		simpleDao.insert("AD0200606I", gad01mt);


		Map mailMap = simpleDao.queryForMap("AD0200117S", gad01mt);

		String contents = "";
		String subject = "";
		if(gad01mt.getAdContractDivCD().equals("20")) {
			contents = " 업소 수정 건이 승인완료 되었습니다.";
			subject = " : VMS-AD 계약수정 승인완료 <";
		}else {
			contents = " 업소 해지 건이 승인완료 되었습니다.";
			subject = " : VMS-AD 계약해지 승인완료 <";
		}

//2021-10-06_승인완료 시 메일 발송 처리 주석

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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+ contents +"\n";
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
		//map.put("subject", FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		map.put("subject", gad01mt.getEmpID() + subject  + mailMap.get("EMAILADDR") + ">");
		map.put("content", content);
		map.put("from", gad01mt.getEmailAddr());
		System.out.println("AdSupportID:::::"+gad01mt.getAdSupportID());
		System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
		System.out.println("sender::::"+sender);
		System.out.println("to:::::"+mailMap.get("EMAILADDR"));
		System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		System.out.println("from::::"+gad01mt.getEmailAddr());
		emailSender.sendMail(map);

	}

	@Override
	public void contractApprovalAD(GAD01MT gad01mt) throws Exception {

		//처음 승인요청 보낼 시 
		if(gad01mt.getLevelNo().equals("2")) {

			//승인중
			gad01mt.setApprStateCD("30");

			simpleDao.update("AD0200601U", gad01mt);
			simpleDao.update("AD0200602U", gad01mt);
			simpleDao.update("AD0200603U", gad01mt);
		}
		else {
			simpleDao.update("AD0200602U", gad01mt);
			simpleDao.update("AD0200603U", gad01mt);
		}

		Map mailMap = simpleDao.queryForMap("AD0100206S", gad01mt);

		String contents = "";
		String subject = "";
		if(gad01mt.getAdContractDivCD().equals("20")) {
			contents = " 업소 수정 건이 승인 되었습니다.";
			subject = " : VMS-AD 계약수정 승인요청 <";
		}else {
			contents = " 업소 해지 건이 승인 되었습니다.";
			subject = " : VMS-AD 계약해지 승인요청 <";
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
		content+="<table width='700' cellpadding='0' cellspacing='0' border='1'> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>TYPE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM")+ contents +"\n";
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
		map.put("subject", FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		map.put("subject", gad01mt.getEmpID() + subject  + mailMap.get("EMAILADDR") + ">");
		map.put("content", content);
		map.put("from", gad01mt.getEmailAddr());
		System.out.println("AdSupportID:::::"+gad01mt.getAdSupportID());
		System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
		System.out.println("sender::::"+sender);
		System.out.println("to:::::"+mailMap.get("EMAILADDR"));
		System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		System.out.println("from::::"+gad01mt.getEmailAddr());
		emailSender.sendMail(map);

	}

	@Override
	public void contractRejectAD(GAD01MT gad01mt) throws Exception {

		//AD정보 반려
		gad01mt.setApprStateCD("40");

		simpleDao.update("AD0200604U", gad01mt);
		simpleDao.update("AD0200605U", gad01mt);
		//simpleDao.update("AD0200607U", gad01mt_a);

		Map mailMap = simpleDao.queryForMap("AD0200117S", gad01mt);

		String contents = "";
		String subject = "";
		if(gad01mt.getAdContractDivCD().equals("20")) {
			contents = " 수정 건이 반려 되었습니다.";
			subject = " : VMS-AD 계약수정 반려 <";

			gad01mt.setAdHistoryCD("70");
		}else {
			contents = "  해지 건이 반려 되었습니다.";
			subject = " : VMS-AD 계약해지 반려 <";

			//gad01mt.setAdHistoryCD("110");
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
		content+="<table width='700' cellpadding='0' cellspacing='0' border='1'> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>TYPE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+mailMap.get("VENUENM") + contents +"\n";
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
		//map.put("subject", FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		map.put("subject", gad01mt.getEmpID() + subject  + mailMap.get("EMAILADDR") + ">");
		map.put("content", content);
		map.put("from", gad01mt.getEmailAddr());
		System.out.println("AdSupportID:::::"+gad01mt.getAdSupportID());
		System.out.println("date:::::"+FormatUtil.formatDate(gad01mt.getClientDate()));
		System.out.println("sender::::"+sender);
		System.out.println("to:::::"+mailMap.get("EMAILADDR"));
		System.out.println("subject::::"+FormatUtil.formatMonth(gad01mt.getAdSupportID())+"["+mailMap.get("VENUENM")+"]"+subject);
		System.out.println("from::::"+gad01mt.getEmailAddr());
		emailSender.sendMail(map);
	}


	@Override
	public void afterDateDelay(GAD01MT gad01mt) throws Exception {
		List list = new ArrayList();
		list = simpleDao.queryForList("AD0200740S", gad01mt);

		String [] eventYms;
		simpleDao.update("AD0200701U", gad01mt);

		simpleDao.delete("AD0200701D", gad01mt);
		simpleDao.delete("AD0200702D", gad01mt);

		eventYms = new String[Integer.parseInt(gad01mt.getContractMonth())];


		for (int j=0; j < eventYms.length; j++) {
			if (j == 0){
				eventYms[j] = gad01mt.getStartDT();
			} else {
				int yyyy = Integer.parseInt(eventYms[j-1].substring(0, 4));
				int mm = Integer.parseInt(eventYms[j-1].substring(4, 6)) + 1;
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

			simpleDao.insert("AD0200701I", gad01mt);

			for(int m = 0; m < list.size(); m++) {
				GAD01MT tmp = new GAD01MT();
				Map map = (Map) list.get(m);

				tmp.setAdSupportID(map.get("adSupportID").toString());
				tmp.setPrdCD(map.get("prdCD").toString());
				tmp.setPrdQty(map.get("prdQty").toString());
				tmp.setEventYm(eventYms[k]);
				tmp.setContractMonth(gad01mt.getContractMonth());

				if (!tmp.getActiveFlg().equals("D")){
					simpleDao.insert("AD0200702I", tmp);
				}
			}
		}
	}

	@Override
	public void tmpSaveSupportRequestAD(GAD01MT gad01mt) throws Exception {
		gad01mt.setApprStateCD("10");
		gad01mt.setApprTpID("000010");

		if(gad01mt.getAdSeq().length() > 0){	// 이미 임시테이블에 있는 경우
			// 임시테이블에 있는데 필수광고물만 수정요청시 기존 수정한 데이터는 초기화 시킨다.(필수광고물만 수정해야하므로)
			simpleDao.update("AD0200909U", gad01mt);
			simpleDao.delete("AD0200901D", gad01mt);
			simpleDao.insert("AD0200901I", gad01mt);
			simpleDao.delete("AD0200902D", gad01mt);
			simpleDao.insert("AD0200902I", gad01mt);
			simpleDao.delete("AD0200903D", gad01mt);
			simpleDao.insert("AD0200903I", gad01mt);

			simpleDao.update("AD0200403U", gad01mt);
		} else{		// 임시테이블에 없는 경우(신규저장)
			String adSeq = simpleDao.queryForMap("AD0200428S", gad01mt).get("adSeq").toString();
			gad01mt.setAdSeq(adSeq);
			simpleDao.insert("AD0200406I", gad01mt);
			simpleDao.insert("AD0200901I", gad01mt);
			simpleDao.insert("AD0200902I", gad01mt);
			simpleDao.insert("AD0200903I", gad01mt);
			simpleDao.insert("AD0200405I", gad01mt);
		}
	}

}