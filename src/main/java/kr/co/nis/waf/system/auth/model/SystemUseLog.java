package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class SystemUseLog extends CommonObject implements Model{
	
	private String loginOutCD = "";
	private String ip = "";
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public String getLoginOutCD() {
		return loginOutCD;
	}

	public void setLoginOutCD(String loginOutCD) {
		this.loginOutCD = loginOutCD;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	
}