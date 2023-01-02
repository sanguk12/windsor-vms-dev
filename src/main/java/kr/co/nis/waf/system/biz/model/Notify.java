package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class Notify extends CommonObject implements Model {
	
	private String notify_code = "";
	private String notify_name = "";
	private String post_period = "";
	private String receipt_division = "";
	private String receipt = "";
	private String notify_no = "";
	private String subject = "";
	private String msg = "";
	private String url = "";
	private String rcv_dtm = "";
	private String confirm_dtm = "";
	private String org_receipt_division = "";
	private String org_receipt = "";
	private String activeFlg = "";
	private String[] receipt_divisions = null;
	private String[] receipts = null;
	private String[] org_receipt_divisions = null;
	private String[] org_receipts = null;
	private String[] activeFlgs = null;
	
	public void clean() {
	}

	
	public void validate(int action) throws Exception {
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.receipt_divisions != null) {
			 size = this.receipt_divisions.length;
		}
		return size;
	}

	public Notify getObject(int index) {
		 Notify vo = new  Notify();
		if (getSize() > index) {
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setNotify_code(this.getNotify_code());}catch(Exception e){}
			try{vo.setReceipt_division(this.receipt_divisions[index]);}catch(Exception e){}
			try{vo.setReceipt(this.receipts[index]);}catch(Exception e){}
			try{vo.setOrg_receipt_division(this.org_receipt_divisions[index]);}catch(Exception e){}
			try{vo.setOrg_receipt(this.org_receipts[index]);}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
		}
		return vo;
	}


	public String getNotify_code() {
		return notify_code;
	}


	public void setNotify_code(String notify_code) {
		this.notify_code = notify_code;
	}


	public String getNotify_name() {
		return notify_name;
	}


	public void setNotify_name(String notify_name) {
		this.notify_name = notify_name;
	}


	public String getPost_period() {
		return post_period;
	}


	public void setPost_period(String post_period) {
		this.post_period = post_period;
	}


	public String getReceipt_division() {
		return receipt_division;
	}


	public void setReceipt_division(String receipt_division) {
		this.receipt_division = receipt_division;
	}


	public String getReceipt() {
		return receipt;
	}


	public void setReceipt(String receipt) {
		this.receipt = receipt;
	}


	public String getNotify_no() {
		return notify_no;
	}


	public void setNotify_no(String notify_no) {
		this.notify_no = notify_no;
	}


	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getMsg() {
		return msg;
	}


	public void setMsg(String msg) {
		this.msg = msg;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public String getRcv_dtm() {
		return rcv_dtm;
	}


	public void setRcv_dtm(String rcv_dtm) {
		this.rcv_dtm = rcv_dtm;
	}


	public String getConfirm_dtm() {
		return confirm_dtm;
	}


	public void setConfirm_dtm(String confirm_dtm) {
		this.confirm_dtm = confirm_dtm;
	}


	public String getActiveFlg() {
		return activeFlg;
	}


	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}


	public String[] getReceipt_divisions() {
		return receipt_divisions;
	}


	public void setReceipt_divisions(String[] receipt_divisions) {
		this.receipt_divisions = receipt_divisions;
	}


	public String[] getReceipts() {
		return receipts;
	}


	public void setReceipts(String[] receipts) {
		this.receipts = receipts;
	}


	public String[] getActiveFlgs() {
		return activeFlgs;
	}


	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
	}


	public String getOrg_receipt_division() {
		return org_receipt_division;
	}


	public void setOrg_receipt_division(String org_receipt_division) {
		this.org_receipt_division = org_receipt_division;
	}


	public String getOrg_receipt() {
		return org_receipt;
	}


	public void setOrg_receipt(String org_receipt) {
		this.org_receipt = org_receipt;
	}


	public String[] getOrg_receipt_divisions() {
		return org_receipt_divisions;
	}


	public void setOrg_receipt_divisions(String[] org_receipt_divisions) {
		this.org_receipt_divisions = org_receipt_divisions;
	}


	public String[] getOrg_receipts() {
		return org_receipts;
	}


	public void setOrg_receipts(String[] org_receipts) {
		this.org_receipts = org_receipts;
	}
	
}