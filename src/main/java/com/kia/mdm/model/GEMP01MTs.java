package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GEMP01MTs extends CommonObject implements Model {

	private String[] empIDs = null;
	private String[] empNms= null;
	private String[] empTpCD= null;
	private String[] rageSphereCD = null;
	private String[] officeCD = null;
	private String[] teamCD = null;
	private String[] territoryCD = null;
	private String[] dkmdTpCD = null;
	private String[] emailAddr = null;
	private String[] workStatCD = null;
	
	private String[] grpID = null;
	private String[] useYN = null;
	private String[] activeFlg = null;
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public int getSize() {
		int size = 0 ;
		
		if (this.empIDs != null) {
			 size = this.empIDs.length;
		}
		
		return size;
	}
	
	public GEMP01MT getGEMP01MT(int i){
		
		GEMP01MT gemp01mt = new GEMP01MT();
		if (getSize() > i) {
			gemp01mt.setEmpID(this.empIDs[i]);
			gemp01mt.setEmpNm(this.empNms[i]);	
			gemp01mt.setEmpTpCD(this.empTpCD[i]);	
			gemp01mt.setRageSphereCD(this.rageSphereCD[i]);	
			gemp01mt.setOfficeCD(this.officeCD[i]);	
			gemp01mt.setTeamCD(this.teamCD[i]);	
			gemp01mt.setTerritoryCD(this.territoryCD[i]);	
			gemp01mt.setDkmdTpCD(this.dkmdTpCD[i]);	
			gemp01mt.setEmailAddr(this.emailAddr[i]);	
			gemp01mt.setWorkStatCD(this.workStatCD[i]);	
			gemp01mt.setGrpID(this.grpID[i]);	
			gemp01mt.setUseYN(this.useYN[i]);	
			gemp01mt.setActiveFlg(this.activeFlg[i]);	
			gemp01mt.setUserID(super.getUserID());				
		}
		return gemp01mt;
		
	}

	public String[] getEmpIDs() {
		return empIDs;
	}

	public void setEmpIDs(String[] empIDs) {
		this.empIDs = empIDs;
	}

	public String[] getEmpNms() {
		return empNms;
	}

	public void setEmpNms(String[] empNms) {
		this.empNms = empNms;
	}

	public String[] getEmpTpCD() {
		return empTpCD;
	}

	public void setEmpTpCD(String[] empTpCD) {
		this.empTpCD = empTpCD;
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

	public String[] getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String[] dkmdTpCD) {
		this.dkmdTpCD = dkmdTpCD;
	}

	public String[] getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String[] emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String[] getWorkStatCD() {
		return workStatCD;
	}

	public void setWorkStatCD(String[] workStatCD) {
		this.workStatCD = workStatCD;
	}

	public String[] getGrpID() {
		return grpID;
	}

	public void setGrpID(String[] grpID) {
		this.grpID = grpID;
	}

	public String[] getUseYN() {
		return useYN;
	}

	public void setUseYN(String[] useYN) {
		this.useYN = useYN;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}
	
}
