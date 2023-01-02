package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GAPP01MT extends CommonObject implements Model {

	private String apprTpID = "";
	private String apprTpNm = "";
	private String remark = "";
	private String apprGrpID = "";
	private String apprGrpNm = "";
	private String papprGrpID = "";
	private String empID = "";
	private String orgEmpID = "";
	private String sortSeq = "";
	
	private String[] apprTpIDs = null;
	private String[] apprGrpIDs = null;
	
	public void clean() {
//		try{cellular_no = StringUtil.unFormat(cellular_no);}catch(Exception e){}
//		try{emergency_tel_no = StringUtil.unFormat(emergency_tel_no);}catch(Exception e){}
//		try{home_tel_no = StringUtil.unFormat(home_tel_no);}catch(Exception e){}
//		try{entrada_date = StringUtil.unFormat(entrada_date);}catch(Exception e){}
//		try{resign_date = StringUtil.unFormat(resign_date);}catch(Exception e){}
//		try{postcode = StringUtil.unFormat(postcode);}catch(Exception e){}
		
	}
	
	public void validate(int action) throws Exception {
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.apprTpIDs != null) {
			 size = this.apprTpIDs.length;
		}
		return size;
	}
	
	public GAPP01MT getObject(int index) {
		GAPP01MT vo = new GAPP01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setApprTpID(this.apprTpIDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize_grp() {
		int size = 0 ;
		if (this.apprGrpIDs != null) {
			 size = this.apprGrpIDs.length;
		}
		return size;
	}
	
	public GAPP01MT getObject_grp(int index) {
		GAPP01MT vo = new GAPP01MT();
		if (getSize_grp() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setApprGrpID(this.apprGrpIDs[index]);}catch(Exception e){}
			try{vo.setApprTpID(this.getApprTpID());}catch(Exception e){}
		}
		return vo;
	}
	
	public String getOrgEmpID() {
		return orgEmpID;
	}

	public void setOrgEmpID(String orgEmpID) {
		this.orgEmpID = orgEmpID;
	}

	public String[] getApprGrpIDs() {
		return apprGrpIDs;
	}

	public void setApprGrpIDs(String[] apprGrpIDs) {
		this.apprGrpIDs = apprGrpIDs;
	}

	public String[] getApprTpIDs() {
		return apprTpIDs;
	}

	public void setApprTpIDs(String[] apprTpIDs) {
		this.apprTpIDs = apprTpIDs;
	}

	public String getApprTpID() {
		return apprTpID;
	}

	public void setApprTpID(String apprTpID) {
		this.apprTpID = apprTpID;
	}

	public String getApprTpNm() {
		return apprTpNm;
	}

	public void setApprTpNm(String apprTpNm) {
		this.apprTpNm = apprTpNm;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getApprGrpID() {
		return apprGrpID;
	}

	public void setApprGrpID(String apprGrpID) {
		this.apprGrpID = apprGrpID;
	}

	public String getApprGrpNm() {
		return apprGrpNm;
	}

	public void setApprGrpNm(String apprGrpNm) {
		this.apprGrpNm = apprGrpNm;
	}

	public String getPapprGrpID() {
		return papprGrpID;
	}

	public void setPapprGrpID(String papprGrpID) {
		this.papprGrpID = papprGrpID;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getSortSeq() {
		return sortSeq;
	}

	public void setSortSeq(String sortSeq) {
		this.sortSeq = sortSeq;
	}

}