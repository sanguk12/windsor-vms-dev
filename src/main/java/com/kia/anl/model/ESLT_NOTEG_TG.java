package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월Shipment실적|도매상
public class ESLT_NOTEG_TG extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String team = "";
	private String market = "";
	private String volume = "";
	private String amount = "";
	private String fy_S = "";
	private String period_S = "";
	
	private String fys[] = null;
	private String periods[] = null;
	private String teams[] = null;
	private String markets[] = null;
	private String volumes[] = null;
	private String amounts[] = null;
	
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
	
	public ESLT_NOTEG_TG getObject(int index) {
		ESLT_NOTEG_TG vo = new ESLT_NOTEG_TG();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setTeam(this.teams[index]);}catch(Exception e){};
		try{vo.setMarket(this.markets[index]);}catch(Exception e){};
		try{vo.setVolume(this.volumes[index]);}catch(Exception e){};
		try{vo.setAmount(this.amounts[index]);}catch(Exception e){};
		
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

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
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

	public String[] getVolumes() {
		return volumes;
	}

	public void setVolumes(String[] volumes) {
		this.volumes = volumes;
	}

	public String[] getAmounts() {
		return amounts;
	}

	public void setAmounts(String[] amounts) {
		this.amounts = amounts;
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

}
