package com.kia.mil.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

public class GMIL01MT extends CommonObject implements Model {

	private String mileageID = "";
	private String venueCD = "";
	private String contractDateFrom = "";
	private String contractDateTo = "";
	private String contractMonthCt = "";
	private String apAmt = "";
	private String msTargetRate = "";
	private String tcontractQty = "";
	private String gsvAmt = "";
	private String gsvRate = "";
	private String contractAmt = "";
	private String contractTaxAmt = "";
	private String addContractAmt = "";
	private String addContractTaxAmt = "";
	private String stipulationAmt = "";
	private String payRequestDate = "";
	private String mileageStateCD = "";
	private String mileagePayTPCD = "";
	private String transferDate = "";
	private String transferDueDate = "";
	private String prdCD = "";
	private String factoryPrice = "";
	private String contractQty = "";
	private String enterQty = "";
	private String enterUnitAmt = "";
	private String addEnterUnitAmt = "";
	private String plnEnterQty = "";
	private String plnEnterUnitAmt = "";
	private String plnAddEnterUnitAmt = "";
	private String rltEnterQty = "";
	private String rltEnterUnitAmt = "";
	private String payAmt = "";
	private String addPayAmt = "";
	private String activeFlg = "";
	private String commt = "";
	private String empID = "";
	private String emailAddr = "";
	private String apprTpID = "";
	private String apprTpID_bef = "";
	private String eventYM = "";
	private String verifyStateCD = "";
	private String targetRate = "";
	private String payStateCD = "";
	private String verifyErrCommt = "";
	private String payCommt = "";
	
	private String rageSphereCDName = "";
	private String officeCDName = "";
	private String teamCDName = "";;

	private String levelNo = "";
	private String apprCommt = "";
	private String lastApprYN = "";	//최종승인여부
	//private String levelNos[] = null;
	//private String apprCommts[] = null;
	//private String lastApprYNs[] = null;

	private String[] mileageIDs = null;
	private String[] prdCDs = null;
	private String[] factoryPrices = null;
	private String[] contractQtys = null;
	private String[] enterQtys = null;
	private String[] enterUnitAmts = null;
	private String[] addEnterUnitAmts = null;
	private String[] plnEnterQtys = null;
	private String[] plnEnterUnitAmts = null;
	private String[] plnAddEnterUnitAmts = null;
	private String[] rltEnterQtys = null;
	private String[] rltEnterUnitAmts = null;
	private String[] payAmts = null;
	private String[] addPayAmts = null;
	private String[] activeFlgs = null;
	private String[] commts = null;
	private String[] transferDates = null;
	private String[] transferDueDates = null;
	private String[] payTpCDs = null;
	private String[] eventYMs = null;
	private String[] mileagePayTPCDs = null;
	private String[] verifyErrCommts = null;
	private String[] levelNos = null;
	private String[] apprCommts = null;
	private String[] lastApprYNs = null;
	private String[] payCommts = null;
	
	//GSUP03MT
	private String payTpCD = "";
	private String keymanID = "";
	private String bankCD = "";
	private String accountNo = "";
	private String holderNm = "";
	private String keymanIDs[] = null;
	private String bankCDs[] = null;
	private String accountNos[] = null;
	private String holderNms[] = null;
	
	//GSUP02MT
	private String addAmt = "";
	private String addTaxAmt = "";
	
