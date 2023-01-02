package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;

public class GPRD02MT extends CommonObject implements Model {

	private String prdCD = "";
	private String guidSeq= "";
	private String overQty= "";
	private String underQty = "";
	private String guidAmt = "";
	private String guidAmtYN = "";
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public String getPrdCD() {
		return prdCD;
	}

	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}

	public String getGuidSeq() {
		return guidSeq;
	}

	public void setGuidSeq(String guidSeq) {
		this.guidSeq = guidSeq;
	}

	public String getOverQty() {
		return overQty;
	}

	public void setOverQty(String overQty) {
		this.overQty = overQty;
	}

	public String getUnderQty() {
		return underQty;
	}

	public void setUnderQty(String underQty) {
		this.underQty = underQty;
	}

	public String getGuidAmt() {
		return guidAmt;
	}

	public void setGuidAmt(String guidAmt) {
		this.guidAmt = guidAmt;
	}

	public String getGuidAmtYN() {
		return guidAmtYN;
	}

	public void setGuidAmtYN(String guidAmtYN) {
		this.guidAmtYN = guidAmtYN;
	}
}
