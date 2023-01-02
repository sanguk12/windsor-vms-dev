package com.kia.key.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GKEY06MT extends CommonObject implements Model{

	private String keymanID = "";
	private String keymanDocTpCd = "";
	private String docChkYn1 = "";
	private String docChkYn2 = "";
	private String docChkYn3 = "";
	private String docChkYn4 = "";
	private String keymanNm = "";
	
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

	public String getDocChkYn1() {
		return docChkYn1;
	}

	public void setDocChkYn1(String docChkYn1) {
		this.docChkYn1 = docChkYn1;
	}

	public String getDocChkYn2() {
		return docChkYn2;
	}

	public void setDocChkYn2(String docChkYn2) {
		this.docChkYn2 = docChkYn2;
	}

	public String getDocChkYn3() {
		return docChkYn3;
	}

	public void setDocChkYn3(String docChkYn3) {
		this.docChkYn3 = docChkYn3;
	}

	public String getDocChkYn4() {
		return docChkYn4;
	}

	public void setDocChkYn4(String docChkYn4) {
		this.docChkYn4 = docChkYn4;
	}

	public String getKeymanNm() {
		return keymanNm;
	}

	public void setKeymanNm(String keymanNm) {
		this.keymanNm = keymanNm;
	}

}
