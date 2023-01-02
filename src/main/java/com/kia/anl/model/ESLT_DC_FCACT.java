package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월DC예상실적|지점
public class ESLT_DC_FCACT extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String branch = "";
	private String datatype = "";
	private String productL2 = "";
	private String volume = "";
	private String fy_S = "";
	private String period_S = "";
	
	private String fys[] = null;
	private String periods[] = null;
	private String branchs[] = null;
	private String datatypes[] = null;
	private String productL2s[] = null;
	private String volumes[] = null;
	
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
	
	public ESLT_DC_FCACT getObject(int index) {
		ESLT_DC_FCACT vo = new ESLT_DC_FCACT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setBranch(this.branchs[index]);}catch(Exception e){};
		try{vo.setDatatype(this.datatypes[index]);}catch(Exception e){};
		try{vo.setProductL2(this.productL2s[index]);}catch(Exception e){};
		try{vo.setVolume(this.volumes[index]);}catch(Exception e){};
		
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

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public String getProductL2() {
		return productL2;
	}

	public void setProductL2(String productL2) {
		this.productL2 = productL2;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
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

	public String[] getDatatypes() {
		return datatypes;
	}

	public void setDatatypes(String[] datatypes) {
		this.datatypes = datatypes;
	}

	public String[] getProductL2s() {
		return productL2s;
	}

	public void setProductL2s(String[] productL2s) {
		this.productL2s = productL2s;
	}

	public String[] getVolumes() {
		return volumes;
	}

	public void setVolumes(String[] volumes) {
		this.volumes = volumes;
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
	
}
