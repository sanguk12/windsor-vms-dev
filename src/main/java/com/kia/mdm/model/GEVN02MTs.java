package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GEVN02MTs extends CommonObject implements Model {

	private String[] eventYM = null;
	private String[] yearCD = null;
	private String[] monthCD = null;
	private String[] applyDateFrom = null;
	private String[] applyDateTo = null;
	private String[] activeFlg = null;

	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public int getSize() {
		int size = 0 ;
		
		if (this.eventYM != null) {
			 size = this.eventYM.length;
		}
		
		return size;
	}

	public GEVN02MT getGEVN02MT(int i){
		
		GEVN02MT gevn02mt = new GEVN02MT();
		if (getSize() > i) {
			gevn02mt.setYearCD(this.yearCD[i]);
			gevn02mt.setEventYM(this.eventYM[i]);	
			gevn02mt.setApplyDateFrom(this.applyDateFrom[i]);	
			gevn02mt.setApplyDateTo(this.applyDateTo[i]);	
			gevn02mt.setActiveFlg(this.activeFlg[i]);	
			gevn02mt.setUserID(super.getUserID());				
		}
		return gevn02mt;
		
	}

	
	public String[] getEventYM() {
		return eventYM;
	}

	public void setEventYM(String[] eventYM) {
		this.eventYM = eventYM;
	}

	public String[] getYearCD() {
		return yearCD;
	}

	public void setYearCD(String[] yearCD) {
		this.yearCD = yearCD;
	}

	public String[] getMonthCD() {
		return monthCD;
	}

	public void setMonthCD(String[] monthCD) {
		this.monthCD = monthCD;
	}

	public String[] getApplyDateFrom() {
		return applyDateFrom;
	}

	public void setApplyDateFrom(String[] applyDateFrom) {
		this.applyDateFrom = applyDateFrom;
	}

	public String[] getApplyDateTo() {
		return applyDateTo;
	}

	public void setApplyDateTo(String[] applyDateTo) {
		this.applyDateTo = applyDateTo;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}
}
