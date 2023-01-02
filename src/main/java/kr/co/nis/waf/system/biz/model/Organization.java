package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class Organization extends CommonObject implements Model {
	
	private String orgID = "";
	private String orgCD = "";
	private String orgName = "";
	private String porgID = "";
	private String seq = "";
	private String orgClassCD = "";
	private String remark = "";
	private String attrib01 = "";
	private String attrib02 = "";
	private String attrib03 = "";
	private String attrib04 = "";
	private String attrib05 = "";
	private String attrib06 = "";
	private String attrib07 = "";
	private String attrib08 = "";
	private String attrib09 = "";
	private String attrib10 = "";
	private String attrib11 = "";
	private String attrib12 = "";
	private String activeFlg = "";
	private String partnerID = "";
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}
	
	public String getOrgID()
	{
		return orgID;
	}
	
	public void setOrgID(String orgID)
	{
		this.orgID = orgID;
	}
	
	public String getPorgID()
	{
		return porgID;
	}
	
	public void setPorgID(String porgID)
	{
		this.porgID = porgID;
	}
	
	public String getOrgCD()
	{
		return orgCD;
	}
	
	public void setOrgCD(String orgCD)
	{
		this.orgCD = orgCD;
	}

	public String getOrgName()
	{
		return orgName;
	}

	public void setOrgName(String orgName)
	{
		this.orgName = orgName;
	}

	public String getSeq()
	{
		return seq;
	}

	public void setSeq(String seq)
	{
		this.seq = seq;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public String getAttrib01()
	{
		return attrib01;
	}

	public void setAttrib01(String attrib01)
	{
		this.attrib01 = attrib01;
	}

	public String getAttrib02()
	{
		return attrib02;
	}

	public void setAttrib02(String attrib02)
	{
		this.attrib02 = attrib02;
	}
	
	public String getAttrib03()
	{
		return attrib03;
	}
	
	public void setAttrib03(String attrib03)
	{
		this.attrib03 = attrib03;
	}
	
	public String getAttrib04()
	{
		return attrib04;
	}
	
	public void setAttrib04(String attrib04)
	{
		this.attrib04 = attrib04;
	}
	
	public String getAttrib05()
	{
		return attrib05;
	}
	
	public void setAttrib05(String attrib05)
	{
		this.attrib05 = attrib05;
	}
	
	public String getAttrib06()
	{
		return attrib06;
	}
	
	public void setAttrib06(String attrib06)
	{
		this.attrib06 = attrib06;
	}
	
	public String getAttrib07()
	{
		return attrib07;
	}
	
	public void setAttrib07(String attrib07)
	{
		this.attrib07 = attrib07;
	}
	
	public String getAttrib08()
	{
		return attrib08;
	}
	
	public void setAttrib08(String attrib08)
	{
		this.attrib08 = attrib08;
	}
	
	public String getAttrib09()
	{
		return attrib09;
	}
	
	public void setAttrib09(String attrib09)
	{
		this.attrib09 = attrib09;
	}
	
	public String getAttrib10()
	{
		return attrib10;
	}
	
	public void setAttrib10(String attrib10)
	{
		this.attrib10 = attrib10;
	}
	
	public String getAttrib11()
	{
		return attrib11;
	}
	
	public void setAttrib11(String attrib11)
	{
		this.attrib11 = attrib11;
	}
	
	public String getAttrib12()
	{
		return attrib12;
	}
	
	public void setAttrib12(String attrib12)
	{
		this.attrib12 = attrib12;
	}
	
	public String getActiveFlg()
	{
		return activeFlg;
	}
	
	public void setActiveFlg(String activeFlg)
	{
		this.activeFlg = activeFlg;
	}
	
	public String getOrgClassCD()
	{
		return orgClassCD;
	}
	
	public void setOrgClassCD(String orgClassCD)
	{
		this.orgClassCD = orgClassCD;
	}
	
	public String getPartnerID()
	{
		return partnerID;
	}
	
	public void setPartnerID(String partnerID)
	{
		this.partnerID = partnerID;
	}
	
}