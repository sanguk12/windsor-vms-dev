package com.kia.api.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

public class GAPI01MT extends CommonObject implements Model{
		
	private static final long serialVersionUID = 1L;
	
	private String userID      = "";
	private String newPassword = "";
	private String password    = "";
	private String token       = "";	
	
	private String approveYN   = "";
	private String contractYN  = "";	
	private String contract01  = "";	
	private String contract02  = "";	
	private String contract03  = "";	
	private String contract04  = "";	
	private String contract05  = "";	
	private String contract06  = "";	
	private String contract07  = "";	
	private String contract08  = "";	
	private String contract09  = "";	
	private String contract10  = "";	
	private String contractIMG = "";	
	private String keymanID    = "";	
	
	private String bankCD      = "";	
	private String accountNO   = "";	
	private String holderNM    = "";	
	private String eventYM     = "";	
	private String venueCD     = "";	
	private String venueNM     = "";	
	private String prdCD       = "";	
	private String diffNo      = "";	
	
	private String saleCD01    = "";	
	private String saleCD02    = "";	
	private String saleCD03    = "";	
	private String saleCD04    = "";	
	private String saleCD05    = "";	
	private String saleCD06    = "";	
	private String saleCD07    = "";	
	private String saleCD08    = "";	
	private String saleCD09    = "";	
	private String saleCD10    = "";	    
	
	private String commt       = "";	 
	private String birthDate   = "";	 
	private String addr  	   = "";	 
	private String phoneNo 	   = "";	 
	private String regIDNo 	   = "";	 
	private String seq 	  	   = "";	 
	private String errCode 	   = ""; //에러코드	 
	private String authType	   = ""; //인증수단	 
	private String resSeq	   = "";	 
	private String name		   = "";	 
	private String gender	   = "";	 
	private String nationalinfo	= "";	 
	private String DI			= "";	 
	private String CI			= "";	 
	private String mobileNo		= "";	 
	private String mobileCo		= "";	 
	private String corpNo		= "";	 
	private String rspCd		= "";	 
	
	public void clean() throws Exception {
		
	}

