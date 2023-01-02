package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 대표품목조회순서
public class ESLT_PRODUCT_SEQ extends CommonObject implements Model{

	private String dataLv2 = "";
	private String esltProduct = "";
	private String dispSeq = "";

	private String dataLv2s[] = null;
	private String esltProducts[] = null;
	private String dispSeqs[] = null;
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public int getSize() {
		int size = 0;
		if(this.esltProducts != null) {
			size = esltProducts.length;
		}
		return size;
	}
	
	public ESLT_PRODUCT_SEQ getObject(int index) {
		ESLT_PRODUCT_SEQ vo = new ESLT_PRODUCT_SEQ();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setDataLv2(this.dataLv2s[index]);}catch(Exception e){};
		try{vo.setEsltProduct (this.esltProducts[index]);}catch(Exception e){};
		try{vo.setDispSeq(this.dispSeqs[index]);}catch(Exception e){};
		
		return vo;
	}
	
	

	public String getDataLv2() {
		return dataLv2;
	}

	public void setDataLv2(String dataLv2) {
		this.dataLv2 = dataLv2;
	}

	public String[] getDataLv2s() {
		return dataLv2s;
	}

	public void setDataLv2s(String[] dataLv2s) {
		this.dataLv2s = dataLv2s;
	}

	public String getEsltProduct() {
		return esltProduct;
	}

	public void setEsltProduct(String esltProduct) {
		this.esltProduct = esltProduct;
	}

	public String getDispSeq() {
		return dispSeq;
	}

	public void setDispSeq(String dispSeq) {
		this.dispSeq = dispSeq;
	}

	public String[] getEsltProducts() {
		return esltProducts;
	}

	public void setEsltProducts(String[] esltProducts) {
		this.esltProducts = esltProducts;
	}

	public String[] getDispSeqs() {
		return dispSeqs;
	}

	public void setDispSeqs(String[] dispSeqs) {
		this.dispSeqs = dispSeqs;
	}

}
