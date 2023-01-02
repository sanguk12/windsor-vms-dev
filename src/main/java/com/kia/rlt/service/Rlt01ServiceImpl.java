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

@Service("rlt01Service")
public class Rlt01ServiceImpl implements Rlt01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void resultCreationVenue(GRLT01MT grlt01mt) throws Exception {		
		simpleDao.insert("RLT0100505I", grlt01mt);
		
		List venueList = simpleDao.queryForList("RLT0100509S", grlt01mt);
		
		if(venueList != null && venueList.size()>0){		
			for(int i=0; i<venueList.size(); i++){
				Map map = (Map) venueList.get(i);
				String venueCD = map.get("venueCD").toString();
				grlt01mt.setVenueCD(venueCD);
				simpleDao.insert("RLT0100506I", grlt01mt);
			}
		}
		
		//G1은 차수가 9로 세팅
		//List list = simpleDao.queryForList("RLT0100101S", grlt01mt);
		List list = simpleDao.queryForList("RLT0100501S", grlt01mt);
		
		if(list!=null && list.size()>0) {
			for(int i=0; i<list.size(); i++) {
				Map map = (Map) list.get(i);
				String activeFlg = map.get("activeFlg").toString();
				String venueCD = map.get("venueCD").toString();
				String apprStateCD = map.get("apprStateCD")!=null?map.get("apprStateCD").toString():"";
				grlt01mt.setVenueCD(venueCD);
				
				if(activeFlg.equals("I")) {
					//simpleDao.insert("RLT0100101I", grlt01mt);
					//simpleDao.insert("RLT0100102I", grlt01mt);
					//simpleDao.insert("RLT0100103I", grlt01mt);
					simpleDao.insert("RLT0100501I", grlt01mt);
					simpleDao.insert("RLT0100502I", grlt01mt);
					simpleDao.insert("RLT0100503I", grlt01mt);
					
					//GRLT01DT의 insert정보 토대로 GRLT01MT실적정보 갱신
					//Map map_tmp = simpleDao.queryForMap("RLT0100102S", grlt01mt);
//					Map map_tmp = simpleDao.queryForMap("RLT0100502S", grlt01mt);
//					grlt01mt.setResultTQty(map_tmp.get("resultTQty").toString());
//					grlt01mt.setTargetRate(map_tmp.get("targetRate").toString());
//					grlt01mt.setGuidPayRate(map_tmp.get("guidPayRate").toString());
//					grlt01mt.setPayRate(map_tmp.get("payRate").toString());
//					grlt01mt.setExcPayTpCD(map_tmp.get("excPayTpCD")!=null?map_tmp.get("excPayTpCD").toString():"");
//					grlt01mt.setTpayAmt(map_tmp.get("tpayAmt").toString());
//					grlt01mt.setResultTpCD(map_tmp.get("resultTpCD").toString());
//					grlt01mt.setGsvRate(map_tmp.get("gsvRate").toString());
//					//simpleDao.update("RLT0100101U", grlt01mt);
//					simpleDao.update("RLT0100501U", grlt01mt);
				}
				else if(activeFlg.equals("U")) {
					//승인상태 등록, 반려시 삭제 후 다시생성
					if(apprStateCD.equals("10") || apprStateCD.equals("40")) {
						//simpleDao.delete("RLT0100101D", grlt01mt);
						//simpleDao.delete("RLT0100102D", grlt01mt);
						//simpleDao.delete("RLT0100103D", grlt01mt);
						simpleDao.delete("RLT0100501D", grlt01mt);
						simpleDao.delete("RLT0100502D", grlt01mt);
						simpleDao.delete("RLT0100503D", grlt01mt);
						
						//simpleDao.insert("RLT0100101I", grlt01mt);
						//simpleDao.insert("RLT0100102I", grlt01mt);
						//simpleDao.insert("RLT0100103I", grlt01mt);
						simpleDao.insert("RLT0100501I", grlt01mt);
						simpleDao.insert("RLT0100502I", grlt01mt);
						simpleDao.insert("RLT0100503I", grlt01mt);
						
						//GRLT01DT의 insert정보 토대로 GRLT01MT실적정보 갱신
						//Map map_tmp = simpleDao.queryForMap("RLT0100102S", grlt01mt);
//						Map map_tmp = simpleDao.queryForMap("RLT0100502S", grlt01mt);
//						grlt01mt.setResultTQty(map_tmp.get("resultTQty").toString());
//						grlt01mt.setTargetRate(map_tmp.get("targetRate").toString());
//						grlt01mt.setGuidPayRate(map_tmp.get("guidPayRate").toString());
//						grlt01mt.setPayRate(map_tmp.get("payRate").toString());
//						grlt01mt.setExcPayTpCD(map_tmp.get("excPayTpCD")!=null?map_tmp.get("excPayTpCD").toString():"");
//						grlt01mt.setTpayAmt(map_tmp.get("tpayAmt").toString());
//						grlt01mt.setResultTpCD(map_tmp.get("resultTpCD").toString());
//						grlt01mt.setGsvRate(map_tmp.get("gsvRate").toString());
//						//simpleDao.update("RLT0100101U", grlt01mt);
//						simpleDao.update("RLT0100501U", grlt01mt);
					}
				}
			}
		}
	}
	
	public void saveResultKeymanVenue(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize_keyman(); i++) {
			if(grlt01mt.getObject_keyman(i).getActiveFlg().equals("D")) {
				simpleDao.delete("RLT0100104D", grlt01mt.getObject_keyman(i));
			}
			else if(grlt01mt.getObject_keyman(i).getActiveFlg().equals("I")) {
				simpleDao.insert("RLT0100104I", grlt01mt.getObject_keyman(i));
			}
			else if(grlt01mt.getObject_keyman(i).getActiveFlg().equals("U")) {
				simpleDao.update("RLT0100102U", grlt01mt.getObject_keyman(i));
			}
		}
	}
	
	public void saveResultWriteVenue(GRLT01MT grlt01mt) throws Exception {
		//상태가 반려일경우
		if(grlt01mt.getApprStateCD().equals("40")) {
			//simpleDao.update("RLT0100104U", grlt01mt);
			for(int i=0; i<grlt01mt.getSize_prd(); i++) {
				//simpleDao.update("RLT0100105U", grlt01mt.getObject_prd(i));
				simpleDao.update("RLT0100505U", grlt01mt.getObject_prd(i));
			}
			simpleDao.update("RLT0100504U", grlt01mt);
			//simpleDao.delete("RLT0100105D", grlt01mt);
			simpleDao.delete("RLT0100505D", grlt01mt);
		}
		else {
			//simpleDao.update("RLT0100103U", grlt01mt);
			for(int i=0; i<grlt01mt.getSize_prd(); i++) {
				//simpleDao.update("RLT0100105U", grlt01mt.getObject_prd(i));
				simpleDao.update("RLT0100505U", grlt01mt.getObject_prd(i));
			}
			simpleDao.update("RLT0100503U", grlt01mt);
		}
	}
	
	public void requestAppResultVenue(GRLT01MT grlt01mt) throws Exception {
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
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			//simpleDao.delete("RLT0100201D", grlt01mt.getObject_request(i));
			//simpleDao.insert("RLT0100201I", grlt01mt.getObject_request(i));
			//simpleDao.update("RLT0100201U", grlt01mt.getObject_request(i));
			
			GRLT01MT grlt01mts = grlt01mt.getObject_request_apprType(i);
			
			/*Normal*/
			if(grlt01mts.getApprType().equals("10")){
				grlt01mts.setApprTpID(grlt01mts.getApprTpID_Normal());
				
			/*Special*/
			} else if(grlt01mts.getApprType().equals("30")) {
				grlt01mts.setApprTpID(grlt01mts.getApprTpID());
			}
			
			simpleDao.delete("RLT0100601D", grlt01mts);
			simpleDao.insert("RLT0100601I", grlt01mts);
			simpleDao.update("RLT0100601U", grlt01mts);
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
	
	public void clearRequestAppResultVenue(GRLT01MT grlt01mt) throws Exception {
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
		
		//Result정보, 승인정보갱신
		for(int i=0; i<grlt01mt.getSize(); i++) {
			//simpleDao.delete("RLT0100201D", grlt01mt.getObject_request(i));
			//simpleDao.insert("RLT0100201U", grlt01mt.getObject_request(i));
			
			GRLT01MT grlt01mts = grlt01mt.getObject_request_apprType(i);
			
			/*Normal*/
			if(grlt01mts.getApprType().equals("10")){
				grlt01mts.setApprTpID(grlt01mts.getApprTpID_Normal());
				
			/*Special*/
			} else if(grlt01mts.getApprType().equals("30")) {
				grlt01mts.setApprTpID(grlt01mts.getApprTpID());
			}
			
			simpleDao.delete("RLT0100601D", grlt01mts);
			simpleDao.insert("RLT0100601U", grlt01mts);
			
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
//		content+="		<td style='width:400px;height:50px;'>"+FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 승인요청취소</td> \n";
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
//		map.put("subject", FormatUtil.formatMonth(grlt01mt.getEventYM())+", Result 승인요청취소 메일");
//		map.put("content", content);
//		map.put("from", grlt01mt.getEmailAddr()); 
//		emailSender.sendMail(map);
	}
	
	public void resultCreationBrand(GRLT02MT grlt02mt) throws Exception {
		List list = simpleDao.queryForList("RLT0100302S", grlt02mt);
		
		if(list!=null && list.size()>0) {
			for(int i=0; i<list.size(); i++) {
				Map map = (Map) list.get(i);
				grlt02mt.setVenueCD(map.get("venueCD").toString());
				grlt02mt.setPrdCD(map.get("prdCD").toString());
				
				String activeFlg = map.get("activeFlg").toString();
				String rank = map.get("rank").toString();
				String apprStateCD = map.get("apprStateCD")!=null?map.get("apprStateCD").toString():"";
				
				logger.debug("rank : "+rank);
				logger.debug("apprStateCD : "+apprStateCD);
				
				if(activeFlg.equals("I")) {
					//같은 업소 중 처음업소일 경우만 GRLT02MT에 등록
					if(rank.equals("1")) {
						simpleDao.delete("RLT0100301D", grlt02mt);
						
						simpleDao.insert("RLT0100301I", grlt02mt);
						simpleDao.insert("RLT0100302I", grlt02mt);
					}
					else {
						simpleDao.insert("RLT0100302I", grlt02mt);
					}
				}
				else if(activeFlg.equals("U")) {
					if(apprStateCD.equals("10") || apprStateCD.equals("40")) {
						//같은 업소 중 처음업소일 경우만 GRLT02MT에 삭제 및 등록
						if(rank.equals("1")) {
							simpleDao.delete("RLT0100302D", grlt02mt);
							simpleDao.delete("RLT0100303D", grlt02mt);
							simpleDao.delete("RLT0100301D", grlt02mt);
							
							simpleDao.insert("RLT0100301I", grlt02mt);
							simpleDao.insert("RLT0100302I", grlt02mt);
						}
						else {
							simpleDao.delete("RLT0100302D", grlt02mt);
							simpleDao.delete("RLT0100303D", grlt02mt);
							
							simpleDao.insert("RLT0100302I", grlt02mt);
						}
					}
				}
			}
		}
			
//		List list = simpleDao.queryForList("RLT0100302S", grlt02mt);
//		
//		if(list!=null && list.size()>0) {
//			for(int i=0; i<list.size(); i++) {
//				Map map = (Map) list.get(i);
//				String activeFlg = map.get("activeFlg").toString();
//				String venueCD = map.get("venueCD").toString();
//				String rank = map.get("rank").toString();
//				String apprStateCD = map.get("apprStateCD")!=null?map.get("apprStateCD").toString():"";
//				grlt02mt.setVenueCD(venueCD);
//				
//				
//				if(activeFlg.equals("I")) {
//					if(!rank.equals("1")) {
//						simpleDao.insert("RLT0100302I", grlt02mt);
//					} else {
//						simpleDao.insert("RLT0100301I", grlt02mt);
//						simpleDao.insert("RLT0100302I", grlt02mt);
//					}
//					
//				}
//				else if(activeFlg.equals("U")) {
//					if(apprStateCD.equals("10") || apprStateCD.equals("40")) {
//						List list_U = simpleDao.queryForList("RLT0100304S", grlt02mt);
//						
//						if(list_U!=null && list_U.size()>0) {
//							for(int j=0; j<list_U.size(); j++) {
//								Map map_U = (Map) list_U.get(j);
//								String venueCD_U = map_U.get("venueCD").toString();
//								String prdCD_U = map_U.get("prdCD").toString();
//								String apprStateCD_U = map_U.get("apprStateCD")!=null?map_U.get("apprStateCD").toString():"";
//								grlt02mt.setVenueCD(venueCD_U);
//								grlt02mt.setPrdCD(prdCD_U);
//								
//								//승인상태 등록, 반려시 삭제 후 다시생성
//								if(apprStateCD_U.equals("10") || apprStateCD_U.equals("40")) {
//									simpleDao.delete("RLT0100301D", grlt02mt);
//									simpleDao.delete("RLT0100302D", grlt02mt);
//									simpleDao.delete("RLT0100303D", grlt02mt);
//									
//									simpleDao.insert("RLT0100301I", grlt02mt);
//									simpleDao.insert("RLT0100303I", grlt02mt);
//								}
//							}
//						}	
//					}
//				}
//			}
//		}
	}
	
	public void saveResultWriteBrand(GRLT02MT grlt02mt) throws Exception {
		//상태가 반려일경우
		for(int i=0; i<grlt02mt.getSize_prd(); i++) {
			GRLT02MT grlt02mt_a = grlt02mt.getObject_prd(i);
			if(grlt02mt_a.getApprStateCD().equals("40")) {
				simpleDao.update("RLT0100304U", grlt02mt_a);
				simpleDao.delete("RLT0100305D", grlt02mt_a);
			} else {
				simpleDao.update("RLT0100303U", grlt02mt_a);
			}
		}
	}	
	
	public void requestAppResultBrand(GRLT02MT grlt02mt) throws Exception {
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
			simpleDao.delete("RLT0100401D", grlt02mt.getObject_request(i));
			simpleDao.insert("RLT0100401I", grlt02mt.getObject_request(i));
			simpleDao.update("RLT0100401U", grlt02mt.getObject_request(i));
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
	
	public void clearRequestAppResultBrand(GRLT02MT grlt02mt) throws Exception {
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
			simpleDao.delete("RLT0100401D", grlt02mt.getObject_request(i));
			simpleDao.insert("RLT0100401U", grlt02mt.getObject_request(i));
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
	
	//일괄승인요청 처리
	public void requestAppResult(GRLT01MT grlt01mt) throws Exception {
	    //Result 승인정보 삭제
		simpleDao.delete("RLT0101101D", grlt01mt);
		//Result 승인요청
		simpleDao.insert("RLT0101101I", grlt01mt);
		//Result 정보 승인상태 갱신
		simpleDao.update("RLT0101101U", grlt01mt);
	}
	
	//일괄승인요청 취소 처리
	public void clearRequestAppResult(GRLT01MT grlt01mt) throws Exception {
		//데이터 삭제 
		simpleDao.delete("RLT0101102D", grlt01mt);
		//Reslut 정보 승인상태 갱신
		simpleDao.update("RLT0101102U", grlt01mt);
	}
	
}