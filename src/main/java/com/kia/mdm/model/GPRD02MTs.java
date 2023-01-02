package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GPRD02MTs extends CommonObject implements Model {

	private String prdCD = "";
	private String[] guidSeq= null;
	private String[] overQty= null;
	private String[] underQty = null;
	private String[] guidAmt = null;
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}
	
	public int getSize() {
		int size = 0 ;
		
		if (this.overQty != null) {
			 size = this.overQty.length;
		}
		
		return size;
	}

	public GPRD02MT getGPRD02MT(int i){
		
		GPRD02MT gprd02mt = new GPRD02MT();
		if (getSize() > i) {
			gprd02mt.setPrdCD(this.prdCD);
			gprd02mt.setOverQty(this.overQty[i]);	
			gprd02mt.setUnderQty(this.underQty[i]);	
			gprd02mt.setGuidAmt(this.guidAmt[i]);	
			gprd02mt.setUserID(super.getUserID());				
		}
		return gprd02mt;
		
	}

	public String getPrdCD() {
		return prdCD;
	}

	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}

	public String[] getGuidSeq() {
		return guidSeq;
	}

	public void setGuidSeq(String[] guidSeq) {
		this.guidSeq = guidSeq;
	}

	public String[] getOverQty() {
		return overQty;
	}

	public void setOverQty(String[] overQty) {
		this.overQty = overQty;
	}

	public String[] getUnderQty() {
		return underQty;
	}

	public void setUnderQty(String[] underQty) {
		this.underQty = underQty;
	}

	public String[] getGuidAmt() {
		return guidAmt;
	}

	public void setGuidAmt(String[] guidAmt) {
		this.guidAmt = guidAmt;
	}
}
