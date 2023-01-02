package com.kia.cvr.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GCVR02MTs extends CommonObject implements Model {
	private String[] seq = null;
	private String[] fromRate = null;
	private String[] toRate = null;
	private String[] rate = null;
	private String[] activeFlg = null;
	
	private String eventYm = "";
	private String[] rageSphereCDs = null;
	private String[] officeCDs = null;
	private String[] kindTpCDs = null;
	private String[] nggsvRns = null;
	private String[] nggsvRcs = null;
	private String[] commts = null;
	private String[] apprStateCDs = null;
	private String[] lapprLevelNos = null;
	private String regID = "";
	private String chgID = "";

	public void clean() {
	}
	
	public void validate(int action) throws Exception {}

	public int getSize() {
		int size = 0 ;
		
		if (this.officeCDs != null) {
			 size = this.officeCDs.length;
		}
		
		return size;
	}
	
	public GCVR02MT getGCVR02MT(int i){
		
		GCVR02MT gcvr02mt = new GCVR02MT();
		if (getSize() > i) {
			if (this.fromRate != null) gcvr02mt.setFromRate(this.fromRate[i]);
			if (this.toRate != null) gcvr02mt.setToRate(this.toRate[i]);	
			if (this.rate != null) gcvr02mt.setRate(this.rate[i]);	
			
			if (this.eventYm != null) gcvr02mt.setEventYm(this.eventYm);
			if (this.rageSphereCDs != null) gcvr02mt.setRageSphereCD(this.rageSphereCDs[i]);
			if (this.officeCDs != null) gcvr02mt.setOfficeCD(this.officeCDs[i]);
			if (this.kindTpCDs != null) gcvr02mt.setKindTpCD(this.kindTpCDs[i]);
			if (this.nggsvRns != null) gcvr02mt.setNggsvRn(this.nggsvRns[i]);
			if (this.nggsvRcs != null) gcvr02mt.setNggsvRc(this.nggsvRcs[i]);
			if (this.commts != null) gcvr02mt.setCommt(this.commts[i]);
			if (this.apprStateCDs != null) gcvr02mt.setApprStateCD(this.apprStateCDs[i]);
			if (this.lapprLevelNos != null) gcvr02mt.setLapprLevelNo(this.lapprLevelNos[i]);
			if (this.regID != null) gcvr02mt.setRegID(this.regID);
			if (this.chgID != null) gcvr02mt.setChgID(this.chgID);
		}
		return gcvr02mt;
		
	}
	public String[] getFromRate() {
		return fromRate;
	}

	public void setFromRate(String[] fromRate) {
		this.fromRate = fromRate;
	}

	public String[] getToRate() {
		return toRate;
	}

	public void setToRate(String[] toRate) {
		this.toRate = toRate;
	}

	public String[] getRate() {
		return rate;
	}

	public void setRate(String[] rate) {
		this.rate = rate;
	}

	public String[] getSeq() {
		return seq;
	}

	public void setSeq(String[] seq) {
		this.seq = seq;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getEventYm() {
		return eventYm;
	}

	public void setEventYm(String eventYm) {
		this.eventYm = eventYm;
	}

	public String[] getRageSphereCDs() {
		return rageSphereCDs;
	}

	public void setRageSphereCDs(String[] rageSphereCDs) {
		this.rageSphereCDs = rageSphereCDs;
	}

	public String[] getOfficeCDs() {
		return officeCDs;
	}

	public void setOfficeCDs(String[] officeCDs) {
		this.officeCDs = officeCDs;
	}

	public String[] getKindTpCDs() {
		return kindTpCDs;
	}

	public void setKindTpCDs(String[] kindTpCDs) {
		this.kindTpCDs = kindTpCDs;
	}

	public String[] getNggsvRns() {
		return nggsvRns;
	}

	public void setNggsvRns(String[] nggsvRns) {
		this.nggsvRns = nggsvRns;
	}

	public String[] getNggsvRcs() {
		return nggsvRcs;
	}

	public void setNggsvRcs(String[] nggsvRcs) {
		this.nggsvRcs = nggsvRcs;
	}

	public String[] getCommts() {
		return commts;
	}

	public void setCommts(String[] commts) {
		this.commts = commts;
	}

	public String[] getApprStateCDs() {
		return apprStateCDs;
	}

	public void setApprStateCDs(String[] apprStateCDs) {
		this.apprStateCDs = apprStateCDs;
	}

	public String[] getLapprLevelNos() {
		return lapprLevelNos;
	}

	public void setLapprLevelNos(String[] lapprLevelNos) {
		this.lapprLevelNos = lapprLevelNos;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getChgID() {
		return chgID;
	}

	public void setChgID(String chgID) {
		this.chgID = chgID;
	}

}
			
	
