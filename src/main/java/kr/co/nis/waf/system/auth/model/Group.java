package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class Group extends CommonObject implements Model{
	
	private String[] grpIDs = null;
	private String grpID = "";
	private String pgrpID = "";
	private int levelCnt = 0;
	private String grpName = "";
	private String remark = "";
	private String mnuConstructID = "";
	
	private String dkmdTpCD = "";
	
	private String[] userIDs = null;
	
	public void clean() throws Exception {}

	public void validate(int action) throws Exception {}

	public String[] getUserIDs() {
		return userIDs;
	}

	public void setUserIDs(String[] userIDs) {
		this.userIDs = userIDs;
	}
	

	public String getGrpID() {
		return grpID;
	}

	public void setGrpID(String grpID) {
		this.grpID = grpID;
	}
	
	public String getGrpName() {
		return grpName;
	}

	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getPgrpID() {
		return pgrpID;
	}

	public void setPgrpID(String pgrpID) {
		this.pgrpID = pgrpID;
	}
	
	public int getLevelCnt() {
		return levelCnt;
	}

	public void setLevelCnt(int levelCnt) {
		this.levelCnt = levelCnt;
	}
	
	public String[] getGrpIDs() {
		return grpIDs;
	}

	public void setGrpIDs(String[] grpIDs) {
		this.grpIDs = grpIDs;
	}
	
	public String getMnuConstructID() {
		return mnuConstructID;
	}

	public void setMnuConstructID(String mnuConstructID) {
		this.mnuConstructID = mnuConstructID;
	}

	public String getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String dkmdTpCD) {
		this.dkmdTpCD = dkmdTpCD;
	}

}
