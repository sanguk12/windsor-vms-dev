package com.kia.pln.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GPLN02MT extends CommonObject implements Model {

	private String eventYM = "";
	private String venueCD = "";
	private String dkmdTpCD = "";
	private String rageSphereCD = "";
	private String officeCD = "";
	private String teamCD = "";
	private String territoryCD = "";
	private String programCD= "";
	private String activityCD = "";
	private String supportID= "";
	private String activeFlg = "";
	private String incntTpCD = "";
	private String apprStateCD = "";
	private String prdCD = "";
	private String apprTpID = "";
	private String[] venueCDs = null;
	private String[] prdCDs = null;
	private String[] activityCDs = null;
	private String[] activeFlgs = null;
	
	//mail
	private String emailAddr = "";
	private String rageSphereCDName = "";
	private String officeCDName = "";
	private String teamCDName = "";
	
	//GPLN04MT
	private String levelNo = "";
	private String apprCommt = "";
	private String lastApprYN = "";	//최종승인여부
	private String levelNos[] = null;
	private String apprCommts[] = null;
	private String lastApprYNs[] = null;
	
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
	
	public GPLN02MT getObject_request(int index) {
		GPLN02MT vo = new GPLN02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setApprStateCD(this.getApprStateCD());}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GPLN02MT getObject_approval(int index) {
		GPLN02MT vo = new GPLN02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GPLN02MT getObject_reject(int index) {
		GPLN02MT vo = new GPLN02MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEventYM(this.getEventYM());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
		}
		return vo;
	}

	public String getApprTpID() {
		return apprTpID;
	}

	public void setApprTpID(String apprTpID) {
		this.apprTpID = apprTpID;
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

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String[] getPrdCDs() {
		return prdCDs;
	}

	public void setPrdCDs(String[] prdCDs) {
		this.prdCDs = prdCDs;
	}

	public String[] getActivityCDs() {
		return activityCDs;
	}

	public void setActivityCDs(String[] activityCDs) {
		this.activityCDs = activityCDs;
	}

	public String[] getActiveFlgs() {
		return activeFlgs;
	}

	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
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

}
