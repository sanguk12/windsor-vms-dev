package com.kia.sup.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

public class GSUP01MT extends CommonObject implements Model {

	private String supportID = "";
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
	private String stipulationAmt = "";
	private String payRequestDate = "";
	private String supportStateCD = "";
	private String transferDate = "";
	private String transferDueDate = "";
	private String prdCD = "";
	private String factoryPrice = "";
	private String contractQty = "";
	private String enterQty = "";
	private String enterUnitAmt = "";
	private String payAmt = "";
	private String activeFlg = "";
	private String commt = "";
	private String empID = "";
	private String emailAddr = "";
	private String[] supportIDs = null;
	private String[] prdCDs = null;
	private String[] factoryPrices = null;
	private String[] contractQtys = null;
	private String[] enterQtys = null;
	private String[] enterUnitAmts = null;
	private String[] payAmts = null;
	private String[] activeFlgs = null;
	private String[] commts = null;
	private String[] transferDates = null;
	private String[] transferDueDates = null;
	private String[] payTpCDs = null;
	
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
	private String addMM = "";
	
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
		try{payRequestDate = StringUtil.unFormat(payRequestDate);}catch(Exception e){}
		try{transferDate = StringUtil.unFormat(transferDate);}catch(Exception e){}
		try{transferDueDate = StringUtil.unFormat(transferDueDate);}catch(Exception e){}
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
	
	public GSUP01MT getObject(int index) {
		GSUP01MT vo = new GSUP01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setSupportID(this.getSupportID());}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setFactoryPrice(StringUtil.unFormatNum(this.factoryPrices[index]));}catch(Exception e){}
			try{vo.setContractQty(StringUtil.unFormatNum(this.contractQtys[index]));}catch(Exception e){}
			try{vo.setEnterQty(StringUtil.unFormatNum(this.enterQtys[index]));}catch(Exception e){}
			try{vo.setEnterUnitAmt(StringUtil.unFormatNum(this.enterUnitAmts[index]));}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
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
	
	public GSUP01MT getObject_keyman(int index) {
		GSUP01MT vo = new GSUP01MT();
		if (getSize_keyman() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setSupportID(this.getSupportID());}catch(Exception e){}
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
		if (this.supportIDs != null) {
			 size = this.supportIDs.length;
		}
		return size;
	}
	
	public GSUP01MT getObject_req(int index) {
		GSUP01MT vo = new GSUP01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setSupportStateCD(this.getSupportStateCD());}catch(Exception e){}
			try{vo.setSupportID(this.supportIDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GSUP01MT getObject_pay(int index) {
		GSUP01MT vo = new GSUP01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setSupportStateCD(this.getSupportStateCD());}catch(Exception e){}
			try{vo.setSupportID(this.supportIDs[index]);}catch(Exception e){}
			try{vo.setPayTpCD(this.payTpCDs[index]);}catch(Exception e){}
			try{vo.setCommt(this.commts[index]);}catch(Exception e){}
			try{vo.setTransferDate(FormatUtil.unFormat(this.transferDates[index]));}catch(Exception e){}
			try{vo.setTransferDueDate(FormatUtil.unFormat(this.transferDueDates[index]));}catch(Exception e){}
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

	public String[] getSupportIDs() {
		return supportIDs;
	}

	public void setSupportIDs(String[] supportIDs) {
		this.supportIDs = supportIDs;
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

	public String getSupportID() {
		return supportID;
	}

	public void setSupportID(String supportID) {
		this.supportID = supportID;
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

	public String getSupportStateCD() {
		return supportStateCD;
	}

	public void setSupportStateCD(String supportStateCD) {
		this.supportStateCD = supportStateCD;
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

	public String getAddMM() {
		return addMM;
	}

	public void setAddMM(String addMM) {
		this.addMM = addMM;
	}
	
}