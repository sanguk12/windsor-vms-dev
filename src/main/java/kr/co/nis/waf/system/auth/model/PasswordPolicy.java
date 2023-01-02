
package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.StringUtil;

public class PasswordPolicy extends CommonObject implements Model{
	
	private String passwdMinNumbers = "";
	private String passwdUsageLimitCnt = "";
	private String passwdUsageLimitRuleYN = "";
	private String passwdChgCnt = "";
	private String passwdChgRuleYN = "";
	private String accountBlockCnt = "";
	private String accountBlockRuleYN = "";
	
	public void clean() throws Exception {
		try {
			this.passwdMinNumbers = StringUtil.unFormatNum(this.passwdMinNumbers);
			if (this.passwdMinNumbers.equals("")) this.passwdMinNumbers = "0";
		} catch (Exception e){this.passwdMinNumbers = "0";}
		try {
			this.passwdUsageLimitCnt = StringUtil.unFormatNum(this.passwdUsageLimitCnt);
			if (this.passwdUsageLimitCnt.equals("")) this.passwdUsageLimitCnt = "0";
		} catch (Exception e){this.passwdUsageLimitCnt = "0";}
		try {
			this.passwdChgCnt = StringUtil.unFormatNum(this.passwdChgCnt);
			if (this.passwdChgCnt.equals("")) this.passwdChgCnt = "0";
		} catch (Exception e){this.passwdChgCnt = "0";}
		try {
			this.accountBlockCnt = StringUtil.unFormatNum(this.accountBlockCnt);
			if (this.accountBlockCnt.equals("")) this.accountBlockCnt = "0";
		} catch (Exception e){this.accountBlockCnt = "0";}
	}

	public void validate(int action) throws Exception {
	}

	public String getPasswdMinNumbers() {
		return passwdMinNumbers;
	}

	public void setPasswdMinNumbers(String passwdMinNumbers) {
		this.passwdMinNumbers = passwdMinNumbers;
	}

	public String getPasswdUsageLimitCnt() {
		return passwdUsageLimitCnt;
	}

	public void setPasswdUsageLimitCnt(String passwdUsageLimitCnt) {
		this.passwdUsageLimitCnt = passwdUsageLimitCnt;
	}

	public String getPasswdUsageLimitRuleYN() {
		return passwdUsageLimitRuleYN;
	}

	public void setPasswdUsageLimitRuleYN(String passwdUsageLimitRuleYN) {
		this.passwdUsageLimitRuleYN = passwdUsageLimitRuleYN;
	}

	public String getPasswdChgCnt() {
		return passwdChgCnt;
	}

	public void setPasswdChgCnt(String passwdChgCnt) {
		this.passwdChgCnt = passwdChgCnt;
	}

	public String getPasswdChgRuleYN() {
		return passwdChgRuleYN;
	}

	public void setPasswdChgRuleYN(String passwdChgRuleYN) {
		this.passwdChgRuleYN = passwdChgRuleYN;
	}

	public String getAccountBlockCnt() {
		return accountBlockCnt;
	}

	public void setAccountBlockCnt(String accountBlockCnt) {
		this.accountBlockCnt = accountBlockCnt;
	}

	public String getAccountBlockRuleYN() {
		return accountBlockRuleYN;
	}

	public void setAccountBlockRuleYN(String accountBlockRuleYN) {
		this.accountBlockRuleYN = accountBlockRuleYN;
	}

}
