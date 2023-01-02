package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class Auth extends CommonObject implements Model {
	private String grpID = null;
	private String viewID = null;
	private String[] userIDs = null;
	private String userName = null;
	private String mnuConstructID = null;
	private String[] mnuConstructIDs = null;
	private String mnuConstructName = null;
	private String remark = null;
	private String passwd = null;
	
	private String pgmID = null;
	private String pgmName = null;
	private String pgmUrl = null;
	private String pgmCode = null;
	
	private String pmnuConstructID = null;
	private String mnuGrpID = null;
	private String mnuGrpName = null;
	private int mnuLevel = 0;
	
	private String funcID = null;
	private String funcCode = null;
	private String funcName = null;
	private String activeYN = null;
	private String authType = null;
	
	private String[] dataFuncID = null;
	private String[] dataActiveYN = null;
	
	private String menuConstructID = null;
	private String menuGroupID = null;
	private String userID = null;
	private String programID = null;
	private String viewPageID = null;
	
	
	public void clean() throws Exception {
		
	}

	public void validate(int action) throws Exception {
		
	}

	public String getMenuConstructID() {
		return menuConstructID;
	}
	
	public void setMenuConstructID(String menuConstructID) {
		this.menuConstructID = menuConstructID;
	}
	
	public String getMenuGroupID() {
		return menuGroupID;
	}
	
	public void setMenuGroupID(String menuGroupID) {
		this.menuGroupID = menuGroupID;
	}
	
	public String getUserID() {
		return userID;
	}
	
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public String getProgramID() {
		return programID;
	}
	
	public void setProgramID(String programID) {
		this.programID = programID;
	}
	
	public String getViewPageID() {
		return viewPageID;
	}
	
	public void setViewPageID(String viewPageID) {
		this.viewPageID = viewPageID;
	}
	
	public String[] getDataFuncID() {
		return dataFuncID;
	}
	
	public void setDataFuncID(String[] dataFuncID) {
		this.dataFuncID = dataFuncID;
	}

	public String[] getDataActiveYN() {
		return dataActiveYN;
	}
	
	public void setDataActiveYN(String[] dataActiveYN) {
		this.dataActiveYN = dataActiveYN;
	}
	
	public String getGrpID() {
		return grpID;
	}
	
	public void setGrpID(String grpID) {
		this.grpID = grpID;
	}

	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getMnuConstructID() {
		return mnuConstructID;
	}
	
	public void setMnuConstructID(String mnuConstructID) {
		this.mnuConstructID = mnuConstructID;
	}
	
	public String getMnuConstructName() {
		return mnuConstructName;
	}
	
	public void setMnuConstructName(String mnuConstructName) {
		this.mnuConstructName = mnuConstructName;
	}
	
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getPmnuConstructID() {
		return pmnuConstructID;
	}
	
	public void setPmnuConstructID(String pmnuConstructID) {
		this.pmnuConstructID = pmnuConstructID;
	}
	
	public String getMnuGrpID() {
		return mnuGrpID;
	}
	
	public void setMnuGrpID(String mnuGrpID) {
		this.mnuGrpID = mnuGrpID;
	}
	
	public String getMnuGrpName() {
		return mnuGrpName;
	}
	
	public void setMnuGrpName(String mnuGrpName) {
		this.mnuGrpName = mnuGrpName;
	}
	
	public int getMnuLevel() {
		return mnuLevel;
	}
	
	public void setMnuLevel(int mnuLevel) {
		this.mnuLevel = mnuLevel;
	}
	
	public String getPgmID() {
		return pgmID;
	}
	
	public void setPgmID(String pgmID) {
		this.pgmID = pgmID;
	}
	
	public String getPgmName() {
		return pgmName;
	}
	
	public void setPgmName(String pgmName) {
		this.pgmName = pgmName;
	}
	
	public String getPgmUrl() {
		return pgmUrl;
	}
	
	public void setPgmUrl(String pgmUrl) {
		this.pgmUrl = pgmUrl;
	}
	
	public String getPgmCode() {
		return pgmCode;
	}
	
	public void setPgmCode(String pgmCode) {
		this.pgmCode = pgmCode;
	}
	
	public String getFuncID() {
		return funcID;
	}
	
	public void setFuncID(String funcID) {
		this.funcID = funcID;
	}
	
	public String getFuncCode() {
		return funcCode;
	}
	
	public void setFuncCode(String funcCode) {
		this.funcCode = funcCode;
	}
	
	public String getFuncName() {
		return funcName;
	}
	
	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}
	
	public String getActiveYN() {
		return activeYN;
	}
	
	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
	}
	
	public String getAuthType() {
		return authType;
	}
	
	public void setAuthType(String authType) {
		this.authType = authType;
	}
	
	public String getPasswd() {
		return passwd;
	}
	
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	public String[] getUserIDs() {
		return userIDs;
	}
	
	public void setUserIDs(String[] userIDs) {
		this.userIDs = userIDs;
	}
	
	public String[] getMnuConstructIDs() {
		return mnuConstructIDs;
	}
	
	public void setMnuConstructIDs(String[] mnuConstructIDs) {
		this.mnuConstructIDs = mnuConstructIDs;
	}
	
	public String getViewID() {
		return viewID;
	}
	
	public void setViewID(String viewID) {
		this.viewID = viewID;
	}
}