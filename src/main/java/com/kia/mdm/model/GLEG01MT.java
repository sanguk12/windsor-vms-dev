package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GLEG01MT extends CommonObject implements Model {

	private String empID = "";
	private String legalCD = "";
	private String[] legalCDs = null;     
	
	public int getSize() {
		int size = 0 ;
		if (this.legalCDs != null) {
			 size = this.legalCDs.length;
		}
		return size;
	}
	
	public GLEG01MT getObject_request(int index) {
		GLEG01MT vo = new GLEG01MT();
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
