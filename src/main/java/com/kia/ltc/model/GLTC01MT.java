package com.kia.ltc.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

public class GLTC01MT extends CommonObject implements Model {
	//GLTC01MT
	private String supportID = "";
	private String venueCD = "";
	private String empID = "";
	private String contractDateFrom = "";
	private String contractDateTo = "";
	private String contractMonthCt = "";
	private String minContractQty = "";
	private String targetRate = "";
	private String addPayRate = "";
	private String threeMonthAvgTQty = "";
	private String tcontractQty = "";
	private String tcontractAmt = "";
	private String tpayAmt = "";
	private String gsvRate = "";
	private String threeMonthAvgRate = "";
	private String apprStateCD = "";
	private String lApprLevelNo = "";
	private String apprTpID = "";
	
	//GLTC01DT
	private String prdCD = "";
	private String factoryPrice = "";
	private String threeMonthAvgQty = "";
	private String enterQty = "";
	private String enterUnitAmt = "";
	private String contractAmt = "";
	private String activeFlg = "";
	private String[] supportIDs = null;
	private String[] prdCDs = null;
	private String[] factoryPrices = null;
	private String[] threeMonthAvgQtys = null;
	private String[] contractAmts = null;
	private String[] enterQtys = null;
	private String[] enterUnitAmts = null;
	private String[] activeFlgs = null;
	
	//GLTC02MT
	private String commt = "";
	private String levelNo = "";
	private String lastApprYN = "";
	
	public void clean() {
		try{contractDateFrom = StringUtil.unFormat(contractDateFrom);}catch(Exception e){}
		try{contractDateTo = StringUtil.unFormat(contractDateTo);}catch(Exception e){}
		try{contractMonthCt = StringUtil.unFormatNum(contractMonthCt);}catch(Exception e){}
		try{minContractQty = StringUtil.unFormatNum(minContractQty);}catch(Exception e){}
		try{targetRate = StringUtil.unFormatNum(targetRate);}catch(Exception e){}
		try{addPayRate = StringUtil.unFormatNum(addPayRate);}catch(Exception e){}
		try{threeMonthAvgTQty = StringUtil.unFormatNum(threeMonthAvgTQty);}catch(Exception e){}
		try{tcontractQty = StringUtil.unFormatNum(tcontractQty);}catch(Exception e){}
		try{tcontractAmt = StringUtil.unFormatNum(tcontractAmt);}catch(Exception e){}
		try{tpayAmt = StringUtil.unFormatNum(tpayAmt);}catch(Exception e){}
		try{gsvRate = StringUtil.unFormatNum(gsvRate);}catch(Exception e){}
		try{threeMonthAvgRate = StringUtil.unFormatNum(threeMonthAvgRate);}catch(Exception e){}
		try{tcontractAmt = StringUtil.unFormatNum(tcontractAmt);}catch(Exception e){}
		try{factoryPrice = StringUtil.unFormatNum(factoryPrice);}catch(Exception e){}
		try{enterQty = StringUtil.unFormatNum(enterQty);}catch(Exception e){}
		try{enterUnitAmt = StringUtil.unFormatNum(enterUnitAmt);}catch(Exception e){}
		try{contractAmt = StringUtil.unFormatNum(contractAmt);}catch(Exception e){}
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
	
	public GLTC01MT getObject(int index) {
		GLTC01MT vo = new GLTC01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setSupportID(this.getSupportID());}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setFactoryPrice(StringUtil.unFormatNum(this.factoryPrices[index]));}catch(Exception e){}
			try{vo.setThreeMonthAvgQty(StringUtil.unFormatNum(this.threeMonthAvgQtys[index]));}catch(Exception e){}
			try{vo.setEnterQty(StringUtil.unFormatNum(this.enterQtys[index]));}catch(Exception e){}
			try{vo.setEnterUnitAmt(StringUtil.unFormatNum(this.enterUnitAmts[index]));}catch(Exception e){}
			try{vo.setContractAmt(StringUtil.unFormatNum(this.contractAmts[index]));}catch(Exception e){}
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
	
	public GLTC01MT getObject_req(int index) {
		GLTC01MT vo = new GLTC01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setSupportID(this.supportIDs[index]);}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
		}
		return vo;
	}
	
	public GLTC01MT getObject_pay(int index) {
		GLTC01MT vo = new GLTC01MT();
		if (getSize_req() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setSupportID(this.supportIDs[index]);}catch(Exception e){}
		}
		return vo;
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

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
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

	public String getMinContractQty() {
		return minContractQty;
	}

	public void setMinContractQty(String minContractQty) {
		this.minContractQty = minContractQty;
	}

	public String getTargetRate() {
		return targetRate;
	}

	public void setTargetRate(String targetRate) {
		this.targetRate = targetRate;
	}

	public String getAddPayRate() {
		return addPayRate;
	}

	public void setAddPayRate(String addPayRate) {
		this.addPayRate = addPayRate;
	}

	public String getThreeMonthAvgTQty() {
		return threeMonthAvgTQty;
	}

	public void setThreeMonthAvgTQty(String threeMonthAvgTQty) {
		this.threeMonthAvgTQty = threeMonthAvgTQty;
	}

	public String getTcontractQty() {
		return tcontractQty;
	}

	public void setTcontractQty(String tcontractQty) {
		this.tcontractQty = tcontractQty;
	}

	public String getTcontractAmt() {
		return tcontractAmt;
	}

	public void setTcontractAmt(String tcontractAmt) {
		this.tcontractAmt = tcontractAmt;
	}

	public String getTpayAmt() {
		return tpayAmt;
	}

	public void setTpayAmt(String tpayAmt) {
		this.tpayAmt = tpayAmt;
	}

	public String getGsvRate() {
		return gsvRate;
	}

	public void setGsvRate(String gsvRate) {
		this.gsvRate = gsvRate;
	}

	public String getThreeMonthAvgRate() {
		return threeMonthAvgRate;
	}

	public void setThreeMonthAvgRate(String threeMonthAvgRate) {
		this.threeMonthAvgRate = threeMonthAvgRate;
	}

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
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

	public String getThreeMonthAvgQty() {
		return threeMonthAvgQty;
	}

	public void setThreeMonthAvgQty(String threeMonthAvgQty) {
		this.threeMonthAvgQty = threeMonthAvgQty;
	}

	public String[] getThreeMonthAvgQtys() {
		return threeMonthAvgQtys;
	}

	public void setThreeMonthAvgQtys(String[] threeMonthAvgQtys) {
		this.threeMonthAvgQtys = threeMonthAvgQtys;
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

	public String getContractAmt() {
		return contractAmt;
	}

	public void setContractAmt(String contractAmt) {
		this.contractAmt = contractAmt;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String[] getSupportIDs() {
		return supportIDs;
	}

	public void setSupportIDs(String[] supportIDs) {
		this.supportIDs = supportIDs;
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

	public String[] getContractAmts() {
		return contractAmts;
	}

	public void setContractAmts(String[] contractAmts) {
		this.contractAmts = contractAmts;
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

	public String[] getActiveFlgs() {
		return activeFlgs;
	}

	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
	}

	public String getlApprLevelNo() {
		return lApprLevelNo;
	}

	public void setlApprLevelNo(String lApprLevelNo) {
		this.lApprLevelNo = lApprLevelNo;
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

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String getLastApprYN() {
		return lastApprYN;
	}

	public void setLastApprYN(String lastApprYN) {
		this.lastApprYN = lastApprYN;
	}
	
	
}