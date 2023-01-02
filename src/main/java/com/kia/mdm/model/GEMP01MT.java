package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GEMP01MT extends CommonObject implements Model {

	private String empID = "";
	private String empNm= "";
	private String empTpCD= "";
	private String rageSphereCD = "";
	private String officeCD = "";
	private String teamCD = "";
	private String territoryCD = "";
	private String dkmdTpCD = "";
	private String emailAddr = "";
	private String workStatCD = "";
	
	private String grpID = "";
	private String useYN = "";
	private String activeFlg = "";
	
	private String legalCD = "";
	private String[] legalCDs = null;     
	
	public int getSize() {
		int size = 0 ;
		if (this.legalCDs != null) {
			 size = this.legalCDs.length;
		}
		return size;
	}
	
	public GEMP01MT getObject_request(int index) {
		GEMP01MT vo = new GEMP01MT();
		if (getSize() > index) {
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setLegalCD(this.legalCDs[index]);}catch(Exception e){}
		}
		return vo;
	}	

	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getEmpTpCD() {
		return empTpCD;
	}

	public void setEmpTpCD(String empTpCD) {
		this.empTpCD = empTpCD;
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

	public String getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String dKADTpCD) {
		dkmdTpCD = dKADTpCD;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getWorkStatCD() {
		return workStatCD;
	}

	public void setWorkStatCD(String workStatCD) {
		this.workStatCD = workStatCD;
	}

	public String getGrpID() {
		return grpID;
	}

	public void setGrpID(String grpID) {
		this.grpID = grpID;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getLegalCD() {
		return legalCD;
	}

	public void setLegalCD(String legalCD) {
		this.legalCD = legalCD;
	}

	public String[] getLegalCDs() {
		return legalCDs;
	}

	public void setLegalCDs(String[] legalCDs) {
		this.legalCDs = legalCDs;
	}
	
	

}
