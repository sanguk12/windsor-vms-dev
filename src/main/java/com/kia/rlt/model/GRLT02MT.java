package com.kia.rlt.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

public class GRLT02MT extends CommonObject implements Model {

	//GRLT02MT
	private String eventYM = "";
	private String venueCD = "";
	private String venueNM = "";
	
	private String dkmdTpCD = "";
	private String empID = "";
	private String rageSphereCD = "";
	private String officeCD = "";
	private String teamCD = "";
	private String territoryCD = "";
	private String programCD= "";
	private String activityCD = "";
	private String supportID = "";
	private String applyDateFrom = "";
	private String applyDateTo = "";
	private String activeFlg = "";
	private String incntTpCD = "";
	private String[] venueCDs = null;
	private String[] venueNMs = null;
	
	private String[] verifyErrCommts = null;
	private String[] activityCDs = null;
	private String[] supportIDs = null;
	private String[] payCommts = null;
	private String[] transferDates = null;
	private String[] transferDueDates = null;
	
	//GRLT02DT
	private String prdCD = "";
	private String prdNM = "";
	private String factoryPrice = "";
	private String sdxYN = "";
	private String rfidQty = "";
	private String resultTpCD = "";
	private String resultQty = "";
	private String resultUnitAmt = "";
	private String guidAmt = "";
	private String payAmt = "";
	private String targetQty = "";
	private String sdxTpCD = "";
	private String targetRate = "";
	private String gsvRate = "";
	private String commt = "";
	private String keymanID = "";
	private String bankCD = "";
	private String accountNo = "";
	private String holderNm = "";
	private String apprStateCD = "";
	private String verifyStateCD = "";
	private String verifyErrCommt = "";
	private String lApprLevelNo = "";
	private String lverifyLevelNo = "";
	private String payStateCD = "";
	private String payCommt = "";
	private String payApprDate = "";
	private String transferDate = "";
	private String transferDueDate = "";
	private String keyChkYN = "";
	private String keyChkNote = "";
	private String prdCDs[] = null;
	private String prdNMs[] = null;
	
	private String factoryPrices[] = null;
	private String sdxYNs[] = null;
	private String rfidQtys[] = null;
	private String resultTpCDs[] = null;
	private String resultQtys[] = null;
	private String resultUnitAmts[] = null;
	private String guidAmts[] = null;
	private String payAmts[] = null;
	private String targetQtys[] = null;
	private String sdxTpCDs[] = null;
	private String targetRates[] = null;
	private String gsvRates[] = null;
	private String commts[] = null;
	private String keymanIDs[] = null;
	private String bankCDs[] = null;
	private String accountNos[] = null;
	private String holderNms[] = null;
	private String apprStateCDs[] = null;
	private String verifyStateCDs[] = null;
	private String keyChkYNs[] = null;
	private String keyChkNotes[] = null;
	
	//mail
	private String emailAddr = "";
	private String rageSphereCDName = "";
	private String officeCDName = "";
	private String teamCDName = "";
	
	//GRLT08MT
	private String apprTpID = "";
	private String apprTpID_bef = "";
	private String levelNo = "";
	private String apprCommt = "";
	private String lastApprYN = "";	//최종승인여부
	private String levelNos[] = null;
	private String apprCommts[] = null;
	private String lastApprYNs[] = null;
	
	//SMS
	private String callback =""; //보내는전화번호	
	
	public void clean() {
		try{resultQty = StringUtil.unFormatNum(resultQty);}catch(Exception e){}
		try{resultUnitAmt = StringUtil.unFormatNum(resultUnitAmt);}catch(Exception e){}
		try{guidAmt = StringUtil.unFormatNum(guidAmt);}catch(Exception e){}
		try{payAmt = StringUtil.unFormatNum(payAmt);}catch(Exception e){}
		try{targetQty = StringUtil.unFormatNum(targetQty);}catch(Exception e){}
		try{targetRate = StringUtil.unFormatNum(targetRate);}catch(Exception e){}
		try{gsvRate = StringUtil.unFormatNum(gsvRate);}catch(Exception e){}
	}
	
	public void validate(int action) throws Exception {
	}
	
	public int getSize_prd() {
		int size = 0 ;
		if (this.prdCDs != null) {
			 size = this.prdCDs.length;
		}
		return size;
	}
	
