package kr.co.nis.waf.system.common.model;

import kr.co.nis.waf.BaseObject;

public class CommonObject extends BaseObject {

	public final int ACTION_DEFAULT = 0;
	public final int ACTION_ADD = 1;
	public final int ACTION_MODIFY = 2;
	public final int ACTION_REMOVE = 3;
	public final int ACTION_SAVE = 4;

	private String companyID = "";
	private String userID = "";
	
	private String timezoneCD = "";
	private String languageCD = "";
	private String currencyCD = "";
	private String localeCD = "";
	private String dateFormatCD = "";
	private String amtFormatCD = "";
	private String clientDate = "";
	
	private String empID = "";
	private String empNm = "";
	
	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getCompanyID() {
		return companyID;
	}
	
	public void setCompanyID(String companyID) {
		this.companyID = companyID;
	}
	
	public String getUserID() {
		return userID;
	}
	
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public String getTimezoneCD() {
		return timezoneCD;
	}
	
	public void setTimezoneCD(String timezoneCD) {
		this.timezoneCD = timezoneCD;
	}
	
	public String getLanguageCD() {
		return languageCD;
	}
	
	public void setLanguageCD(String languageCD) {
		this.languageCD = languageCD;
	}
	
	public String getCurrencyCD() {
		return currencyCD;
	}
	
	public void setCurrencyCD(String currencyCD) {
		this.currencyCD = currencyCD;
	}

	public String getLocaleCD() {
		return localeCD;
	}

	public void setLocaleCD(String localeCD) {
		this.localeCD = localeCD;
	}

	public String getDateFormatCD() {
		return dateFormatCD;
	}

	public void setDateFormatCD(String dateFormatCD) {
		this.dateFormatCD = dateFormatCD;
	}

	public String getAmtFormatCD() {
		return amtFormatCD;
	}

	public void setAmtFormatCD(String amtFormatCD) {
		this.amtFormatCD = amtFormatCD;
	}

	public String getClientDate() {
		return clientDate;
	}

	public void setClientDate(String clientDate) {
		this.clientDate = clientDate;
	}
	
	
}
