package com.kia.pln.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.util.DateUtil;
import kr.co.nis.waf.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02DT;
import com.kia.pln.model.GPLN02DTs;
import com.kia.pln.model.GPLN02MT;
import com.kia.pln.model.GPLN02MTs;

@Service("pln01Service")
public class Pln01ServiceImpl implements Pln01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void savePlanVenue(GPLN01MT gpln01mt) throws Exception {
		for(int i=0; i<gpln01mt.getSize(); i++) {
			if(gpln01mt.getObject(i).getActiveFlg().equals("D")) {
				simpleDao.insert("PLN0100101D", gpln01mt.getObject(i));
				simpleDao.insert("PLN0100102D", gpln01mt.getObject(i));
			}
			else if(gpln01mt.getObject(i).getActiveFlg().equals("I")) {
				simpleDao.insert("PLN0100101I", gpln01mt.getObject(i));
				//선지원일경우, 단가를 선지원단가로 가져옴
				if(gpln01mt.getObject(i).getActivityCD().equals("20")) {
					simpleDao.insert("PLN0100105I", gpln01mt.getObject(i));
				}
				else {
					simpleDao.insert("PLN0100102I", gpln01mt.getObject(i));
				}
			}
			else if(gpln01mt.getObject(i).getActiveFlg().equals("U")) {
				simpleDao.insert("PLN0100101U", gpln01mt.getObject(i));
			}
		}
	}
	
	public void copyBefMonPlanVenue(GPLN01MT gpln01mt) throws Exception {
		simpleDao.insert("PLN0100103I", gpln01mt);
		simpleDao.insert("PLN0100104I", gpln01mt);
	}
	
	public void savePlanVenueWrite(GPLN01MT gpln01mt) throws Exception {
		//상태가 반려일경우
		if(gpln01mt.getApprStateCD().equals("40")) {
			//simpleDao.update("PLN0100205U", gpln01mt);
			simpleDao.update("PLN0100705U", gpln01mt);
			for(int i=0; i<gpln01mt.getSize_write(); i++) {
				//simpleDao.update("PLN0100202U", gpln01mt.getObject_write(i));
				simpleDao.update("PLN0100702U", gpln01mt.getObject_write(i));
			}
			//simpleDao.delete("PLN0100201D", gpln01mt);
			simpleDao.delete("PLN0100701D", gpln01mt);
		}
		//상태가 등록
		else {
			//simpleDao.update("PLN0100201U", gpln01mt);
			simpleDao.update("PLN0100701U", gpln01mt);
			for(int i=0; i<gpln01mt.getSize_write(); i++) {
				//simpleDao.update("PLN0100202U", gpln01mt.getObject_write(i));
				simpleDao.update("PLN0100702U", gpln01mt.getObject_write(i));
			}
		}
	}
	
	public void copyBefMonPlanVenueWrite(GPLN01MT gpln01mt) throws Exception {
		for(int i=0; i<gpln01mt.getSize(); i++) {
			//복사할 대상인 전달 구하기 START
			String eventYM = gpln01mt.getEventYM()+"01";
			String befEventYM = StringUtil.unFormat(DateUtil.getForeMonth(eventYM, -1)).substring(0,6);
			gpln01mt.setBefEventYM(befEventYM);
			logger.debug("##befEventYM : "+befEventYM);
			//복사할 대상인 전달 구하기 END
			
			//long cal_gsv = 0;
			double cal_gsv = 0;
			long cal_threeMonthAvgRate = 0;
			
			GPLN01MT gpln01mt_m = gpln01mt.getObject_copy(i);
			
			List gpln01mt_list = new ArrayList();
			//gpln01mt_list = simpleDao.queryForList("PLN0100204S", gpln01mt_m);
			gpln01mt_list = simpleDao.queryForList("PLN0100704S", gpln01mt_m);
			List gpln01dt_list = new ArrayList();
			//gpln01dt_list = simpleDao.queryForList("PLN0100205S", gpln01mt_m);
			gpln01dt_list = simpleDao.queryForList("PLN0100705S", gpln01mt_m);
			
			//gsv및 3개월평균대비 재계산 후 복사
			if(gpln01mt_list!=null && gpln01dt_list!=null) {
				if(gpln01mt_list.size() > 0 && gpln01dt_list.size() > 0) {
					Map gpln01mt_map = new HashMap();
					gpln01mt_map = (Map)gpln01mt_list.get(0);
					
					long threeMonthAvgTQty = 0;
					long planTQty = 0;
					long tpayAmt = 0;
					long planQty_factoryPrice = 0;
					String keymanID = "";
					threeMonthAvgTQty = Integer.parseInt(gpln01mt_map.get("threeMonthAvgTQty").toString());
					planTQty = Integer.parseInt(gpln01mt_map.get("planTQty").toString());
					tpayAmt = Integer.parseInt(gpln01mt_map.get("tpayAmt").toString());
					keymanID = gpln01mt_map.get("keymanID").toString();
					if (logger.isDebugEnabled()) {
						logger.debug("====================================");
						logger.debug("###threeMonthAvgTQty : "+threeMonthAvgTQty);
						logger.debug("###planTQty : "+planTQty);
						logger.debug("###tpayAmt : "+tpayAmt);
						logger.debug("###keymanID : "+keymanID);
						logger.debug("====================================");
					}
					gpln01mt_m.setPlanTQty(String.valueOf(planTQty));
					gpln01mt_m.setTpayAmt(String.valueOf(tpayAmt));
					gpln01mt_m.setKeymanID(keymanID);
					
					if(threeMonthAvgTQty > 0) {
						cal_threeMonthAvgRate = Math.round(((double)planTQty / (double)threeMonthAvgTQty) * 100);
					}
					else {
						cal_threeMonthAvgRate = 0;
					}
					
					for(int j=0; j<gpln01dt_list.size(); j++) {
						Map gpln01dt_map = new HashMap();
						gpln01dt_map = (Map)gpln01dt_list.get(j);
						
						long planQty = 0;
						long factoryPrice = 0;
						
						planQty = Integer.parseInt(gpln01dt_map.get("planQty").toString());
						factoryPrice = Integer.parseInt(gpln01dt_map.get("factoryPrice").toString());
						planQty_factoryPrice += planQty * factoryPrice;
						if (logger.isDebugEnabled()) {
							logger.debug("###planQty : "+planQty);
							logger.debug("###factoryPrice : "+factoryPrice);
							logger.debug("###planQty_factoryPrice : "+planQty_factoryPrice);
						}
					}
					
					if(planQty_factoryPrice > 0) {
						double tmp = (double)(tpayAmt*(1+0.0352)) / (double)planQty_factoryPrice;
						//cal_gsv = Math.round(tmp * 100);
						cal_gsv = Math.round(tmp * 1000) / 10;
					}
					else {
						//cal_gsv = 0;
						cal_gsv = 0.0;
					}
					
					if (logger.isDebugEnabled()) {
						logger.debug("###cal_gsv : "+cal_gsv);
						logger.debug("###cal_threeMonthAvgRate : "+cal_threeMonthAvgRate);
					}
					gpln01mt_m.setGsvRate(String.valueOf(cal_gsv));
					gpln01mt_m.setThreeMonthAvgRate(String.valueOf(cal_threeMonthAvgRate));
					
					//simpleDao.update("PLN0100203U", gpln01mt_m);
					simpleDao.update("PLN0100703U", gpln01mt_m);
					
					for(int j=0; j<gpln01dt_list.size(); j++) {
						GPLN01MT gpln01mt_t = new GPLN01MT();
						Map gpln01dt_map = new HashMap();
						gpln01dt_map = (Map)gpln01dt_list.get(j);
						
						String prdCD = "";
						String planQty = "0";
						String planUnitAmt = "0";
						String payAmt = "0";
						prdCD = gpln01dt_map.get("prdCD").toString();
						planQty = gpln01dt_map.get("planQty").toString();
						planUnitAmt = gpln01dt_map.get("planUnitAmt").toString();
						payAmt = gpln01dt_map.get("payAmt").toString();
						
						gpln01mt_t.setEventYM(gpln01mt_m.getEventYM());
						gpln01mt_t.setVenueCD(gpln01mt_m.getVenueCD());
						gpln01mt_t.setUserID(gpln01mt_m.getUserID());
						gpln01mt_t.setPrdCD(prdCD);
						gpln01mt_t.setPlanQty(planQty);
						gpln01mt_t.setPlanUnitAmt(planUnitAmt);
						gpln01mt_t.setPayAmt(payAmt);
						
						//simpleDao.update("PLN0100204U", gpln01mt_t);
						simpleDao.update("PLN0100704U", gpln01mt_t);
					}
				}
			}
		}
	}
	
	public void requestAppPlanVenue(GPLN01MT gpln01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		toMap.put("empID", gpln01mt.getEmpID());
//		toMap.put("apprTpID", gpln01mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//plan정보, 승인정보갱신
		for(int i=0; i<gpln01mt.getSize(); i++) {
			//simpleDao.delete("PLN0100201D", gpln01mt.getObject_request(i));
			//simpleDao.insert("PLN0100301I", gpln01mt.getObject_request(i));
			//simpleDao.update("PLN0100301U", gpln01mt.getObject_request(i));
			simpleDao.delete("PLN0100701D", gpln01mt.getObject_request(i));
			simpleDao.insert("PLN0100801I", gpln01mt.getObject_request(i));
			simpleDao.update("PLN0100801U", gpln01mt.getObject_request(i));
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
	
	public void clearRequestAppPlanVenue(GPLN01MT gpln01mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		toMap.put("empID", gpln01mt.getEmpID());
//		toMap.put("apprTpID", gpln01mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		String to_emailAddr = "";
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//plan정보, 승인정보갱신
		for(int i=0; i<gpln01mt.getSize(); i++) {
			//simpleDao.delete("PLN0100301D", gpln01mt.getObject_request(i));
			//simpleDao.insert("PLN0100301U", gpln01mt.getObject_request(i));
			simpleDao.delete("PLN0100801D", gpln01mt.getObject_request(i));
			simpleDao.insert("PLN0100801U", gpln01mt.getObject_request(i));
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 승인요청취소</td> \n";
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
//		map.put("subject", FormatUtil.formatMonth(gpln01mt.getEventYM())+", Plan 승인요청취소 메일");
//		map.put("content", content);
//		map.put("from", gpln01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void savePlanBrand(GPLN02MTs gpln02mts) throws Exception {
		for (int i = 0; i < gpln02mts.getSize(); i++) {
			GPLN02MT gpln02mt = gpln02mts.getGPLN02MT(i);
			if(gpln02mt.getActiveFlg().equals("D")) {
				simpleDao.delete("PLN0100401D", gpln02mt);
				simpleDao.delete("PLN0100402D", gpln02mt);
				simpleDao.delete("PLN0100403D", gpln02mt);
			}
			else if(gpln02mt.getActiveFlg().equals("I")) {
				simpleDao.insert("PLN0100401I", gpln02mt);
//				simpleDao.insert("PLN0100402I", gpln02mt);
			}
			else if(gpln02mt.getActiveFlg().equals("U")) {
				simpleDao.update("PLN0100401U", gpln02mt);
			}
			
		}
	}
	
	public void copyBefMonPlanBrand(GPLN02MT gpln02mt, GPLN02DT gpln02dt) throws Exception {
		simpleDao.insert("PLN0100403I", gpln02mt);
//		simpleDao.insert("PLN0100404I", gpln02dt);
	}
	
	public void savePlanBrandWrite(GPLN02DTs gpln02dts) throws Exception {
		for (int i = 0; i < gpln02dts.getSize(); i++) {
			GPLN02DT gpln02dt = gpln02dts.getGPLN02DT(i);
			
			//상태가 반려일경우
			if(gpln02dt.getApprStateCD().equals("40")) {
				if(gpln02dt.getActiveFlg().equals("D")) {
					simpleDao.delete("PLN0100508D", gpln02dt);
					simpleDao.delete("PLN0100507D", gpln02dt);
				}
				else {
					simpleDao.update("PLN0100506U", gpln02dt);
					simpleDao.delete("PLN0100507D", gpln02dt);
				}
			}
			//상태가 등록
			else {
				if(gpln02dt.getActiveFlg().equals("D")) {
					simpleDao.delete("PLN0100503D", gpln02dt);
				}
				else if(gpln02dt.getActiveFlg().equals("I")) {
					if(simpleDao.queryForInt("PLN0100506S", gpln02dts.getGPLN02DT(i)) > 0) {
						throw new DuplicateKeyException("duplicate exception");
					}
					gpln02dt.setApprStateCD("10");
					simpleDao.insert("PLN0100501I", gpln02dt);
				}
				else if(gpln02dt.getActiveFlg().equals("U")) {
					simpleDao.update("PLN0100502U", gpln02dt);
				}
			}
		}
	}
	
	public void copyBefMonPlanBrandWrite(GPLN02DT gpln02dt) throws Exception {
		for(int i=0; i<gpln02dt.getSize(); i++) {
			simpleDao.delete("PLN0100504D", gpln02dt.getObject(i));
			simpleDao.insert("PLN0100505I", gpln02dt.getObject(i));
		}
	}
	
	public void requestAppPlanBrand(GPLN02MT gpln02mt) throws Exception {
	//2014.07.30, taejoon.jang, 메일전송 리마크
//		//상위승인자 메일정보
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		String to_emailAddr = "";
//		toMap.put("empID", gpln02mt.getEmpID());
//		toMap.put("apprTpID", gpln02mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		//plan정보, 승인정보갱신
		for(int i=0; i<gpln02mt.getSize(); i++) {
			simpleDao.delete("PLN0100602D", gpln02mt.getObject_request(i));
			simpleDao.insert("PLN0100601I", gpln02mt.getObject_request(i));
			simpleDao.update("PLN0100601U", gpln02mt.getObject_request(i));
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
	
	public void clearRequestAppPlanBrand(GPLN02MT gpln02mt) throws Exception {
		//2014.07.30, taejoon.jang, 메일전송 리마크
//		List list = new ArrayList();
//		Map toMap = new HashMap();
//		toMap.put("empID", gpln02mt.getEmpID());
//		toMap.put("apprTpID", gpln02mt.getApprTpID());
//		list = simpleDao.queryForList("COM03008S", toMap);
//		String to_emailAddr = "";
//		if(list.size() > 0) {
//			toMap = (Map)list.get(0);
//			to_emailAddr = toMap.get("emailAddr").toString();
//		}
		
		for(int i=0; i<gpln02mt.getSize(); i++) {
			simpleDao.insert("PLN0100601D", gpln02mt.getObject_request(i));
			simpleDao.insert("PLN0100601U", gpln02mt.getObject_request(i));
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 승인요청취소</td> \n";
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
//		map.put("subject", FormatUtil.formatMonth(gpln02mt.getEventYM())+", Plan 승인요청취소 메일");
//		map.put("content", content);
//		map.put("from", gpln02mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	//일괄승인요청 처리 CWJ 2019.05.17
	public void requestAppPlan(GPLN01MT gpln01mt) throws Exception {
	    //plan정보, 승인정보갱신		
		//반려된 것 데이터 삭제 
		simpleDao.delete("PLN0101101D", gpln01mt);
		//Plan승인요청
		simpleDao.insert("PLN0101101I", gpln01mt);
		//Plan정보 승인상태 갱신
		simpleDao.update("PLN0101101U", gpln01mt);
		
	}
	
	//일괄승인요청취소 처리 CWJ 2019.05.17
	public void clearRequestAppPlan(GPLN01MT gpln01mt) throws Exception {
		//데이터 삭제 
		simpleDao.delete("PLN0101101D", gpln01mt);
		//Plan정보 승인상태 갱신
		simpleDao.update("PLN0101101U", gpln01mt);
	}
}