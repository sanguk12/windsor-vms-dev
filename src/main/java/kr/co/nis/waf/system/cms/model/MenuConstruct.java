package kr.co.nis.waf.system.cms.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;


public class MenuConstruct extends CommonObject implements Model {

	private String[] mnuConstructIDs = null;
	private String mnuConstructID = "";
	private String mnuConstructName = "";
	private String[] useYNs = null;
	private String useYN = "";
	private String displayYN = "";
	private String remark = "";
	private String regDate = "";
	private String regID = "";
	private String chgDate = "";
	private String chgID = "";
	private String[] mnuGrpIDs = null;
	private String mnuGrpID = "";
	private String mnuGrpName = "";
	private String pmnuGrpID = "";
	private String url = "";
	private String[] pgmIDs = null;
	private String pgmID = "";
	private String pgmName = "";
	private int[] seqs = null;
	private int seq = 0;
	private String authType = "";
	
	private String pmnuConstructID = null;
	private int mnuLevel = 0;
	
	private String code = null;
	private String name = null;
	private String pcode = null;
	
	private String copyMenuConstructID = "";
	
	private String gtfcompanyID = "";
	
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public String getGtfcompanyID() {
		return gtfcompanyID;
	}

	public void setGtfcompanyID(String gtfcompanyID) {
		this.gtfcompanyID = gtfcompanyID;
	}

	public String[] getMnuGrpIDs() {
		return mnuGrpIDs;
	}

	public void setMnuGrpIDs(String[] mnuGrpIDs) {
		this.mnuGrpIDs = mnuGrpIDs;
	}
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
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

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getDisplayYN() {
		return displayYN;
	}

	public void setDisplayYN(String displayYN) {
		this.displayYN = displayYN;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}
	
	public String getChgDate() {
		return chgDate;
	}

	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}

	public String getChgID() {
		return chgID;
	}

	public void setChgID(String chgID) {
		this.chgID = chgID;
	}

	public String getPmnuConstructID() {
		return pmnuConstructID;
	}

	public void setPmnuConstructID(String pmnuConstructID) {
		this.pmnuConstructID = pmnuConstructID;
	}

	public int getMnuLevel() {
		return mnuLevel;
	}

	public void setMnuLevel(int mnuLevel) {
		this.mnuLevel = mnuLevel;
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

	public String[] getMnuConstructIDs() {
		return mnuConstructIDs;
	}

	public void setMnuConstructIDs(String[] mnuConstructIDs) {
		this.mnuConstructIDs = mnuConstructIDs;
	}

	public String getPmnuGrpID() {
		return pmnuGrpID;
	}

	public void setPmnuGrpID(String pmnuGrpID) {
		this.pmnuGrpID = pmnuGrpID;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPgmID() {
		return pgmID;
	}

	public void setPgmID(String pgmID) {
		this.pgmID = pgmID;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String[] getUseYNs() {
		return useYNs;
	}

	public void setUseYNs(String[] useYNs) {
		this.useYNs = useYNs;
	}

	public String[] getPgmIDs() {
		return pgmIDs;
	}

	public void setPgmIDs(String[] pgmIDs) {
		this.pgmIDs = pgmIDs;
	}

	public String getPgmName() {
		return pgmName;
	}

	public void setPgmName(String pgmName) {
		this.pgmName = pgmName;
	}

	public int[] getSeqs() {
		return seqs;
	}

	public void setSeqs(int[] seqs) {
		this.seqs = seqs;
	}

	public String getAuthType() {
		return authType;
	}

	public void setAuthType(String authType) {
		this.authType = authType;
	}
	
	public String getCopyMenuConstructID() {
		return copyMenuConstructID;
	}
	
	public void setCopyMenuConstructID(String copyMenuConstructID) {
		this.copyMenuConstructID = copyMenuConstructID;
	}
	
}
