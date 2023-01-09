package com.kia.ad.model;

import java.util.Map;

import com.kia.ltc.model.GLTC01MT;
import com.kia.mdm.model.GVEN01MT;
import com.kia.pln.model.GPLN01MT;
import com.kia.rlt.model.GRLT01MT;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.StringUtil;

public class GAD01MT extends CommonObject implements Model{
	
	private String venueCD = "";
	private String totalAmt = "";
	private String territoryCD = "";
	private String teamCD = "";
	private String startDT = "";
	private String regID = "";
	private String regDate = "";
	private String rageSphereCD = "";
	private String prdTotalAmt = "";
	private String posmAmt = "";
	private String perfDivCD = "";
	private String payStateCD = "";
	private String officeCD = "";
	private String incAmt = "";
	private String endDT = "";
	private String dkmdtpCD = "";
	private String contractStateCD = "";
	private String contractMonth = "";
	private String contractDivCD = "";
	private String commt = "";
	private String chgID = "";
	private String chgDate = "";
	private String apprStateCD = "";
	private String apprCommt = "";
	private String apAmt = "";
	private String adSupportID = "";
	private String apprType = "";
	private String apprExpc = "";
	private String prdCD = "";
	private String prdQty = "";
	private String eventYm = "";
	private String activeYN = "";
	private String seq = "";
	private String activeFlg = "";
	private String expcCommt = "";
	private String adChgFlg = "";

	private String newcontractYn = "";

	//mail
	private String emailAddr = "";
	private String rageSphereCDName = "";
	private String officeCDName = "";
	private String teamCDName = "";
	
	//GAD02MT
	private String activeYN_02 = "";
	
	//GAD03MT
	private String eventYM = "";
	private String empID = "";
	private String apprTpID = "";
	private String levelNo = "";
	private String lastApprYN = "";	//최종승인여부
	private String apprGrpNM = "";
	private String apprDate = "";
	private String levelNos[] = null;
	private String lastApprYNs[] = null;
	private String empIDs[] = null;
	
	//GAD04MT
	private String adContractDivCD = "";
	private String adSeq = "";
	
	//GAD07MT
	private String buCD = "";
	private String requiredADCD1 = "";
	private String amt1 = "";
	private String requiredADCD2 = "";
	private String amt2 = "";
	private String requiredADCD3 = "";
	private String amt3 = "";
	
	//GAD08MT
	private String adHistoryCD = "";
	
