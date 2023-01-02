package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class LangDescription extends CommonObject implements Model {
	
	private String languageCD_info = "";
	private String pkDesc = "";
	private String tableID = "";
	private String pkID1 = "";
	private String pkID2 = "";
	private String pkID3 = "";
	
	public void clean() {}
	
	public void validate(int action) throws Exception {}

	public String getLanguageCD_info() {
		return languageCD_info;
	}

	public void setLanguageCD_info(String languageCD_info) {
		this.languageCD_info = languageCD_info;
	}

	public String getPkDesc() {
		return pkDesc;
	}

	public void setPkDesc(String pkDesc) {
		this.pkDesc = pkDesc;
	}

	public String getTableID() {
		return tableID;
	}

	public void setTableID(String tableID) {
		this.tableID = tableID;
	}

	public String getPkID1() {
		return pkID1;
	}

	public void setPkID1(String pkID1) {
		this.pkID1 = pkID1;
	}

	public String getPkID2() {
		return pkID2;
	}

	public void setPkID2(String pkID2) {
		this.pkID2 = pkID2;
	}

	public String getPkID3() {
		return pkID3;
	}

	public void setPkID3(String pkID3) {
		this.pkID3 = pkID3;
	}

	
}
