package kr.co.nis.waf.system.common.model;

public interface Model extends kr.co.nis.waf.mvc.Model {

	/*
	public void setCompanyID(String companyID) throws Exception;
	
	public void setUserID(String userID) throws Exception;
	
	public void setTimezoneCD(String timezoneCD) throws Exception;
	
	public void setLanguageCD(String languageCD) throws Exception;
	
	public void setCurrencyCD(String currencyCD) throws Exception;
	
	public void setLocaleCD(String localeCD) throws Exception;
	
	public void setDateFormatCD(String dateFormatCD) throws Exception;
	
	public void setAmtFormatCD(String amtFormatCD) throws Exception;
	*/
	public void setSalOrgCD(String salOrgCD) throws Exception;
	public void setClientDate(String clientDate) throws Exception;
	
	public void clean() throws Exception;

	public void validate(int action) throws Exception;
}