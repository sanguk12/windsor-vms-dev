package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

 
public class VENUE_INFO_LOG extends CommonObject implements Model{

	private String venueCD="";
	private String venueNm="";
	private String territoryCD="";
	private String regID = "";
	private String empID = "";
	private String empNm = "";
	private String territoryCDName="";
	private String chgID="";
	private String chgDate="";
	private String regDate="";
	
	
	
	@Override	
	public void clean() throws Exception {
		
	}

	@Override
	public void validate(int arg0) throws Exception {
		
	}
	
	public int getSize(){
		int size=0;
		if(this.venueCD !=null){
			size=this.venueCD.length();
		}
		return size;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}
	
	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}
	
	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getVenueNm() {
		return venueNm;
	}

	public void setVenueNm(String venueNm) {
		this.venueNm = venueNm;
	}

	public String getTerritoryCD() {
		return territoryCD;
	}

	public void setTerritoryCD(String territoryCD) {
		this.territoryCD = territoryCD;
	}

	public String getTerritoryCDName() {
		return territoryCDName;
	}

	public void setTerritoryCDName(String territoryCDName) {
		this.territoryCDName = territoryCDName;
	}

	public String getChgID() {
		return chgID;
	}

	public void setChgID(String chgID) {
		this.chgID = chgID;
	}

	public String getChgDate() {
		return chgDate;
	}

	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}	
	
}
