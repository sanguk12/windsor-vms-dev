package kr.co.nis.waf.system.common.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;


public class HelpContents extends CommonObject implements Model {

	private String helpContentsID = "";
	private String helpContentsName = "";
	private String phelpContentsID = "";
	private String helpContentsCD = "";
	private String content = "";
	private String remark = "";
	private String seq = "";
	private String useYN = "";
	private String activeFlg = "";
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getHelpContentsID() {
		return helpContentsID;
	}

	public void setHelpContentsID(String helpContentsID) {
		this.helpContentsID = helpContentsID;
	}

	public String getHelpContentsName() {
		return helpContentsName;
	}

	public void setHelpContentsName(String helpContentsName) {
		this.helpContentsName = helpContentsName;
	}

	public String getPhelpContentsID() {
		return phelpContentsID;
	}

	public void setPhelpContentsID(String phelpContentsID) {
		this.phelpContentsID = phelpContentsID;
	}

	public String getHelpContentsCD() {
		return helpContentsCD;
	}

	public void setHelpContentsCD(String helpContentsCD) {
		this.helpContentsCD = helpContentsCD;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

}