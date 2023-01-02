package com.kia.rlt.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

public class GRLT01MT extends CommonObject implements Model {

	private String eventYM = "";
	private String venueCD = "";
	private String diffNo = "";
	private String programCD = "";
	private String activityCD = "";
	private String resultTQty = "";
	private String targetRate = "";
	private String guidPayRate = "";
	private String payRate = "";
	private String excPayTpCD = "";
	private String tpayAmt = "";
	private String resultTpCD = "";
	private String gsvRate = "";
	private String commt = "";
	private String apprStateCD = "";
	private String verifyStateCD = "";
	private String verifyErrCommt = "";
	private String payStateCD = "";
	private String payCommt = "";
	private String payApprDate = "";
	private String transferDueDate = "";
	private String transferDate = "";
	private String lapprLevelNo = "";
	private String activeFlg = "";
	private String supportID = "";
	private String keyChkYN = "";
	private String keyChkNote = "";
	private String apprType = "";
	private String apprLv = "";
	
	private String[] apprTypes = null;
	private String[] venueCDs = null;
	private String[] verifyErrCommts = null;
	private String[] activityCDs = null;
	private String[] tpayAmts = null;
	private String[] payCommts = null;
	private String[] transferDueDates = null;
	private String[] transferDates = null;
	private String[] supportIDs = null;
	private String[] keyChkYNs = null;
	private String[] keyChkNotes = null;
	
	//GRLT01DT
	private String incntTpCD = "";
	private String prdCD = "";
	private String factoryPrice = "";
	private String sdxYN = "";
	private String rfidQty = "";
	private String resultQty = "";
	private String resultUnitAmt = "";
	private String incomeTax = "";
	private String residentTax = "";
	private String withholdingTax = "";
	private String totalAmt = "";
	private String inputQty = "";
	private String inputAmt = "";
	private String kindTpCD5 = "";
	private String limitQtyFlag = "";
	private String prdCDs[] = null;
	private String rfidQtys[] = null;
	private String resultQtys[] = null;
	private String resultUnitAmts[] = null;
	private String incomeTaxs[] = null;
	private String residentTaxs[] = null;
	private String withholdingTaxs[] = null;
	private String totalAmts[] = null;
	private String inputQtys[] = null;
	private String inputAmts[] = null;
	private String kindTpCD5s[] = null;
	private String limitQtyFlags[] = null;
	
	//mail
	private String emailAddr = "";
	private String rageSphereCDName = "";
	private String officeCDName = "";
	private String teamCDName = "";
	
	//GRLT06MT
	private String keymanID = "";
	private String bankCD = "";
	private String accountNo = "";
	private String payAmt = "";
	private String incentive = "";
	private String holderNm = "";
	private String keymanIDs[] = null;
	private String bankCDs[] = null;
	private String accountNos[] = null;
	private String payAmts[] = null;
	private String incentives[] = null;
	private String activeFlgs[] = null;
	private String holderNms[] = null;
	
	//GRLT07MT
	private String apprTpID = "";
	private String apprTpID_Normal = "";
	private String apprTpID_bef = "";	//검증메일시 쓰임
	private String levelNo = "";
	private String apprCommt = "";
	private String lastApprYN = "";	//최종승인여부
	private String levelNos[] = null;
	private String apprCommts[] = null;
	private String lastApprYNs[] = null;
	private String empIDs[] = null;
	
	//SMS
	private String callback =""; //보내는전화번호
	
	private String rageSphereCD = "";
	private String officeCD = "";
	
