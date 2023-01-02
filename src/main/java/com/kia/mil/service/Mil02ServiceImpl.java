package com.kia.mil.service;

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

import com.kia.mil.model.GMIL01MT;
import com.kia.pln.model.GPLN01MT;

@Service("mil02Service")
public class Mil02ServiceImpl implements Mil02Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private EmailSender emailSender;
	
	public void approvalMileage(GMIL01MT gmil01mt) throws Exception {
		//simpleDao.update("MIL0200101U", gmil01mt);
		if(gmil01mt.getLevelNo().equals("2")) {
			gmil01mt.setMileageStateCD("30");
			simpleDao.update("MIL0200101U", gmil01mt);
			simpleDao.update("MIL0200102U", gmil01mt);
			simpleDao.update("MIL0200103U", gmil01mt);
		}
		else{
			simpleDao.update("MIL0200102U", gmil01mt);
			simpleDao.update("MIL0200103U", gmil01mt);
		}
		/*
		//plan정보, 승인정보갱신
				for(int i=0; i<gpln01mt.getSize(); i++) {
					GPLN01MT gpln01mt_b = gpln01mt.getObject_approval(i);
					if(gpln01mt_b.getLevelNo().equals("2")) {
						//plan정보 승인중
						gpln01mt_b.setApprStateCD("30");
						simpleDao.update("PLN0200101U", gpln01mt_b);
						//plan승인정보 갱신
						simpleDao.update("PLN0200102U", gpln01mt_b);
						simpleDao.update("PLN0200103U", gpln01mt_b);
					}
					else {
						//plan승인정보 갱신
						simpleDao.update("PLN0200102U", gpln01mt_b);
						simpleDao.update("PLN0200103U", gpln01mt_b);
					}
				}
				*/
	}

	public void lastApprovalMileage(GMIL01MT gmil01mt) throws Exception {
		gmil01mt.setMileageStateCD("50");
		simpleDao.update("MIL0200101U", gmil01mt);
		simpleDao.update("MIL0200102U", gmil01mt);
		simpleDao.insert("MIL0200101I", gmil01mt);
		simpleDao.insert("MIL0200102I", gmil01mt);
		simpleDao.insert("MIL0200105U", gmil01mt);
		simpleDao.insert("MIL0200106U", gmil01mt);
	}

	public void rejectMileage(GMIL01MT gmil01mt) throws Exception {
		simpleDao.update("MIL0200101U", gmil01mt);
		simpleDao.update("MIL0200104U", gmil01mt);
		
		//담당자 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		toMap.put("empID", gmil01mt.getEmpID());
		String to_emailAddr = "";
		//list = simpleDao.queryForList("COM03009S", toMap);
		list = simpleDao.queryForList("MIL0200104S", gmil01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr = toMap.get("emailAddr").toString();
				}
			}
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gmil01mt.getPayRequestDate())+", 마일리지 등록 승인반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gmil01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+gmil01mt.getEmpNm()+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatDate(gmil01mt.getPayRequestDate())+", 마일리지 등록 승인반려 메일");
		map.put("content", content);
		map.put("from", gmil01mt.getEmailAddr()); 
		emailSender.sendMail(map);
	}

	public void approvalMileageRlt(GMIL01MT gmil01mt) throws Exception {
		//simpleDao.update("MIL0200101U", gmil01mt);
		if(gmil01mt.getLevelNo().equals("2")) {
			gmil01mt.setMileageStateCD("30");
			simpleDao.update("MIL0200201U", gmil01mt);
			simpleDao.update("MIL0200202U", gmil01mt);
			simpleDao.update("MIL0200203U", gmil01mt);
		}
		else{
			simpleDao.update("MIL0200202U", gmil01mt);
			simpleDao.update("MIL0200203U", gmil01mt);
		}
		/*
		//plan정보, 승인정보갱신
				for(int i=0; i<gpln01mt.getSize(); i++) {
					GPLN01MT gpln01mt_b = gpln01mt.getObject_approval(i);
					if(gpln01mt_b.getLevelNo().equals("2")) {
						//plan정보 승인중
						gpln01mt_b.setApprStateCD("30");
						simpleDao.update("PLN0200101U", gpln01mt_b);
						//plan승인정보 갱신
						simpleDao.update("PLN0200102U", gpln01mt_b);
						simpleDao.update("PLN0200103U", gpln01mt_b);
					}
					else {
						//plan승인정보 갱신
						simpleDao.update("PLN0200102U", gpln01mt_b);
						simpleDao.update("PLN0200103U", gpln01mt_b);
					}
				}
				*/
	}

	public void lastApprovalMileageRlt(GMIL01MT gmil01mt) throws Exception {
		/*
		List list = new ArrayList();
		Map toMap = new HashMap();
		String contractDateFrom = "";
		String contractDateTo = "";
		String venueCD = "";
		list = simpleDao.queryForList("MIL0200205S", gmil01mt);
		if(list.size() > 0) {
			toMap = (Map)list.get(0);
			contractDateFrom = toMap.get("contractDateFrom").toString();
			contractDateTo = toMap.get("contractDateTo").toString();
			venueCD = toMap.get("venueCD").toString();
			
		}
		gmil01mt.setContractDateFrom(contractDateFrom);
		gmil01mt.setContractDateTo(contractDateTo);
		gmil01mt.setVenueCD(venueCD);
		*/
		
		gmil01mt.setMileageStateCD("50");
		gmil01mt.setVerifyStateCD("REQ");
		simpleDao.update("MIL0200201U", gmil01mt);
		simpleDao.update("MIL0200202U", gmil01mt);
		/*마일리지 적용된 Result데이터에  마일리지지원여부를 Y로 변경*/
		simpleDao.update("MIL0200205U", gmil01mt);
		simpleDao.update("MIL0200206U", gmil01mt);
		//simpleDao.insert("MIL0200201I", gmil01mt);
		//simpleDao.insert("MIL0200202I", gmil01mt);
	}

	public void rejectMileageRlt(GMIL01MT gmil01mt) throws Exception {
		simpleDao.update("MIL0200201U", gmil01mt);
		simpleDao.update("MIL0200204U", gmil01mt);
		
		//담당자 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		toMap.put("empID", gmil01mt.getEmpID());
		String to_emailAddr = "";
		//list = simpleDao.queryForList("COM03009S", toMap);
		list = simpleDao.queryForList("MIL0200204S", gmil01mt);
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				toMap = (Map)list.get(i);
				if(toMap.get("emailAddr") != null){
					to_emailAddr = toMap.get("emailAddr").toString();
				}
			}
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gmil01mt.getPayRequestDate())+", 마일리지 등록 승인반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gmil01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+gmil01mt.getEmpNm()+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatDate(gmil01mt.getPayRequestDate())+", 마일리지 지급요청 반려 메일");
		map.put("content", content);
		map.put("from", gmil01mt.getEmailAddr()); 
		emailSender.sendMail(map);
	}
	/*
	public void approvalMileage_add(GMIL01MT gmil01mt) throws Exception {
		simpleDao.update("MIL0200201U", gmil01mt);
	}
	
	public void rejectMileage_add(GMIL01MT gmil01mt) throws Exception {
		simpleDao.update("MIL0200201U", gmil01mt);
		
		//담당자 메일정보
		List list = new ArrayList();
		Map toMap = new HashMap();
		toMap.put("empID", gmil01mt.getEmpID());
		String to_emailAddr = "";
		list = simpleDao.queryForList("COM03009S", toMap);
		if(list.size() > 0) {
			toMap = (Map)list.get(0);
			to_emailAddr = toMap.get("emailAddr").toString();
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
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gmil01mt.getPayRequestDate())+", 마일리지 지급요청 반려</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>DATE</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+FormatUtil.formatDate(gmil01mt.getClientDate())+"</td> \n";
		content+="	</tr> \n";
		content+="	<tr> \n";
		content+="		<td style='width:100px;height:50px;text-align:center;'>SENDER</td> \n";
		content+="		<td style='width:200px;height:50px;padding-left:5px;'>"+gmil01mt.getEmpNm()+"</td> \n";
		content+="	</tr> \n";
		content+="</table> \n";
		content+="</body> \n";
		content+="</html> \n";
		
		map.put("to", to_emailAddr);
		map.put("subject", FormatUtil.formatDate(gmil01mt.getPayRequestDate())+", 마일리지 지급요청 반려 메일");
		map.put("content", content);
		map.put("from", gmil01mt.getEmailAddr()); 
		emailSender.sendMail(map);
	}
	*/
	
}