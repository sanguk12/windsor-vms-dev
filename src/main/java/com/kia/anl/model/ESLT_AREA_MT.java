package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 지점정보
public class ESLT_AREA_MT extends CommonObject implements Model{

	private String city = "";
	private String subCity1 = "";
	private String subCity2 = "";
	private String lpbTeam = "";
	private String gpbTeam = "";
	
	private String citys[] = null;
	private String subCity1s[] = null;
	private String subCity2s[] = null;
	private String lpbTeams[] = null;
	private String gpbTeams[] = null;
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public int getSize() {
		int size = 0;
		if(this.citys != null) {
			size = citys.length;
		}
		return size;
	}
	
	public ESLT_AREA_MT getObject(int index) {
		ESLT_AREA_MT vo = new ESLT_AREA_MT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setCity (this.citys[index]);}catch(Exception e){};
		try{vo.setSubCity1(this.subCity1s[index]);}catch(Exception e){};
		try{vo.setSubCity2(this.subCity2s[index]);}catch(Exception e){};
		try{vo.setLpbTeam(this.lpbTeams[index]);}catch(Exception e){};
		try{vo.setGpbTeam(this.gpbTeams[index]);}catch(Exception e){};
		
		return vo;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getSubCity1() {
		return subCity1;
	}

	public void setSubCity1(String subCity1) {
		this.subCity1 = subCity1;
	}

	public String getSubCity2() {
		return subCity2;
	}

	public void setSubCity2(String subCity2) {
		this.subCity2 = subCity2;
	}

	public String getLpbTeam() {
		return lpbTeam;
	}

	public void setLpbTeam(String lpbTeam) {
		this.lpbTeam = lpbTeam;
	}

	public String getGpbTeam() {
		return gpbTeam;
	}

	public void setGpbTeam(String gpbTeam) {
		this.gpbTeam = gpbTeam;
	}

	public String[] getCitys() {
		return citys;
	}

	public void setCitys(String[] citys) {
		this.citys = citys;
	}

	public String[] getSubCity1s() {
		return subCity1s;
	}

	public void setSubCity1s(String[] subCity1s) {
		this.subCity1s = subCity1s;
	}

	public String[] getSubCity2s() {
		return subCity2s;
	}

	public void setSubCity2s(String[] subCity2s) {
		this.subCity2s = subCity2s;
	}

	public String[] getLpbTeams() {
		return lpbTeams;
	}

	public void setLpbTeams(String[] lpbTeams) {
		this.lpbTeams = lpbTeams;
	}

	public String[] getGpbTeams() {
		return gpbTeams;
	}

	public void setGpbTeams(String[] gpbTeams) {
		this.gpbTeams = gpbTeams;
	}

}
