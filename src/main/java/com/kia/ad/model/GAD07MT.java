package com.kia.ad.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GAD07MT extends CommonObject implements Model{
	
	private String apprStateCD = "";
	private String buCD = "";
	private String requiredADCD1 = "";
	private String amt1 = "";
	private String requiredADCD2 = "";
	private String amt2 = "";
	private String requiredADCD3 = "";
	private String amt3 = "";
	private String location1 = "";
	private String location2 = "";
	private String location3 = "";
	private String adProgram = "";
	private String venueActivity1 = "";
	private String venueActivity2 = "";
	private String venueActivity3 = "";

	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getBuCD() {
		return buCD;
	}

	public void setBuCD(String buCD) {
		this.buCD = buCD;
	}

	public String getRequiredADCD1() {
		return requiredADCD1;
	}

	public void setRequiredADCD1(String requiredADCD1) {
		this.requiredADCD1 = requiredADCD1;
	}

	public String getAmt1() {
		return amt1;
	}

	public void setAmt1(String amt1) {
		this.amt1 = amt1;
	}

	public String getRequiredADCD2() {
		return requiredADCD2;
	}

	public void setRequiredADCD2(String requiredADCD2) {
		this.requiredADCD2 = requiredADCD2;
	}

	public String getAmt2() {
		return amt2;
	}

	public void setAmt2(String amt2) {
		this.amt2 = amt2;
	}

	public String getRequiredADCD3() {
		return requiredADCD3;
	}

	public void setRequiredADCD3(String requiredADCD3) {
		this.requiredADCD3 = requiredADCD3;
	}

	public String getLocation1() {
		return location1;
	}
	public void setLocation1(String location1) {
		this.location1 = location1;
	}
	public String getLocation2() {
		return location2;
	}

	public void setLocation2(String location2) {
		this.location2 = location2;
	}
	public String getLocation3() {
		return location3;
	}

	public void setLocation3(String location3) {
		this.location3 = location3;
	}

	public String getAdProgram() {
		return adProgram;
	}
	public void setAdProgram(String adProgram) {
		this.adProgram = adProgram;
	}


	public String getVenueActivity1() {
		return venueActivity1;
	}
	public void setVenueActivity1(String venueActivity1) {
		this.venueActivity1 = venueActivity1;
	}

	public String getVenueActivity2() {
		return venueActivity2;
	}
	public void setVenueActivity2(String venueActivity2) {
		this.venueActivity2 = venueActivity2;
	}
	public String getVenueActivity3() {
		return venueActivity3;
	}
	public void setVenueActivity3(String venueActivity3) {
		this.venueActivity3 = venueActivity3;
	}

}
