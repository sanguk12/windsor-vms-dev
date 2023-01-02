
package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.mvc.Model;

public class Company extends CommonObject implements Model{
	
	public final int ACTION_DEFAULT = 0;
	public final int ACTION_ADD = 1;
	public final int ACTION_MODIFY = 2;
	public final int ACTION_REMOVE = 3;
	public final int ACTION_SAVE = 4;
	
	private String companyID         = "";
	private String companyCD         = "";
	private String companyName       = "";
	private String reprName          = "";
	private String bizRegNo          = "";
	private String sangho            = "";
	private String bizCond           = "";
	private String bizItem           = "";
	private String zipCode           = "";
	private String addr1             = "";
	private String addr2             = "";
	private String telNo1            = "";
	private String telNo2            = "";
	private String faxNo             = "";
	private String homepageURL       = "";
	private String closeYN           = "";
	private String remark            = "";
	private String activeFlg         = "";
	
	
	public void clean() throws Exception {
	}


	public void validate(int action) throws Exception {

		if (this.companyCD.equals(""))
		{
			throw new InputRequiredException("???�????????????�� ?????");
		}
		else if (this.companyName.equals(""))
		{
			throw new InputRequiredException("???�?? ????????�� ?????");
		}
	}

	
	public String getCompanyID()
	{
		return companyID;
	}

	public void setCompanyID(String companyID)
	{
		this.companyID = companyID;
	}

	public String getCompanyCD()
	{
		return companyCD;
	}

	public void setCompanyCD(String companyCD)
	{
		this.companyCD = companyCD;
	}

	public String getCompanyName()
	{
		return companyName;
	}

	public void setCompanyName(String companyName)
	{
		this.companyName = companyName;
	}

	public String getReprName()
	{
		return reprName;
	}

	public void setReprName(String reprName)
	{
		this.reprName = reprName;
	}

	public String getBizRegNo()
	{
		return bizRegNo;
	}

	public void setBizRegNo(String bizRegNo)
	{
		this.bizRegNo = bizRegNo;
	}

	public String getSangho()
	{
		return sangho;
	}

	public void setSangho(String sangho)
	{
		this.sangho = sangho;
	}

	public String getBizCond()
	{
		return bizCond;
	}

	public void setBizCond(String bizCond)
	{
		this.bizCond = bizCond;
	}

	public String getBizItem()
	{
		return bizItem;
	}

	public void setBizItem(String bizItem)
	{
		this.bizItem = bizItem;
	}

	public String getZipCode()
	{
		return zipCode;
	}

	public void setZipCode(String zipCode)
	{
		this.zipCode = zipCode;
	}

	public String getAddr1()
	{
		return addr1;
	}

	public void setAddr1(String addr1)
	{
		this.addr1 = addr1;
	}

	public String getAddr2()
	{
		return addr2;
	}

	public void setAddr2(String addr2)
	{
		this.addr2 = addr2;
	}

	public String getTelNo1()
	{
		return telNo1;
	}

	public void setTelNo1(String telNo1)
	{
		this.telNo1 = telNo1;
	}

	public String getTelNo2()
	{
		return telNo2;
	}

	public void setTelNo2(String telNo2)
	{
		this.telNo2 = telNo2;
	}

	public String getFaxNo()
	{
		return faxNo;
	}

	public void setFaxNo(String faxNo)
	{
		this.faxNo = faxNo;
	}

	public String getHomepageURL()
	{
		return homepageURL;
	}

	public void setHomepageURL(String homepageURL)
	{
		this.homepageURL = homepageURL;
	}

	public String getCloseYN()
	{
		return closeYN;
	}

	public void setCloseYN(String closeYN)
	{
		this.closeYN = closeYN;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public String getActiveFlg()
	{
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg)
	{
		this.activeFlg = activeFlg;
	}

}
