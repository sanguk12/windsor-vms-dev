package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.biz.model.Classification;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.util.StringUtil;

public class ClasseList extends CommonObject implements Model{
	
	private String[] classID = null;
	private String[] className = null;
	private String[] pclassID = null;
	private String[] classCD = null;
	private String[] remark = null;
	private String[] seq = null;
	private String[] useYN = null;
	private String[] activeFlg = null;
	/**<FM> attrib01:siteID, attrib02:pwrTypeCD, attribDesc02:pwrname*/
	private String attrib01 = "";
	private String[] attrib02 = null;
	private String[] attribDesc02 = null;
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public int getSize() {
		return this.classCD.length;
	}
	
	public Classification getClass(int index) {
		Classification classification = new Classification();
		
		if (getSize() > index) {
			classification.setCompanyID(this.getCompanyID());
			classification.setClassID(this.classID[index]);
			classification.setClassName(this.className[index]);
			classification.setPclassID(this.pclassID[index]);
			classification.setClassCD(this.classCD[index]);
			classification.setSeq(this.seq[index]);
			classification.setRemark(this.remark[index]);
			classification.setUseYN(this.useYN[index]);
			classification.setActiveFlg(this.activeFlg[index]);
			classification.setUserID(this.getUserID());
			
			try{classification.setAttrib01(this.getAttrib01());}catch(Exception e){}
			try{classification.setAttrib02(this.attrib02[index]);}catch(Exception e){}
			try{classification.setAttribDesc02(this.attribDesc02[index]);}catch(Exception e){}
		}
		
		return classification;
	}

	public String getAttrib01() {
		return attrib01;
	}

	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}

	public String[] getAttrib02() {
		return attrib02;
	}

	public void setAttrib02(String[] attrib02) {
		this.attrib02 = attrib02;
	}

	public String[] getAttribDesc02() {
		return attribDesc02;
	}

	public void setAttribDesc02(String[] attribDesc02) {
		this.attribDesc02 = attribDesc02;
	}

	public String[] getClassID() {
		return classID;
	}

	public void setClassID(String[] classID) {
		this.classID = classID;
	}

	public String[] getClassName() {
		return className;
	}

	public void setClassName(String[] className) {
		this.className = className;
	}

	public String[] getPclassID() {
		return pclassID;
	}

	public void setPclassID(String[] pclassID) {
		this.pclassID = pclassID;
	}

	public String[] getClassCD() {
		return classCD;
	}

	public void setClassCD(String[] classCD) {
		this.classCD = classCD;
	}

	public String[] getRemark() {
		return remark;
	}

	public void setRemark(String[] remark) {
		this.remark = remark;
	}

	public String[] getSeq() {
		return seq;
	}

	public void setSeq(String[] seq) {
		this.seq = seq;
	}

	public String[] getUseYN() {
		return useYN;
	}

	public void setUseYN(String[] useYN) {
		this.useYN = useYN;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}

}