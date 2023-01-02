package com.kia.com.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GSYS10MT extends CommonObject implements Model {

	private String ifdate = "";
	private String ifNm = "";
	private String resultCD = "";
	private String resultMsg = "";
	private String ifResultCD = "";
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {
		
	}

	public String getIfdate() {
		return ifdate;
	}

	public void setIfdate(String ifdate) {
		this.ifdate = ifdate;
	}

	public String getIfNm() {
		return ifNm;
	}

	public void setIfNm(String ifNm) {
		this.ifNm = ifNm;
	}

	public String getResultCD() {
		return resultCD;
	}

	public void setResultCD(String resultCD) {
		this.resultCD = resultCD;
	}

	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public String getIfResultCD() {
		return ifResultCD;
	}

	public void setIfResultCD(String ifResultCD) {
		this.ifResultCD = ifResultCD;
	}
	
}