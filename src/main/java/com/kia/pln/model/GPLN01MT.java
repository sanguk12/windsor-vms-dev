package com.kia.pln.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.StringUtil;

public class GPLN01MT extends CommonObject implements Model {

	private String eventYM = "";
	private String befEventYM = "";
	private String venueCD = "";
	private String programCD = "";
	private String activityCD = "";
	private String threeMonthAvgTQty = "";
	private String planTQty = "";
	private String tpayAmt = "";
	private String gsvRate = "";
	private String threeMonthAvgRate = "";
	private String keymanID = "";
	private String commt = "";
	private String apprStateCD = "";
	private String lapprLevelNo = "";
	private String activeFlg = "";
	private String apprTpID = "";
	private String[] venueCDs = null;
	private String[] programCDs = null;
	private String[] activityCDs = null;
	private String[] activeFlgs = null;
	
	//GPLN01DT
	private String incntTpCD = "";
	private String prdCD = "";
	private String factoryPrice = "";
	private String sdxYN = "";
	private String threeMonthAvgQty = "";
	private String planQty = "";
	private String planUnitAmt = "";
	private String payAmt = "";
	private String prdCDs[] = null;
	private String planQtys[] = null;
	private String planUnitAmts[] = null;
	private String payAmts[] = null;
	
	//mail
	private String emailAddr = "";
	private String rageSphereCDName = "";
	private String officeCDName = "";
	private String teamCDName = "";
	
	//GPLN03MT
	private String levelNo = "";
	private String apprCommt = "";
	private String lastApprYN = "";	//최종승인여부
	private String levelNos[] = null;
	private String apprCommts[] = null;
	private String lastApprYNs[] = null;
	private String empIDs[] = null;
	
	private String rageSphereCD = "";
	private String officeCD = "";
	private String apprLv = "";		//승인라인 레벨
	private String empID = "";
	
	public void clean() {
		try{threeMonthAvgTQty = StringUtil.unFormatNum(threeMonthAvgTQty);}catch(Exception e){}
		try{planTQty = StringUtil.unFormatNum(planTQty);}catch(Exception e){}
		try{tpayAmt = StringUtil.unFormatNum(tpayAmt);}catch(Exception e){}
		try{gsvRate = StringUtil.unFormatNum(gsvRate);}catch(Exception e){}
		try{threeMonthAvgRate = StringUtil.unFormatNum(threeMonthAvgRate);}catch(Exception e){}
	}
	
	public void validate(int action) throws Exception {
		
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
	
	public GPLN01MT getObject(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setIncntTpCD(this.getIncntTpCD());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setProgramCD(this.programCDs[index]);}catch(Exception e){}
			try{vo.setActivityCD(this.activityCDs[index]);}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize_write() {
		int size = 0 ;
		if (this.prdCDs != null) {
			 size = this.prdCDs.length;
		}
		return size;
	}
	
	public GPLN01MT getObject_write(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize_write() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.getVenueCD());}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
			try{vo.setPlanQty(StringUtil.unFormatNum(this.planQtys[index]));}catch(Exception e){}
			try{vo.setPlanUnitAmt(StringUtil.unFormatNum(this.planUnitAmts[index]));}catch(Exception e){}
			try{vo.setPayAmt(StringUtil.unFormatNum(this.payAmts[index]));}catch(Exception e){}
		}
		return vo;
	}
	
	public GPLN01MT getObject_copy(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setBefEventYM(this.getBefEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GPLN01MT getObject_request(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GPLN01MT getObject_approval(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize_new() {
		int size = 0 ;
		if (this.levelNos != null) {
			 size = this.levelNos.length;
		}
		return size;
	}
	
	public GPLN01MT getObject_approval_new(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize_new() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setActivityCD(this.getActivityCD());}catch(Exception e){}
			try{vo.setOfficeCD(this.getOfficeCD());}catch(Exception e){}
			try{vo.setRageSphereCD(this.getRageSphereCD());}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GPLN01MT getObject_reject(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GPLN01MT getObject_reject2(int index) {
		GPLN01MT vo = new GPLN01MT();
		if (getSize2() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setEmpID(this.empIDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public String getApprTpID() {
		return apprTpID;
	}

	public void setApprTpID(String apprTpID) {
		this.apprTpID = apprTpID;
	}

	public String[] getApprCommts() {
		return apprCommts;
	}

	public void setApprCommts(String[] apprCommts) {
		this.apprCommts = apprCommts;
	}

	public String getLapprLevelNo() {
		return lapprLevelNo;
	}

	public void setLapprLevelNo(String lapprLevelNo) {
		this.lapprLevelNo = lapprLevelNo;
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

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getBefEventYM() {
		return befEventYM;
	}

	public void setBefEventYM(String befEventYM) {
		this.befEventYM = befEventYM;
	}

	public String getThreeMonthAvgTQty() {
		return threeMonthAvgTQty;
	}

	public void setThreeMonthAvgTQty(String threeMonthAvgTQty) {
		this.threeMonthAvgTQty = threeMonthAvgTQty;
	}

	public String getPlanTQty() {
		return planTQty;
	}

	public void setPlanTQty(String planTQty) {
		this.planTQty = planTQty;
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

	public String getKeymanID() {
		return keymanID;
	}

	public void setKeymanID(String keymanID) {
		this.keymanID = keymanID;
	}

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String[] getPrdCDs() {
		return prdCDs;
	}

	public void setPrdCDs(String[] prdCDs) {
		this.prdCDs = prdCDs;
	}

	public String[] getPlanQtys() {
		return planQtys;
	}

	public void setPlanQtys(String[] planQtys) {
		this.planQtys = planQtys;
	}

	public String[] getPlanUnitAmts() {
		return planUnitAmts;
	}

	public void setPlanUnitAmts(String[] planUnitAmts) {
		this.planUnitAmts = planUnitAmts;
	}

	public String[] getPayAmts() {
		return payAmts;
	}

	public void setPayAmts(String[] payAmts) {
		this.payAmts = payAmts;
	}

	public String getIncntTpCD() {
		return incntTpCD;
	}

	public void setIncntTpCD(String incntTpCD) {
		this.incntTpCD = incntTpCD;
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

	public String getThreeMonthAvgQty() {
		return threeMonthAvgQty;
	}

	public void setThreeMonthAvgQty(String threeMonthAvgQty) {
		this.threeMonthAvgQty = threeMonthAvgQty;
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

	public String[] getActiveFlgs() {
		return activeFlgs;
	}

	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
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

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String[] getProgramCDs() {
		return programCDs;
	}

	public void setProgramCDs(String[] programCDs) {
		this.programCDs = programCDs;
	}

	public String[] getActivityCDs() {
		return activityCDs;
	}

	public void setActivityCDs(String[] activityCDs) {
		this.activityCDs = activityCDs;
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
	
	public String[] getEmpIDs() {
		return empIDs;
	}

	public void setEmpIDs(String[] empIDs) {
		this.empIDs = empIDs;
	}

	public String[] getLevelNos() {
		return levelNos;
	}

	public void setLevelNos(String[] levelNos) {
		this.levelNos = levelNos;
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

	public String getApprLv() {
		return apprLv;
	}

	public void setApprLv(String apprLv) {
		this.apprLv = apprLv;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}
	
}