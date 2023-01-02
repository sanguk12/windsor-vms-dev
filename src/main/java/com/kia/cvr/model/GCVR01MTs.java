package com.kia.cvr.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GCVR01MTs extends CommonObject implements Model {
	private String[] seq = null;
	private String[] fromRate = null;
	private String[] toRate = null;
	private String[] rate = null;
	private String[] activeFlg = null;

	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public int getSize() {
		int size = 0 ;
		
		if (this.fromRate != null) {
			 size = this.fromRate.length;
		}
		
		return size;
	}
	
	public GCVR01MT getGCVR01MT(int i){
		
		GCVR01MT gcvr01mt = new GCVR01MT();
		if (getSize() > i) {
			gcvr01mt.setFromRate(this.fromRate[i]);
			gcvr01mt.setToRate(this.toRate[i]);	
			gcvr01mt.setRate(this.rate[i]);	
		}
		return gcvr01mt;
		
	}
	public String[] getFromRate() {
		return fromRate;
	}

	public void setFromRate(String[] fromRate) {
		this.fromRate = fromRate;
	}

	public String[] getToRate() {
		return toRate;
	}

	public void setToRate(String[] toRate) {
		this.toRate = toRate;
	}

	public String[] getRate() {
		return rate;
	}

	public void setRate(String[] rate) {
		this.rate = rate;
	}

	public String[] getSeq() {
		return seq;
	}

	public void setSeq(String[] seq) {
		this.seq = seq;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}
	
}
			
	
