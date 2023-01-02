 
package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;


public class SystemLangDescription extends CommonObject implements Model {
			
	private String systemLanguageCD = "";
	private String tableID = "";
	private String resultCode = "";
	private String resultMessage = "";
		
	public void clean() throws Exception {

	}

	public void validate(int action) throws Exception {

	}

	public String getTableID() {
		return tableID;
	}

	public void setTableID(String tableID) {
		this.tableID = tableID;
	}

	public String getSystemLanguageCD() {
		return systemLanguageCD;
	}

	public void setSystemLanguageCD(String systemLanguageCD) {
		this.systemLanguageCD = systemLanguageCD;
	}

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String getResultMessage() {
		return resultMessage;
	}

	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}

	
}