	public void clean() {
		try{resultTQty = StringUtil.unFormatNum(resultTQty);}catch(Exception e){}
		try{targetRate = StringUtil.unFormatNum(targetRate);}catch(Exception e){}
		try{guidPayRate = StringUtil.unFormatNum(guidPayRate);}catch(Exception e){}
		try{payRate = StringUtil.unFormatNum(payRate);}catch(Exception e){}
		try{tpayAmt = StringUtil.unFormatNum(tpayAmt);}catch(Exception e){}
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
	
	public GRLT01MT getObject_prd(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize_prd() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.getVenueCD());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setRfidQty(StringUtil.unFormatNum(this.rfidQtys[index]));}catch(Exception e){}
			try{vo.setResultQty(StringUtil.unFormatNum(this.resultQtys[index]));}catch(Exception e){}
			try{vo.setResultUnitAmt(StringUtil.unFormatNum(this.resultUnitAmts[index]));}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
			try{vo.setIncomeTax(StringUtil.unFormatNum(this.incomeTaxs[index]));}catch(Exception e){}
			try{vo.setResidentTax(StringUtil.unFormatNum(this.residentTaxs[index]));}catch(Exception e){}
			try{vo.setWithholdingTax(StringUtil.unFormatNum(this.withholdingTaxs[index]));}catch(Exception e){}
			try{vo.setTotalAmt(StringUtil.unFormatNum(this.totalAmts[index]));}catch(Exception e){}
			try{vo.setInputQty(StringUtil.unFormatNum(this.inputQtys[index]));}catch(Exception e){}
			try{vo.setInputAmt(StringUtil.unFormatNum(this.inputAmts[index]));}catch(Exception e){}
			try{vo.setKindTpCD5(this.kindTpCD5s[index]);}catch(Exception e){}
			try{vo.setLimitQtyFlag(this.limitQtyFlags[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize_keyman() {
		int size = 0 ;
		if (this.keymanIDs != null) {
			 size = this.keymanIDs.length;
		}
		return size;
	}
	
	public GRLT01MT getObject_keyman(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize_keyman() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.getVenueCD());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setBankCD(this.bankCDs[index]);}catch(Exception e){}
			try{vo.setAccountNo(this.accountNos[index]);}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
			try{vo.setIncentive(StringUtil.unFormatNum(this.incentives[index]));}catch(Exception e){}
			try{vo.setHolderNm(this.holderNms[index]);}catch(Exception e){}
			try{vo.setKeyChkYN(this.keyChkYNs[index]);}catch(Exception e){}
			try{vo.setKeyChkNote(this.keyChkNotes[index]);}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
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
	
	public int getSize2() {
		int size = 0 ;
		if (this.empIDs != null) {
			 size = this.empIDs.length;
		}
		return size;
	}
	
	public int getSize_new() {
		int size = 0 ;
		if (this.levelNos != null) {
			size = this.levelNos.length;
		}
		return size;
	}
	
	public GRLT01MT getObject_request(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setVerifyStateCD(this.getVerifyStateCD());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_request_apprType(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setApprTpID_Normal(this.getApprTpID_Normal());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setVerifyStateCD(this.getVerifyStateCD());}catch(Exception e){}
			try{vo.setApprType(this.apprTypes[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_approval(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_approval_new(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize_new() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setApprTpID_Normal(this.getApprTpID_Normal());}catch(Exception e){}
			try{vo.setActivityCD(this.getActivityCD());}catch(Exception e){}
			try{vo.setOfficeCD(this.getOfficeCD());}catch(Exception e){}
			try{vo.setRageSphereCD(this.getRageSphereCD());}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setApprType(this.apprTypes[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_approval_apprType(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setApprTpID_Normal(this.getApprTpID_Normal());}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setApprType(this.apprTypes[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_reject(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_reject_apprType(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setApprTpID_Normal(this.getApprTpID_Normal());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setApprType(this.apprTypes[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_determine(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setVerifyStateCD(this.getVerifyStateCD());}catch(Exception e){}
			try{vo.setPayStateCD(this.getPayStateCD());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_verify(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setVerifyErrCommt(this.verifyErrCommts[index]);}catch(Exception e){}
			try{vo.setActivityCD(this.activityCDs[index]);}catch(Exception e){}
			try{vo.setTpayAmt(FormatUtil.unFormatNum(this.tpayAmts[index]));}catch(Exception e){}
			try{vo.setSupportID(this.supportIDs[index]);}catch(Exception e){}
			try{vo.setKeyChkYN(this.keyChkYNs[index]);}catch(Exception e){}
			try{vo.setKeyChkNote(this.keyChkNotes[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_pay(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPayCommt(this.payCommts[index]);}catch(Exception e){}
			try{vo.setTransferDate(FormatUtil.unFormat(this.transferDates[index]));}catch(Exception e){}
			try{vo.setTransferDueDate(FormatUtil.unFormat(this.transferDueDates[index]));}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_payKeyman(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize_keyman() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setBankCD(this.bankCDs[index]);}catch(Exception e){}
			try{vo.setAccountNo(this.accountNos[index]);}catch(Exception e){}
			try{vo.setHolderNm(this.holderNms[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_paySupport(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setDiffNo(this.getDiffNo());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPayCommt(this.payCommts[index]);}catch(Exception e){}
			try{vo.setTransferDate(FormatUtil.unFormat(this.transferDates[index]));}catch(Exception e){}
			try{vo.setTransferDueDate(FormatUtil.unFormat(this.transferDueDates[index]));}catch(Exception e){}
		}
		return vo;
	}
	
	public GRLT01MT getObject_reject2(int index) {
		GRLT01MT vo = new GRLT01MT();
		if (getSize2() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setEmpID(this.empIDs[index]);}catch(Exception e){}
			try{vo.setDiffNo(this.diffNo);}catch(Exception e){}
		}
		return vo;
	}

	public String getSupportID() {
		return supportID;
	}

	public void setSupportID(String supportID) {
		this.supportID = supportID;
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

	public String[] getSupportIDs() {
		return supportIDs;
	}

	public void setSupportIDs(String[] supportIDs) {
		this.supportIDs = supportIDs;
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

	public String[] getTpayAmts() {
		return tpayAmts;
	}

	public void setTpayAmts(String[] tpayAmts) {
		this.tpayAmts = tpayAmts;
	}

	public String[] getActivityCDs() {
		return activityCDs;
	}

	public void setActivityCDs(String[] activityCDs) {
		this.activityCDs = activityCDs;
	}

	public String getTransferDate() {
		return transferDate;
	}

	public void setTransferDate(String transferDate) {
		this.transferDate = transferDate;
	}

	public String getTransferDueDate() {
		return transferDueDate;
	}

	public void setTransferDueDate(String transferDueDate) {
		this.transferDueDate = transferDueDate;
	}

	public String[] getTransferDueDates() {
		return transferDueDates;
	}

	public void setTransferDueDates(String[] transferDueDates) {
		this.transferDueDates = transferDueDates;
	}

	public String[] getTransferDates() {
		return transferDates;
	}

	public void setTransferDates(String[] transferDates) {
		this.transferDates = transferDates;
	}

	public String getPayCommt() {
		return payCommt;
	}

	public void setPayCommt(String payCommt) {
		this.payCommt = payCommt;
	}

	public String[] getPayCommts() {
		return payCommts;
	}

	public void setPayCommts(String[] payCommts) {
		this.payCommts = payCommts;
	}

	public String getPayApprDate() {
		return payApprDate;
	}

	public void setPayApprDate(String payApprDate) {
		this.payApprDate = payApprDate;
	}

	public String getApprTpID_bef() {
		return apprTpID_bef;
	}

	public void setApprTpID_bef(String apprTpID_bef) {
		this.apprTpID_bef = apprTpID_bef;
	}

	public String getVerifyErrCommt() {
		return verifyErrCommt;
	}

	public void setVerifyErrCommt(String verifyErrCommt) {
		this.verifyErrCommt = verifyErrCommt;
	}

	public String[] getVerifyErrCommts() {
		return verifyErrCommts;
	}

	public void setVerifyErrCommts(String[] verifyErrCommts) {
		this.verifyErrCommts = verifyErrCommts;
	}

	public String getHolderNm() {
		return holderNm;
	}

	public void setHolderNm(String holderNm) {
		this.holderNm = holderNm;
	}

	public String[] getHolderNms() {
		return holderNms;
	}

	public void setHolderNms(String[] holderNms) {
		this.holderNms = holderNms;
	}

	public String getPayStateCD() {
		return payStateCD;
	}

	public void setPayStateCD(String payStateCD) {
		this.payStateCD = payStateCD;
	}

	public String getVerifyStateCD() {
		return verifyStateCD;
	}

	public void setVerifyStateCD(String verifyStateCD) {
		this.verifyStateCD = verifyStateCD;
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

	public String getIncntTpCD() {
		return incntTpCD;
	}

	public void setIncntTpCD(String incntTpCD) {
		this.incntTpCD = incntTpCD;
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

	public String getResultTQty() {
		return resultTQty;
	}

	public void setResultTQty(String resultTQty) {
		this.resultTQty = resultTQty;
	}

	public String getTargetRate() {
		return targetRate;
	}

	public void setTargetRate(String targetRate) {
		this.targetRate = targetRate;
	}

	public String getGuidPayRate() {
		return guidPayRate;
	}

	public void setGuidPayRate(String guidPayRate) {
		this.guidPayRate = guidPayRate;
	}

	public String getPayRate() {
		return payRate;
	}

	public void setPayRate(String payRate) {
		this.payRate = payRate;
	}

	public String getExcPayTpCD() {
		return excPayTpCD;
	}

	public void setExcPayTpCD(String excPayTpCD) {
		this.excPayTpCD = excPayTpCD;
	}

	public String getTpayAmt() {
		return tpayAmt;
	}

	public void setTpayAmt(String tpayAmt) {
		this.tpayAmt = tpayAmt;
	}

	public String getResultTpCD() {
		return resultTpCD;
	}

	public void setResultTpCD(String resultTpCD) {
		this.resultTpCD = resultTpCD;
	}

	public String getGsvRate() {
		return gsvRate;
	}

	public void setGsvRate(String gsvRate) {
		this.gsvRate = gsvRate;
	}

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getLapprLevelNo() {
		return lapprLevelNo;
	}

	public void setLapprLevelNo(String lapprLevelNo) {
		this.lapprLevelNo = lapprLevelNo;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String getDiffNo() {
		return diffNo;
	}

	public void setDiffNo(String diffNo) {
		this.diffNo = diffNo;
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

	public String[] getPrdCDs() {
		return prdCDs;
	}

	public void setPrdCDs(String[] prdCDs) {
		this.prdCDs = prdCDs;
	}

	public String[] getRfidQtys() {
		return rfidQtys;
	}

	public void setRfidQtys(String[] rfidQtys) {
		this.rfidQtys = rfidQtys;
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

	public String getPayAmt() {
		return payAmt;
	}

	public void setPayAmt(String payAmt) {
		this.payAmt = payAmt;
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

	public String[] getPayAmts() {
		return payAmts;
	}

	public void setPayAmts(String[] payAmts) {
		this.payAmts = payAmts;
	}

	public String[] getActiveFlgs() {
		return activeFlgs;
	}

	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
	}

	public String getCallback() {
		return callback;
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getApprTpID_Normal() {
		return apprTpID_Normal;
	}

	public void setApprTpID_Normal(String apprTpID_Normal) {
		this.apprTpID_Normal = apprTpID_Normal;
	}

	public String getApprType() {
		return apprType;
	}

	public void setApprType(String apprType) {
		this.apprType = apprType;
	}
	
	public String getApprLv() {
		return apprLv;
	}

	public void setApprLv(String apprLv) {
		this.apprLv = apprLv;
	}

	public String[] getApprTypes() {
		return apprTypes;
	}

	public void setApprTypes(String[] apprTypes) {
		this.apprTypes = apprTypes;
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

	public String[] getEmpIDs() {
		return empIDs;
	}
	public String getIncentive() {
		return incentive;
	}

	public void setEmpIDs(String[] empIDs) {
		this.empIDs = empIDs;
	}

	public void setIncentive(String incentive) {
		this.incentive = incentive;
	}

	public String[] getIncentives() {
		return incentives;
	}

	public void setIncentives(String[] incentives) {
		this.incentives = incentives;
	}

	public String getIncomeTax() {
		return incomeTax;
	}

	public void setIncomeTax(String incomeTax) {
		this.incomeTax = incomeTax;
	}

	public String getResidentTax() {
		return residentTax;
	}

	public void setResidentTax(String residentTax) {
		this.residentTax = residentTax;
	}

	public String getWithholdingTax() {
		return withholdingTax;
	}

	public void setWithholdingTax(String withholdingTax) {
		this.withholdingTax = withholdingTax;
	}

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

	public String[] getIncomeTaxs() {
		return incomeTaxs;
	}

	public void setIncomeTaxs(String[] incomeTaxs) {
		this.incomeTaxs = incomeTaxs;
	}

	public String[] getResidentTaxs() {
		return residentTaxs;
	}

	public void setResidentTaxs(String[] residentTaxs) {
		this.residentTaxs = residentTaxs;
	}

	public String[] getWithholdingTaxs() {
		return withholdingTaxs;
	}

	public void setWithholdingTaxs(String[] withholdingTaxs) {
		this.withholdingTaxs = withholdingTaxs;
	}

	public String[] getTotalAmts() {
		return totalAmts;
	}

	public void setTotalAmts(String[] totalAmts) {
		this.totalAmts = totalAmts;
	}

	public String getInputQty() {
		return inputQty;
	}

	public void setInputQty(String inputQty) {
		this.inputQty = inputQty;
	}

	public String getInputAmt() {
		return inputAmt;
	}

	public void setInputAmt(String inputAmt) {
		this.inputAmt = inputAmt;
	}

	public String getLimitQtyFlag() {
		return limitQtyFlag;
	}

	public void setLimitQtyFlag(String limitQtyFlag) {
		this.limitQtyFlag = limitQtyFlag;
	}

	public String[] getInputQtys() {
		return inputQtys;
	}

	public void setInputQtys(String[] inputQtys) {
		this.inputQtys = inputQtys;
	}

	public String[] getInputAmts() {
		return inputAmts;
	}

	public void setInputAmts(String[] inputAmts) {
		this.inputAmts = inputAmts;
	}
	
	public String getKindTpCD5() {
		return kindTpCD5;
	}

	public void setKindTpCD5(String kindTpCD5) {
		this.kindTpCD5 = kindTpCD5;
	}

	public String[] getKindTpCD5s() {
		return kindTpCD5s;
	}

	public void setKindTpCD5s(String[] kindTpCD5s) {
		this.kindTpCD5s = kindTpCD5s;
	}

	public String[] getLimitQtyFlags() {
		return limitQtyFlags;
	}

	public void setLimitQtyFlags(String[] limitQtyFlags) {
		this.limitQtyFlags = limitQtyFlags;
	}
	
}