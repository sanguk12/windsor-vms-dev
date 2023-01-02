package com.kia.anl.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

// 월NOTEG실적|주소
public class ESLT_NOTEG_ACT extends CommonObject implements Model{

	private String fy = "";
	private String period = "";
	private String venueID = "";
	private String city = "";
	private String subCity1 = "";
	private String subCity2 = "";
	private String market = "";
	private String productL7 = "";
	private String volume = "";
	private String amount = "";
	private String fy_S = "";
	private String period_S = "";

	private String fys[] = null;
	private String periods[] = null;
	private String venueIDs[] = null;
	private String citys[] = null;
	private String subCity1s[] = null;
	private String subCity2s[] = null;
	private String markets[] = null;
	private String productL7s[] = null;
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
	
	public ESLT_NOTEG_ACT getObject(int index) {
		ESLT_NOTEG_ACT vo = new ESLT_NOTEG_ACT();
		
		try{vo.setUserID(this.getUserID());}catch(Exception e){}
		try{vo.setFy(this.fys[index]);}catch(Exception e){};
		try{vo.setPeriod(this.periods[index]);}catch(Exception e){};
		try{vo.setVenueID(this.venueIDs[index]);}catch(Exception e){};
		try{vo.setCity(this.citys[index]);}catch(Exception e){};
		try{vo.setSubCity1(this.subCity1s[index]);}catch(Exception e){};
		try{vo.setSubCity2(this.subCity2s[index]);}catch(Exception e){};
		try{vo.setMarket(this.markets[index]);}catch(Exception e){};
		try{vo.setProductL7(this.productL7s[index]);}catch(Exception e){};
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

	public String getVenueID() {
		return venueID;
	}

	public void setVenueID(String venueID) {
		this.venueID = venueID;
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

	public String getMarket() {
		return market;
	}

	public void setMarket(String market) {
		this.market = market;
	}

	public String getProductL7() {
		return productL7;
	}

	public void setProductL7(String productL7) {
		this.productL7 = productL7;
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

	public String[] getVenueIDs() {
		return venueIDs;
	}

	public void setVenueIDs(String[] venueIDs) {
		this.venueIDs = venueIDs;
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

	public String[] getMarkets() {
		return markets;
	}

	public void setMarkets(String[] markets) {
		this.markets = markets;
	}

	public String[] getProductL7s() {
		return productL7s;
	}

	public void setProductL7s(String[] productL7s) {
		this.productL7s = productL7s;
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
