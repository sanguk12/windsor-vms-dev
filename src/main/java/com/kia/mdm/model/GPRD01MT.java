package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.FormatUtil;

public class GPRD01MT extends CommonObject implements Model {

	private String prdCD = "";
	private String prdSAPCD= "";
	private String prdNm= "";
	private String prdShCD = "";
	private String categoryCD1 = "";
	private String categoryCD2 = "";
	private String categoryCD3 = "";
	private String categoryCD4 = "";
	private String categoryCD5 = "";
	private String factoryPrice = "";
	private String ml = "";
	private String unit = "";
	private String eu = "";
	private String sdxYN = "";
	private String qtyUnitCD = "";
	private String dkRivalTpCD = "";
	private String kindTpCD1 = "";
	private String kindTpCD2 = "";
	private String kindTpCD3 = "";
	private String kindTpCD4 = "";
	private String kindTpCD5 = "";
	private String boxUnit = "";
	private String incntTpCD = "";
	private String activeYN = "";
	private String angelPrd16CD = "";
	private String angelPrdMlCD = "";
	private String gsv = "";
	private String wsdc = "";
	private String cogs = "";
	private String duty = "";
	
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public String getPrdCD() {
		return prdCD;
	}

	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}

	public String getPrdSAPCD() {
		return prdSAPCD;
	}

	public void setPrdSAPCD(String prdSAPCD) {
		this.prdSAPCD = prdSAPCD;
	}

	public String getPrdNm() {
		return prdNm;
	}

	public void setPrdNm(String prdNm) {
		this.prdNm = prdNm;
	}

	public String getPrdShCD() {
		return prdShCD;
	}

	public void setPrdShCD(String prdShCD) {
		this.prdShCD = prdShCD;
	}

	public String getCategoryCD1() {
		return categoryCD1;
	}

	public void setCategoryCD1(String categoryCD1) {
		this.categoryCD1 = categoryCD1;
	}

	public String getCategoryCD2() {
		return categoryCD2;
	}

	public void setCategoryCD2(String categoryCD2) {
		this.categoryCD2 = categoryCD2;
	}

	public String getCategoryCD3() {
		return categoryCD3;
	}

	public void setCategoryCD3(String categoryCD3) {
		this.categoryCD3 = categoryCD3;
	}

	public String getCategoryCD4() {
		return categoryCD4;
	}

	public void setCategoryCD4(String categoryCD4) {
		this.categoryCD4 = categoryCD4;
	}

	public String getCategoryCD5() {
		return categoryCD5;
	}

	public void setCategoryCD5(String categoryCD5) {
		this.categoryCD5 = categoryCD5;
	}

	public String getFactoryPrice() {
		return factoryPrice;
	}

	public void setFactoryPrice(String factoryPrice) {
		this.factoryPrice = factoryPrice;
	}

	public String getMl() {
		return ml;
	}

	public void setMl(String ml) {
		this.ml = ml;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getEu() {
		return eu;
	}

	public void setEu(String eu) {
		this.eu = eu;
	}

	public String getSdxYN() {
		return sdxYN;
	}

	public void setSdxYN(String sdxYN) {
		this.sdxYN = sdxYN;
	}

	public String getQtyUnitCD() {
		return qtyUnitCD;
	}

	public void setQtyUnitCD(String qtyUnitCD) {
		this.qtyUnitCD = qtyUnitCD;
	}

	public String getDkRivalTpCD() {
		return dkRivalTpCD;
	}

	public void setDkRivalTpCD(String dkRivalTpCD) {
		this.dkRivalTpCD = dkRivalTpCD;
	}

	public String getKindTpCD1() {
		return kindTpCD1;
	}

	public void setKindTpCD1(String kindTpCD1) {
		this.kindTpCD1 = kindTpCD1;
	}

	public String getKindTpCD2() {
		return kindTpCD2;
	}

	public void setKindTpCD2(String kindTpCD2) {
		this.kindTpCD2 = kindTpCD2;
	}

	public String getKindTpCD3() {
		return kindTpCD3;
	}

	public void setKindTpCD3(String kindTpCD3) {
		this.kindTpCD3 = kindTpCD3;
	}

	public String getKindTpCD4() {
		return kindTpCD4;
	}

	public void setKindTpCD4(String kindTpCD4) {
		this.kindTpCD4 = kindTpCD4;
	}

	public String getKindTpCD5() {
		return kindTpCD5;
	}

	public void setKindTpCD5(String kindTpCD5) {
		this.kindTpCD5 = kindTpCD5;
	}
	
	public String getBoxUnit() {
		return boxUnit;
	}

	public void setBoxUnit(String boxUnit) {
		this.boxUnit = boxUnit;
	}

	public String getIncntTpCD() {
		return incntTpCD;
	}

	public void setIncntTpCD(String incntTpCD) {
		this.incntTpCD = incntTpCD;
	}

	public String getActiveYN() {
		return activeYN;
	}

	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
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

	public String getGsv() {
		return gsv;
	}

	public void setGsv(String gsv) {
		this.gsv = gsv;
	}

	public String getWsdc() {
		return wsdc;
	}

	public void setWsdc(String wsdc) {
		this.wsdc = wsdc;
	}

	public String getCogs() {
		return cogs;
	}

	public void setCogs(String cogs) {
		this.cogs = cogs;
	}

	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}
}
