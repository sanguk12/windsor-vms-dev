package com.kia.com.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class ItemRetrAuth extends CommonObject implements Model {
	
	private String cate_id = "";
	private String no = "";
	private String retr_auth_division = "";
	private String retriever = "";
	
	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
	public String getCate_id() {
		return cate_id;
	}
	public void setCate_id(String cate_id) {
		this.cate_id = cate_id;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getRetr_auth_division() {
		return retr_auth_division;
	}
	public void setRetr_auth_division(String retr_auth_division) {
		this.retr_auth_division = retr_auth_division;
	}
	public String getRetriever() {
		return retriever;
	}
	public void setRetriever(String retriever) {
		this.retriever = retriever;
	}
	
}
