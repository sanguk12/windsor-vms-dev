package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 거래처정보
public class ESLT_CUSTOMER_MT extends CommonObject implements Model{

	private String customerCd = "";
	private String branch = "";
	
	private String customerCds[] = null;
	private String branchs[] = null;
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public int getSize() {
		int size = 0;
		if(this.branchs != null) {
			size = branchs.length;
		}
		return size;
	}
	
	public ESLT_CUSTOMER_MT getObject(int index) {
		ESLT_CUSTOMER_MT vo = new ESLT_CUSTOMER_MT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setBranch (this.branchs[index]);}catch(Exception e){};
		try{vo.setCustomerCd(this.customerCds[index]);}catch(Exception e){};
		
		return vo;
	}

	public String getCustomerCd() {
		return customerCd;
	}

	public void setCustomerCd(String customerCd) {
		this.customerCd = customerCd;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String[] getCustomerCds() {
		return customerCds;
	}

	public void setCustomerCds(String[] customerCds) {
		this.customerCds = customerCds;
	}

	public String[] getBranchs() {
		return branchs;
	}

	public void setBranchs(String[] branchs) {
		this.branchs = branchs;
	}
	
}
