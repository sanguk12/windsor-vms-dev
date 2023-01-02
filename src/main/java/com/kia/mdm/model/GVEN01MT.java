package com.kia.mdm.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GVEN01MT extends CommonObject implements Model {

	private String venueCD = "";
	private String venueNm = "";
	private String dkmdTpCD = "";
	private String territoryCD = "";
	private String venueGradCD = "";
	private String channelCD = "";
	private String subChannelCD = "";
	private String segmentCD = "";
	private String subSegmentCD = "";
	private String addrTpCD1 = "";
	private String addrTpCD2 = "";
	private String addrTpCD3 = "";
	private String addrTpCD4 = "";
	private String wsCD = "";
	private String wsSapCD = "";
	private String note1 = "";
	private String note2 = "";
	private String note3 = "";
	private String note4 = "";
	private String activeYN = "";
	private String activeFlg = "";
	private String incntTpCD = "";
	private String venueDivCD = "";
	
	private String[] venueCDs = null;
	private String[] venueNms = null;
	private String[] dkmdTpCDs = null;
	private String[] territoryCDs = null;
	private String[] venueGradCDs = null;
	private String[] channelCDs = null;
	private String[] subChannelCDs = null;
	private String[] segmentCDs = null;
	private String[] subSegmentCDs = null;
	private String[] addrTpCD1s = null;
	private String[] addrTpCD2s = null;
	private String[] addrTpCD3s = null;
	private String[] addrTpCD4s = null;
	private String[] wsCDs = null;
	private String[] wsSapCDs = null;
	private String[] note1s = null;
	private String[] note2s = null;
	private String[] note3s = null;
	private String[] note4s = null;
	private String[] activeYNs = null;
	private String[] activeFlgs = null;
	private String[] incntTpCDs = null;
	private String[] venueDivCDs = null;
	
	public void clean() {
		
	}
	
	public void validate(int action) throws Exception {
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.venueCDs != null) {
			 size = this.venueCDs.length;
		}
		return size;
	}

	public GVEN01MT getObject(int index) {
		GVEN01MT vo = new GVEN01MT();
		if (getSize() > index) {
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setVenueNm(this.venueNms[index]);}catch(Exception e){}
			try{vo.setDkmdTpCD(this.dkmdTpCDs[index]);}catch(Exception e){}
			try{vo.setTerritoryCD(this.territoryCDs[index]);}catch(Exception e){}
			try{vo.setVenueGradCD(this.venueGradCDs[index]);}catch(Exception e){}
			try{vo.setChannelCD(this.channelCDs[index]);}catch(Exception e){}
			try{vo.setSubChannelCD(this.subChannelCDs[index]);}catch(Exception e){}
			try{vo.setSegmentCD(this.segmentCDs[index]);}catch(Exception e){}
			try{vo.setSubSegmentCD(this.subSegmentCDs[index]);}catch(Exception e){}
			try{vo.setAddrTpCD1(this.addrTpCD1s[index]);}catch(Exception e){}
			try{vo.setAddrTpCD2(this.addrTpCD2s[index]);}catch(Exception e){}
			try{vo.setAddrTpCD3(this.addrTpCD3s[index]);}catch(Exception e){}
			try{vo.setAddrTpCD4(this.addrTpCD4s[index]);}catch(Exception e){}
			try{vo.setWsCD(this.wsCDs[index]);}catch(Exception e){}
			try{vo.setWsSapCD(this.wsSapCDs[index]);}catch(Exception e){}
			try{vo.setNote1(this.note1s[index]);}catch(Exception e){}
			try{vo.setNote2(this.note2s[index]);}catch(Exception e){}
			try{vo.setNote3(this.note3s[index]);}catch(Exception e){}
			try{vo.setNote4(this.note4s[index]);}catch(Exception e){}
			try{vo.setActiveYN(this.activeYNs[index]);}catch(Exception e){}
			try{vo.setIncntTpCD(this.incntTpCDs[index]);}catch(Exception e){}
			try{vo.setVenueDivCD(this.venueDivCDs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getVenueNm() {
		return venueNm;
	}

	public void setVenueNm(String venueNm) {
		this.venueNm = venueNm;
	}

	public String getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String dkmdTpCD) {
		this.dkmdTpCD = dkmdTpCD;
	}

	public String getTerritoryCD() {
		return territoryCD;
	}

	public void setTerritoryCD(String territoryCD) {
		this.territoryCD = territoryCD;
	}

	public String getVenueGradCD() {
		return venueGradCD;
	}

	public void setVenueGradCD(String venueGradCD) {
		this.venueGradCD = venueGradCD;
	}

	public String getChannelCD() {
		return channelCD;
	}

	public void setChannelCD(String channelCD) {
		this.channelCD = channelCD;
	}

	public String getSubChannelCD() {
		return subChannelCD;
	}

	public void setSubChannelCD(String subChannelCD) {
		this.subChannelCD = subChannelCD;
	}

	public String getSegmentCD() {
		return segmentCD;
	}

	public void setSegmentCD(String segmentCD) {
		this.segmentCD = segmentCD;
	}

	public String getSubSegmentCD() {
		return subSegmentCD;
	}

	public void setSubSegmentCD(String subSegmentCD) {
		this.subSegmentCD = subSegmentCD;
	}

	public String getAddrTpCD1() {
		return addrTpCD1;
	}

	public void setAddrTpCD1(String addrTpCD1) {
		this.addrTpCD1 = addrTpCD1;
	}

	public String getAddrTpCD2() {
		return addrTpCD2;
	}

	public void setAddrTpCD2(String addrTpCD2) {
		this.addrTpCD2 = addrTpCD2;
	}

	public String getAddrTpCD3() {
		return addrTpCD3;
	}

	public void setAddrTpCD3(String addrTpCD3) {
		this.addrTpCD3 = addrTpCD3;
	}
	
	public String getAddrTpCD4() {
		return addrTpCD4;
	}

	public void setAddrTpCD4(String addrTpCD4) {
		this.addrTpCD4 = addrTpCD4;
	}

	public String getWsCD() {
		return wsCD;
	}

	public void setWsCD(String wsCD) {
		this.wsCD = wsCD;
	}

	public String getWsSapCD() {
		return wsSapCD;
	}

	public void setWsSapCD(String wsSapCD) {
		this.wsSapCD = wsSapCD;
	}

	public String getNote1() {
		return note1;
	}

	public void setNote1(String note1) {
		this.note1 = note1;
	}

	public String getNote2() {
		return note2;
	}

	public void setNote2(String note2) {
		this.note2 = note2;
	}

	public String getNote3() {
		return note3;
	}

	public void setNote3(String note3) {
		this.note3 = note3;
	}

	public String getNote4() {
		return note4;
	}

	public void setNote4(String note4) {
		this.note4 = note4;
	}

	public String getActiveYN() {
		return activeYN;
	}

	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getIncntTpCD() {
		return incntTpCD;
	}

	public void setIncntTpCD(String incntTpCD) {
		this.incntTpCD = incntTpCD;
	}

	public String getVenueDivCD() {
		return venueDivCD;
	}

	public void setVenueDivCD(String venueDivCD) {
		this.venueDivCD = venueDivCD;
	}

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String[] getVenueNms() {
		return venueNms;
	}

	public void setVenueNms(String[] venueNms) {
		this.venueNms = venueNms;
	}

	public String[] getDkmdTpCDs() {
		return dkmdTpCDs;
	}

	public void setDkmdTpCDs(String[] dkmdTpCDs) {
		this.dkmdTpCDs = dkmdTpCDs;
	}

	public String[] getTerritoryCDs() {
		return territoryCDs;
	}

	public void setTerritoryCDs(String[] territoryCDs) {
		this.territoryCDs = territoryCDs;
	}

	public String[] getVenueGradCDs() {
		return venueGradCDs;
	}

	public void setVenueGradCDs(String[] venueGradCDs) {
		this.venueGradCDs = venueGradCDs;
	}

	public String[] getChannelCDs() {
		return channelCDs;
	}

	public void setChannelCDs(String[] channelCDs) {
		this.channelCDs = channelCDs;
	}

	public String[] getSubChannelCDs() {
		return subChannelCDs;
	}

	public void setSubChannelCDs(String[] subChannelCDs) {
		this.subChannelCDs = subChannelCDs;
	}

	public String[] getSegmentCDs() {
		return segmentCDs;
	}

	public void setSegmentCDs(String[] segmentCDs) {
		this.segmentCDs = segmentCDs;
	}

	public String[] getSubSegmentCDs() {
		return subSegmentCDs;
	}

	public void setSubSegmentCDs(String[] subSegmentCDs) {
		this.subSegmentCDs = subSegmentCDs;
	}

	public String[] getAddrTpCD1s() {
		return addrTpCD1s;
	}

	public void setAddrTpCD1s(String[] addrTpCD1s) {
		this.addrTpCD1s = addrTpCD1s;
	}

	public String[] getAddrTpCD2s() {
		return addrTpCD2s;
	}

	public void setAddrTpCD2s(String[] addrTpCD2s) {
		this.addrTpCD2s = addrTpCD2s;
	}

	public String[] getAddrTpCD3s() {
		return addrTpCD3s;
	}

	public void setAddrTpCD3s(String[] addrTpCD3s) {
		this.addrTpCD3s = addrTpCD3s;
	}
	
	public String[] getAddrTpCD4s() {
		return addrTpCD4s;
	}

	public void setAddrTpCD4s(String[] addrTpCD4s) {
		this.addrTpCD4s = addrTpCD4s;
	}

	public String[] getWsCDs() {
		return wsCDs;
	}

	public void setWsCDs(String[] wsCDs) {
		this.wsCDs = wsCDs;
	}

	public String[] getWsSapCDs() {
		return wsSapCDs;
	}

	public void setWsSapCDs(String[] wsSapCDs) {
		this.wsSapCDs = wsSapCDs;
	}

	public String[] getNote1s() {
		return note1s;
	}

	public void setNote1s(String[] note1s) {
		this.note1s = note1s;
	}

	public String[] getNote2s() {
		return note2s;
	}

	public void setNote2s(String[] note2s) {
		this.note2s = note2s;
	}

	public String[] getNote3s() {
		return note3s;
	}

	public void setNote3s(String[] note3s) {
		this.note3s = note3s;
	}

	public String[] getNote4s() {
		return note4s;
	}

	public void setNote4s(String[] note4s) {
		this.note4s = note4s;
	}

	public String[] getActiveYNs() {
		return activeYNs;
	}

	public void setActiveYNs(String[] activeYNs) {
		this.activeYNs = activeYNs;
	}

	public String[] getActiveFlgs() {
		return activeFlgs;
	}

	public void setActiveFlgs(String[] activeFlgs) {
		this.activeFlgs = activeFlgs;
	}

	public String[] getIncntTpCDs() {
		return incntTpCDs;
	}

	public void setIncntTpCDs(String[] incntTpCDs) {
		this.incntTpCDs = incntTpCDs;
	}

	public String[] getVenueDivCDs() {
		return venueDivCDs;
	}

	public void setVenueDivCDs(String[] venueDivCDs) {
		this.venueDivCDs = venueDivCDs;
	}
	
}