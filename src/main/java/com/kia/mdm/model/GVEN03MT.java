package com.kia.mdm.model;

import com.kia.ad.model.GAD01MT;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GVEN03MT extends CommonObject implements Model {

	private String tmpVenueCD = "";	       
	private String requestDate = "";	       
	private String apprDate = "";	         
	private String requestStateCD = "";	   
	private String lapprLevelNo = "";	     
	private String venueCD = "";	           
	private String venueNm = "";	           
	private String dkmdTpCD = "";	         
	private String territoryCD = "";	       
	private String venueGradCD = "";	       
	private String channelCD = "";	         
	private String subChannelCD = "";	     
	private String segmentCD = "";	         
	private String subSegmentCD = "";	     
	private String addrTpCD1 = "";	         
	private String addrTpCD2 = "";	         
	private String addrTpCD3 = "";		       
	private String addrTpCD4 = "";		       
	private String note1 = "";		           
	private String note2 = "";		           
	private String note3 = "";		           
	private String note4 = "";		           
	private String incntTpCD = "";		       
	private String activeYN = "";		       
	private String regID = "";		           
	private String regDate = "";		         
	private String chgID = "";		           
	private String chgDate = "";		         
	private String venueDivCD = "";		     
	private String newAddr1 = "";		       
	private String oldAddr1 = "";		       
	private String fasciaCD = "";		         
	private String mdDupYN = "";		         
	private String siteCD = "";		         
	private String ageingCD = "";		       
	private String kegYN = "";		   
	private String locationCD	= "";	     
	private String reserveSegmentCD	= "";	
	private String reason1CD = "";		       
	private String reason2 = "";		         
	private String ws1CD = "";		           
	private String ws1SapCD = "";		       
	private String ws2CD = "";		           
	private String ws2SapCD = "";		       
	private String ws3CD = "";
	private String ws3SapCD = "";		       
	private String ws4SapCD = "";           
	private String ws4CD = "";              
	private String phoneNo = "";              
	private String mdVenueCD = "";              
	private String requestDateCD = "";
	private String venSeq = "";
	private String postCD = "";
	private String newAddr2 = "";		       
	private String oldAddr2 = "";
	private String addrTpCD5 = "";
	private String legalCD = "";
	
	
//	GVEN04MT
	private String apprTpID = "";
	private String commt = "";
	private String gbn = "";
	private String levelNo = "";
	private String apprCommt = "";
	private String apprStateCD = "";
	private String lastApprYN = "";
	private String printYN = "";
	
	private String saveChk = "";
	
//	mail
	private String emailAddr = "";
	private String maxNum = "";
	
	
	private String[] tmpVenueCDs = null;	       
	private String[] requestDates = null;	   
	private String[] apprDates = null;	       
	private String[] requestStateCDs = null;	   
	private String[] lapprLevelNos = null;	   
	private String[] venueCDs = null;	       
	private String[] venueNms = null;	       
	private String[] dkmdTpCDs = null;	       
	private String[] territoryCDs = null;	   
	private String[] venueGradCDs = null;	   
	private String[] channelCDs = null;	       
	private String[] subChannelCDs = null;	   
	private String[] segmentCDs = null;	       
	private String[] subSegmentCDs = null;	   
	private String[] addrTpCD1s = null;	       
	private String[] addrTpCD2s = null;	       
	private String[] addrTpCD3s = null;		   
	private String[] addrTpCD4s = null;		   
	private String[] note1s = null;		       
	private String[] note2s = null;		       
	private String[] note3s = null;		       
	private String[] note4s = null;		       
	private String[] incntTpCDs = null;		   
	private String[] activeYNs = null;		   
	private String[] regIDs = null;		       
	private String[] regDates = null;		   
	private String[] chgIDs = null;		       
	private String[] chgDates = null;		   
	private String[] venueDivCDs = null;		   
	private String[] newAddr1s = null;		   
	private String[] oldAddr1s = null;		   
	private String[] fasciaCDs = null;		       
	private String[] mdDupYNs = null;		   
	private String[] siteCDs = null;		       
	private String[] ageingCDs = null;		   
	private String[] kegYNs = null;		       
	private String[] locationCDs	= null;	   
	private String[] reserveSegmentCDs	= null;	
	private String[] reason1CDs = null;		   
	private String[] reason2s = null;		   
	private String[] ws1CDs = null;		       
	private String[] ws1SapCDs = null;		   
	private String[] ws2CDs = null;		       
	private String[] ws2SapCDs = null;		   
	private String[] ws3CDs = null;	           
	private String[] ws3SapCDs = null;          
	private String[] ws4CDs = null;             
	private String[] ws4SapCDs = null;          
	private String[] phoneNos = null;          
	private String[] mdVenueCDs = null;
	private String[] venSeqs = null;
	private String[] postCDs = null;
	private String[] newAddr2s = null;		   
	private String[] oldAddr2s = null;
	private String[] addrTpCD5s = null;
	private String[] legalCDs = null;
	
	private String[] commts = null;          
	private String[] gbns = null;          
	private String[] levelNos = null;          
	private String[] apprCommts = null;          
	private String[] apprStateCDs = null;          
	private String[] lastApprYNs = null;          
	private String[] emailAddrs = null;          
	private String[] apprTpIDs = null;          

	private String activeFlg = "";
	private String[] activeFlgs = null;
	
	public void clean() {
		
	}
	
	public void validate(int action) throws Exception {
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.venueNms != null) {
			 size = this.venueNms.length;
		}
		return size;
	}
	
	
	public int getTmpSize() {
		int size = 0 ;
		if (this.tmpVenueCDs != null) {
			 size = this.tmpVenueCDs.length;
		}
		return size;
	}
	
	public int getCdSize() {
		int size = 0 ;
		if (this.venueCDs != null) {
			 size = this.venueCDs.length;
		}
		return size;
	}
	


	//신규 엑셀 업로드
	public GVEN03MT getObject(int index) {
		GVEN03MT vo = new GVEN03MT();
		if (getSize() > index) {
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setTmpVenueCD(this.getTmpVenueCD());}catch(Exception e){}
			try{vo.setRequestStateCD(this.getRequestStateCD());}catch(Exception e){}
			try{vo.setRequestDate(this.requestDates[index]);}catch(Exception e){}
			try{vo.setTmpVenueCD(this.tmpVenueCDs[index]);}catch(Exception e){}
			try{vo.setMdDupYN(this.mdDupYNs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setVenueNm(this.venueNms[index]);}catch(Exception e){}
			try{vo.setTerritoryCD(this.territoryCDs[index]);}catch(Exception e){}
			try{vo.setFasciaCD(this.fasciaCDs[index]);}catch(Exception e){}
			try{vo.setVenueGradCD(this.venueGradCDs[index]);}catch(Exception e){}
			try{vo.setAddrTpCD1(this.addrTpCD1s[index]);}catch(Exception e){}
			try{vo.setAddrTpCD2(this.addrTpCD2s[index]);}catch(Exception e){}
			try{vo.setAddrTpCD3(this.addrTpCD3s[index]);}catch(Exception e){}
			try{vo.setAddrTpCD4(this.addrTpCD4s[index]);}catch(Exception e){}
			try{vo.setSegmentCD(this.segmentCDs[index]);}catch(Exception e){}
			try{vo.setSubSegmentCD(this.subSegmentCDs[index]);}catch(Exception e){}
			try{vo.setSubChannelCD(this.subChannelCDs[index]);}catch(Exception e){}
			try{vo.setReserveSegmentCD(this.reserveSegmentCDs[index]);}catch(Exception e){}
			try{vo.setSiteCD(this.siteCDs[index]);}catch(Exception e){}
			try{vo.setAgeingCD(this.ageingCDs[index]);}catch(Exception e){}
			try{vo.setKegYN(this.kegYNs[index]);}catch(Exception e){}
			try{vo.setMdVenueCD(this.mdVenueCDs[index]);}catch(Exception e){}
			try{vo.setLocationCD(this.locationCDs[index]);}catch(Exception e){}
			try{vo.setWs1SapCD(this.ws1SapCDs[index]);}catch(Exception e){}
			try{vo.setWs2SapCD(this.ws2SapCDs[index]);}catch(Exception e){}
			try{vo.setWs3SapCD(this.ws3SapCDs[index]);}catch(Exception e){}
			try{vo.setWs4SapCD(this.ws4SapCDs[index]);}catch(Exception e){}
			try{vo.setWs1CD(this.ws1CDs[index]);}catch(Exception e){}
			try{vo.setWs2CD(this.ws2CDs[index]);}catch(Exception e){}
			try{vo.setWs3CD(this.ws3CDs[index]);}catch(Exception e){}
			try{vo.setWs4CD(this.ws4CDs[index]);}catch(Exception e){}
			try{vo.setPhoneNo(this.phoneNos[index]);}catch(Exception e){}
			try{vo.setChannelCD(this.channelCDs[index]);}catch(Exception e){}
			try{vo.setPostCD(this.postCDs[index]);}catch(Exception e){}
			try{vo.setNewAddr1(this.newAddr1s[index]);}catch(Exception e){}
			try{vo.setOldAddr1(this.oldAddr1s[index]);}catch(Exception e){}
			try{vo.setNewAddr2(this.newAddr2s[index]);}catch(Exception e){}
			try{vo.setOldAddr2(this.oldAddr2s[index]);}catch(Exception e){}
			try{vo.setLegalCD(this.legalCDs[index]);}catch(Exception e){}
			try{vo.setVenSeq(this.getVenSeq());}catch(Exception e){}
			try{vo.setActiveYN(this.getActiveYN());}catch(Exception e){}
			try{vo.setIncntTpCD(this.getIncntTpCD());}catch(Exception e){}
			try{vo.setDkmdTpCD(this.getDkmdTpCD());}catch(Exception e){}
			try{vo.setVenueDivCD(this.getVenueDivCD());}catch(Exception e){}
		}
		return vo;
	}
	
	public GVEN03MT getObject_request(int index) {
		GVEN03MT vo = new GVEN03MT();
		if (getTmpSize() > index) {
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setRequestStateCD(this.getRequestStateCD());}catch(Exception e){}
			try{vo.setRequestDate(this.requestDates[index]);}catch(Exception e){}
			try{vo.setTmpVenueCD(this.tmpVenueCDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	public GVEN03MT getObject_remove(int index) {
		GVEN03MT vo = new GVEN03MT();
		if (getCdSize() > index) {
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setTmpVenueCD(this.tmpVenueCDs[index]);}catch(Exception e){}
			try{vo.setTmpVenueCD(this.getTmpVenueCD());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.getVenueCD());}catch(Exception e){}
			try{vo.setReason1CD(this.reason1CDs[index]);}catch(Exception e){}
			try{vo.setReason2(this.reason2s[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setRequestStateCD(this.getRequestStateCD());}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//승인
	public GVEN03MT getObject_approval(int index) {
		GVEN03MT vo = new GVEN03MT();
		
		if (getTmpSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setTmpVenueCD(this.tmpVenueCDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setApprStateCD(this.apprStateCDs[index]);}catch(Exception e){}
			try{vo.setVenSeq(this.venSeqs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//반려
	public GVEN03MT getObject_reject(int index) {
		GVEN03MT vo = new GVEN03MT();
		
		if (getTmpSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setTmpVenueCD(this.tmpVenueCDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setCommt(this.commts[index]);}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setApprStateCD(this.apprStateCDs[index]);}catch(Exception e){}
			try{vo.setVenSeq(this.venSeqs[index]);}catch(Exception e){}
			try{vo.setApprTpID(this.apprTpIDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//엑셀출력여부(신규)
	public GVEN03MT getObject_printChk_new(int index) {
		GVEN03MT vo = new GVEN03MT();
		if (getTmpSize() > index) {
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setTmpVenueCD(this.getTmpVenueCD());}catch(Exception e){}
			try{vo.setTmpVenueCD(this.tmpVenueCDs[index]);}catch(Exception e){}
			
		}
		return vo;
	}
	
	//엑셀출력여부(변경, 삭제)
	public GVEN03MT getObject_printChk_update(int index) {
		GVEN03MT vo = new GVEN03MT();
		if (getCdSize() > index) {
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setVenueCD(this.getVenueCD());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setRequestDate(this.getRequestDate());}catch(Exception e){}
			try{vo.setRequestDate(this.requestDates[index]);}catch(Exception e){}
			
		}
		return vo;
	}

	public String getTmpVenueCD() {
		return tmpVenueCD;
	}

	public void setTmpVenueCD(String tmpVenueCD) {
		this.tmpVenueCD = tmpVenueCD;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getApprDate() {
		return apprDate;
	}

	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}

	public String getRequestStateCD() {
		return requestStateCD;
	}

	public void setRequestStateCD(String requestStateCD) {
		this.requestStateCD = requestStateCD;
	}

	public String getLapprLevelNo() {
		return lapprLevelNo;
	}

	public void setLapprLevelNo(String lapprLevelNo) {
		this.lapprLevelNo = lapprLevelNo;
	}

	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getVenueNm() {
		return venueNm;
	}

	public void setVenueNm(String venueNm) {
		this.venueNm = venueNm;
	}

	public String getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String dkmdTpCD) {
		this.dkmdTpCD = dkmdTpCD;
	}

	public String getTerritoryCD() {
		return territoryCD;
	}

	public void setTerritoryCD(String territoryCD) {
		this.territoryCD = territoryCD;
	}

	public String getVenueGradCD() {
		return venueGradCD;
	}

	public void setVenueGradCD(String venueGradCD) {
		this.venueGradCD = venueGradCD;
	}

	public String getChannelCD() {
		return channelCD;
	}

	public void setChannelCD(String channelCD) {
		this.channelCD = channelCD;
	}

	public String getSubChannelCD() {
		return subChannelCD;
	}

	public void setSubChannelCD(String subChannelCD) {
		this.subChannelCD = subChannelCD;
	}

	public String getSegmentCD() {
		return segmentCD;
	}

	public void setSegmentCD(String segmentCD) {
		this.segmentCD = segmentCD;
	}

	public String getSubSegmentCD() {
		return subSegmentCD;
	}

	public void setSubSegmentCD(String subSegmentCD) {
		this.subSegmentCD = subSegmentCD;
	}

	public String getAddrTpCD1() {
		return addrTpCD1;
	}

	public void setAddrTpCD1(String addrTpCD1) {
		this.addrTpCD1 = addrTpCD1;
	}

	public String getAddrTpCD2() {
		return addrTpCD2;
	}

	public void setAddrTpCD2(String addrTpCD2) {
		this.addrTpCD2 = addrTpCD2;
	}

	public String getAddrTpCD3() {
		return addrTpCD3;
	}

	public void setAddrTpCD3(String addrTpCD3) {
		this.addrTpCD3 = addrTpCD3;
	}

	public String getAddrTpCD4() {
		return addrTpCD4;
	}

	public void setAddrTpCD4(String addrTpCD4) {
		this.addrTpCD4 = addrTpCD4;
	}

	public String getNote1() {
		return note1;
	}

	public void setNote1(String note1) {
		this.note1 = note1;
	}

	public String getNote2() {
		return note2;
	}

	public void setNote2(String note2) {
		this.note2 = note2;
	}

	public String getNote3() {
		return note3;
	}

	public void setNote3(String note3) {
		this.note3 = note3;
	}

	public String getNote4() {
		return note4;
	}

	public void setNote4(String note4) {
		this.note4 = note4;
	}

	public String getIncntTpCD() {
		return incntTpCD;
	}

	public void setIncntTpCD(String incntTpCD) {
		this.incntTpCD = incntTpCD;
	}

	public String getActiveYN() {
		return activeYN;
	}

	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getChgID() {
		return chgID;
	}

	public void setChgID(String chgID) {
		this.chgID = chgID;
	}

	public String getChgDate() {
		return chgDate;
	}

	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}

	public String getVenueDivCD() {
		return venueDivCD;
	}

	public void setVenueDivCD(String venueDivCD) {
		this.venueDivCD = venueDivCD;
	}

	public String getNewAddr1() {
		return newAddr1;
	}

	public void setNewAddr1(String newAddr1) {
		this.newAddr1 = newAddr1;
	}

	public String getOldAddr1() {
		return oldAddr1;
	}

	public void setOldAddr1(String oldAddr1) {
		this.oldAddr1 = oldAddr1;
	}
	public String getFasciaCD() {
		return fasciaCD;
	}

	public void setFasciaCD(String fasciaCD) {
		this.fasciaCD = fasciaCD;
	}

	public String[] getFasciaCDs() {
		return fasciaCDs;
	}

	public void setFasciaCDs(String[] fasciaCDs) {
		this.fasciaCDs = fasciaCDs;
	}

	public String getMdDupYN() {
		return mdDupYN;
	}

	public void setMdDupYN(String mdDupYN) {
		this.mdDupYN = mdDupYN;
	}

	public String getSiteCD() {
		return siteCD;
	}

	public void setSiteCD(String siteCD) {
		this.siteCD = siteCD;
	}

	public String getAgeingCD() {
		return ageingCD;
	}

	public void setAgeingCD(String ageingCD) {
		this.ageingCD = ageingCD;
	}

	public String getKegYN() {
		return kegYN;
	}

	public void setKegYN(String kegYN) {
		this.kegYN = kegYN;
	}

	public String getLocationCD() {
		return locationCD;
	}

	public void setLocationCD(String locationCD) {
		this.locationCD = locationCD;
	}

	public String getReserveSegmentCD() {
		return reserveSegmentCD;
	}

	public void setReserveSegmentCD(String reserveSegmentCD) {
		this.reserveSegmentCD = reserveSegmentCD;
	}

	public String getReason1CD() {
		return reason1CD;
	}

	public void setReason1CD(String reason1cd) {
		reason1CD = reason1cd;
	}

	public String getReason2() {
		return reason2;
	}

	public void setReason2(String reason2) {
		this.reason2 = reason2;
	}

	public String getWs1CD() {
		return ws1CD;
	}

	public void setWs1CD(String ws1cd) {
		ws1CD = ws1cd;
	}

	public String getWs1SapCD() {
		return ws1SapCD;
	}

	public void setWs1SapCD(String ws1SapCD) {
		this.ws1SapCD = ws1SapCD;
	}

	public String getWs2CD() {
		return ws2CD;
	}

	public void setWs2CD(String ws2cd) {
		ws2CD = ws2cd;
	}

	public String getWs2SapCD() {
		return ws2SapCD;
	}

	public void setWs2SapCD(String ws2SapCD) {
		this.ws2SapCD = ws2SapCD;
	}

	public String getWs3CD() {
		return ws3CD;
	}

	public void setWs3CD(String ws3cd) {
		ws3CD = ws3cd;
	}

	public String getWs3SapCD() {
		return ws3SapCD;
	}

	public void setWs3SapCD(String ws3SapCD) {
		this.ws3SapCD = ws3SapCD;
	}

	public String getWs4SapCD() {
		return ws4SapCD;
	}

	public void setWs4SapCD(String ws4SapCD) {
		this.ws4SapCD = ws4SapCD;
	}

	public String getWs4CD() {
		return ws4CD;
	}

	public void setWs4CD(String ws4cd) {
		ws4CD = ws4cd;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String[] getTmpVenueCDs() {
		return tmpVenueCDs;
	}

	public void setTmpVenueCDs(String[] tmpVenueCDs) {
		this.tmpVenueCDs = tmpVenueCDs;
	}

	public String[] getRequestDates() {
		return requestDates;
	}

	public void setRequestDates(String[] requestDates) {
		this.requestDates = requestDates;
	}

	public String[] getApprDates() {
		return apprDates;
	}

	public void setApprDates(String[] apprDates) {
		this.apprDates = apprDates;
	}

	public String[] getRequestStateCDs() {
		return requestStateCDs;
	}

	public void setRequestStateCDs(String[] requestStateCDs) {
		this.requestStateCDs = requestStateCDs;
	}

	public String[] getLapprLevelNos() {
		return lapprLevelNos;
	}

	public void setLapprLevelNos(String[] lapprLevelNos) {
		this.lapprLevelNos = lapprLevelNos;
	}

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String[] getVenueNms() {
		return venueNms;
	}

	public void setVenueNms(String[] venueNms) {
		this.venueNms = venueNms;
	}

	public String[] getDkmdTpCDs() {
		return dkmdTpCDs;
	}

	public void setDkmdTpCDs(String[] dkmdTpCDs) {
		this.dkmdTpCDs = dkmdTpCDs;
	}

	public String[] getTerritoryCDs() {
		return territoryCDs;
	}

	public void setTerritoryCDs(String[] territoryCDs) {
		this.territoryCDs = territoryCDs;
	}

	public String[] getVenueGradCDs() {
		return venueGradCDs;
	}

	public void setVenueGradCDs(String[] venueGradCDs) {
		this.venueGradCDs = venueGradCDs;
	}

	public String[] getChannelCDs() {
		return channelCDs;
	}

	public void setChannelCDs(String[] channelCDs) {
		this.channelCDs = channelCDs;
	}

	public String[] getSubChannelCDs() {
		return subChannelCDs;
	}

	public void setSubChannelCDs(String[] subChannelCDs) {
		this.subChannelCDs = subChannelCDs;
	}

	public String[] getSegmentCDs() {
		return segmentCDs;
	}

	public void setSegmentCDs(String[] segmentCDs) {
		this.segmentCDs = segmentCDs;
	}

	public String[] getSubSegmentCDs() {
		return subSegmentCDs;
	}

	public void setSubSegmentCDs(String[] subSegmentCDs) {
		this.subSegmentCDs = subSegmentCDs;
	}

	public String[] getAddrTpCD1s() {
		return addrTpCD1s;
	}

	public void setAddrTpCD1s(String[] addrTpCD1s) {
		this.addrTpCD1s = addrTpCD1s;
	}

	public String[] getAddrTpCD2s() {
		return addrTpCD2s;
	}

	public void setAddrTpCD2s(String[] addrTpCD2s) {
		this.addrTpCD2s = addrTpCD2s;
	}

	public String[] getAddrTpCD3s() {
		return addrTpCD3s;
	}

	public void setAddrTpCD3s(String[] addrTpCD3s) {
		this.addrTpCD3s = addrTpCD3s;
	}

	public String[] getAddrTpCD4s() {
		return addrTpCD4s;
	}

	public void setAddrTpCD4s(String[] addrTpCD4s) {
		this.addrTpCD4s = addrTpCD4s;
	}


	public String[] getNote1s() {
		return note1s;
	}

	public void setNote1s(String[] note1s) {
		this.note1s = note1s;
	}

	public String[] getNote2s() {
		return note2s;
	}

	public void setNote2s(String[] note2s) {
		this.note2s = note2s;
	}

	public String[] getNote3s() {
		return note3s;
	}

	public void setNote3s(String[] note3s) {
		this.note3s = note3s;
	}

	public String[] getNote4s() {
		return note4s;
	}

	public void setNote4s(String[] note4s) {
		this.note4s = note4s;
	}

	public String[] getIncntTpCDs() {
		return incntTpCDs;
	}

	public void setIncntTpCDs(String[] incntTpCDs) {
		this.incntTpCDs = incntTpCDs;
	}

	public String[] getActiveYNs() {
		return activeYNs;
	}

	public void setActiveYNs(String[] activeYNs) {
		this.activeYNs = activeYNs;
	}

	public String[] getRegIDs() {
		return regIDs;
	}

	public void setRegIDs(String[] regIDs) {
		this.regIDs = regIDs;
	}

	public String[] getRegDates() {
		return regDates;
	}

	public void setRegDates(String[] regDates) {
		this.regDates = regDates;
	}

	public String[] getChgIDs() {
		return chgIDs;
	}

	public void setChgIDs(String[] chgIDs) {
		this.chgIDs = chgIDs;
	}

	public String[] getChgDates() {
		return chgDates;
	}

	public void setChgDates(String[] chgDates) {
		this.chgDates = chgDates;
	}

	public String[] getVenueDivCDs() {
		return venueDivCDs;
	}

	public void setVenueDivCDs(String[] venueDivCDs) {
		this.venueDivCDs = venueDivCDs;
	}

	public String[] getNewAddr1s() {
		return newAddr1s;
	}

	public void setNewAddr1s(String[] newAddr1s) {
		this.newAddr1s = newAddr1s;
	}

	public String[] getOldAddr1s() {
		return oldAddr1s;
	}

	public void setOldAddr1s(String[] oldAddr1s) {
		this.oldAddr1s = oldAddr1s;
	}
	
	public String[] getMdDupYNs() {
		return mdDupYNs;
	}

	public void setMdDupYNs(String[] mdDupYNs) {
		this.mdDupYNs = mdDupYNs;
	}

	public String[] getSiteCDs() {
		return siteCDs;
	}

	public void setSiteCDs(String[] siteCDs) {
		this.siteCDs = siteCDs;
	}

	public String[] getAgeingCDs() {
		return ageingCDs;
	}

	public void setAgeingCDs(String[] ageingCDs) {
		this.ageingCDs = ageingCDs;
	}

	public String[] getKegYNs() {
		return kegYNs;
	}

	public void setKegYNs(String[] kegYNs) {
		this.kegYNs = kegYNs;
	}

	public String[] getLocationCDs() {
		return locationCDs;
	}

	public void setLocationCDs(String[] locationCDs) {
		this.locationCDs = locationCDs;
	}

	public String[] getReserveSegmentCDs() {
		return reserveSegmentCDs;
	}

	public void setReserveSegmentCDs(String[] reserveSegmentCDs) {
		this.reserveSegmentCDs = reserveSegmentCDs;
	}

	public String[] getReason1CDs() {
		return reason1CDs;
	}

	public void setReason1CDs(String[] reason1cDs) {
		reason1CDs = reason1cDs;
	}

	public String[] getReason2s() {
		return reason2s;
	}

	public void setReason2s(String[] reason2s) {
		this.reason2s = reason2s;
	}

	public String[] getWs1CDs() {
		return ws1CDs;
	}

	public void setWs1CDs(String[] ws1cDs) {
		ws1CDs = ws1cDs;
	}

	public String[] getWs1SapCDs() {
		return ws1SapCDs;
	}

	public void setWs1SapCDs(String[] ws1SapCDs) {
		this.ws1SapCDs = ws1SapCDs;
	}

	public String[] getWs2CDs() {
		return ws2CDs;
	}

	public void setWs2CDs(String[] ws2cDs) {
		ws2CDs = ws2cDs;
	}

	public String[] getWs2SapCDs() {
		return ws2SapCDs;
	}

	public void setWs2SapCDs(String[] ws2SapCDs) {
		this.ws2SapCDs = ws2SapCDs;
	}

	public String[] getWs3CDs() {
		return ws3CDs;
	}

	public void setWs3CDs(String[] ws3cDs) {
		ws3CDs = ws3cDs;
	}

	public String[] getWs3SapCDs() {
		return ws3SapCDs;
	}

	public void setWs3SapCDs(String[] ws3SapCDs) {
		this.ws3SapCDs = ws3SapCDs;
	}

	public String[] getWs4CDs() {
		return ws4CDs;
	}

	public void setWs4CDs(String[] ws4cDs) {
		ws4CDs = ws4cDs;
	}

	public String[] getWs4SapCDs() {
		return ws4SapCDs;
	}

	public void setWs4SapCDs(String[] ws4SapCDs) {
		this.ws4SapCDs = ws4SapCDs;
	}

	public String[] getPhoneNos() {
		return phoneNos;
	}

	public void setPhoneNos(String[] phoneNos) {
		this.phoneNos = phoneNos;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getMdVenueCD() {
		return mdVenueCD;
	}

	public void setMdVenueCD(String mdVenueCD) {
		this.mdVenueCD = mdVenueCD;
	}

	public String[] getMdVenueCDs() {
		return mdVenueCDs;
	}

	public void setMdVenueCDs(String[] mdVenueCDs) {
		this.mdVenueCDs = mdVenueCDs;
	}

	public String getRequestDateCD() {
		return requestDateCD;
	}

	public void setRequestDateCD(String requestDateCD) {
		this.requestDateCD = requestDateCD;
	}

	public String getApprTpID() {
		return apprTpID;
	}

	public void setApprTpID(String apprTpID) {
		this.apprTpID = apprTpID;
	}

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String getGbn() {
		return gbn;
	}

	public void setGbn(String gbn) {
		this.gbn = gbn;
	}

	public String[] getCommts() {
		return commts;
	}

	public void setCommts(String[] commts) {
		this.commts = commts;
	}

	public String getVenSeq() {
		return venSeq;
	}

	public void setVenSeq(String venSeq) {
		this.venSeq = venSeq;
	}

	public String[] getVenSeqs() {
		return venSeqs;
	}

	public void setVenSeqs(String[] venSeqs) {
		this.venSeqs = venSeqs;
	}

	public String getLevelNo() {
		return levelNo;
	}

	public void setLevelNo(String levelNo) {
		this.levelNo = levelNo;
	}

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getApprCommt() {
		return apprCommt;
	}

	public void setApprCommt(String apprCommt) {
		this.apprCommt = apprCommt;
	}

	public String[] getGbns() {
		return gbns;
	}

	public void setGbns(String[] gbns) {
		this.gbns = gbns;
	}

	public String[] getLevelNos() {
		return levelNos;
	}

	public void setLevelNos(String[] levelNos) {
		this.levelNos = levelNos;
	}

	public String[] getApprStateCDs() {
		return apprStateCDs;
	}

	public void setApprStateCDs(String[] apprStateCDs) {
		this.apprStateCDs = apprStateCDs;
	}

	public String[] getApprCommts() {
		return apprCommts;
	}

	public void setApprCommts(String[] apprCommts) {
		this.apprCommts = apprCommts;
	}

	public String getLastApprYN() {
		return lastApprYN;
	}

	public void setLastApprYN(String lastApprYN) {
		this.lastApprYN = lastApprYN;
	}

	public String[] getLastApprYNs() {
		return lastApprYNs;
	}

	public void setLastApprYNs(String[] lastApprYNs) {
		this.lastApprYNs = lastApprYNs;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String[] getEmailAddrs() {
		return emailAddrs;
	}

	public void setEmailAddrs(String[] emailAddrs) {
		this.emailAddrs = emailAddrs;
	}

	public String[] getApprTpIDs() {
		return apprTpIDs;
	}

	public void setApprTpIDs(String[] apprTpIDs) {
		this.apprTpIDs = apprTpIDs;
	}

	public String getPrintYN() {
		return printYN;
	}

	public void setPrintYN(String printYN) {
		this.printYN = printYN;
	}

	public String getSaveChk() {
		return saveChk;
	}

	public void setSaveChk(String saveChk) {
		this.saveChk = saveChk;
	}

	public String[] getActiveFlgs() {
		return activeFlgs;
	}

	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
	}

	public String getPostCD() {
		return postCD;
	}

	public void setPostCD(String postCD) {
		this.postCD = postCD;
	}

	public String[] getPostCDs() {
		return postCDs;
	}

	public void setPostCDs(String[] postCDs) {
		this.postCDs = postCDs;
	}

	public String getNewAddr2() {
		return newAddr2;
	}

	public void setNewAddr2(String newAddr2) {
		this.newAddr2 = newAddr2;
	}

	public String getOldAddr2() {
		return oldAddr2;
	}

	public void setOldAddr2(String oldAddr2) {
		this.oldAddr2 = oldAddr2;
	}

	public String[] getNewAddr2s() {
		return newAddr2s;
	}

	public void setNewAddr2s(String[] newAddr2s) {
		this.newAddr2s = newAddr2s;
	}

	public String[] getOldAddr2s() {
		return oldAddr2s;
	}

	public void setOldAddr2s(String[] oldAddr2s) {
		this.oldAddr2s = oldAddr2s;
	}

	public String getAddrTpCD5() {
		return addrTpCD5;
	}

	public void setAddrTpCD5(String addrTpCD5) {
		this.addrTpCD5 = addrTpCD5;
	}

	public String[] getAddrTpCD5s() {
		return addrTpCD5s;
	}

	public void setAddrTpCD5s(String[] addrTpCD5s) {
		this.addrTpCD5s = addrTpCD5s;
	}

	public String getMaxNum() {
		return maxNum;
	}

	public void setMaxNum(String maxNum) {
		this.maxNum = maxNum;
	}

	public String getLegalCD() {
		return legalCD;
	}

	public void setLegalCD(String legalCD) {
		this.legalCD = legalCD;
	}

	public String[] getLegalCDs() {
		return legalCDs;
	}

	public void setLegalCDs(String[] legalCDs) {
		this.legalCDs = legalCDs;
	}
	
	
	
}