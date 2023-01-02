package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class LangDescriptions extends CommonObject implements Model {
	
	private String[] languageCD_info = null;
	private String[] pkDesc = null;
	private String[] tableID = null;
	private String[] pkID1 = null;
	private String[] pkID2 = null;
	private String[] pkID3 = null;
	
	public void clean() {}
	
	public void validate(int action) throws Exception {}

	public LangDescription getLangDescription(int index){
		
		LangDescription langDescription = new LangDescription();
		if (getSize() > index) {
			langDescription.setCompanyID(super.getCompanyID());
			langDescription.setLanguageCD_info(this.languageCD_info[index]);
			langDescription.setPkDesc(this.pkDesc[index]);
			langDescription.setTableID(this.tableID[index]);
			langDescription.setPkID1(this.pkID1[index]);
			langDescription.setPkID2(this.pkID2[index]);
			langDescription.setPkID3(this.pkID3[index]);
			langDescription.setTimezoneCD(super.getTimezoneCD());
			langDescription.setUserID(super.getUserID());
		}
		return langDescription;
		
	}

	public int getSize() {
		int size = 0 ;
		
		if (this.pkID1 != null) {
			 size = this.pkID1.length;
		}
		
		return size;
	}

	public String[] getLanguageCD_info() {
		return languageCD_info;
	}

	public void setLanguageCD_info(String[] languageCD_info) {
		this.languageCD_info = languageCD_info;
	}

	public String[] getPkDesc() {
		return pkDesc;
	}

	public void setPkDesc(String[] pkDesc) {
		this.pkDesc = pkDesc;
	}

	public String[] getTableID() {
		return tableID;
	}

	public void setTableID(String[] tableID) {
		this.tableID = tableID;
	}

	public String[] getPkID1() {
		return pkID1;
	}

	public void setPkID1(String[] pkID1) {
		this.pkID1 = pkID1;
	}

	public String[] getPkID2() {
		return pkID2;
	}

	public void setPkID2(String[] pkID2) {
		this.pkID2 = pkID2;
	}

	public String[] getPkID3() {
		return pkID3;
	}

	public void setPkID3(String[] pkID3) {
		this.pkID3 = pkID3;
	}
	
	
}