	public void clean() {
		try{contractDateFrom = StringUtil.unFormat(contractDateFrom);}catch(Exception e){}
		try{contractDateTo = StringUtil.unFormat(contractDateTo);}catch(Exception e){}
		try{contractMonthCt = StringUtil.unFormatNum(contractMonthCt);}catch(Exception e){}
		try{apAmt = StringUtil.unFormatNum(apAmt);}catch(Exception e){}
		try{msTargetRate = StringUtil.unFormatNum(msTargetRate);}catch(Exception e){}
		try{tcontractQty = StringUtil.unFormatNum(tcontractQty);}catch(Exception e){}
		try{gsvAmt = StringUtil.unFormatNum(gsvAmt);}catch(Exception e){}
		try{gsvRate = StringUtil.unFormatNum(gsvRate);}catch(Exception e){}
		try{stipulationAmt = StringUtil.unFormatNum(stipulationAmt);}catch(Exception e){}
		try{contractAmt = StringUtil.unFormatNum(contractAmt);}catch(Exception e){}
		try{contractTaxAmt = StringUtil.unFormatNum(contractTaxAmt);}catch(Exception e){}
		try{addContractAmt = StringUtil.unFormatNum(addContractAmt);}catch(Exception e){}
		try{addContractTaxAmt = StringUtil.unFormatNum(addContractTaxAmt);}catch(Exception e){}
		try{payRequestDate = StringUtil.unFormat(payRequestDate);}catch(Exception e){}
		try{transferDate = StringUtil.unFormat(transferDate);}catch(Exception e){}
		try{transferDueDate = StringUtil.unFormat(transferDueDate);}catch(Exception e){}
		try{eventYM = StringUtil.unFormat(eventYM);}catch(Exception e){}
	}
	
