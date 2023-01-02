package com.kia.key.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.StringUtil;

public class GKEY01MT extends CommonObject implements Model {

	private String keymanID = "";
	private String venueCD = "";
	private String keymanNm = "";
	private String keymanTypeCD = "";
	private String regIDNo = "";
	private String birthDate = "";
	private String addr = "";
	private String phoneNo = "";
	private String bankCD = "";
	private String accountNo = "";
	private String holderNm = "";
	private String dutyCD = "";
	private String note = "";
	private String PkeymanYN = "";
	private String activeYN = "";
	private String oldKeymanID = "";
	private String lApplyDate = "";
	private String[] activeYNs = null;
	private String docFinshFl = "";
	private String docMngFl = "";					// 키맨서류보관형태
	private String licenceChkYn = "";
	
	//GKEY02MT
	private String requestDate = "";
	private String requestSeq = "";
	private String requestTpCD = "";
	private String empID = "";
	private String requestStateCD = "";
	private String lApprLevelNo = "";
	private String accreErrCommt = "";
	private String accreDate = "";
	private String apprTpID = "";
	private String mobileRegYN = "";
	private String[] keymanIDs = null;
	private String[] venueCDs = null;
	private String[] keymanNms = null;
	private String[] keymanTypeCDs = null;
	private String[] regIDNos = null;
	private String[] birthDates = null;
	private String[] addrs = null;
	private String[] phoneNos = null;
	private String[] bankCDs = null;
	private String[] emailAddrs = null;
	private String[] accountNos = null;
	private String[] holderNms = null;
	private String[] dutyCDs = null;
	private String[] notes = null;
	private String[] PkeymanYNs = null;
	private String[] requestTpCDs = null;
	private String[] requestDates = null;
	private String[] requestSeqs = null;
	private String[] accreErrCommts = null;
	private String[] licenceChkYns = null;
	private String[] mobileRegYNs = null;
	
	private String requestTpCDName = "";
	private String venueNm = "";
	private String[] requestTpCDNames = null;
	private String[] venueNms = null;
	
	//GKEY03MT
	private String levelNo = "";
	private String apprCommt = "";
	private String apprGrpNm = "";
	private String commt = "";
	private String lastApprYN = "";	//최종승인여부
	private String apprStateCD = "";
	private String apprDate = "";
	private String emailAddr = "";
	private String levelNos[] = null;
	private String apprCommts[] = null;
	private String lastApprYNs[] = null;

	public void clean() {
		try{lApplyDate = StringUtil.unFormat(lApplyDate);}catch(Exception e){}
		try{requestDate = StringUtil.unFormat(requestDate);}catch(Exception e){}
		try{accreDate = StringUtil.unFormat(accreDate);}catch(Exception e){}
		try{apprDate = StringUtil.unFormat(apprDate);}catch(Exception e){}
	}
	
