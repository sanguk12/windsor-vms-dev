package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월Shipment실적|도매상
public class ESLT_NOTEG_FC extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String team = "";
	private String market = "";
	private String forVolume = "";
	private String outVolume = "";
	private String forAmount = "";
	private String outAmount = "";
	private String fy_S = "";
	private String period_S = "";
	
	private String fys[] = null;
	private String periods[] = null;
	private String teams[] = null;
	private String markets[] = null;
	private String forVolumes[] = null;
	private String outVolumes[] = null;
	private String forAmounts[] = null;
	private String outAmounts[] = null;
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public int getSize() {
		int size = 0;
		if(this.fys != null) {
			size = fys.length;
		}
		return size;
	}
	
	public ESLT_NOTEG_FC getObject(int index) {
		ESLT_NOTEG_FC vo = new ESLT_NOTEG_FC();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setTeam(this.teams[index]);}catch(Exception e){};
		try{vo.setMarket(this.markets[index]);}catch(Exception e){};
		try{vo.setForVolume(this.forVolumes[index]);}catch(Exception e){};
		try{vo.setOutVolume(this.outVolumes[index]);}catch(Exception e){};
		try{vo.setForAmount(this.forAmounts[index]);}catch(Exception e){};
		try{vo.setOutAmount(this.outAmounts[index]);}catch(Exception e){};
		
		return vo;
	}

	public String getFy() {
		return fy;
	}

	public void setFy(String fy) {
		this.fy = fy;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getMarket() {
		return market;
	}

	public void setMarket(String market) {
		this.market = market;
	}

	public String getForVolume() {
		return forVolume;
	}

	public void setForVolume(String forVolume) {
		this.forVolume = forVolume;
	}

	public String getOutVolume() {
		return outVolume;
	}

	public void setOutVolume(String outVolume) {
		this.outVolume = outVolume;
	}

	public String getForAmount() {
		return forAmount;
	}

	public void setForAmount(String forAmount) {
		this.forAmount = forAmount;
	}

	public String getOutAmount() {
		return outAmount;
	}

	public void setOutAmount(String outAmount) {
		this.outAmount = outAmount;
	}

	public String getFy_S() {
		return fy_S;
	}

	public void setFy_S(String fy_S) {
		this.fy_S = fy_S;
	}

	public String getPeriod_S() {
		return period_S;
	}

	public void setPeriod_S(String period_S) {
		this.period_S = period_S;
	}

	public String[] getFys() {
		return fys;
	}

	public void setFys(String[] fys) {
		this.fys = fys;
	}

	public String[] getPeriods() {
		return periods;
	}

	public void setPeriods(String[] periods) {
		this.periods = periods;
	}

	public String[] getTeams() {
		return teams;
	}

	public void setTeams(String[] teams) {
		this.teams = teams;
	}

	public String[] getMarkets() {
		return markets;
	}

	public void setMarkets(String[] markets) {
		this.markets = markets;
	}

	public String[] getForVolumes() {
		return forVolumes;
	}

	public void setForVolumes(String[] forVolumes) {
		this.forVolumes = forVolumes;
	}

	public String[] getOutVolumes() {
		return outVolumes;
	}

	public void setOutVolumes(String[] outVolumes) {
		this.outVolumes = outVolumes;
	}

	public String[] getForAmounts() {
		return forAmounts;
	}

	public void setForAmounts(String[] forAmounts) {
		this.forAmounts = forAmounts;
	}

	public String[] getOutAmounts() {
		return outAmounts;
	}

	public void setOutAmounts(String[] outAmounts) {
		this.outAmounts = outAmounts;
	}

}
