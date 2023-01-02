package com.kia.pln.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GPLN04MT extends CommonObject implements Model {

	private String eventYM = "";
	private String venueCD = "";
	private String prdCD = "";
	private String levelNO = "";
	private String apprGrpNm = "";
	private String empID = "";
	private String commt= "";
	private String apprStateCD = "";
	private String apprDate= "";
	
	private String activeFlg = "";
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public String getEventYM() {
		return eventYM;
	}

	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}

	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getPrdCD() {
		return prdCD;
	}

	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}

	public String getLevelNO() {
		return levelNO;
	}

	public void setLevelNO(String levelNO) {
		this.levelNO = levelNO;
	}

	public String getApprGrpNm() {
		return apprGrpNm;
	}

	public void setApprGrpNm(String apprGrpNm) {
		this.apprGrpNm = apprGrpNm;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getApprDate() {
		return apprDate;
	}

	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

}
