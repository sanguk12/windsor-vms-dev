package com.kia.com.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class Bbs extends CommonObject implements Model {
	
	private String no = "";
	private String cate_id = "";
	private String cls_code = "";
	private String subject = "";
	private String dscr = "";
	private String writer_name = "";
	private String retr_cnt = "";
	private String top_notice_yn = "";
	private String hot_yn = "";
	private String post_yn = "";
	private String post_period_code = "";
	private String writer_no = "";
	private String process_status_code = "";
	private String open_status_code = "";
	private String email = "";
	private String tel_no = "";
	private String delete_yn = "";
	private String register = "";
	private String reg_dtm = "";
	private String modifier = "";
	private String mod_dtm = "";
	private String remover = "";
	private String rm_dtm = "";
	
	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	public String getNo() {
		return no;
	}
	
	
	public void setNo(String no) {
		this.no = no;
	}
	public String getCate_id() {
		return cate_id;
	}
	public void setCate_id(String cate_id) {
		this.cate_id = cate_id;
	}
	public String getCls_code() {
		return cls_code;
	}
	public void setCls_code(String cls_code) {
		this.cls_code = cls_code;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getDscr() {
		return dscr;
	}
	public void setDscr(String dscr) {
		this.dscr = dscr;
	}
	public String getWriter_name() {
		return writer_name;
	}
	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
	}
	public String getRetr_cnt() {
		return retr_cnt;
	}
	public void setRetr_cnt(String retr_cnt) {
		this.retr_cnt = retr_cnt;
	}
	public String getTop_notice_yn() {
		return top_notice_yn;
	}
	public void setTop_notice_yn(String top_notice_yn) {
		this.top_notice_yn = top_notice_yn;
	}
	public String getHot_yn() {
		return hot_yn;
	}
	public void setHot_yn(String hot_yn) {
		this.hot_yn = hot_yn;
	}
	public String getPost_yn() {
		return post_yn;
	}
	public void setPost_yn(String post_yn) {
		this.post_yn = post_yn;
	}
	public String getPost_period_code() {
		return post_period_code;
	}
	public void setPost_period_code(String post_period_code) {
		this.post_period_code = post_period_code;
	}
	public String getWriter_no() {
		return writer_no;
	}
	public void setWriter_no(String writer_no) {
		this.writer_no = writer_no;
	}
	public String getProcess_status_code() {
		return process_status_code;
	}
	public void setProcess_status_code(String process_status_code) {
		this.process_status_code = process_status_code;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel_no() {
		return tel_no;
	}
	public void setTel_no(String tel_no) {
		this.tel_no = tel_no;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getReg_dtm() {
		return reg_dtm;
	}
	public void setReg_dtm(String reg_dtm) {
		this.reg_dtm = reg_dtm;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public String getMod_dtm() {
		return mod_dtm;
	}
	public void setMod_dtm(String mod_dtm) {
		this.mod_dtm = mod_dtm;
	}
	public String getRemover() {
		return remover;
	}
	public void setRemover(String remover) {
		this.remover = remover;
	}
	public String getRm_dtm() {
		return rm_dtm;
	}
	public void setRm_dtm(String rm_dtm) {
		this.rm_dtm = rm_dtm;
	}
	public String getOpen_status_code() {
		return open_status_code;
	}
	public void setOpen_status_code(String open_status_code) {
		this.open_status_code = open_status_code;
	}
	
}