	public void validate(int arg0) throws Exception {
		
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(Object object, String userID) {
		this.userID = userID;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
	
	public String getApproveYN() {
		return approveYN;
	}

	public void setApproveYN(String approveYN) {
		this.approveYN = approveYN;
	}
	
	public String getContractYN() {
		return contractYN;
	}

	public void setContractYN(String contractYN) {
		this.contractYN = contractYN;
	}
	
	public String getContract01() {
		return contract01;
	}

	public void setContract01(String contract01) {
		this.contract01 = contract01;
	}
	
	public String getContract02() {
		return contract02;
	}

	public void setContract02(String contract02) {
		this.contract02 = contract02;
	}
	
	public String getContract03() {
		return contract03;
	}

	public void setContract03(String contract03) {
		this.contract03 = contract03;
	}
	
	public String getContract04() {
		return contract04;
	}

	public void setContract04(String contract04) {
		this.contract04 = contract04;
	}
	
	public String getContract05() {
		return contract05;
	}

	public void setContract05(String contract05) {
		this.contract05 = contract05;
	}
	
	public String getContract06() {
		return contract06;
	}

	public void setContract06(String contract06) {
		this.contract06 = contract06;
	}
	
	public String getContract07() {
		return contract07;
	}

	public void setContract07(String contract07) {
		this.contract07 = contract07;
	}
	
	public String getContract08() {
		return contract08;
	}

	public void setContract08(String contract08) {
		this.contract08 = contract08;
	}
	
	public String getContract09() {
		return contract09;
	}

	public void setContract09(String contract09) {
		this.contract09 = contract09;
	}
	
	public String getContract10() {
		return contract10;
	}

	public void setContract10(String contract10) {
		this.contract10 = contract10;
	}
	
	public String getContractIMG() {
		return contractIMG;
	}

	public void setContractIMG(String contractIMG) {
		this.contractIMG = contractIMG;
	}
	
	public String getKeymanID() {
		return keymanID;
	}

	public void setKeymanID(String keymanID) {
		this.keymanID = keymanID;
	}
	
	public String getBankCD() {
		return bankCD;
	}

	public void setBankCD(String bankCD) {
		this.bankCD = bankCD;
	}
	
	public String getAccountNO() {
		return accountNO;
	}

	public void setAccountNO(String accountNO) {
		this.accountNO = accountNO;
	}
	
	public String getHolderNM() {
		return holderNM;
	}

	public void setHolderNM(String holderNM) {
		this.holderNM = holderNM;
	}
	
	public String getEventYM() {
		return eventYM;
	}

	public void setEventYM(String eventYM) {
		this.eventYM = eventYM;
	}
	
	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}
	
	public String getVenueNM() {
		return venueNM;
	}

	public void setVenueNM(String venueNM) {
		this.venueNM = venueNM;
	}
	
	public String getPrdCD() {
		return prdCD;
	}

	public void setPrdCD(String prdCD) {
		this.prdCD = prdCD;
	}
	
	public String getDiffNo() {
		return diffNo;
	}

	public void setDiffNo(String diffNo) {
		this.diffNo = diffNo;
	}
	
	public String getSaleCD01() {
		return saleCD01;
	}

	public void setSaleCD01(String saleCD01) {
		this.saleCD01 = saleCD01;
	}
	
	public String getSaleCD02() {
		return saleCD02;
	}

	public void setSaleCD02(String saleCD02) {
		this.saleCD02 = saleCD02;
	}
	
	public String getSaleCD03() {
		return saleCD03;
	}

	public void setSaleCD03(String saleCD03) {
		this.saleCD03 = saleCD03;
	}
	
	public String getSaleCD04() {
		return saleCD04;
	}

	public void setSaleCD04(String saleCD04) {
		this.saleCD04 = saleCD04;
	}
	
	public String getSaleCD05() {
		return saleCD05;
	}

	public void setSaleCD05(String saleCD05) {
		this.saleCD05 = saleCD05;
	}
	
	public String getSaleCD06() {
		return saleCD06;
	}

	public void setSaleCD06(String saleCD06) {
		this.saleCD06 = saleCD06;
	}
	
	public String getSaleCD07() {
		return saleCD07;
	}

	public void setSaleCD07(String saleCD07) {
		this.saleCD07 = saleCD07;
	}
	
	public String getSaleCD08() {
		return saleCD08;
	}

	public void setSaleCD08(String saleCD08) {
		this.saleCD08 = saleCD08;
	}
	
	public String getSaleCD09() {
		return saleCD09;
	}

	public void setSaleCD09(String saleCD09) {
		this.saleCD09 = saleCD09;
	}
		
	public String getSaleCD10() {
		return saleCD10;
	}

	public void setSaleCD10(String saleCD10) {
		this.saleCD10 = saleCD10;
	}

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getRegIDNo() {
		return regIDNo;
	}

	public void setRegIDNo(String regIDNo) {
		this.regIDNo = regIDNo;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}

	public String getAuthType() {
		return authType;
	}

	public void setAuthType(String authType) {
		this.authType = authType;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getResSeq() {
		return resSeq;
	}

	public void setResSeq(String resSeq) {
		this.resSeq = resSeq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getNationalinfo() {
		return nationalinfo;
	}

	public void setNationalinfo(String nationalinfo) {
		this.nationalinfo = nationalinfo;
	}

	public String getDI() {
		return DI;
	}

	public void setDI(String dI) {
		DI = dI;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getMobileCo() {
		return mobileCo;
	}

	public void setMobileCo(String mobileCo) {
		this.mobileCo = mobileCo;
	}

	public String getCI() {
		return CI;
	}

	public void setCI(String cI) {
		CI = cI;
	}

	public String getCorpNo() {
		return corpNo;
	}

	public void setCorpNo(String corpNo) {
		this.corpNo = corpNo;
	}

	public String getRspCd() {
		return rspCd;
	}

	public void setRspCd(String rspCd) {
		this.rspCd = rspCd;
	}
	
}
