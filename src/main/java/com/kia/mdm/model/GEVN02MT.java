package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;

public class GEVN02MT extends CommonObject implements Model {

	private String eventYM = "";
	private String yearCD = "";
	private String monthCD = "";
	private String applyDateFrom = "";
	private String applyDateTo = "";
	
	private String activeFlg = "";

	public void clean() {
		try{this.applyDateFrom = FormatUtil.convertDate(this.applyDateFrom, super.getDateFormatCD(), "YMD", "");} catch (Exception e){this.applyDateFrom = "";}
		try{this.applyDateTo = FormatUtil.convertDate(this.applyDateTo, super.getDateFormatCD(), "YMD", "");} catch (Exception e){this.applyDateTo = "";}
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

	public String getApplyDateFrom() {
		return applyDateFrom;
	}

	public void setApplyDateFrom(String applyDateFrom) {
		this.applyDateFrom = applyDateFrom;
	}

	public String getApplyDateTo() {
		return applyDateTo;
	}

	public void setApplyDateTo(String applyDateTo) {
		this.applyDateTo = applyDateTo;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}
}
