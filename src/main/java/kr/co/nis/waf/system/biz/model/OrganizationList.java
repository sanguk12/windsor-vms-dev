package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.biz.model.Organization;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class OrganizationList extends CommonObject implements Model {
	
	private String[] orgID = null;
	private String[] orgCD = null;
	private String[] orgName = null;
	private String[] porgID = null;
	private String[] orgClassCD = null;
	private String[] seq = null;
	private String[] remark = null;
	private String[] attrib01 = null;
	private String[] attrib02 = null;
	private String[] attrib03 = null;
	private String[] attrib04 = null;
	private String[] attrib05 = null;
	private String[] attrib06 = null;
	private String[] attrib07 = null;
	private String[] attrib08 = null;
	private String[] attrib09 = null;
	private String[] attrib10 = null;
	private String[] attrib11 = null;
	private String[] attrib12 = null;
	private String[] activeFlg = null;
	private String[] partnerID = null;
	private String[] companyIDs = null;
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public int getSize() {
		return this.orgID.length;
	}
	
	public Organization getOrganization(int index) {
		
		Organization organization = new Organization();
		
		if (getSize() > index) {
			organization.setCompanyID(getCompanyID());
			organization.setOrgID(this.orgID[index]);
			organization.setOrgCD(this.orgCD[index]);
			organization.setOrgName(this.orgName[index]);
			organization.setOrgClassCD(this.orgClassCD[index]);
			organization.setPorgID(this.porgID[index]);
			organization.setSeq(this.seq[index]);
			organization.setRemark(this.remark[index]);
//			organization.setExtend01(this.extend01[index]);
//			organization.setExtend02(this.extend02[index]);
//			organization.setExtend03(this.extend03[index]);
//			organization.setExtend04(this.extend04[index]);
//			organization.setExtend05(this.extend05[index]);
//			organization.setExtend06(this.extend06[index]);
//			organization.setExtend07(this.extend07[index]);
//			organization.setExtend08(this.extend08[index]);
//			organization.setExtend09(this.extend09[index]);
//			organization.setExtend10(this.extend10[index]);
//			organization.setExtend11(this.extend11[index]);
//			organization.setExtend12(this.extend12[index]);
			organization.setActiveFlg(this.activeFlg[index]);
			organization.setPartnerID(this.partnerID[index]);
		}
		
		return organization;
	}
	

	public String[] getOrgClassCD()
	{
		return orgClassCD;
	}


	public void setOrgClassCD(String[] orgClassCD)
	{
		this.orgClassCD = orgClassCD;
	}



	public String[] getOrgID()
	{
		return orgID;
	}


	
	public void setOrgID(String[] orgID)
	{
		this.orgID = orgID;
	}


	public String[] getOrgCD()
	{
		return orgCD;
	}

	
	public void setOrgCD(String[] orgCD)
	{
		this.orgCD = orgCD;
	}

	
	public String[] getOrgName()
	{
		return orgName;
	}

	
	public void setOrgName(String[] orgName)
	{
		this.orgName = orgName;
	}

	
	public String[] getPorgID()
	{
		return porgID;
	}

	
	public void setPorgID(String[] porgID)
	{
		this.porgID = porgID;
	}

	
	public String[] getSeq()
	{
		return seq;
	}

	
	public void setSeq(String[] seq)
	{
		this.seq = seq;
	}

	
	public String[] getRemark()
	{
		return remark;
	}

	
	public void setRemark(String[] remark)
	{
		this.remark = remark;
	}

	
	public String[] getAttrib01()
	{
		return attrib01;
	}

	
	public void setAttrib01(String[] attrib01)
	{
		this.attrib01 = attrib01;
	}

	
	public String[] getAttrib02()
	{
		return attrib02;
	}

	
	public void setAttrib02(String[] attrib02)
	{
		this.attrib02 = attrib02;
	}

	
	public String[] getAttrib03()
	{
		return attrib03;
	}

	
	public void setAttrib03(String[] attrib03)
	{
		this.attrib03 = attrib03;
	}

	
	public String[] getAttrib04()
	{
		return attrib04;
	}

	
	public void setAttrib04(String[] attrib04)
	{
		this.attrib04 = attrib04;
	}

	
	public String[] getAttrib05()
	{
		return attrib05;
	}

	public void setAttrib05(String[] attrib05)
	{
		this.attrib05 = attrib05;
	}

	
	public String[] getAttrib06()
	{
		return attrib06;
	}

	
	public void setAttrib06(String[] attrib06)
	{
		this.attrib06 = attrib06;
	}

	
	public String[] getAttrib07()
	{
		return attrib07;
	}

	
	public void setAttrib07(String[] attrib07)
	{
		this.attrib07 = attrib07;
	}

	
	public String[] getAttrib08()
	{
		return attrib08;
	}

	
	public void setAttrib08(String[] attrib08)
	{
		this.attrib08 = attrib08;
	}

	
	public String[] getAttrib09()
	{
		return attrib09;
	}

	
	public void setAttrib09(String[] attrib09)
	{
		this.attrib09 = attrib09;
	}

	
	public String[] getAttrib10()
	{
		return attrib10;
	}

	
	public void setAttrib10(String[] attrib10)
	{
		this.attrib10 = attrib10;
	}

	
	public String[] getAttrib11()
	{
		return attrib11;
	}


	public void setAttrib11(String[] attrib11)
	{
		this.attrib11 = attrib11;
	}


	public String[] getAttrib12()
	{
		return attrib12;
	}


	public void setAttrib12(String[] attrib12)
	{
		this.attrib12 = attrib12;
	}


	public String[] getActiveFlg()
	{
		return activeFlg;
	}


	public void setActiveFlg(String[] activeFlg)
	{
		this.activeFlg = activeFlg;
	}


	public String[] getPartnerID()
	{
		return partnerID;
	}


	public void setPartnerID(String[] partnerID)
	{
		this.partnerID = partnerID;
	}

	public String[] getCompanyIDs() {
		return companyIDs;
	}

	public void setCompanyIDs(String[] companyIDs) {
		this.companyIDs = companyIDs;
	}

}