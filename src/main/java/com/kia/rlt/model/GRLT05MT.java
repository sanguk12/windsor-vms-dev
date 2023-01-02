package com.kia.rlt.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.StringUtil;

public class GRLT05MT extends CommonObject implements Model {

	private String eventYM = "";
	private String diffNo = "";
	private String applyDateFrom = "";
	private String applyDateTo = "";
	private String activeFlg = "";
	
	public void clean() {
		try{applyDateFrom = StringUtil.unFormat(applyDateFrom);}catch(Exception e){}
		try{applyDateTo = StringUtil.unFormat(applyDateTo);}catch(Exception e){}
	}
	
	public void validate(int action) throws Exception {
		
	}

	public String getEventYM() {
		return eventYM;
	}

	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}

	public String getDiffNo() {
		return diffNo;
	}

	public void setDiffNo(String diffNo) {
		this.diffNo = diffNo;
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