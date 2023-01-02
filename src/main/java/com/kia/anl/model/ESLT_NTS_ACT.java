package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월NTS실적|주소
public class ESLT_NTS_ACT extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String city = "";
	private String subcity1 = "";
	private String subcity2 = "";
	private String market = "";
	private String segment = "";
	private String channel = "";
	private String company = "";
	private String volume = "";
	private String fy_S = "";
	private String period_S = "";
	
	private String fys[] = null;
	private String periods[] = null;
	private String citys[] = null;
	private String subcity1s[] = null;
	private String subcity2s[] = null;
	private String markets[] = null;
	private String segments[] = null;
	private String channels[] = null;
	private String companys[] = null;
	private String volumes[] = null;
	
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
	
	public ESLT_NTS_ACT getObject(int index) {
		ESLT_NTS_ACT vo = new ESLT_NTS_ACT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setCity(this.citys[index]);}catch(Exception e){};
		try{vo.setSubcity1(this.subcity1s[index]);}catch(Exception e){};
		try{vo.setSubcity2(this.subcity2s[index]);}catch(Exception e){};
		try{vo.setMarket(this.markets[index]);}catch(Exception e){};
		try{vo.setSegment(this.segments[index]);}catch(Exception e){};
		try{vo.setChannel(this.channels[index]);}catch(Exception e){};
		try{vo.setCompany(this.companys[index]);}catch(Exception e){};
		try{vo.setVolume(this.volumes[index]);}catch(Exception e){};
		
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

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getSubcity1() {
		return subcity1;
	}

	public void setSubcity1(String subcity1) {
		this.subcity1 = subcity1;
	}

	public String getSubcity2() {
		return subcity2;
	}

	public void setSubcity2(String subcity2) {
		this.subcity2 = subcity2;
	}

	public String getMarket() {
		return market;
	}

	public void setMarket(String market) {
		this.market = market;
	}

	public String getSegment() {
		return segment;
	}

	public void setSegment(String segment) {
		this.segment = segment;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
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

	public String[] getCitys() {
		return citys;
	}

	public void setCitys(String[] citys) {
		this.citys = citys;
	}

	public String[] getSubcity1s() {
		return subcity1s;
	}

	public void setSubcity1s(String[] subcity1s) {
		this.subcity1s = subcity1s;
	}

	public String[] getSubcity2s() {
		return subcity2s;
	}

	public void setSubcity2s(String[] subcity2s) {
		this.subcity2s = subcity2s;
	}

	public String[] getMarkets() {
		return markets;
	}

	public void setMarkets(String[] markets) {
		this.markets = markets;
	}

	public String[] getSegments() {
		return segments;
	}

	public void setSegments(String[] segments) {
		this.segments = segments;
	}

	public String[] getChannels() {
		return channels;
	}

	public void setChannels(String[] channels) {
		this.channels = channels;
	}

	public String[] getCompanys() {
		return companys;
	}

	public void setCompanys(String[] companys) {
		this.companys = companys;
	}

	public String[] getVolumes() {
		return volumes;
	}

	public void setVolumes(String[] volumes) {
		this.volumes = volumes;
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
