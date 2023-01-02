package com.kia.ad.model;

import com.kia.mdm.model.GVEN01MT;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GCHA01MT extends CommonObject implements Model{
	
	//GCHA01MT
	private String chainCD = "";
	private String chainNm = "";
	private String regID = "";
	private String regDate = "";
	//
	private String venueCD = "";
	
	//GCHA01MT
	private String[] chainCDs = null;              
	private String[] chainNms = null;          
	private String[] regIDs = null;              
	private String[] regDates = null;
	//
	private String[] venueCDs = null;              
	
	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	public GCHA01MT getChainObject(int index) {
		GCHA01MT vo = new GCHA01MT();
		
		if (getSize() > index) {
			try{vo.setChainCD(this.chainCDs[index]);}catch(Exception e){}
			try{vo.setChainNm(this.chainNms[index]);}catch(Exception e){}
			try{vo.setRegID(this.getUserID());}catch(Exception e){}
		}
			
		return vo;
	}
	
	public GCHA01MT getChainVenueObject(int index) {
		GCHA01MT vo = new GCHA01MT();
		
		if (getSize() > index) {
			try{vo.setChainCD(this.chainCDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setRegID(this.getUserID());}catch(Exception e){}
		}
			
		return vo;
	}
	
	public int getSize() {
		int size = 0 ;
		
		if (this.chainCDs != null) {
			 size = this.chainCDs.length;
		}
		return size;
	}
	
	public String getChainCD() {
		return chainCD;
	}
	
	public void setChainCD(String chainCD) {
		this.chainCD = chainCD;
	}
	
	public String getChainNm() {
		return chainNm;
	}
	
	public void setChainNm(String chainNm) {
		this.chainNm = chainNm;
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
	
	public String getVenueCD() {
		return venueCD;
	}
	
	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}
	
	public String[] getChainCDs() {
		return chainCDs;
	}
	
	public void setChainCDs(String[] chainCDs) {
		this.chainCDs = chainCDs;
	}
	
	public String[] getChainNms() {
		return chainNms;
	}
	
	public void setChainNms(String[] chainNms) {
		this.chainNms = chainNms;
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
	
	public String[] getVenueCDs() {
		return venueCDs;
	}
	
	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}


}
