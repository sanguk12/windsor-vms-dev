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

	public String getAmt3() {
		return amt3;
	}

	public void setAmt3(String amt3) {
		this.amt3 = amt3;
	}

}
