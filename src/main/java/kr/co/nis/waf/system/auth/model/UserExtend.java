package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.mvc.Model;

public class UserExtend extends User implements Model{
	
	private String authLevelCD = "";
	private String partnerDivCD = "";
	private String companyID = "";
	private String orgID = "";
	private String partnerID = "";
	private String empID = "";
	private String grpID = "";
	private String themeCD = "";
	private String timezoneCD_info = "";
	private String languageCD_info = "";
	private String currencyCD_info = "";
	private String localeCD_info = "";
	private String siteID = "";
	private String dateFormatCD_info = "";
	private String amtFormatCD_info = "";
	
	private String salOrgCD = "";
	private String salOffCD = "";
	private String prtnrID = "";
	
	public void validate(int action) throws Exception {
		super.validate(action);
	}
	
	
	public String getAuthLevelCD() {
		return authLevelCD;
	}

	public void setAuthLevelCD(String authLevelCD) {
		this.authLevelCD = authLevelCD;
	}

	public String getPartnerDivCD() {
		return partnerDivCD;
	}

	public void setPartnerDivCD(String partnerDivCD) {
		this.partnerDivCD = partnerDivCD;
	}

	public String getCompanyID() {
		return companyID;
	}

	public void setCompanyID(String companyID) {
		this.companyID = companyID;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getPartnerID() {
		return partnerID;
	}

	public void setPartnerID(String partnerID) {
		this.partnerID = partnerID;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getGrpID() {
		return grpID;
	}

	public void setGrpID(String grpID) {
		this.grpID = grpID;
	}

	public String getThemeCD() {
		return themeCD;
	}

	public void setThemeCD(String themeCD) {
		this.themeCD = themeCD;
	}

	public String getTimezoneCD_info() {
		return timezoneCD_info;
	}

	public void setTimezoneCD_info(String timezoneCD) {
		this.timezoneCD_info = timezoneCD;
	}

	public String getLanguageCD_info() {
		return languageCD_info;
	}

	public void setLanguageCD_info(String languageCD) {
		this.languageCD_info = languageCD;
	}

	public String getCurrencyCD_info() {
		return currencyCD_info;
	}

	public void setCurrencyCD_info(String currencyCD) {
		this.currencyCD_info = currencyCD;
	}

	public String getLocaleCD_info() {
		return localeCD_info;
	}

	public void setLocaleCD_info(String localeCD) {
		this.localeCD_info = localeCD;
	}

	public String getSiteID() {
		return siteID;
	}

	public void setSiteID(String siteID) {
		this.siteID = siteID;
	}

	public String getDateFormatCD_info() {
		return dateFormatCD_info;
	}

	public void setDateFormatCD_info(String dateFormatCD_info) {
		this.dateFormatCD_info = dateFormatCD_info;
	}

	public String getAmtFormatCD_info() {
		return amtFormatCD_info;
	}

	public void setAmtFormatCD_info(String amtFormatCD_info) {
		this.amtFormatCD_info = amtFormatCD_info;
	}

	public String getSalOrgCD() {
		return salOrgCD;
	}

	public void setSalOrgCD(String salOrgCD) {
		this.salOrgCD = salOrgCD;
	}

	public String getSalOffCD() {
		return salOffCD;
	}

	public void setSalOffCD(String salOffCD) {
		this.salOffCD = salOffCD;
	}

	public String getPrtnrID() {
		return prtnrID;
	}

	public void setPrtnrID(String prtnrID) {
		this.prtnrID = prtnrID;
	}
	
}