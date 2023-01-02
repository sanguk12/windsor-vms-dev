package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월Shipment실적|도매상
public class ESLT_SH_FC extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String branch = "";
	private String esltProduct = "";
	private String productL2 = "";
	private String productL3 = "";
	private String forVolume = "";
	private String outVolume = "";
	private String fy_S = "";
	private String period_S = "";
	
	private String fys[] = null;
	private String periods[] = null;
	private String branchs[] = null;
	private String esltProducts[] = null;
	private String productL2s[] = null;
	private String productL3s[] = null;
	private String forVolumes[] = null;
	private String outVolumes[] = null;
	
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
	
	public ESLT_SH_FC getObject(int index) {
		ESLT_SH_FC vo = new ESLT_SH_FC();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setBranch(this.branchs[index]);}catch(Exception e){};
		try{vo.setEsltProduct(this.esltProducts[index]);}catch(Exception e){};
		try{vo.setProductL2(this.productL2s[index]);}catch(Exception e){};
		try{vo.setProductL3(this.productL3s[index]);}catch(Exception e){};
		try{vo.setForVolume(this.forVolumes[index]);}catch(Exception e){};
		try{vo.setOutVolume(this.outVolumes[index]);}catch(Exception e){};
		
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

	public String getEsltProduct() {
		return esltProduct;
	}

	public void setEsltProduct(String esltProduct) {
		this.esltProduct = esltProduct;
	}

	public String getProductL2() {
		return productL2;
	}

	public void setProductL2(String productL2) {
		this.productL2 = productL2;
	}

	public String getProductL3() {
		return productL3;
	}

	public void setProductL3(String productL3) {
		this.productL3 = productL3;
	}

	public String getForVolume() {
		return forVolume;
	}

	public void setForVolume(String forVolume) {
		this.forVolume = forVolume;
	}

	public String getOutVolume() {
		return outVolume;
	}

	public void setOutVolume(String outVolume) {
		this.outVolume = outVolume;
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

	public String[] getEsltProducts() {
		return esltProducts;
	}

	public void setEsltProducts(String[] esltProducts) {
		this.esltProducts = esltProducts;
	}

	public String[] getProductL2s() {
		return productL2s;
	}

	public void setProductL2s(String[] productL2s) {
		this.productL2s = productL2s;
	}

	public String[] getProductL3s() {
		return productL3s;
	}

	public void setProductL3s(String[] productL3s) {
		this.productL3s = productL3s;
	}

	public String[] getForVolumes() {
		return forVolumes;
	}

	public void setForVolumes(String[] forVolumes) {
		this.forVolumes = forVolumes;
	}

	public String[] getOutVolumes() {
		return outVolumes;
	}

	public void setOutVolumes(String[] outVolumes) {
		this.outVolumes = outVolumes;
	}

}
