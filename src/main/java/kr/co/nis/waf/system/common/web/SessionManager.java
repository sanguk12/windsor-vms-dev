package kr.co.nis.waf.system.common.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.util.DateUtil;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class SessionManager extends kr.co.nis.waf.common.SessionManager {

	protected final Log logger = LogFactory.getLog(getClass());
	
	public SessionManager(HttpServletRequest request, HttpServletResponse response) {
		super(request, response);
	}

	public Object getAttribute(String key) {
		return session.getAttribute(key);
	}
	
	public Map getAttributeAll(HttpServletRequest request) {
		
		Map params = new HashMap();
		
		params.put("authType", super.getAuthType());
		params.put("mnuConstructID", super.getMnuConstructID());
		params.put("grpID", super.getGrpID());
		params.put("userID", super.getUserID());
		params.put("userName", super.getUserName());
		
		params.put("mnuGrpID", StringUtil.nullToBlank(request.getParameter("mnuGrpID"), ""));
		params.put("pgmID", StringUtil.nullToBlank(request.getParameter("pgmID"), ""));
		params.put("viewID", StringUtil.nullToBlank(request.getParameter("viewID"), ""));
		
		params.put("companyID", getCompanyID());
		params.put("authLevelCD", getAuthLevel());
		
		params.put("currencyCD", super.getCurrency());
		params.put("systemLanguageCD", super.getSystemLanguage());
		params.put("languageCD", super.getLanguage());
		params.put("localeCD", super.getLocale());
		params.put("timezoneCD", super.getTimezone());
		params.put("timezoneDesc", super.getTimezoneDesc());
		params.put("officeTimezoneDesc", getOfficeTimezoneDesc());
		params.put("systemTimezoneDesc", super.getSystemTimezoneDesc());
		params.put("dateFormatCD", super.getDateFormat());
		params.put("amtFormatCD", super.getAmtFormat());
		params.put("menuStyle", super.getMenuStyle());
		params.put("theme", super.getTheme());
		params.put("themeURL", super.getThemeURL());
		params.put("saasYN", getSaaSYN());
		
		/*diageo session START*/
		params.put("dkmdTpCD", getDkmdTpCD());
		params.put("initPasswdYN", getInitPasswdYN());
		params.put("empID", getEmpID());
		params.put("empNm", getEmpNm());
		params.put("empTpCD", getEmpTpCD());
		params.put("rageSphereCD", getRageSphereCD());
		params.put("officeCD", getOfficeCD());
		params.put("teamCD", getTeamCD());
		params.put("territoryCD", getTerritoryCD());
		params.put("emailAddr", getEmailAddr());
		params.put("rageSphereCDName", getRageSphereCDName());
		params.put("officeCDName", getOfficeCDName());
		params.put("teamCDName", getTeamCDName());
		params.put("territoryCDName", getTerritoryCDName());
		params.put("displayMnuTp", getDisplayMnuTp());
		params.put("appCount", getAppCount());
		
		/*diageo session END*/

		params.put("maxInactiveInterval", session.getMaxInactiveInterval());
		try {
			params.put("currentDate", DateUtil.getConvertDate(
					DateUtil.getDate(), 
					super.getSystemTimezoneDesc(), 
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("currentTime", DateUtil.getConvertDateTime(
					DateUtil.getDate(), 
					super.getSystemTimezoneDesc(), 
					super.getTimezoneDesc(), 
					super.getDateFormat(),
					""));
			params.put("firstDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getFirstDateByTimezone(0,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("lastDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getLastDateByTimezone(0,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("befFirstDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getFirstDateByTimezone(-1,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("befLastDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getLastDateByTimezone(-1,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("agoWeekDate", DateUtil.getConvertDate( 
					DateUtil.getDate(FormatUtil.unFormat(DateUtil.getDayAfter(-7))),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("afterWeekDate", DateUtil.getConvertDate( 
					DateUtil.getDate(FormatUtil.unFormat(DateUtil.getDayAfter(7))),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("agoYearDate", DateUtil.getConvertDate( 
					DateUtil.getDate(FormatUtil.unFormat(DateUtil.getPrevYear(DateUtil.getCurrentDate()))),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			
			super.setClientDate(super.getClientDate());
			params.put("clientDate", super.getClientDate());
			
		}
		catch (Exception e) {}
		
		return params;
	}

	public Map getAttributeAll(HttpServletRequest request, Map params) {
		
		params.put("authType", super.getAuthType());
		
		if (!params.containsKey("mnuConstructID")) {
			params.put("mnuConstructID", super.getMnuConstructID());
		}
		params.put("grpID", super.getGrpID());
		params.put("userID", super.getUserID());
		params.put("userName", super.getUserName());
		
		params.put("mnuGrpID", StringUtil.nullToBlank(request.getParameter("mnuGrpID"), ""));
		params.put("pgmID", StringUtil.nullToBlank(request.getParameter("pgmID"), ""));
		params.put("viewID", StringUtil.nullToBlank(request.getParameter("viewID"), ""));
		
		if (!params.containsKey("companyID")) {
			params.put("companyID", getCompanyID());
		}
		if (!params.containsKey("orgID")) {
			params.put("orgID", getOrgID());
		}
		params.put("authLevelCD", getAuthLevel());

		if (!params.containsKey("rpartnerID")) {
			params.put("rpartnerID", getRpartnerID());
		}

		if (!params.containsKey("partnerDivCD")) {
			params.put("partnerDivCD", getPartnerDiv());
		}

		if (!params.containsKey("partnerID")) {
			params.put("partnerID", getPartnerID());
			params.put("partnerCD", getPartnerCD());
			params.put("partnerName", getPartnerName());
		}

		params.put("currencyCD", super.getCurrency());
		params.put("languageCD", super.getLanguage());
		params.put("systemLanguageCD", super.getSystemLanguage());
		params.put("localeCD", super.getLocale());
		params.put("timezoneCD", super.getTimezone());
		params.put("timezoneDesc", super.getTimezoneDesc());
		params.put("systemTimezoneDesc", super.getSystemTimezoneDesc());
		params.put("officeTimezoneDesc", getOfficeTimezoneDesc());
		params.put("dateFormatCD", super.getDateFormat());
		params.put("amtFormatCD", super.getAmtFormat());
		params.put("menuStyle", super.getMenuStyle());
		params.put("theme", super.getTheme());
		params.put("themeURL", super.getThemeURL());
		params.put("saasYN", getSaaSYN());
		
		/*diageo session START*/
		params.put("dkmdTpCD", getDkmdTpCD());
		params.put("initPasswdYN", getInitPasswdYN());
		params.put("empID", getEmpID());
		params.put("empNm", getEmpNm());
		params.put("empTpCD", getEmpTpCD());
		params.put("rageSphereCD", getRageSphereCD());
		params.put("officeCD", getOfficeCD());
		params.put("teamCD", getTeamCD());
		params.put("territoryCD", getTerritoryCD());
		params.put("emailAddr", getEmailAddr());
		params.put("rageSphereCDName", getRageSphereCDName());
		params.put("officeCDName", getOfficeCDName());
		params.put("teamCDName", getTeamCDName());
		params.put("territoryCDName", getTerritoryCDName());
		params.put("displayMnuTp", getDisplayMnuTp());
		params.put("appCount", getAppCount());
		
		/*diageo session END*/

		params.put("maxInactiveInterval", session.getMaxInactiveInterval());
		try {
			params.put("currentDate", DateUtil.getConvertDate(
					DateUtil.getDate(), 
					super.getSystemTimezoneDesc(), 
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("currentTime", DateUtil.getConvertDateTime(
					DateUtil.getDate(), 
					super.getSystemTimezoneDesc(), 
					super.getTimezoneDesc(), 
					super.getDateFormat(),
					""));
			params.put("firstDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getFirstDateByTimezone(0,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("lastDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getLastDateByTimezone(0,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat())); 
			params.put("befFirstDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getFirstDateByTimezone(-1,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("befLastDate", DateUtil.getConvertDate( 
					DateUtil.getDate(DateUtil.getLastDateByTimezone(-1,super.getTimezoneDesc())),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("agoWeekDate", DateUtil.getConvertDate( 
					DateUtil.getDate(FormatUtil.unFormat(DateUtil.getDayAfter(-7))),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("afterWeekDate", DateUtil.getConvertDate( 
					DateUtil.getDate(FormatUtil.unFormat(DateUtil.getDayAfter(7))),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			params.put("agoYearDate", DateUtil.getConvertDate( 
					DateUtil.getDate(FormatUtil.unFormat(DateUtil.getPrevYear(DateUtil.getCurrentDate()))),
					super.getTimezoneDesc(),
					super.getTimezoneDesc(), 
					super.getDateFormat()));
			
			super.setClientDate(super.getClientDate());
			params.put("clientDate", super.getClientDate());
		}
		catch (Exception e){};
		
		return params;
	}

	public String getAuthLevel() {
		return (String) session.getAttribute("AUTHLEVEL");
	}
	public void setAuthLevel(String authLevel) {
		session.setAttribute("AUTHLEVEL", authLevel);
	}
	
	public String getCompanyID() {
		return (String) session.getAttribute("COMPANYID");
	}
	public void setCompanyID(String companyID) {
		session.setAttribute("COMPANYID", companyID);
	}

	public String getOrgID() {
		return (String) session.getAttribute("ORGID");
	}
	public void setOrgID(String orgID) {
		session.setAttribute("ORGID", orgID);
	}

	public String getPartnerDiv() {
		return (String) session.getAttribute("PARTNERDIV");
	}
	public void setPartnerDiv(String partnerDiv) {
		session.setAttribute("PARTNERDIV", partnerDiv);
	}

	public String getPartnerID() {
		return (String) session.getAttribute("PARTNERID");
	}
	public void setPartnerID(String partnerID) {
		session.setAttribute("PARTNERID", partnerID);
	}
	
	public String getPartnerCD() {
		return (String) session.getAttribute("PARTNERCD");
	}
	public void setPartnerCD(String partnerCD) {
		session.setAttribute("PARTNERCD", partnerCD);
	}
	
	public String getPartnerName() {
		return (String) session.getAttribute("PARTNERNAME");
	}
	public void setPartnerName(String partnerName) {
		session.setAttribute("PARTNERNAME", partnerName);
	}

	public String getRpartnerID() {
		return (String) session.getAttribute("RPARTNERID");
	}
	public void setRpartnerID(String rpartnerID) {
		session.setAttribute("RPARTNERID", rpartnerID);
	}
	
	public String getSaaSYN() {
		return (String) session.getAttribute("SAASYN");
	}
	public void setSaaSYN(String saasYN) {
		session.setAttribute("SAASYN", saasYN);
	}
	
	public String getSiteID() {
		return (String) session.getAttribute("SITEID");
	}
	public void setSiteID(String siteID) {
		session.setAttribute("SITEID", siteID);
	}
	
	public String getAgencyID() {
		return (String) session.getAttribute("AGENCYID");
	}
	public void setAgencyID(String agencyID) {
		session.setAttribute("AGENCYID", agencyID);
	}
	
	public String getAgencyCD() {
		return (String) session.getAttribute("AGENCYCD");
	}
	public void setAgencyCD(String agencyCD) {
		session.setAttribute("AGENCYCD", agencyCD);
	}
	
	public String getAgencyName() {
		return (String) session.getAttribute("AGENCYNAME");
	}
	public void setAgencyName(String agencyName) {
		session.setAttribute("AGENCYNAME", agencyName);
	}
	
	public String getHqID() {
		return (String) session.getAttribute("HQID");
	}
	public void setHqID(String hqID) {
		session.setAttribute("HQID", hqID);
	}
	
	public String getSalOrgCD() {
		return (String) session.getAttribute("SALORGCD");
	}
	public void setSalOrgCD(String salOrgCD) {
		session.setAttribute("SALORGCD", salOrgCD);
	}
	
	public String getSalOffCD() {
		return (String) session.getAttribute("SALOFFCD");
	}
	public void setSalOffCD(String salOffCD) {
		session.setAttribute("SALOFFCD", salOffCD);
	}
	
	public String getPrtnrID() {
		return (String) session.getAttribute("PRTNRID");
	}
	public void setPrtnrID(String prtnrID) {
		session.setAttribute("PRTNRID", prtnrID);
	}
	
	public String getPrtnrNm() {
		return (String) session.getAttribute("PRTNRNM");
	}
	public void setPrtnrNm(String prtnrNm) {
		session.setAttribute("PRTNRNM", prtnrNm);
	} 
	
	public String getOfficeTimezoneDesc() {
		return (String) session.getAttribute("OFFICETIMEZONEDESC");
	}
	public void setOfficeTimezoneDesc(String officeTimezoneDesc) {
		session.setAttribute("OFFICETIMEZONEDESC", officeTimezoneDesc);
	}

	/* diageo sesion START */
	public String getDkmdTpCD() {
		return (String) session.getAttribute("DKMDTPCD");
	}
	public void setDkmdTpCD(String dkmdTpCD) {
		session.setAttribute("DKMDTPCD", dkmdTpCD);
	}
	
	public String getInitPasswdYN() {
		return (String) session.getAttribute("INITPASSWDYN");
	}
	public void setInitPasswdYN(String initPasswdYN) {
		session.setAttribute("INITPASSWDYN", initPasswdYN);
	}
	
    public String getEmpID() {
		return (String) session.getAttribute("EMPID");
	}
	public void setEmpID(String empID) {
		session.setAttribute("EMPID", empID);
	}
	
	public String getEmpNm() {
		return (String) session.getAttribute("EMPNM");
	}
	public void setEmpNm(String empNm) {
		session.setAttribute("EMPNM", empNm);
	}
	
	public String getEmpTpCD() {
		return (String) session.getAttribute("EMPTPCD");
	}
	public void setEmpTpCD(String empTpCD) {
		session.setAttribute("EMPTPCD", empTpCD);
	}
	
	public String getRageSphereCD() {
		return (String) session.getAttribute("RAGESPHERECD");
	}
	public void setRageSphereCD(String rageSphereCD) {
		session.setAttribute("RAGESPHERECD", rageSphereCD);
	}
	
	public String getOfficeCD() {
		return (String) session.getAttribute("OFFICECD");
	}
	public void setOfficeCD(String officeCD) {
		session.setAttribute("OFFICECD", officeCD);
	}
	
	public String getTeamCD() {
		return (String) session.getAttribute("TEAMCD");
	}
	public void setTeamCD(String teamCD) {
		session.setAttribute("TEAMCD", teamCD);
	}
	
	public String getTerritoryCD() {
		return (String) session.getAttribute("TERRITORYCD");
	}
	public void setTerritoryCD(String territoryCD) {
		session.setAttribute("TERRITORYCD", territoryCD);
	}
	
	public String getEmailAddr() {
		return (String) session.getAttribute("EMAILADDR");
	}
	public void setEmailAddr(String emailAddr) {
		session.setAttribute("EMAILADDR", emailAddr);
	}
	
	public String getRageSphereCDName() {
		return (String) session.getAttribute("RAGESPHERECDNAME");
	}
	public void setRageSphereCDName(String rageSphereCDName) {
		session.setAttribute("RAGESPHERECDNAME", rageSphereCDName);
	}
	
	public String getOfficeCDName() {
		return (String) session.getAttribute("OFFICECDNAME");
	}
	public void setOfficeCDName(String officeCDName) {
		session.setAttribute("OFFICECDNAME", officeCDName);
	}
	
	public String getTeamCDName() {
		return (String) session.getAttribute("TEAMCDNAME");
	}
	public void setTeamCDName(String teamCDName) {
		session.setAttribute("TEAMCDNAME", teamCDName);
	}
	
	public String getTerritoryCDName() {
		return (String) session.getAttribute("TERRITORYCDNAME");
	}
	public void setTerritoryCDName(String territoryCDName) {
		session.setAttribute("TERRITORYCDNAME", territoryCDName);
	}
	
	public String getDisplayMnuTp(){
		return (String) session.getAttribute("DISPLAYMNUTP");
	}
	public void setDisplayMnuTp(String displayMnuTp){
		System.out.println("SessionManager.java ★★★★★★★★★★★ : " + displayMnuTp);
		session.setAttribute("DISPLAYMNUTP", displayMnuTp);
	}
	
	public String getAppCount(){
		return (String) session.getAttribute("APPCOUNT");
	}
	public void setAppCount(String appCount){
		session.setAttribute("APPCOUNT", appCount);
	}
	/*diageo session END*/
	
}