package com.kia.pln.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GPLN02DTs extends CommonObject implements Model {

	private String eventYM = "";
	private String venueCD = "";
	private String[] prdCD = null;
	private String[] factoryPrice = null;
	private String[] sdxYN = null;
	private String[] planQty = null;
	private String[] planUnitAmt = null;
	private String[] guidAmt = null;
	private String[] payAmt = null;
	private String[] gsvRate = null;
	private String[] commt = null;
	private String[] apprStateCD = null;
	private String[] lApprLevelNo = null;
	
	private String[] activeFlg = null;
	private String incntTpCD = "";
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public int getSize() {
		int size = 0 ;
		
		if (this.prdCD != null) {
			 size = this.prdCD.length;
		}
		
		return size;
	}
	
	public GPLN02DT getGPLN02DT(int i){
		
		GPLN02DT gpln02dt = new GPLN02DT();
		if (getSize() > i) {
			gpln02dt.setEventYM(this.eventYM);	
			gpln02dt.setVenueCD(this.venueCD);	
			gpln02dt.setPrdCD(this.prdCD[i]);	
			gpln02dt.setFactoryPrice(this.factoryPrice[i]);	
			gpln02dt.setPlanQty(this.planQty[i]);	
			gpln02dt.setPlanUnitAmt(this.planUnitAmt[i]);	
			gpln02dt.setGuidAmt(this.guidAmt[i]);	
			gpln02dt.setPayAmt(this.payAmt[i]);	
			gpln02dt.setGsvRate(this.gsvRate[i]);	
			gpln02dt.setCommt(this.commt[i]);	
			gpln02dt.setApprStateCD(this.apprStateCD[i]);	
			gpln02dt.setActiveFlg(this.activeFlg[i]);	
			gpln02dt.setIncntTpCD(this.incntTpCD);	
			gpln02dt.setUserID(super.getUserID());
			gpln02dt.setEmpID(super.getEmpID());
		}
		return gpln02dt;
		
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

	public String[] getPrdCD() {
		return prdCD;
	}

	public void setPrdCD(String[] prdCD) {
		this.prdCD = prdCD;
	}

	public String[] getFactoryPrice() {
		return factoryPrice;
	}

	public void setFactoryPrice(String[] factoryPrice) {
		this.factoryPrice = factoryPrice;
	}

	public String[] getSdxYN() {
		return sdxYN;
	}

	public void setSdxYN(String[] sdxYN) {
		this.sdxYN = sdxYN;
	}

	public String[] getPlanQty() {
		return planQty;
	}

	public void setPlanQty(String[] planQty) {
		this.planQty = planQty;
	}

	public String[] getPlanUnitAmt() {
		return planUnitAmt;
	}

	public void setPlanUnitAmt(String[] planUnitAmt) {
		this.planUnitAmt = planUnitAmt;
	}

	public String[] getGuidAmt() {
		return guidAmt;
	}

	public void setGuidAmt(String[] guidAmt) {
		this.guidAmt = guidAmt;
	}

	public String[] getPayAmt() {
		return payAmt;
	}

	public void setPayAmt(String[] payAmt) {
		this.payAmt = payAmt;
	}

	public String[] getGsvRate() {
		return gsvRate;
	}

	public void setGsvRate(String[] gsvRate) {
		this.gsvRate = gsvRate;
	}

	public String[] getCommt() {
		return commt;
	}

	public void setCommt(String[] commt) {
		this.commt = commt;
	}

	public String[] getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String[] apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String[] getlApprLevelNo() {
		return lApprLevelNo;
	}

	public void setlApprLevelNo(String[] lApprLevelNo) {
		this.lApprLevelNo = lApprLevelNo;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getIncntTpCD() {
		return incntTpCD;
	}

	public void setIncntTpCD(String incntTpCD) {
		this.incntTpCD = incntTpCD;
	}

}