	private String[] venueCDs = null;
	private String[] totalAmts = null;
	private String[] territoryCDs = null;
	private String[] teamCDs = null;
	private String[] startDTs = null;
	private String[] regIDs = null;
	private String[] regDates = null;
	private String[] rageSphereCDs = null;
	private String[] prdTotalAmts = null;
	private String[] posmAmts = null;
	private String[] perfDivCDs = null;
	private String[] payStateCDs = null;
	private String[] officeCDs = null;
	private String[] incAmts = null;
	private String[] endDTs = null;
	private String[] dkmdtpCDs = null;
	private String[] contractStateCDs = null;
	private String[] contractMonths = null;
	private String[] contractDivCDs = null;
	private String[] commts = null;
	private String[] chgIDs = null;
	private String[] chgDates = null;
	private String[] apprStateCDs = null;
	private String[] apprCommts = null;
	private String[] apAmts = null;
	private String[] adSupportIDs = null;
	private String[] prdCDs = null;
	private String[] prdQtys = null;
	private String[] eventYms = null;
	private String[] activeFlgs = null;
	private String[] apprExpcs = null;
	private String[] apprTpIDs = null;
	private String[] adSeqs = null;
	private String[] adContractDivCDs = null;
	private String[] adChgFlgs = null;

	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.venueCDs != null) {
			 size = this.venueCDs.length;
		}
		return size;
	}
	public int getSize_prd() {
		int size = 0 ;
		if (this.prdCDs != null) {
			size = this.prdCDs.length;
		}
		return size;
	}
	
	//승인요청, 승인요청 취소
	public GAD01MT getObject_request(int index) {
		GAD01MT vo = new GAD01MT();
		
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setAdSupportID(this.adSupportIDs[index]);}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setAdSupportID(this.adSupportIDs[index]);}catch(Exception e){}
			try{vo.setApprExpc(this.apprExpcs[index]);}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setAdSeq(this.adSeqs[index]);}catch(Exception e){}
			try{vo.setAdContractDivCD(this.getAdContractDivCD());}catch(Exception e){}
			try{vo.setAdChgFlg(this.adChgFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//승인
	public GAD01MT getObject_approval(int index) {
		GAD01MT vo = new GAD01MT();
		
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setActiveYN_02(this.getActiveYN_02());}catch(Exception e){}
			try{vo.setContractStateCD(this.getContractStateCD());}catch(Exception e){}
			try{vo.setAdHistoryCD(this.getAdHistoryCD());}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setApprExpc(this.apprExpcs[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setAdSupportID(this.adSupportIDs[index]);}catch(Exception e){}
			try{vo.setAdSeq(this.adSeqs[index]);}catch(Exception e){}
			try{vo.setAdContractDivCD(this.adContractDivCDs[index]);}catch(Exception e){}
			try{vo.setAdChgFlg(this.adChgFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//반려
	public GAD01MT getObject_reject(int index) {
		GAD01MT vo = new GAD01MT();
		
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setAdSupportID(this.adSupportIDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setApprExpc(this.apprExpcs[index]);}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setAdSeq(this.adSeqs[index]);}catch(Exception e){}
			try{vo.setAdContractDivCD(this.adContractDivCDs[index]);}catch(Exception e){}
			try{vo.setAdChgFlg(this.adChgFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//반려
	public GAD01MT getObject_reject_s(int index) {
		GAD01MT vo = new GAD01MT();
			
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setApprExpc(this.apprExpcs[index]);}catch(Exception e){}
			try{vo.setApprTpID(this.apprTpIDs[index]);}catch(Exception e){}
			try{vo.setAdSeq(this.adSeqs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//계약완료
	public GAD01MT getObject_finishContract(int index) {
		GAD01MT vo = new GAD01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setActiveYN_02(this.getActiveYN_02());}catch(Exception e){}
			try{vo.setAdSupportID(this.adSupportIDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprExpc(this.apprExpcs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	//지급완료
	public GAD01MT getObject_finishPay(int index) {
		GAD01MT vo = new GAD01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setAdSupportID(this.adSupportIDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GAD01MT getObject_prd(int index, String adSupportID) {
		GAD01MT vo = new GAD01MT();
		if (getSize_prd() > index) {
			try{vo.setAdSupportID(adSupportID);}catch(Exception e){}
			try{vo.setAdSeq(this.getAdSeq());}catch(Exception e){}
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setAdSupportID(this.getAdSupportID());}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setPrdQty(StringUtil.unFormatNum(this.prdQtys[index]));}catch(Exception e){}
			try{vo.setEventYm(StringUtil.unFormatNum(this.eventYms[index]));}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public String getVenueCD() {
		return venueCD;
	}
	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}
	public String getTotalAmt() {
		return totalAmt;
	}
	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}
	public String getTerritoryCD() {
		return territoryCD;
	}
	public void setTerritoryCD(String territoryCD) {
		this.territoryCD = territoryCD;
	}
	public String getTeamCD() {
		return teamCD;
	}
	public void setTeamCD(String teamCD) {
		this.teamCD = teamCD;
	}
	public String getStartDT() {
		return startDT;
	}
	public void setStartDT(String startDT) {
		this.startDT = startDT;
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
	public String getRageSphereCD() {
		return rageSphereCD;
	}
	public void setRageSphereCD(String rageSphereCD) {
		this.rageSphereCD = rageSphereCD;
	}
	public String getPrdTotalAmt() {
		return prdTotalAmt;
	}
	public void setPrdTotalAmt(String prdTotalAmt) {
		this.prdTotalAmt = prdTotalAmt;
	}
	public String getPosmAmt() {
		return posmAmt;
	}
	public void setPosmAmt(String posmAmt) {
		this.posmAmt = posmAmt;
	}
	public String getPerfDivCD() {
		return perfDivCD;
	}
	public void setPerfDivCD(String perfDivCD) {
		this.perfDivCD = perfDivCD;
	}
	public String getPayStateCD() {
		return payStateCD;
	}
	public void setPayStateCD(String payStateCD) {
		this.payStateCD = payStateCD;
	}
	public String getOfficeCD() {
		return officeCD;
	}
	public void setOfficeCD(String officeCD) {
		this.officeCD = officeCD;
	}
	public String getIncAmt() {
		return incAmt;
	}
	public void setIncAmt(String incAmt) {
		this.incAmt = incAmt;
	}
	public String getEndDT() {
		return endDT;
	}
	public void setEndDT(String endDT) {
		this.endDT = endDT;
	}
	public String getDkmdtpCD() {
		return dkmdtpCD;
	}
	public void setDkmdtpCD(String dkmdtpCD) {
		this.dkmdtpCD = dkmdtpCD;
	}
	public String getContractStateCD() {
		return contractStateCD;
	}
	public void setContractStateCD(String contractStateCD) {
		this.contractStateCD = contractStateCD;
	}
	public String getContractMonth() {
		return contractMonth;
	}
	public void setContractMonth(String contractMonth) {
		this.contractMonth = contractMonth;
	}
	public String getContractDivCD() {
		return contractDivCD;
	}
	public void setContractDivCD(String contractDivCD) {
		this.contractDivCD = contractDivCD;
	}
	public String getCommt() {
		return commt;
	}
	public void setCommt(String commt) {
		this.commt = commt;
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
	public String getApAmt() {
		return apAmt;
	}
	public void setApAmt(String apAmt) {
		this.apAmt = apAmt;
	}
	public String getAdSupportID() {
		return adSupportID;
	}
	public void setAdSupportID(String adSupportID) {
		this.adSupportID = adSupportID;
	}
	public String getApprType() {
		return apprType;
	}
	public void setApprType(String apprType) {
		this.apprType = apprType;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getRageSphereCDName() {
		return rageSphereCDName;
	}
	public void setRageSphereCDName(String rageSphereCDName) {
		this.rageSphereCDName = rageSphereCDName;
	}
	public String getOfficeCDName() {
		return officeCDName;
	}
	public void setOfficeCDName(String officeCDName) {
		this.officeCDName = officeCDName;
	}
	public String getTeamCDName() {
		return teamCDName;
	}
	public void setTeamCDName(String teamCDName) {
		this.teamCDName = teamCDName;
	}
	public String getActiveYN_02() {
		return activeYN_02;
	}
	public void setActiveYN_02(String activeYN_02) {
		this.activeYN_02 = activeYN_02;
	}
	public String getEventYM() {
		return eventYM;
	}
	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}
	public String getEmpID() {
		return empID;
	}
	public void setEmpID(String empID) {
		this.empID = empID;
	}
	public String getApprTpID() {
		return apprTpID;
	}
	public void setApprTpID(String apprTpID) {
		this.apprTpID = apprTpID;
	}
	public String getLevelNo() {
		return levelNo;
	}
	public void setLevelNo(String levelNo) {
		this.levelNo = levelNo;
	}
	public String getLastApprYN() {
		return lastApprYN;
	}
	public void setLastApprYN(String lastApprYN) {
		this.lastApprYN = lastApprYN;
	}
	public String getApprGrpNM() {
		return apprGrpNM;
	}
	public void setApprGrpNM(String apprGrpNM) {
		this.apprGrpNM = apprGrpNM;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String[] getLevelNos() {
		return levelNos;
	}
	public void setLevelNos(String[] levelNos) {
		this.levelNos = levelNos;
	}
	public String[] getLastApprYNs() {
		return lastApprYNs;
	}
	public void setLastApprYNs(String[] lastApprYNs) {
		this.lastApprYNs = lastApprYNs;
	}
	public String[] getEmpIDs() {
		return empIDs;
	}
	public void setEmpIDs(String[] empIDs) {
		this.empIDs = empIDs;
	}
	public String getAdContractDivCD() {
		return adContractDivCD;
	}
	public void setAdContractDivCD(String adContractDivCD) {
		this.adContractDivCD = adContractDivCD;
	}
	public String getAdSeq() {
		return adSeq;
	}
	public void setAdSeq(String adSeq) {
		this.adSeq = adSeq;
	}
	public String[] getVenueCDs() {
		return venueCDs;
	}
	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}
	public String[] getTotalAmts() {
		return totalAmts;
	}
	public void setTotalAmts(String[] totalAmts) {
		this.totalAmts = totalAmts;
	}
	public String[] getTerritoryCDs() {
		return territoryCDs;
	}
	public void setTerritoryCDs(String[] territoryCDs) {
		this.territoryCDs = territoryCDs;
	}
	public String[] getTeamCDs() {
		return teamCDs;
	}
	public void setTeamCDs(String[] teamCDs) {
		this.teamCDs = teamCDs;
	}
	public String[] getStartDTs() {
		return startDTs;
	}
	public void setStartDTs(String[] startDTs) {
		this.startDTs = startDTs;
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
	public String[] getRageSphereCDs() {
		return rageSphereCDs;
	}
	public void setRageSphereCDs(String[] rageSphereCDs) {
		this.rageSphereCDs = rageSphereCDs;
	}
	public String[] getPrdTotalAmts() {
		return prdTotalAmts;
	}
	public void setPrdTotalAmts(String[] prdTotalAmts) {
		this.prdTotalAmts = prdTotalAmts;
	}
	public String[] getPosmAmts() {
		return posmAmts;
	}
	public void setPosmAmts(String[] posmAmts) {
		this.posmAmts = posmAmts;
	}
	public String[] getPerfDivCDs() {
		return perfDivCDs;
	}
	public void setPerfDivCDs(String[] perfDivCDs) {
		this.perfDivCDs = perfDivCDs;
	}
	public String[] getPayStateCDs() {
		return payStateCDs;
	}
	public void setPayStateCDs(String[] payStateCDs) {
		this.payStateCDs = payStateCDs;
	}
	public String[] getOfficeCDs() {
		return officeCDs;
	}
	public void setOfficeCDs(String[] officeCDs) {
		this.officeCDs = officeCDs;
	}
	public String[] getIncAmts() {
		return incAmts;
	}
	public void setIncAmts(String[] incAmts) {
		this.incAmts = incAmts;
	}
	public String[] getEndDTs() {
		return endDTs;
	}
	public void setEndDTs(String[] endDTs) {
		this.endDTs = endDTs;
	}
	public String[] getDkmdtpCDs() {
		return dkmdtpCDs;
	}
	public void setDkmdtpCDs(String[] dkmdtpCDs) {
		this.dkmdtpCDs = dkmdtpCDs;
	}
	public String[] getContractStateCDs() {
		return contractStateCDs;
	}
	public void setContractStateCDs(String[] contractStateCDs) {
		this.contractStateCDs = contractStateCDs;
	}
	public String[] getContractMonths() {
		return contractMonths;
	}
	public void setContractMonths(String[] contractMonths) {
		this.contractMonths = contractMonths;
	}
	public String[] getContractDivCDs() {
		return contractDivCDs;
	}
	public void setContractDivCDs(String[] contractDivCDs) {
		this.contractDivCDs = contractDivCDs;
	}
	public String[] getCommts() {
		return commts;
	}
	public void setCommts(String[] commts) {
		this.commts = commts;
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
	public String[] getApAmts() {
		return apAmts;
	}
	public void setApAmts(String[] apAmts) {
		this.apAmts = apAmts;
	}
	public String[] getAdSupportIDs() {
		return adSupportIDs;
	}
	public void setAdSupportIDs(String[] adSupportIDs) {
		this.adSupportIDs = adSupportIDs;
	}
	public String[] getPrdCDs() {
		return prdCDs;
	}
	public void setPrdCDs(String[] prdCDs) {
		this.prdCDs = prdCDs;
	}
	public String[] getPrdQtys() {
		return prdQtys;
	}
	public void setPrdQtys(String[] prdQtys) {
		this.prdQtys = prdQtys;
	}
	public String getApprExpc() {
		return apprExpc;
	}
	public void setApprExpc(String apprExpc) {
		this.apprExpc = apprExpc;
	}
	public String getPrdCD() {
		return prdCD;
	}
	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}
	public String getPrdQty() {
		return prdQty;
	}
	public void setPrdQty(String prdQty) {
		this.prdQty = prdQty;
	}
	public String getEventYm() {
		return eventYm;
	}
	public void setEventYm(String eventYm) {
		this.eventYm = eventYm;
	}
	public String getActiveYN() {
		return activeYN;
	}
	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
	}
	public String[] getEventYms() {
		return eventYms;
	}
	public void setEventYms(String[] eventYms) {
		this.eventYms = eventYms;
	}
	public String[] getApprExpcs() {
		return apprExpcs;
	}
	public void setApprExpcs(String[] apprExpcs) {
		this.apprExpcs = apprExpcs;
	}
	public String[] getApprTpIDs() {
		return apprTpIDs;
	}
	public void setApprTpIDs(String[] apprTpIDs) {
		this.apprTpIDs = apprTpIDs;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getActiveFlg() {
		return activeFlg;
	}
	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}
	public String[] getActiveFlgs() {
		return activeFlgs;
	}
	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
	}
	public String getExpcCommt() {
		return expcCommt;
	}
	public void setExpcCommt(String expcCommt) {
		this.expcCommt = expcCommt;
	}
	public String getnewcontractYn() {
		return newcontractYn;
	}
	public void setnewcontractYn(String newcontractYn) {
		this.newcontractYn = newcontractYn;
	}

	public String getAdChgFlg() {
		return adChgFlg;
	}
	public void setAdChgFlg(String adChgFlg) {
		this.adChgFlg = adChgFlg;
	}
	public String[] getAdSeqs() {
		return adSeqs;
	}
	public void setAdSeqs(String[] adSeqs) {
		this.adSeqs = adSeqs;
	}
	public String[] getAdContractDivCDs() {
		return adContractDivCDs;
	}
	public void setAdContractDivCDs(String[] adContractDivCDs) {
		this.adContractDivCDs = adContractDivCDs;
	}
	public String getBuCD() {
		return buCD;
	}
	public void setBuCD(String buCD) {
		this.buCD = buCD;
	}
	public String getRequiredADCD1() {
		return requiredADCD1;
	}
	public void setRequiredADCD1(String requiredADCD1) {
		this.requiredADCD1 = requiredADCD1;
	}
	public String getAmt1() {
		return amt1;
	}
	public void setAmt1(String amt1) {
		this.amt1 = amt1;
	}
	public String getRequiredADCD2() {
		return requiredADCD2;
	}
	public void setRequiredADCD2(String requiredADCD2) {
		this.requiredADCD2 = requiredADCD2;
	}
	public String getAmt2() {
		return amt2;
	}
	public void setAmt2(String amt2) {
		this.amt2 = amt2;
	}
	public String getRequiredADCD3() {
		return requiredADCD3;
	}
	public void setRequiredADCD3(String requiredADCD3) {
		this.requiredADCD3 = requiredADCD3;
	}
	public String getAmt3() {
		return amt3;
	}
	public void setAmt3(String amt3) {
		this.amt3 = amt3;
	}
	public String getAdHistoryCD() {
		return adHistoryCD;
	}
	public void setAdHistoryCD(String adHistoryCD) {
		this.adHistoryCD = adHistoryCD;
	}
	public String[] getAdChgFlgs() {
		return adChgFlgs;
	}
	public void setAdChgFlgs(String[] adChgFlgs) {
		this.adChgFlgs = adChgFlgs;
	}
}
