package com.kia.pln.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GPLN02MTs extends CommonObject implements Model {

	private String eventYM = "";
	private String[] venueCD = null;
	private String[] dkmdTpCD = null;
	private String[] rageSphereCD = null;
	private String[] officeCD = null;
	private String[] teamCD = null;
	private String[] territoryCD = null;
	private String[] programCD= null;
	private String[] activityCD = null;
	private String[] supportID= null;
	
	private String[] activeFlg = null;
	private String incntTpCD = "";
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public int getSize() {
		int size = 0 ;
		
		if (this.venueCD != null) {
			 size = this.venueCD.length;
		}
		
		return size;
	}
	
	public GPLN02MT getGPLN02MT(int i){
		
		GPLN02MT gpln02mt = new GPLN02MT();
		if (getSize() > i) {
			gpln02mt.setEventYM(this.eventYM);	
			gpln02mt.setVenueCD(this.venueCD[i]);	
			gpln02mt.setProgramCD(this.programCD[i]);	
			gpln02mt.setActivityCD(this.activityCD[i]);	
			gpln02mt.setActiveFlg(this.activeFlg[i]);	
			gpln02mt.setIncntTpCD(this.incntTpCD);	
			gpln02mt.setUserID(super.getUserID());
			gpln02mt.setEmpID(super.getEmpID());
		}
		return gpln02mt;
		
	}
	
	public String getEventYM() {
		return eventYM;
	}

	public String[] getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String[] venueCD) {
		this.venueCD = venueCD;
	}

	public String[] getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String[] dkmdTpCD) {
		this.dkmdTpCD = dkmdTpCD;
	}

	public String[] getRageSphereCD() {
		return rageSphereCD;
	}

	public void setRageSphereCD(String[] rageSphereCD) {
		this.rageSphereCD = rageSphereCD;
	}

	public String[] getOfficeCD() {
		return officeCD;
	}

	public void setOfficeCD(String[] officeCD) {
		this.officeCD = officeCD;
	}

	public String[] getTeamCD() {
		return teamCD;
	}

	public void setTeamCD(String[] teamCD) {
		this.teamCD = teamCD;
	}

	public String[] getTerritoryCD() {
		return territoryCD;
	}

	public void setTerritoryCD(String[] territoryCD) {
		this.territoryCD = territoryCD;
	}

	public String[] getProgramCD() {
		return programCD;
	}

	public void setProgramCD(String[] programCD) {
		this.programCD = programCD;
	}

	public String[] getActivityCD() {
		return activityCD;
	}

	public void setActivityCD(String[] activityCD) {
		this.activityCD = activityCD;
	}

	public String[] getSupportID() {
		return supportID;
	}

	public void setSupportID(String[] supportID) {
		this.supportID = supportID;
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

	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}
	
}
