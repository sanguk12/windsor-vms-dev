package com.kia.cvr.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GCVR01MT extends CommonObject implements Model {

	private String seq = "";
	private String fromRate = "";
	private String toRate = "";
	private String rate = "";
	private String activeFlg = "";
	
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

}

