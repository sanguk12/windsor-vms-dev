package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월Shipment실적|도매상
public class ESLT_CD_TG extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String branch = "";
	private String periodType = "";
	private String branchType = "";
	private String ratio = "";
	private String fy_S = "";
	private String period_S = "";
	 
	private String fys[] = null;
	private String periods[] = null;
	private String branchs[] = null;
	private String periodTypes[] = null;
	private String branchTypes[] = null;
	private String ratios[] = null;
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public int getSize() {
		int size = 0;
		if(this.fys != null) {
			size = fys.length;
		}
		return size;
	}
	
	public ESLT_CD_TG getObject(int index) {
		ESLT_CD_TG vo = new ESLT_CD_TG();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setBranch(this.branchs[index]);}catch(Exception e){};
		try{vo.setPeriodType(this.periodTypes[index]);}catch(Exception e){};
		try{vo.setBranchType(this.branchTypes[index]);}catch(Exception e){};
		try{vo.setRatio(this.ratios[index]);}catch(Exception e){};
		
		return vo;
	}

	public String getFy() {
		return fy;
	}

	public void setFy(String fy) {
		this.fy = fy;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getPeriodType() {
		return periodType;
	}

	public void setPeriodType(String periodType) {
		this.periodType = periodType;
	}

	public String getBranchType() {
		return branchType;
	}

	public void setBranchType(String branchType) {
		this.branchType = branchType;
	}

	public String getRatio() {
		return ratio;
	}

	public void setRatio(String ratio) {
		this.ratio = ratio;
	}

	public String getFy_S() {
		return fy_S;
	}

	public void setFy_S(String fy_S) {
		this.fy_S = fy_S;
	}

	public String getPeriod_S() {
		return period_S;
	}

	public void setPeriod_S(String period_S) {
		this.period_S = period_S;
	}

	public String[] getFys() {
		return fys;
	}

	public void setFys(String[] fys) {
		this.fys = fys;
	}

	public String[] getPeriods() {
		return periods;
	}

	public void setPeriods(String[] periods) {
		this.periods = periods;
	}

	public String[] getBranchs() {
		return branchs;
	}

	public void setBranchs(String[] branchs) {
		this.branchs = branchs;
	}

	public String[] getPeriodTypes() {
		return periodTypes;
	}

	public void setPeriodTypes(String[] periodTypes) {
		this.periodTypes = periodTypes;
	}

	public String[] getBranchTypes() {
		return branchTypes;
	}

	public void setBranchTypes(String[] branchTypes) {
		this.branchTypes = branchTypes;
	}

	public String[] getRatios() {
		return ratios;
	}

	public void setRatios(String[] ratios) {
		this.ratios = ratios;
	}

}
