package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 제품정보
public class ESLT_PRODUCT_MT extends CommonObject implements Model{

	private String productL7 = ""; 
	private String productL2 = ""; 
	private String productL3 = ""; 
	private String productL6 = ""; 
	private String esltProduct = "";
	private String esltProduct2 = ""; 
	
	private String productL7s[] = null;
	private String productL2s[] = null;
	private String productL3s[] = null;
	private String productL6s[] = null;
	private String esltProducts[] = null;
	private String esltProduct2s[] = null;
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public int getSize() {
		int size = 0;
		if(this.productL7s != null) {
			size = productL7s.length;
		}
		return size;
	}
	
	public ESLT_PRODUCT_MT getObject(int index) {
		ESLT_PRODUCT_MT vo = new ESLT_PRODUCT_MT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setProductL7(this.productL7s[index]);}catch(Exception e){};
		try{vo.setProductL2(this.productL2s[index]);}catch(Exception e){};
		try{vo.setProductL3(this.productL3s[index]);}catch(Exception e){};
		try{vo.setProductL6(this.productL6s[index]);}catch(Exception e){};
		try{vo.setEsltProduct(this.esltProducts[index]);}catch(Exception e){};
		try{vo.setEsltProduct2(this.esltProduct2s[index]);}catch(Exception e){};
		
		return vo;
	}

	public String getProductL7() {
		return productL7;
	}

	public void setProductL7(String productL7) {
		this.productL7 = productL7;
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

	public String getProductL6() {
		return productL6;
	}

	public void setProductL6(String productL6) {
		this.productL6 = productL6;
	}

	public String getEsltProduct() {
		return esltProduct;
	}

	public void setEsltProduct(String esltProduct) {
		this.esltProduct = esltProduct;
	}

	public String[] getProductL7s() {
		return productL7s;
	}

	public void setProductL7s(String[] productL7s) {
		this.productL7s = productL7s;
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

	public String[] getProductL6s() {
		return productL6s;
	}

	public void setProductL6s(String[] productL6s) {
		this.productL6s = productL6s;
	}

	public String[] getEsltProducts() {
		return esltProducts;
	}

	public void setEsltProducts(String[] esltProducts) {
		this.esltProducts = esltProducts;
	}

	public String getEsltProduct2() {
		return esltProduct2;
	}

	public void setEsltProduct2(String esltProduct2) {
		this.esltProduct2 = esltProduct2;
	}

	public String[] getEsltProduct2s() {
		return esltProduct2s;
	}

	public void setEsltProduct2s(String[] esltProduct2s) {
		this.esltProduct2s = esltProduct2s;
	}

}
