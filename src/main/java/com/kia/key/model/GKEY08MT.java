package com.kia.key.model;

import java.sql.Clob;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GKEY08MT extends CommonObject implements Model{

	private String keymanID = "";
	private String keymanDocTpCd = "";
	private String signvector1 = null;
	private String signvector2 = "";
	
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

	public String getSignvector1() {
		return signvector1;
	}

	public void setSignvector1(String signvector1) {
		this.signvector1 = signvector1;
	}

	public String getSignvector2() {
		return signvector2;
	}

	public void setSignvector2(String signvector2) {
		this.signvector2 = signvector2;
	}

}
