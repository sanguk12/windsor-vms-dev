package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GEVN01MTs extends CommonObject implements Model {

	private String[] eventYM = null;
	private String[] yearCD = null;
	private String[] monthCD = null;
	private String[] planResultTpCD= null;
	private String[] eventSeq= null;
	private String[] regDateFrom = null;
	private String[] regDateTo = null;
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

	public GEVN01MT getGEVN01MT(int i){
		
		GEVN01MT gevn01mt = new GEVN01MT();
		if (getSize() > i) {
			gevn01mt.setYearCD(this.yearCD[i]);
			gevn01mt.setEventYM(this.eventYM[i]);	
			gevn01mt.setPlanResultTpCD(this.planResultTpCD[i]);	
			gevn01mt.setEventSeq(this.eventSeq[i]);	
			gevn01mt.setRegDateFrom(this.regDateFrom[i]);	
			gevn01mt.setRegDateTo(this.regDateTo[i]);	
			gevn01mt.setActiveFlg(this.activeFlg[i]);	
			gevn01mt.setUserID(super.getUserID());				
		}
		return gevn01mt;
		
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

	public String[] getPlanResultTpCD() {
		return planResultTpCD;
	}

	public void setPlanResultTpCD(String[] planResultTpCD) {
		this.planResultTpCD = planResultTpCD;
	}

	public String[] getEventSeq() {
		return eventSeq;
	}

	public void setEventSeq(String[] eventSeq) {
		this.eventSeq = eventSeq;
	}

	public String[] getRegDateFrom() {
		return regDateFrom;
	}

	public void setRegDateFrom(String[] regDateFrom) {
		this.regDateFrom = regDateFrom;
	}

	public String[] getRegDateTo() {
		return regDateTo;
	}

	public void setRegDateTo(String[] regDateTo) {
		this.regDateTo = regDateTo;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}
}
