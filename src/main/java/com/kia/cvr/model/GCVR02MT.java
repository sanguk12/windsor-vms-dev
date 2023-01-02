package com.kia.cvr.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GCVR02MT extends CommonObject implements Model {

	private String seq = "";
	private String fromRate = "";
	private String toRate = "";
	private String rate = "";
	private String activeFlg = "";
	
	private String eventYm = "";
	private String rageSphereCD = "";
	private String officeCD = "";
	private String kindTpCD = "";
	private String nggsvRn = "";
	private String nggsvRc = "";
	private String commt = "";
	private String apprStateCD = "";
	private String lapprLevelNo = "";
	private String regID = "";
	private String chgID = "";
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public String getFromRate() {
		return fromRate;
	}

	public void setFromRate(String fromRate) {
		this.fromRate = fromRate;
	}

	public String getToRate() {
		return toRate;
	}

	public void setToRate(String toRate) {
		this.toRate = toRate;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getEventYm() {
		return eventYm;
	}

	public void setEventYm(String eventYm) {
		this.eventYm = eventYm;
	}

	public String getRagesphereCD() {
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

	public String getKindTpCD() {
		return kindTpCD;
	}

	public void setKindTpCD(String kindTpCD) {
		this.kindTpCD = kindTpCD;
	}

	public String getNggsvRn() {
		return nggsvRn;
	}

	public void setNggsvRn(String nggsvRn) {
		this.nggsvRn = nggsvRn;
	}

	public String getNggsvRc() {
		return nggsvRc;
	}

	public void setNggsvRc(String nggsvRc) {
		this.nggsvRc = nggsvRc;
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

	public String getLapprLevelNo() {
		return lapprLevelNo;
	}

	public void setLapprLevelNo(String lapprLevelNo) {
		this.lapprLevelNo = lapprLevelNo;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getChgID() {
		return chgID;
	}

	public void setChgID(String chgID) {
		this.chgID = chgID;
	}

}

