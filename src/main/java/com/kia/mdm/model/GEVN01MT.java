package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;

public class GEVN01MT extends CommonObject implements Model {

	private String eventYM = "";
	private String yearCD = "";
	private String monthCD = "";
	private String planResultTpCD= "";
	private String eventSeq= "";
	private String regDateFrom = "";
	private String regDateTo = "";
	
	private String activeFlg = "";

	public void clean() {
		try{this.regDateFrom = FormatUtil.convertDate(this.regDateFrom, super.getDateFormatCD(), "YMD", "");} catch (Exception e){this.regDateFrom = "";}
		try{this.regDateTo = FormatUtil.convertDate(this.regDateTo, super.getDateFormatCD(), "YMD", "");} catch (Exception e){this.regDateTo = "";}
	}
	
	public void validate(int action) throws Exception {}

	public String getEventYM() {
		return eventYM;
	}

	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}

	public String getYearCD() {
		return yearCD;
	}

	public void setYearCD(String yearCD) {
		this.yearCD = yearCD;
	}

	public String getMonthCD() {
		return monthCD;
	}

	public void setMonthCD(String monthCD) {
		this.monthCD = monthCD;
	}

	public String getPlanResultTpCD() {
		return planResultTpCD;
	}

	public void setPlanResultTpCD(String planResultTpCD) {
		this.planResultTpCD = planResultTpCD;
	}

	public String getEventSeq() {
		return eventSeq;
	}

	public void setEventSeq(String eventSeq) {
		this.eventSeq = eventSeq;
	}

	public String getRegDateFrom() {
		return regDateFrom;
	}

	public void setRegDateFrom(String regDateFrom) {
		this.regDateFrom = regDateFrom;
	}

	public String getRegDateTo() {
		return regDateTo;
	}

	public void setRegDateTo(String regDateTo) {
		this.regDateTo = regDateTo;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}
}
