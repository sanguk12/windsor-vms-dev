package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 지점정보
public class ESLT_BRANCH_MT extends CommonObject implements Model{

	private String branch = "";
	private String region = "";
	private String channel = "";
	private String empid = "";
	private String empid1 = "";
	private String dispseq = "";
	private String useyn = "";
	
	private String branchs[] = null;
	private String regions[] = null;
	private String channels[] = null;
	private String empids[] = null;
	private String empid1s[] = null;
	private String dispseqs[] = null;
	private String useyns[] = null;
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public int getSize() {
		int size = 0;
		if(this.branchs != null) {
			size = branchs.length;
		}
		return size;
	}
	
	public ESLT_BRANCH_MT getObject(int index) {
		ESLT_BRANCH_MT vo = new ESLT_BRANCH_MT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setBranch (this.branchs[index]);}catch(Exception e){};
		try{vo.setRegion(this.regions[index]);}catch(Exception e){};
		try{vo.setChannel(this.channels[index]);}catch(Exception e){};
		try{vo.setEmpid(this.empids[index]);}catch(Exception e){};
		try{vo.setEmpid1(this.empid1s[index]);}catch(Exception e){};
		try{vo.setDispseq(this.dispseqs[index]);}catch(Exception e){};
		try{vo.setUseyn(this.useyns[index]);}catch(Exception e){};
		
		return vo;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getEmpid() {
		return empid;
	}

	public void setEmpid(String empid) {
		this.empid = empid;
	}

	public String getDispseq() {
		return dispseq;
	}

	public void setDispseq(String dispseq) {
		this.dispseq = dispseq;
	}

	public String getUseyn() {
		return useyn;
	}

	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}

	public String[] getBranchs() {
		return branchs;
	}

	public void setBranchs(String[] branchs) {
		this.branchs = branchs;
	}

	public String[] getRegions() {
		return regions;
	}

	public void setRegions(String[] regions) {
		this.regions = regions;
	}

	public String[] getChannels() {
		return channels;
	}

	public void setChannels(String[] channels) {
		this.channels = channels;
	}

	public String[] getEmpids() {
		return empids;
	}

	public void setEmpids(String[] empids) {
		this.empids = empids;
	}

	public String getEmpid1() {
		return empid1;
	}

	public void setEmpid1(String empid1) {
		this.empid1 = empid1;
	}

	public String[] getEmpid1s() {
		return empid1s;
	}

	public void setEmpid1s(String[] empid1s) {
		this.empid1s = empid1s;
	}

	public String[] getDispseqs() {
		return dispseqs;
	}

	public void setDispseqs(String[] dispseqs) {
		this.dispseqs = dispseqs;
	}

	public String[] getUseyns() {
		return useyns;
	}

	public void setUseyns(String[] useyns) {
		this.useyns = useyns;
	}
	
}