	public void validate(int action) throws Exception {
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.prdCDs != null) {
			 size = this.prdCDs.length;
		}
		return size;
	}
	
	public GMIL01MT getObject(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setMileageID(this.getMileageID());}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setFactoryPrice(StringUtil.unFormatNum(this.factoryPrices[index]));}catch(Exception e){}
			try{vo.setContractQty(StringUtil.unFormatNum(this.contractQtys[index]));}catch(Exception e){}
			try{vo.setEnterQty(StringUtil.unFormatNum(this.enterQtys[index]));}catch(Exception e){}
			try{vo.setEnterUnitAmt(StringUtil.unFormatNum(this.enterUnitAmts[index]));}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
			try{vo.setAddEnterUnitAmt(StringUtil.unFormatNum(this.addEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setAddPayAmt(StringUtil.unFormatNum(this.addPayAmts[index]));}catch(Exception e){}
			try{vo.setPlnAddEnterUnitAmt(StringUtil.unFormatNum(this.plnAddEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setPlnEnterQty(StringUtil.unFormatNum(this.plnEnterQtys[index]));}catch(Exception e){}
			try{vo.setPlnEnterUnitAmt(StringUtil.unFormatNum(this.plnEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setRltEnterQty(StringUtil.unFormatNum(this.rltEnterQtys[index]));}catch(Exception e){}
			try{vo.setRltEnterUnitAmt(StringUtil.unFormatNum(this.rltEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setEventYM(StringUtil.unFormatNum(this.eventYMs[index]));}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}

	public int getSize_verify() {
		int size = 0 ;
		if (this.mileageIDs != null) {
			 size = this.mileageIDs.length;
		}
		return size;
	}

	public GMIL01MT getObject_verify(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize_verify() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setMileageID(this.mileageIDs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setFactoryPrice(StringUtil.unFormatNum(this.factoryPrices[index]));}catch(Exception e){}
			try{vo.setContractQty(StringUtil.unFormatNum(this.contractQtys[index]));}catch(Exception e){}
			try{vo.setEnterQty(StringUtil.unFormatNum(this.enterQtys[index]));}catch(Exception e){}
			try{vo.setEnterUnitAmt(StringUtil.unFormatNum(this.enterUnitAmts[index]));}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
			try{vo.setAddEnterUnitAmt(StringUtil.unFormatNum(this.addEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setAddPayAmt(StringUtil.unFormatNum(this.addPayAmts[index]));}catch(Exception e){}
			try{vo.setPlnAddEnterUnitAmt(StringUtil.unFormatNum(this.plnAddEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setPlnEnterQty(StringUtil.unFormatNum(this.plnEnterQtys[index]));}catch(Exception e){}
			try{vo.setPlnEnterUnitAmt(StringUtil.unFormatNum(this.plnEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setRltEnterQty(StringUtil.unFormatNum(this.rltEnterQtys[index]));}catch(Exception e){}
			try{vo.setRltEnterUnitAmt(StringUtil.unFormatNum(this.rltEnterUnitAmts[index]));}catch(Exception e){}
			try{vo.setEventYM(StringUtil.unFormatNum(this.eventYMs[index]));}catch(Exception e){}
			try{vo.setMileagePayTPCD(this.mileagePayTPCDs[index]);}catch(Exception e){}
			try{vo.setVerifyErrCommt(StringUtil.unFormatNum(this.verifyErrCommts[index]));}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}

	public String getPlnEnterQty() {
		return plnEnterQty;
	}

	public void setPlnEnterQty(String plnEnterQty) {
		this.plnEnterQty = plnEnterQty;
	}

	public String getPlnEnterUnitAmt() {
		return plnEnterUnitAmt;
	}

	public void setPlnEnterUnitAmt(String plnEnterUnitAmt) {
		this.plnEnterUnitAmt = plnEnterUnitAmt;
	}

	public String getPlnAddEnterUnitAmt() {
		return plnAddEnterUnitAmt;
	}

	public void setPlnAddEnterUnitAmt(String plnAddEnterUnitAmt) {
		this.plnAddEnterUnitAmt = plnAddEnterUnitAmt;
	}

	public String getRltEnterQty() {
		return rltEnterQty;
	}

	public void setRltEnterQty(String rltEnterQty) {
		this.rltEnterQty = rltEnterQty;
	}

	public String getRltEnterUnitAmt() {
		return rltEnterUnitAmt;
	}

	public void setRltEnterUnitAmt(String rltEnterUnitAmt) {
		this.rltEnterUnitAmt = rltEnterUnitAmt;
	}

	public String[] getPlnEnterQtys() {
		return plnEnterQtys;
	}

	public void setPlnEnterQtys(String[] plnEnterQtys) {
		this.plnEnterQtys = plnEnterQtys;
	}

	public String[] getPlnEnterUnitAmts() {
		return plnEnterUnitAmts;
	}

	public void setPlnEnterUnitAmts(String[] plnEnterUnitAmts) {
		this.plnEnterUnitAmts = plnEnterUnitAmts;
	}

	public String[] getPlnAddEnterUnitAmts() {
		return plnAddEnterUnitAmts;
	}

	public void setPlnAddEnterUnitAmts(String[] plnAddEnterUnitAmts) {
		this.plnAddEnterUnitAmts = plnAddEnterUnitAmts;
	}

	public String[] getRltEnterQtys() {
		return rltEnterQtys;
	}

	public void setRltEnterQtys(String[] rltEnterQtys) {
		this.rltEnterQtys = rltEnterQtys;
	}

	public String[] getRltEnterUnitAmts() {
		return rltEnterUnitAmts;
	}

	public void setRltEnterUnitAmts(String[] rltEnterUnitAmts) {
		this.rltEnterUnitAmts = rltEnterUnitAmts;
	}

	public int getSize_keyman() {
		int size = 0 ;
		if (this.keymanIDs != null) {
			 size = this.keymanIDs.length;
		}
		return size;
	}
	
	public GMIL01MT getObject_keyman(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize_keyman() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setMileageID(this.getMileageID());}catch(Exception e){}
			try{vo.setPayTpCD(this.getPayTpCD());}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setBankCD(this.bankCDs[index]);}catch(Exception e){}
			try{vo.setAccountNo(this.accountNos[index]);}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
			try{vo.setHolderNm(this.holderNms[index]);}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize_req() {
		int size = 0 ;
		if (this.mileageIDs != null) {
			 size = this.mileageIDs.length;
		}
		return size;
	}
	
	public GMIL01MT getObject_req(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setMileageStateCD(this.getMileageStateCD());}catch(Exception e){}
			try{vo.setMileageID(this.mileageIDs[index]);}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVerifyStateCD(this.getVerifyStateCD());}catch(Exception e){}
		}
		return vo;
	}
	
	public GMIL01MT getObject_pay(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setMileageStateCD(this.getMileageStateCD());}catch(Exception e){}
			try{vo.setMileageID(this.mileageIDs[index]);}catch(Exception e){}
			try{vo.setPayTpCD(this.payTpCDs[index]);}catch(Exception e){}
			try{vo.setCommt(this.commts[index]);}catch(Exception e){}
			try{vo.setPayCommt(this.payCommts[index]);}catch(Exception e){}
			try{vo.setTransferDate(FormatUtil.unFormat(this.transferDates[index]));}catch(Exception e){}
			try{vo.setTransferDueDate(FormatUtil.unFormat(this.transferDueDates[index]));}catch(Exception e){}
		}
		return vo;
	}

	public GMIL01MT getObject_request(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setMileageID(this.getMileageID());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVerifyStateCD(this.getVerifyStateCD());}catch(Exception e){}
		}
		return vo;
	}

	public GMIL01MT getObject_approval(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setMileageID(this.mileageIDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
		}
		return vo;
	}

	public GMIL01MT getObject_reject(int index) {
		GMIL01MT vo = new GMIL01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setMileageID(this.mileageIDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
		}
		return vo;
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

	public String[] getPayTpCDs() {
		return payTpCDs;
	}

	public void setPayTpCDs(String[] payTpCDs) {
		this.payTpCDs = payTpCDs;
	}

	public String[] getCommts() {
		return commts;
	}

	public void setCommts(String[] commts) {
		this.commts = commts;
	}

	public String[] getTransferDates() {
		return transferDates;
	}

	public void setTransferDates(String[] transferDates) {
		this.transferDates = transferDates;
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

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String getAddAmt() {
		return addAmt;
	}

	public String getMileagePayTPCD() {
		return mileagePayTPCD;
	}

	public void setMileagePayTPCD(String mileagePayTPCD) {
		this.mileagePayTPCD = mileagePayTPCD;
	}

	public void setAddAmt(String addAmt) {
		this.addAmt = addAmt;
	}

	public String getAddTaxAmt() {
		return addTaxAmt;
	}

	public void setAddTaxAmt(String addTaxAmt) {
		this.addTaxAmt = addTaxAmt;
	}

	public String getPayTpCD() {
		return payTpCD;
	}

	public void setPayTpCD(String payTpCD) {
		this.payTpCD = payTpCD;
	}

	public String[] getMileageIDs() {
		return mileageIDs;
	}

	public void setMileageIDs(String[] mileageIDs) {
		this.mileageIDs = mileageIDs;
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

	public String getMileageID() {
		return mileageID;
	}

	public void setMileageID(String mileageID) {
		this.mileageID = mileageID;
	}

	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getContractDateFrom() {
		return contractDateFrom;
	}

	public void setContractDateFrom(String contractDateFrom) {
		this.contractDateFrom = contractDateFrom;
	}

	public String getContractDateTo() {
		return contractDateTo;
	}

	public void setContractDateTo(String contractDateTo) {
		this.contractDateTo = contractDateTo;
	}

	public String getContractMonthCt() {
		return contractMonthCt;
	}

	public void setContractMonthCt(String contractMonthCt) {
		this.contractMonthCt = contractMonthCt;
	}

	public String getApAmt() {
		return apAmt;
	}

	public void setApAmt(String apAmt) {
		this.apAmt = apAmt;
	}

	public String getMsTargetRate() {
		return msTargetRate;
	}

	public void setMsTargetRate(String msTargetRate) {
		this.msTargetRate = msTargetRate;
	}

	public String getTcontractQty() {
		return tcontractQty;
	}

	public void setTcontractQty(String tcontractQty) {
		this.tcontractQty = tcontractQty;
	}

	public String getGsvAmt() {
		return gsvAmt;
	}

	public void setGsvAmt(String gsvAmt) {
		this.gsvAmt = gsvAmt;
	}

	public String getGsvRate() {
		return gsvRate;
	}

	public void setGsvRate(String gsvRate) {
		this.gsvRate = gsvRate;
	}

	public String getContractAmt() {
		return contractAmt;
	}

	public void setContractAmt(String contractAmt) {
		this.contractAmt = contractAmt;
	}

	public String getContractTaxAmt() {
		return contractTaxAmt;
	}

	public void setContractTaxAmt(String contractTaxAmt) {
		this.contractTaxAmt = contractTaxAmt;
	}

	public String getPayRequestDate() {
		return payRequestDate;
	}

	public void setPayRequestDate(String payRequestDate) {
		this.payRequestDate = payRequestDate;
	}

	public String getMileageStateCD() {
		return mileageStateCD;
	}

	public void setMileageStateCD(String mileageStateCD) {
		this.mileageStateCD = mileageStateCD;
	}

	public String getTransferDate() {
		return transferDate;
	}

	public void setTransferDate(String transferDate) {
		this.transferDate = transferDate;
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

	public String getContractQty() {
		return contractQty;
	}

	public void setContractQty(String contractQty) {
		this.contractQty = contractQty;
	}

	public String getEnterQty() {
		return enterQty;
	}

	public void setEnterQty(String enterQty) {
		this.enterQty = enterQty;
	}

	public String getEnterUnitAmt() {
		return enterUnitAmt;
	}

	public void setEnterUnitAmt(String enterUnitAmt) {
		this.enterUnitAmt = enterUnitAmt;
	}

	public String getPayAmt() {
		return payAmt;
	}

	public void setPayAmt(String payAmt) {
		this.payAmt = payAmt;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
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

	public String[] getContractQtys() {
		return contractQtys;
	}

	public void setContractQtys(String[] contractQtys) {
		this.contractQtys = contractQtys;
	}

	public String[] getEnterQtys() {
		return enterQtys;
	}

	public void setEnterQtys(String[] enterQtys) {
		this.enterQtys = enterQtys;
	}

	public String[] getEnterUnitAmts() {
		return enterUnitAmts;
	}

	public void setEnterUnitAmts(String[] enterUnitAmts) {
		this.enterUnitAmts = enterUnitAmts;
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

	public String getStipulationAmt() {
		return stipulationAmt;
	}

	public void setStipulationAmt(String stipulationAmt) {
		this.stipulationAmt = stipulationAmt;
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

	public String getAddContractAmt() {
		return addContractAmt;
	}

	public void setAddContractAmt(String addContractAmt) {
		this.addContractAmt = addContractAmt;
	}

	public String getAddContractTaxAmt() {
		return addContractTaxAmt;
	}

	public void setAddContractTaxAmt(String addContractTaxAmt) {
		this.addContractTaxAmt = addContractTaxAmt;
	}

	public String getAddEnterUnitAmt() {
		return addEnterUnitAmt;
	}

	public void setAddEnterUnitAmt(String addEnterUnitAmt) {
		this.addEnterUnitAmt = addEnterUnitAmt;
	}

	public String getAddPayAmt() {
		return addPayAmt;
	}

	public void setAddPayAmt(String addPayAmt) {
		this.addPayAmt = addPayAmt;
	}

	public String[] getAddEnterUnitAmts() {
		return addEnterUnitAmts;
	}

	public void setAddEnterUnitAmts(String[] addEnterUnitAmts) {
		this.addEnterUnitAmts = addEnterUnitAmts;
	}

	public String[] getAddPayAmts() {
		return addPayAmts;
	}

	public void setAddPayAmts(String[] addPayAmts) {
		this.addPayAmts = addPayAmts;
	}

	public String getEventYM() {
		return eventYM;
	}

	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}

	public String[] getEventYMs() {
		return eventYMs;
	}

	public void setEventYMs(String[] eventYMs) {
		this.eventYMs = eventYMs;
	}

	public String getVerifyStateCD() {
		return verifyStateCD;
	}

	public void setVerifyStateCD(String verifyStateCD) {
		this.verifyStateCD = verifyStateCD;
	}

	public String getTargetRate() {
		return targetRate;
	}

	public void setTargetRate(String targetRate) {
		this.targetRate = targetRate;
	}

	public String getPayStateCD() {
		return payStateCD;
	}

	public void setPayStateCD(String payStateCD) {
		this.payStateCD = payStateCD;
	}

	public String[] getMileagePayTPCDs() {
		return mileagePayTPCDs;
	}

	public void setMileagePayTPCDs(String[] mileagePayTPCDs) {
		this.mileagePayTPCDs = mileagePayTPCDs;
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

	public String getApprTpID_bef() {
		return apprTpID_bef;
	}

	public void setApprTpID_bef(String apprTpID_bef) {
		this.apprTpID_bef = apprTpID_bef;
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

}