package com.kia.pln.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GPLN02DT extends CommonObject implements Model {

	private String eventYM = "";
	private String venueCD = "";
	private String prdCD = "";
	private String factoryPrice = "";
	private String sdxYN = "";
	private String planQty = "";
	private String planUnitAmt = "";
	private String guidAmt = "";
	private String payAmt = "";
	private String gsvRate = "";
	private String commt = "";
	private String apprStateCD = "";
	private String lApprLevelNo = "";
	private String activeFlg = "";
	private String incntTpCD = "";
	private String activityCD = "";
	
	private String[] venueCDs = null;
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}
	
	public int getSize() {
		int size = 0 ;
		if (this.venueCDs != null) {
			 size = this.venueCDs.length;
		}
		return size;
	}
	
	public GPLN02DT getObject(int index) {
		GPLN02DT vo = new GPLN02DT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String getActivityCD() {
		return activityCD;
	}

	public void setActivityCD(String activityCD) {
		this.activityCD = activityCD;
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

	public String getPlanQty() {
		return planQty;
	}

	public void setPlanQty(String planQty) {
		this.planQty = planQty;
	}

	public String getPlanUnitAmt() {
		return planUnitAmt;
	}

	public void setPlanUnitAmt(String planUnitAmt) {
		this.planUnitAmt = planUnitAmt;
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

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getlApprLevelNo() {
		return lApprLevelNo;
	}

	public void setlApprLevelNo(String lApprLevelNo) {
		this.lApprLevelNo = lApprLevelNo;
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
	
}
