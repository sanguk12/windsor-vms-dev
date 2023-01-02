package com.kia.key.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.util.StringUtil;

public class GKEY05MT extends CommonObject implements Model {

	private String keymanID = "";
	private String keymanDocTpCd = "";
	private String docWorkDate = "";
	private String keymanPrgsCd = "";
	private String docComment = "";
	private String signDocLinkID1 = "";
	private String signDocLinkID2 = "";
	private String fileDocLink = "";
	private String regID = "";
	private String regDate = "";
	private String chgID = "";
	private String chgDate = "";
	
	
	public void clean() {

	}
	
	public void validate(int action) throws Exception {
		
	}

	public String getKeymanID() {
		return keymanID;
	}

	public void setKeymanID(String keymanID) {
		this.keymanID = keymanID;
	}

	public String getKeymanDocTpCd() {
		return keymanDocTpCd;
	}

	public void setKeymanDocTpCd(String keymanDocTpCd) {
		this.keymanDocTpCd = keymanDocTpCd;
	}

	public String getDocWorkDate() {
		return docWorkDate;
	}

	public void setDocWorkDate(String docWorkDate) {
		this.docWorkDate = docWorkDate;
	}

	public String getKeymanPrgsCd() {
		return keymanPrgsCd;
	}

	public void setKeymanPrgsCd(String keymanPrgsCd) {
		this.keymanPrgsCd = keymanPrgsCd;
	}

	public String getSignDocLinkID1() {
		return signDocLinkID1;
	}

	public void setSignDocLinkID1(String signDocLinkID1) {
		this.signDocLinkID1 = signDocLinkID1;
	}

	public String getSignDocLinkID2() {
		return signDocLinkID2;
	}

	public void setSignDocLinkID2(String signDocLinkID2) {
		this.signDocLinkID2 = signDocLinkID2;
	}

	public String getFileDocLink() {
		return fileDocLink;
	}

	public void setFileDocLink(String fileDocLink) {
		this.fileDocLink = fileDocLink;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getChgID() {
		return chgID;
	}

	public void setChgID(String chgID) {
		this.chgID = chgID;
	}

	public String getChgDate() {
		return chgDate;
	}

	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}

	public String getDocComment() {
		return docComment;
	}

	public void setDocComment(String docComment) {
		this.docComment = docComment;
	}
	
	
}