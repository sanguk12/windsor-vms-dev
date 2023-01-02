package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GDAT01MT extends CommonObject implements Model{
	private String GDATID = "";
	private String planResultTpCD = "";
	private String STARTDATE = "";
	private String ENDDATE = "";
	private String REGEMPID = "";
	private String REGDATE  = "";
	private String ACTIVEFLG = "";
	private String FILENAME ="";
	
	@Override
	public String toString() {
		return "GDAT01MT [GDATID=" + GDATID + ", planResultTpCD="
				+ planResultTpCD + ", STARTDATE=" + STARTDATE + ", ENDDATE="
				+ ENDDATE + ", REGEMPID=" + REGEMPID + ", REGDATE=" + REGDATE
				+ ", ACTIVEFLG=" + ACTIVEFLG + ", FILENAME=" + FILENAME + "]";
	}
	public String getFILENAME() {
		return FILENAME;
	}
	public void setFILENAME(String fILENAME) {
		FILENAME = fILENAME;
	}
	public String getGDATID() {
		return GDATID;
	}
	public void setGDATID(String gDATID) {
		GDATID = gDATID;
	}
	public String getPlanResultTpCD() {
		return planResultTpCD;
	}
	public void setPlanResultTpCD(String planResultTpCD) {
		this.planResultTpCD = planResultTpCD;
	}
	public String getSTARTDATE() {
		return STARTDATE;
	}
	public void setSTARTDATE(String sTARTDATE) {
		STARTDATE = sTARTDATE;
	}
	public String getENDDATE() {
		return ENDDATE;
	}
	public void setENDDATE(String eNDDATE) {
		ENDDATE = eNDDATE;
	}
	public String getREGEMPID() {
		return REGEMPID;
	}
	public void setREGEMPID(String rEGEMPID) {
		REGEMPID = rEGEMPID;
	}
	public String getREGDATE() {
		return REGDATE;
	}
	public void setREGDATE(String rEGDATE) {
		REGDATE = rEGDATE;
	}
	public String getACTIVEFLG() {
		return ACTIVEFLG;
	}
	public void setACTIVEFLG(String aCTIVEFLG) {
		ACTIVEFLG = aCTIVEFLG;
	}
	public GDAT01MT() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	
}
