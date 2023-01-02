package com.kia.key.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GKEY07MT extends CommonObject implements Model{
	private String keymanID = "";
	private String keymanDocTpCd = "";
	private String storeNm = "";
	private String reprsNm = "";
	private String reprsBirthDate = "";
	private String keymanNm = "";
	private String keymanBirthDate = "";
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public String getKeymanID() {
		return keymanID;
	}

	public void setKeymanID(String keymanID) {
		this.keymanID = keymanID;
	}

	public String getKeymanDocTpCd() {
		return keymanDocTpCd;
	}

	public void setKeymanDocTpCd(String keymanDocTpCd) {
		this.keymanDocTpCd = keymanDocTpCd;
	}

	public String getStoreNm() {
		return storeNm;
	}

	public void setStoreNm(String storeNm) {
		this.storeNm = storeNm;
	}

	public String getReprsNm() {
		return reprsNm;
	}

	public void setReprsNm(String reprsNm) {
		this.reprsNm = reprsNm;
	}

	public String getReprsBirthDate() {
		return reprsBirthDate;
	}

	public void setReprsBirthDate(String reprsBirthDate) {
		this.reprsBirthDate = reprsBirthDate;
	}

	public String getKeymanNm() {
		return keymanNm;
	}

	public void setKeymanNm(String keymanNm) {
		this.keymanNm = keymanNm;
	}

	public String getKeymanBirthDate() {
		return keymanBirthDate;
	}

	public void setKeymanBirthDate(String keymanBirthDate) {
		this.keymanBirthDate = keymanBirthDate;
	}

}
