package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class Code extends CommonObject implements Model {

	private String codeDiv = "";
	private String codeDivName = "";
	private String[] comCodes = null;
	private String comCode = "";
	private String orgComCode = "";
	private String codeName = "";
	private String codeDesc = "";
	private String seq = "";
	private String remark = "";
	private String useYN = "";
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
	private String seqDiv = "";
	private String seqID = "";
	private String selectYN = "";
	private String activeFlg = "";
	
	
	public void clean() throws Exception {
		if (this.useYN.equals("")) this.useYN = "Y";
	}
	
	public void validate(int action) throws Exception {

	}

	public String getOrgComCode() {
		return orgComCode;
	}

	public void setOrgComCode(String orgComCode) {
		this.orgComCode = orgComCode;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getCodeDiv()
	{
		return codeDiv;
	}

	public void setCodeDiv(String codeDiv)
	{
		this.codeDiv = codeDiv;
	}

	public String getCodeDivName()
	{
		return codeDivName;
	}

	public void setCodeDivName(String codeDivName)
	{
		this.codeDivName = codeDivName;
	}

	public String[] getComCodes()
	{
		return comCodes;
	}

	public void setComCodes(String[] comCodes)
	{
		this.comCodes = comCodes;
	}

	public String getComCode()
	{
		return comCode;
	}

	public void setComCode(String comCode)
	{
		this.comCode = comCode;
	}

	public String getCodeName()
	{
		return codeName;
	}

	public void setCodeName(String codeName)
	{
		this.codeName = codeName;
	}

	public String getCodeDesc()
	{
		return codeDesc;
	}

	public void setCodeDesc(String codeDesc)
	{
		this.codeDesc = codeDesc;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public String getUseYN()
	{
		return useYN;
	}

	public void setUseYN(String useYN)
	{
		this.useYN = useYN;
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
	
	public String getSeqDiv()
	{
		return seqDiv;
	}
	
	public void setSeqDiv(String seqDiv)
	{
		this.seqDiv = seqDiv;
	}
	
	public String getSeqID()
	{
		return seqID;
	}
	
	public void setSeqID(String seqID)
	{
		this.seqID = seqID;
	}
	
	public String getSelectYN()
	{
		return selectYN;
	}
	
	public void setSelectYN(String selectYN)
	{
		this.selectYN = selectYN;
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