	public GRLT02MT getObject_prd(int index) {
		GRLT02MT vo = new GRLT02MT();
		if (getSize_prd() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setVenueNM(this.venueNMs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setPrdNM(this.prdNMs[index]);}catch(Exception e){}
			
			try{vo.setFactoryPrice(StringUtil.unFormatNum(this.factoryPrices[index]));}catch(Exception e){}
			try{vo.setSdxYN(this.sdxYNs[index]);}catch(Exception e){}
			try{vo.setRfidQty(StringUtil.unFormatNum(this.rfidQtys[index]));}catch(Exception e){}
			try{vo.setResultTpCD(this.resultTpCDs[index]);}catch(Exception e){}
			try{vo.setResultQty(StringUtil.unFormatNum(this.resultQtys[index]));}catch(Exception e){}
			try{vo.setResultUnitAmt(StringUtil.unFormatNum(this.resultUnitAmts[index]));}catch(Exception e){}
			try{vo.setGuidAmt(StringUtil.unFormatNum(this.guidAmts[index]));}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
			try{vo.setTargetQty(StringUtil.unFormatNum(this.targetQtys[index]));}catch(Exception e){}
			try{vo.setSdxTpCD(this.sdxTpCDs[index]);}catch(Exception e){}
			try{vo.setTargetRate(StringUtil.unFormatNum(this.targetRates[index]));}catch(Exception e){}
			try{vo.setGsvRate(StringUtil.unFormatNum(this.gsvRates[index]));}catch(Exception e){}
			try{vo.setCommt(this.commts[index]);}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setBankCD(this.bankCDs[index]);}catch(Exception e){}
			try{vo.setAccountNo(this.accountNos[index]);}catch(Exception e){}
			try{vo.setHolderNm(this.holderNms[index]);}catch(Exception e){}
			try{vo.setApprStateCD(this.apprStateCDs[index]);}catch(Exception e){}
			try{vo.setVerifyStateCD(this.verifyStateCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.venueCDs != null) {
			 size = this.venueCDs.length;
		}
		return size;
	}
	
	public GRLT02MT getObject_request(int index) {
		GRLT02MT vo = new GRLT02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setVerifyStateCD(this.getVerifyStateCD());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT02MT getObject_approval(int index) {
		GRLT02MT vo = new GRLT02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
		}
		return vo;
	}

	public GRLT02MT getObject_reject(int index) {
		GRLT02MT vo = new GRLT02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT02MT getObject_verify(int index) {
		GRLT02MT vo = new GRLT02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setVerifyErrCommt(this.verifyErrCommts[index]);}catch(Exception e){}
			try{vo.setActivityCD(this.activityCDs[index]);}catch(Exception e){}
			try{vo.setSupportID(this.supportIDs[index]);}catch(Exception e){}
			try{vo.setPayAmt(FormatUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT02MT getObject_pay(int index) {
		GRLT02MT vo = new GRLT02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setBankCD(this.bankCDs[index]);}catch(Exception e){}
			try{vo.setAccountNo(this.accountNos[index]);}catch(Exception e){}
			try{vo.setHolderNm(this.holderNms[index]);}catch(Exception e){}
			try{vo.setPayCommt(this.payCommts[index]);}catch(Exception e){}
			try{vo.setTransferDate(FormatUtil.unFormat(this.transferDates[index]));}catch(Exception e){}
			try{vo.setTransferDueDate(FormatUtil.unFormat(this.transferDueDates[index]));}catch(Exception e){}
			try{vo.setKeyChkYN(this.keyChkYNs[index]);}catch(Exception e){}
			try{vo.setKeyChkNote(this.keyChkNotes[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public String getEventYM() {
		return eventYM;
	}

	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}

	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String dkmdTpCD) {
		this.dkmdTpCD = dkmdTpCD;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getRageSphereCD() {
		return rageSphereCD;
	}

	public void setRageSphereCD(String rageSphereCD) {
		this.rageSphereCD = rageSphereCD;
	}

	public String getOfficeCD() {
		return officeCD;
	}

	public void setOfficeCD(String officeCD) {
		this.officeCD = officeCD;
	}

	public String getTeamCD() {
		return teamCD;
	}

	public void setTeamCD(String teamCD) {
		this.teamCD = teamCD;
	}

	public String getTerritoryCD() {
		return territoryCD;
	}

	public void setTerritoryCD(String territoryCD) {
		this.territoryCD = territoryCD;
	}

	public String getProgramCD() {
		return programCD;
	}

	public void setProgramCD(String programCD) {
		this.programCD = programCD;
	}

	public String getActivityCD() {
		return activityCD;
	}

	public void setActivityCD(String activityCD) {
		this.activityCD = activityCD;
	}
	
	public String getSupportID() {
		return supportID;
	}

	public void setSupportID(String supportID) {
		this.supportID = supportID;
	}

	public String getApplyDateFrom() {
		return applyDateFrom;
	}

	public void setApplyDateFrom(String applyDateFrom) {
		this.applyDateFrom = applyDateFrom;
	}

	public String getApplyDateTo() {
		return applyDateTo;
	}

	public void setApplyDateTo(String applyDateTo) {
		this.applyDateTo = applyDateTo;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getIncntTpCD() {
		return incntTpCD;
	}

	public void setIncntTpCD(String incntTpCD) {
		this.incntTpCD = incntTpCD;
	}

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String[] getVerifyErrCommts() {
		return verifyErrCommts;
	}

	public void setVerifyErrCommts(String[] verifyErrCommts) {
		this.verifyErrCommts = verifyErrCommts;
	}
	
	public String[] getActivityCDs() {
		return activityCDs;
	}

	public void setActivityCDs(String[] activityCDs) {
		this.activityCDs = activityCDs;
	}
	
	public String[] getSupportIDs() {
		return supportIDs;
	}

	public void setSupportIDs(String[] supportIDs) {
		this.supportIDs = supportIDs;
	}

	public String[] getPayCommts() {
		return payCommts;
	}

	public void setPayCommts(String[] payCommts) {
		this.payCommts = payCommts;
	}

	public String[] getTransferDates() {
		return transferDates;
	}

	public void setTransferDates(String[] transferDates) {
		this.transferDates = transferDates;
	}

	public String[] gettransferDueDates() {
		return transferDueDates;
	}

	public void settransferDueDates(String[] transferDueDates) {
		this.transferDueDates = transferDueDates;
	}

	public String getTransferDueDate() {
		return transferDueDate;
	}

	public void setTransferDueDate(String transferDueDate) {
		this.transferDueDate = transferDueDate;
	}

	public String getPrdCD() {
		return prdCD;
	}

	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}

	public String getFactoryPrice() {
		return factoryPrice;
	}

	public void setFactoryPrice(String factoryPrice) {
		this.factoryPrice = factoryPrice;
	}

	public String getSdxYN() {
		return sdxYN;
	}

	public void setSdxYN(String sdxYN) {
		this.sdxYN = sdxYN;
	}

	public String getRfidQty() {
		return rfidQty;
	}

	public void setRfidQty(String rfidQty) {
		this.rfidQty = rfidQty;
	}

	public String getResultTpCD() {
		return resultTpCD;
	}

	public void setResultTpCD(String resultTpCD) {
		this.resultTpCD = resultTpCD;
	}

	public String getResultQty() {
		return resultQty;
	}

	public void setResultQty(String resultQty) {
		this.resultQty = resultQty;
	}

	public String getResultUnitAmt() {
		return resultUnitAmt;
	}

	public void setResultUnitAmt(String resultUnitAmt) {
		this.resultUnitAmt = resultUnitAmt;
	}

	public String getGuidAmt() {
		return guidAmt;
	}

	public void setGuidAmt(String guidAmt) {
		this.guidAmt = guidAmt;
	}

	public String getPayAmt() {
		return payAmt;
	}

	public void setPayAmt(String payAmt) {
		this.payAmt = payAmt;
	}

	public String getTargetQty() {
		return targetQty;
	}

	public void setTargetQty(String targetQty) {
		this.targetQty = targetQty;
	}

	public String getSdxTpCD() {
		return sdxTpCD;
	}

	public void setSdxTpCD(String sdxTpCD) {
		this.sdxTpCD = sdxTpCD;
	}

	public String getTargetRate() {
		return targetRate;
	}

	public void setTargetRate(String targetRate) {
		this.targetRate = targetRate;
	}

	public String getGsvRate() {
		return gsvRate;
	}

	public void setGsvRate(String gsvRate) {
		this.gsvRate = gsvRate;
	}

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String getKeymanID() {
		return keymanID;
	}

	public void setKeymanID(String keymanID) {
		this.keymanID = keymanID;
	}

	public String getBankCD() {
		return bankCD;
	}

	public void setBankCD(String bankCD) {
		this.bankCD = bankCD;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	
	public String getHolderNm() {
		return holderNm;
	}

	public void setHolderNm(String holderNm) {
		this.holderNm = holderNm;
	}

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getVerifyStateCD() {
		return verifyStateCD;
	}

	public void setVerifyStateCD(String verifyStateCD) {
		this.verifyStateCD = verifyStateCD;
	}

	public String getVerifyErrCommt() {
		return verifyErrCommt;
	}

	public void setVerifyErrCommt(String verifyErrCommt) {
		this.verifyErrCommt = verifyErrCommt;
	}

	public String getlApprLevelNo() {
		return lApprLevelNo;
	}

	public void setlApprLevelNo(String lApprLevelNo) {
		this.lApprLevelNo = lApprLevelNo;
	}

	public String getLverifyLevelNo() {
		return lverifyLevelNo;
	}

	public void setLverifyLevelNo(String lverifyLevelNo) {
		this.lverifyLevelNo = lverifyLevelNo;
	}

	public String getPayStateCD() {
		return payStateCD;
	}

	public void setPayStateCD(String payStateCD) {
		this.payStateCD = payStateCD;
	}

	public String getPayCommt() {
		return payCommt;
	}

	public void setPayCommt(String payCommt) {
		this.payCommt = payCommt;
	}

	public String getPayApprDate() {
		return payApprDate;
	}

	public void setPayApprDate(String payApprDate) {
		this.payApprDate = payApprDate;
	}

	public String getTransferDate() {
		return transferDate;
	}

	public void setTransferDate(String transferDate) {
		this.transferDate = transferDate;
	}

	public String[] getPrdCDs() {
		return prdCDs;
	}

	public void setPrdCDs(String[] prdCDs) {
		this.prdCDs = prdCDs;
	}

	public String[] getFactoryPrices() {
		return factoryPrices;
	}

	public void setFactoryPrices(String[] factoryPrices) {
		this.factoryPrices = factoryPrices;
	}

	public String[] getSdxYNs() {
		return sdxYNs;
	}

	public void setSdxYNs(String[] sdxYNs) {
		this.sdxYNs = sdxYNs;
	}

	public String[] getRfidQtys() {
		return rfidQtys;
	}

	public void setRfidQtys(String[] rfidQtys) {
		this.rfidQtys = rfidQtys;
	}

	public String[] getResultTpCDs() {
		return resultTpCDs;
	}

	public void setResultTpCDs(String[] resultTpCDs) {
		this.resultTpCDs = resultTpCDs;
	}

	public String[] getResultQtys() {
		return resultQtys;
	}

	public void setResultQtys(String[] resultQtys) {
		this.resultQtys = resultQtys;
	}

	public String[] getResultUnitAmts() {
		return resultUnitAmts;
	}

	public void setResultUnitAmts(String[] resultUnitAmts) {
		this.resultUnitAmts = resultUnitAmts;
	}

	public String[] getGuidAmts() {
		return guidAmts;
	}

	public void setGuidAmts(String[] guidAmts) {
		this.guidAmts = guidAmts;
	}

	public String[] getPayAmts() {
		return payAmts;
	}

	public void setPayAmts(String[] payAmts) {
		this.payAmts = payAmts;
	}

	public String[] getTargetQtys() {
		return targetQtys;
	}

	public void setTargetQtys(String[] targetQtys) {
		this.targetQtys = targetQtys;
	}

	public String[] getSdxTpCDs() {
		return sdxTpCDs;
	}

	public void setSdxTpCDs(String[] sdxTpCDs) {
		this.sdxTpCDs = sdxTpCDs;
	}

	public String[] getTargetRates() {
		return targetRates;
	}

	public void setTargetRates(String[] targetRates) {
		this.targetRates = targetRates;
	}

	public String[] getGsvRates() {
		return gsvRates;
	}

	public void setGsvRates(String[] gsvRates) {
		this.gsvRates = gsvRates;
	}

	public String[] getCommts() {
		return commts;
	}

	public void setCommts(String[] commts) {
		this.commts = commts;
	}

	public String[] getKeymanIDs() {
		return keymanIDs;
	}

	public void setKeymanIDs(String[] keymanIDs) {
		this.keymanIDs = keymanIDs;
	}

	public String[] getBankCDs() {
		return bankCDs;
	}

	public void setBankCDs(String[] bankCDs) {
		this.bankCDs = bankCDs;
	}

	public String[] getAccountNos() {
		return accountNos;
	}

	public void setAccountNos(String[] accountNos) {
		this.accountNos = accountNos;
	}

	public String[] getHolderNms() {
		return holderNms;
	}

	public void setHolderNms(String[] holderNms) {
		this.holderNms = holderNms;
	}

	public String[] getApprStateCDs() {
		return apprStateCDs;
	}

	public void setApprStateCDs(String[] apprStateCDs) {
		this.apprStateCDs = apprStateCDs;
	}

	public String[] getVerifyStateCDs() {
		return verifyStateCDs;
	}

	public void setVerifyStateCDs(String[] verifyStateCDs) {
		this.verifyStateCDs = verifyStateCDs;
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

	public String getApprTpID() {
		return apprTpID;
	}

	public void setApprTpID(String apprTpID) {
		this.apprTpID = apprTpID;
	}
	
	public String getApprTpID_bef() {
		return apprTpID_bef;
	}

	public void setApprTpID_bef(String apprTpID_bef) {
		this.apprTpID_bef = apprTpID_bef;
	}

	public String getLevelNo() {
		return levelNo;
	}

	public void setLevelNo(String levelNo) {
		this.levelNo = levelNo;
	}

	public String getApprCommt() {
		return apprCommt;
	}

	public void setApprCommt(String apprCommt) {
		this.apprCommt = apprCommt;
	}

	public String getLastApprYN() {
		return lastApprYN;
	}

	public void setLastApprYN(String lastApprYN) {
		this.lastApprYN = lastApprYN;
	}

	public String[] getLevelNos() {
		return levelNos;
	}

	public void setLevelNos(String[] levelNos) {
		this.levelNos = levelNos;
	}

	public String[] getApprCommts() {
		return apprCommts;
	}

	public void setApprCommts(String[] apprCommts) {
		this.apprCommts = apprCommts;
	}

	public String[] getLastApprYNs() {
		return lastApprYNs;
	}

	public void setLastApprYNs(String[] lastApprYNs) {
		this.lastApprYNs = lastApprYNs;
	}

	public String getVenueNM() {
		return venueNM;
	}

	public void setVenueNM(String venueNM) {
		this.venueNM = venueNM;
	}

	public String[] getVenueNMs() {
		return venueNMs;
	}

	public void setVenueNMs(String[] venueNMs) {
		this.venueNMs = venueNMs;
	}

	public String getPrdNM() {
		return prdNM;
	}

	public void setPrdNM(String prdNM) {
		this.prdNM = prdNM;
	}

	public String[] getPrdNMs() {
		return prdNMs;
	}

	public void setPrdNMs(String[] prdNMs) {
		this.prdNMs = prdNMs;
	}

	public String[] getTransferDueDates() {
		return transferDueDates;
	}

	public void setTransferDueDates(String[] transferDueDates) {
		this.transferDueDates = transferDueDates;
	}

	public String getKeyChkYN() {
		return keyChkYN;
	}

	public void setKeyChkYN(String keyChkYN) {
		this.keyChkYN = keyChkYN;
	}

	public String getKeyChkNote() {
		return keyChkNote;
	}

	public void setKeyChkNote(String keyChkNote) {
		this.keyChkNote = keyChkNote;
	}

	public String[] getKeyChkYNs() {
		return keyChkYNs;
	}

	public void setKeyChkYNs(String[] keyChkYNs) {
		this.keyChkYNs = keyChkYNs;
	}

	public String[] getKeyChkNotes() {
		return keyChkNotes;
	}

	public void setKeyChkNotes(String[] keyChkNotes) {
		this.keyChkNotes = keyChkNotes;
	}

	public String getCallback() {
		return callback;
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}
	
}