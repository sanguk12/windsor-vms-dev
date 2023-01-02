package com.kia.ad.model;

import com.kia.mdm.model.GVEN01MT;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.StringUtil;

public class GME01DT extends CommonObject implements Model{
	
	private String seq = "";
	private String prdCD = "";
	private String qtyUnitCD = "";
	private String sdxYN = "";
	private String efp = "";
	private String duty = "";
	private String cogs  = "";
	private String activeYN = "";
	private String eu = "";
	
	private String[] seqs = null;              
	private String[] prdCDs = null;              
	private String[] qtyUnitCDs = null;          
	private String[] sdxYNs = null;              
	private String[] efps = null;                
	private String[] dutys = null;               
	private String[] cogss  = null;              
	private String[] activeYNs = null;           
	private String[] eus = null;           
	
	@Override
	public void clean() throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void validate(int arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.prdCDs != null) {
			 size = this.prdCDs.length;
		}
		return size;
	}

	public GME01DT getObject(int index) {
		GME01DT vo = new GME01DT();
		
		if (getSize() > index) {
			
			try{vo.setSeq(this.getSeq());}catch(Exception e){}
			try{vo.setPrdCD(this.prdCDs[index]);}catch(Exception e){}
//			try{vo.setQtyUnitCD(this.qtyUnitCDs[index]);}catch(Exception e){}
			try{vo.setEu(this.eus[index]);}catch(Exception e){}
			try{vo.setSdxYN(this.sdxYNs[index]);}catch(Exception e){}
			try{vo.setEfp(StringUtil.unFormatNum(this.efps[index]));}catch(Exception e){}
			try{vo.setDuty(StringUtil.unFormatNum(this.dutys[index]));}catch(Exception e){}
			try{vo.setCogs(StringUtil.unFormatNum(this.cogss[index]));}catch(Exception e){}
			try{vo.setActiveYN(this.activeYNs[index]);}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
		}
			
		return vo;
	}
	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getPrdCD() {
		return prdCD;
	}
	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}
	public String getQtyUnitCD() {
		return qtyUnitCD;
	}
	public void setQtyUnitCD(String qtyUnitCD) {
		this.qtyUnitCD = qtyUnitCD;
	}
	public String getSdxYN() {
		return sdxYN;
	}
	public void setSdxYN(String sdxYN) {
		this.sdxYN = sdxYN;
	}
	public String getEfp() {
		return efp;
	}
	public void setEfp(String efp) {
		this.efp = efp;
	}
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getCogs() {
		return cogs;
	}
	public void setCogs(String cogs) {
		this.cogs = cogs;
	}
	public String getActiveYN() {
		return activeYN;
	}
	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
	}
	
	
	
	public String[] getSeqs() {
		return seqs;
	}
	public void setSeqs(String[] seqs) {
		this.seqs = seqs;
	}
	public String[] getPrdCDs() {
		return prdCDs;
	}
	public void setPrdCDs(String[] prdCDs) {
		this.prdCDs = prdCDs;
	}
	public String[] getQtyUnitCDs() {
		return qtyUnitCDs;
	}
	public void setQtyUnitCDs(String[] qtyUnitCDs) {
		this.qtyUnitCDs = qtyUnitCDs;
	}
	public String[] getSdxYNs() {
		return sdxYNs;
	}
	public void setSdxYNs(String[] sdxYNs) {
		this.sdxYNs = sdxYNs;
	}
	public String[] getEfps() {
		return efps;
	}
	public void setEfps(String[] efps) {
		this.efps = efps;
	}
	public String[] getDutys() {
		return dutys;
	}
	public void setDutys(String[] dutys) {
		this.dutys = dutys;
	}
	public String[] getCogss() {
		return cogss;
	}
	public void setCogss(String[] cogss) {
		this.cogss = cogss;
	}
	public String[] getActiveYNs() {
		return activeYNs;
	}
	public void setActiveYNs(String[] activeYNs) {
		this.activeYNs = activeYNs;
	}
	public String getEu() {
		return eu;
	}
	public void setEu(String eu) {
		this.eu = eu;
	}
	public String[] getEus() {
		return eus;
	}
	public void setEus(String[] eus) {
		this.eus = eus;
	}
		

}
