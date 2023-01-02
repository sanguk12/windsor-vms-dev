package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월채권금액|도매상
public class ESLT_CD_ACT extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String customercd = "";
	private String datatype = "";
	private String volume = "";
	private String fy_S = "";
	private String period_S = "";

	private String fys[] = null;
	private String periods[] = null;
	private String customercds[] = null;
	private String datatypes[] = null;
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
	
	public ESLT_CD_ACT getObject(int index) {
		ESLT_CD_ACT vo = new ESLT_CD_ACT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setCustomercd(this.customercds[index]);}catch(Exception e){};
		try{vo.setDatatype(this.datatypes[index]);}catch(Exception e){};
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

	public String getCustomercd() {
		return customercd;
	}

	public void setCustomercd(String customercd) {
		this.customercd = customercd;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
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

	public String[] getCustomercds() {
		return customercds;
	}

	public void setCustomercds(String[] customercds) {
		this.customercds = customercds;
	}

	public String[] getDatatypes() {
		return datatypes;
	}

	public void setDatatypes(String[] datatypes) {
		this.datatypes = datatypes;
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