	public void validate(int action) throws Exception {
		
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.keymanIDs != null) {
			 size = this.keymanIDs.length;
		}
		return size;
	}

	public GKEY01MT getObject_approval(int index) {
		GKEY01MT vo = new GKEY01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setRequestDate(this.requestDates[index]);}catch(Exception e){}
			try{vo.setRequestSeq(this.requestSeqs[index]);}catch(Exception e){}
			try{vo.setLevelNo(this.levelNos[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setLastApprYN(this.lastApprYNs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GKEY01MT getObject_reject(int index) {
		GKEY01MT vo = new GKEY01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setEmpNm(this.getEmpNm());}catch(Exception e){}
			try{vo.setEmailAddr(this.getEmailAddr());}catch(Exception e){}
			try{vo.setClientDate(this.getClientDate());}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setRequestDate(this.requestDates[index]);}catch(Exception e){}
			try{vo.setRequestSeq(this.requestSeqs[index]);}catch(Exception e){}
			try{vo.setApprCommt(this.apprCommts[index]);}catch(Exception e){}
			try{vo.setRequestTpCDName(this.requestTpCDNames[index]);}catch(Exception e){}
			try{vo.setVenueNm(this.venueNms[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setKeymanNm(this.keymanNms[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GKEY01MT getObject_completeAccre(int index) {
		GKEY01MT vo = new GKEY01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setKeymanNm(this.keymanNms[index]);}catch(Exception e){}
			try{vo.setKeymanTypeCD(this.keymanTypeCDs[index]);}catch(Exception e){}
			try{vo.setRegIDNo(this.regIDNos[index]);}catch(Exception e){}
			try{vo.setBirthDate(this.birthDates[index]);}catch(Exception e){}
			try{vo.setAddr(this.addrs[index]);}catch(Exception e){}
			try{vo.setPhoneNo(this.phoneNos[index]);}catch(Exception e){}
			try{vo.setBankCD(this.bankCDs[index]);}catch(Exception e){}
			try{vo.setAccountNo(this.accountNos[index]);}catch(Exception e){}
			try{vo.setHolderNm(this.holderNms[index]);}catch(Exception e){}
			try{vo.setDutyCD(this.dutyCDs[index]);}catch(Exception e){}
			try{vo.setEmailAddr(this.emailAddrs[index]);}catch(Exception e){}
			try{vo.setNote(this.notes[index]);}catch(Exception e){}
			try{vo.setPkeymanYN(this.PkeymanYNs[index]);}catch(Exception e){}
			try{vo.setRequestDate(this.requestDates[index]);}catch(Exception e){}
			try{vo.setRequestSeq(this.requestSeqs[index]);}catch(Exception e){}
			try{vo.setAccreErrCommt(this.accreErrCommts[index]);}catch(Exception e){}
			try{vo.setRequestTpCD(this.requestTpCDs[index]);}catch(Exception e){}
			try{vo.setLicenceChkYn(this.licenceChkYns[index]);}catch(Exception e){}
		}
		return vo;
	}

	public GKEY01MT getObject_errorAccre(int index) {
		GKEY01MT vo = new GKEY01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setClientDate(this.getClientDate());}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setRequestDate(this.requestDates[index]);}catch(Exception e){}
			try{vo.setRequestSeq(this.requestSeqs[index]);}catch(Exception e){}
			try{vo.setAccreErrCommt(this.accreErrCommts[index]);}catch(Exception e){}
			try{vo.setRequestTpCDName(this.requestTpCDNames[index]);}catch(Exception e){}
			try{vo.setVenueNm(this.venueNms[index]);}catch(Exception e){}
			try{vo.setVenueCD(this.venueCDs[index]);}catch(Exception e){}
			try{vo.setKeymanNm(this.keymanNms[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public GKEY01MT getObject_activeYN(int index) {
		GKEY01MT vo = new GKEY01MT();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setUserID(this.getUserID());}catch(Exception e){}
			try{vo.setEmpID(this.getEmpID());}catch(Exception e){}
			try{vo.setKeymanID(this.keymanIDs[index]);}catch(Exception e){}
			try{vo.setActiveYN(this.activeYNs[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public String getRequestTpCDName() {
		return requestTpCDName;
	}

	public void setRequestTpCDName(String requestTpCDName) {
		this.requestTpCDName = requestTpCDName;
	}

	public String getVenueNm() {
		return venueNm;
	}

	public void setVenueNm(String venueNm) {
		this.venueNm = venueNm;
	}

	public String[] getRequestTpCDNames() {
		return requestTpCDNames;
	}

	public void setRequestTpCDNames(String[] requestTpCDNames) {
		this.requestTpCDNames = requestTpCDNames;
	}

	public String[] getVenueNms() {
		return venueNms;
	}

	public void setVenueNms(String[] venueNms) {
		this.venueNms = venueNms;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getKeymanID() {
		return keymanID;
	}

	public void setKeymanID(String keymanID) {
		this.keymanID = keymanID;
	}

	public String getVenueCD() {
		return venueCD;
	}

	public void setVenueCD(String venueCD) {
		this.venueCD = venueCD;
	}

	public String getKeymanNm() {
		return keymanNm;
	}

	public void setKeymanNm(String keymanNm) {
		this.keymanNm = keymanNm;
	}

	public String getKeymanTypeCD() {
		return keymanTypeCD;
	}

	public void setKeymanTypeCD(String keymanTypeCD) {
		this.keymanTypeCD = keymanTypeCD;
	}

	public String getRegIDNo() {
		return regIDNo;
	}

	public void setRegIDNo(String regIDNo) {
		this.regIDNo = regIDNo;
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

	public String getBankCD() {
		return bankCD;
	}

	public void setBankCD(String bankCD) {
		this.bankCD = bankCD;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getHolderNm() {
		return holderNm;
	}

	public void setHolderNm(String holderNm) {
		this.holderNm = holderNm;
	}

	public String getDutyCD() {
		return dutyCD;
	}

	public void setDutyCD(String dutyCD) {
		this.dutyCD = dutyCD;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getPkeymanYN() {
		return PkeymanYN;
	}

	public void setPkeymanYN(String pkeymanYN) {
		PkeymanYN = pkeymanYN;
	}

	public String getActiveYN() {
		return activeYN;
	}

	public void setActiveYN(String activeYN) {
		this.activeYN = activeYN;
	}

	public String getLicenceChkYn() {
		return licenceChkYn;
	}
	
	public void setLicenceChkYn(String licenceChkYn) {
		this.licenceChkYn = licenceChkYn;
	}
	
	public String getOldKeymanID() {
		return oldKeymanID;
	}

	public void setOldKeymanID(String oldKeymanID) {
		this.oldKeymanID = oldKeymanID;
	}

	public String getlApplyDate() {
		return lApplyDate;
	}

	public void setlApplyDate(String lApplyDate) {
		this.lApplyDate = lApplyDate;
	}
	
	public String[] getActiveYNs() {
		return activeYNs;
	}

	public void setActiveYNs(String[] activeYNs) {
		this.activeYNs = activeYNs;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getRequestSeq() {
		return requestSeq;
	}

	public void setRequestSeq(String requestSeq) {
		this.requestSeq = requestSeq;
	}

	public String[] getAccreErrCommts() {
		return accreErrCommts;
	}

	public void setAccreErrCommts(String[] accreErrCommts) {
		this.accreErrCommts = accreErrCommts;
	}

	public String getRequestTpCD() {
		return requestTpCD;
	}

	public void setRequestTpCD(String requestTpCD) {
		this.requestTpCD = requestTpCD;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	public String getRequestStateCD() {
		return requestStateCD;
	}

	public void setRequestStateCD(String requestStateCD) {
		this.requestStateCD = requestStateCD;
	}

	public String getlApprLevelNo() {
		return lApprLevelNo;
	}

	public void setlApprLevelNo(String lApprLevelNo) {
		this.lApprLevelNo = lApprLevelNo;
	}

	public String getAccreErrCommt() {
		return accreErrCommt;
	}

	public void setAccreErrCommt(String accreErrCommt) {
		this.accreErrCommt = accreErrCommt;
	}

	public String getAccreDate() {
		return accreDate;
	}

	public void setAccreDate(String accreDate) {
		this.accreDate = accreDate;
	}
	
	public String getApprTpID() {
		return apprTpID;
	}

	public void setApprTpID(String apprTpID) {
		this.apprTpID = apprTpID;
	}

	public String[] getKeymanIDs() {
		return keymanIDs;
	}

	public void setKeymanIDs(String[] keymanIDs) {
		this.keymanIDs = keymanIDs;
	}

	public String[] getVenueCDs() {
		return venueCDs;
	}

	public void setVenueCDs(String[] venueCDs) {
		this.venueCDs = venueCDs;
	}

	public String[] getKeymanNms() {
		return keymanNms;
	}

	public void setKeymanNms(String[] keymanNms) {
		this.keymanNms = keymanNms;
	}

	public String[] getKeymanTypeCDs() {
		return keymanTypeCDs;
	}

	public void setKeymanTypeCDs(String[] keymanTypeCDs) {
		this.keymanTypeCDs = keymanTypeCDs;
	}

	public String[] getRegIDNos() {
		return regIDNos;
	}

	public void setRegIDNos(String[] regIDNos) {
		this.regIDNos = regIDNos;
	}

	public String[] getBirthDates() {
		return birthDates;
	}

	public void setBirthDates(String[] birthDates) {
		this.birthDates = birthDates;
	}

	public String[] getAddrs() {
		return addrs;
	}

	public void setAddrs(String[] addrs) {
		this.addrs = addrs;
	}

	public String[] getPhoneNos() {
		return phoneNos;
	}

	public void setPhoneNos(String[] phoneNos) {
		this.phoneNos = phoneNos;
	}

	public String[] getBankCDs() {
		return bankCDs;
	}

	public void setBankCDs(String[] bankCDs) {
		this.bankCDs = bankCDs;
	}

	public String[] getAccountNos() {
		return accountNos;
	}

	public void setAccountNos(String[] accountNos) {
		this.accountNos = accountNos;
	}

	public String[] getHolderNms() {
		return holderNms;
	}

	public void setHolderNms(String[] holderNms) {
		this.holderNms = holderNms;
	}

	public String[] getDutyCDs() {
		return dutyCDs;
	}

	public void setDutyCDs(String[] dutyCDs) {
		this.dutyCDs = dutyCDs;
	}
	
	public String[] getEmailAddrs() {
		return emailAddrs;
	}

	public void setEmailAddrs(String[] emailAddrs) {
		this.emailAddrs = emailAddrs;
	}

	public String[] getNotes() {
		return notes;
	}

	public void setNotes(String[] notes) {
		this.notes = notes;
	}

	public String[] getPkeymanYNs() {
		return PkeymanYNs;
	}

	public void setPkeymanYNs(String[] pkeymanYNs) {
		PkeymanYNs = pkeymanYNs;
	}
	
	public String[] getRequestTpCDs() {
		return requestTpCDs;
	}

	public void setRequestTpCDs(String[] requestTpCDs) {
		this.requestTpCDs = requestTpCDs;
	}
	
	public String[] getLicenceChkYns() {
		return licenceChkYns;
	}

	public void setLicenceChkYns(String[] licenceChkYns) {
		licenceChkYns = licenceChkYns;
	}
	
	public String[] getRequestDates() {
		return requestDates;
	}

	public void setRequestDates(String[] requestDates) {
		this.requestDates = requestDates;
	}

	public String[] getRequestSeqs() {
		return requestSeqs;
	}

	public void setRequestSeqs(String[] requestSeqs) {
		this.requestSeqs = requestSeqs;
	}

	public String getLevelNo() {
		return levelNo;
	}

	public void setLevelNo(String levelNo) {
		this.levelNo = levelNo;
	}
	
	public String getApprCommt() {
		return apprCommt;
	}

	public void setApprCommt(String apprCommt) {
		this.apprCommt = apprCommt;
	}

	public String getApprGrpNm() {
		return apprGrpNm;
	}

	public void setApprGrpNm(String apprGrpNm) {
		this.apprGrpNm = apprGrpNm;
	}

	public String getCommt() {
		return commt;
	}

	public void setCommt(String commt) {
		this.commt = commt;
	}

	public String getLastApprYN() {
		return lastApprYN;
	}

	public void setLastApprYN(String lastApprYN) {
		this.lastApprYN = lastApprYN;
	}

	public String getApprStateCD() {
		return apprStateCD;
	}

	public void setApprStateCD(String apprStateCD) {
		this.apprStateCD = apprStateCD;
	}

	public String getApprDate() {
		return apprDate;
	}

	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}

	public String[] getLevelNos() {
		return levelNos;
	}

	public void setLevelNos(String[] levelNos) {
		this.levelNos = levelNos;
	}

	public String[] getApprCommts() {
		return apprCommts;
	}

	public void setApprCommts(String[] apprCommts) {
		this.apprCommts = apprCommts;
	}

	public String[] getLastApprYNs() {
		return lastApprYNs;
	}

	public void setLastApprYNs(String[] lastApprYNs) {
		this.lastApprYNs = lastApprYNs;
	}

	public String getDocFinshFl() {
		return docFinshFl;
	}

	public void setDocFinshFl(String docFinshFl) {
		this.docFinshFl = docFinshFl;
	}

	public String getDocMngFl() {
		return docMngFl;
	}

	public void setDocMngFl(String docMngFl) {
		this.docMngFl = docMngFl;
	}

	public String getMobileRegYN() {
		return mobileRegYN;
	}

	public void setMobileRegYN(String mobileRegYN) {
		this.mobileRegYN = mobileRegYN;
	}

	public String[] getMobileRegYNs() {
		return mobileRegYNs;
	}

	public void setMobileRegYNs(String[] mobileRegYNs) {
		this.mobileRegYNs = mobileRegYNs;
	}
	
}