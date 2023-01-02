package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class ProgramUseLog extends CommonObject implements Model{
	
	private String pgmID = "";
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public String getPgmID() {
		return pgmID;
	}

	public void setPgmID(String pgmID) {
		this.pgmID = pgmID;
	}
}