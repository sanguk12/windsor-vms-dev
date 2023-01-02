package com.kia.ad.model;

import com.kia.mdm.model.GVEN01MT;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GME01MT extends CommonObject implements Model{
	
	private String seq = "";
	private String commt = "";
	private String yyyy = "";
	private String activeYN = "";
	private String regID = "";
	private String regDate = "";
	private String chgID = "";
	private String chgDate  = "";
	private String activeFlg  = "";
	
	private String[] seqs = null;              
	private String[] commts = null;          
	private String[] activeYNs = null;              
	private String[] yyyys = null;              
	private String[] regIDs = null;                
	private String[] regDates = null;               
	private String[] chgIDs  = null;              
	private String[] chgDates = null;           
	private String[] activeFlgs = null;           
	
	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.commts != null) {
			 size = this.commts.length;
		}
		return size;
	}

	public GME01MT getObject(int index) {
		GME01MT vo = new GME01MT();
		
		if (getSize() > index) {
			try{vo.setSeq(this.seqs[index]);}catch(Exception e){}
			try{vo.setCommt(this.commts[index]);}catch(Exception e){}
			try{vo.setYyyy(this.yyyys[index]);}catch(Exception e){}
			try{vo.setActiveYN(this.activeYNs[index]);}catch(Exception e){}
			try{vo.setActiveFlg(this.activeFlgs[index]);}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
		}
			
		return vo;
	}
	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCommt() {
		return commt;
	}
	public void setCommt(String commt) {
		this.commt = commt;
	}
	public String getYyyy() {
		return yyyy;
	}
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	public String getActiveYN() {
		return activeYN;
	}
	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
	}
	public String getRegID() {
		return regID;
	}
	public void setRegID(String regID) {
		this.regID = regID;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getChgID() {
		return chgID;
	}
	public void setChgID(String chgID) {
		this.chgID = chgID;
	}
	public String getChgDate() {
		return chgDate;
	}
	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}
	public String getActiveFlg() {
		return activeFlg;
	}
	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}
	public String[] getSeqs() {
		return seqs;
	}
	public void setSeqs(String[] seqs) {
		this.seqs = seqs;
	}
	public String[] getCommts() {
		return commts;
	}
	public void setCommts(String[] commts) {
		this.commts = commts;
	}
	public String[] getYyyys() {
		return yyyys;
	}
	public void setYyyys(String[] yyyys) {
		this.yyyys = yyyys;
	}
	public String[] getActiveYNs() {
		return activeYNs;
	}
	public void setActiveYNs(String[] activeYNs) {
		this.activeYNs = activeYNs;
	}
	public String[] getRegIDs() {
		return regIDs;
	}
	public void setRegIDs(String[] regIDs) {
		this.regIDs = regIDs;
	}
	public String[] getRegDates() {
		return regDates;
	}
	public void setRegDates(String[] regDates) {
		this.regDates = regDates;
	}
	public String[] getChgIDs() {
		return chgIDs;
	}
	public void setChgIDs(String[] chgIDs) {
		this.chgIDs = chgIDs;
	}
	public String[] getChgDates() {
		return chgDates;
	}
	public void setChgDates(String[] chgDates) {
		this.chgDates = chgDates;
	}
	public String[] getActiveFlgs() {
		return activeFlgs;
	}
	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
	}

}
