package com.kia.com.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GRLT10IF extends CommonObject implements Model {

	private String startDate = "";
	private String endDate = "";
	private String rfidDate = "";
	private String venueCD = "";
	private String angelPrd16CD = "";
	private String angelPrdMlCD = "";
	private String rfidQty = "";
	private String[] rfidDates = null;
	private String[] venueCDs = null;
	private String[] angelPrd16CDs = null;
	private String[] angelPrdMlCDs = null;
	private String[] rfidQtys = null;
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.rfidDates != null) {
			 size = this.rfidDates.length;
		}
		return size;
	}
	
	public GRLT10IF getObject(int index) {
		GRLT10IF vo = new GRLT10IF();
		if (getSize() > index) {
			try{vo.setRfidDate(this.rfidDates[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setAngelPrd16CD(this.angelPrd16CDs[index]);}catch(Exception e){}
			try{vo.setAngelPrdMlCD(this.angelPrdMlCDs[index]);}catch(Exception e){}
			try{vo.setRfidQty(this.rfidQtys[index]);}catch(Exception e){}
		}
		return vo;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getRfidDate() {
		return rfidDate;
	}

	public void setRfidDate(String rfidDate) {
		this.rfidDate = rfidDate;
	}

	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getAngelPrd16CD() {
		return angelPrd16CD;
	}

	public void setAngelPrd16CD(String angelPrd16CD) {
		this.angelPrd16CD = angelPrd16CD;
	}

	public String getAngelPrdMlCD() {
		return angelPrdMlCD;
	}

	public void setAngelPrdMlCD(String angelPrdMlCD) {
		this.angelPrdMlCD = angelPrdMlCD;
	}

	public String getRfidQty() {
		return rfidQty;
	}

	public void setRfidQty(String rfidQty) {
		this.rfidQty = rfidQty;
	}

	public String[] getRfidDates() {
		return rfidDates;
	}

	public void setRfidDates(String[] rfidDates) {
		this.rfidDates = rfidDates;
	}

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String[] getAngelPrd16CDs() {
		return angelPrd16CDs;
	}

	public void setAngelPrd16CDs(String[] angelPrd16CDs) {
		this.angelPrd16CDs = angelPrd16CDs;
	}

	public String[] getAngelPrdMlCDs() {
		return angelPrdMlCDs;
	}

	public void setAngelPrdMlCDs(String[] angelPrdMlCDs) {
		this.angelPrdMlCDs = angelPrdMlCDs;
	}

	public String[] getRfidQtys() {
		return rfidQtys;
	}

	public void setRfidQtys(String[] rfidQtys) {
		this.rfidQtys = rfidQtys;
	}
	
}