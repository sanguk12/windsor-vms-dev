package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class BoardAuthority extends CommonObject implements Model {
	
	private String boardID = "";
	private String publicID = "";
	private String publicClassCD = "";
	private String publicName = "";

	public void clean() throws Exception {
	}
	
	public void validate(int action) throws Exception {
	}
	
	public String getBoardID() {
		return boardID;
	}

	public void setBoardID(String boardID) {
		this.boardID = boardID;
	}

	public String getPublicID() {
		return publicID;
	}

	public void setPublicID(String publicID) {
		this.publicID = publicID;
	}

	public String getPublicClassCD() {
		return publicClassCD;
	}

	public void setPublicClassCD(String publicClassCD) {
		this.publicClassCD = publicClassCD;
	}

	public String getPublicName() {
		return publicName;
	}

	public void setPublicName(String publicName) {
		this.publicName = publicName;
	}
	
}