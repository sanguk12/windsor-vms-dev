package kr.co.nis.waf.system.cms.model;

import kr.co.nis.waf.system.cms.model.DocLink;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class DocLink extends CommonObject implements Model {
	
	private String[] docLinks = null;
	private String docLinkID = "";
	private String fileName = "";
	private String fileTypeCD = "";
	private String fileSize = "";
	private String fileUrl = "";
	private String linkDivCD = "";
	private String linkID = "";
	private String linkID1 = "";
	private String linkID2 = "";
	private String linkID3 = "";
	private String linkID4 = "";
	private String linkID5 = "";
	private String remark = "";
	private String uuID = "";
	
	public void clean() throws Exception {
	}
	
	public void validate(int action) throws Exception {
	}
	
	public int getSize() {
		int size = 0 ;
		if (this.docLinks != null) {
			 size = this.docLinks.length;
		}
		return size;
	}
	
	public DocLink getObject(int index) {
		DocLink vo = new DocLink();
		if (getSize() > index) {
			try{vo.setCompanyID(this.getCompanyID());}catch(Exception e){}
			try{vo.setDocLinkID(this.docLinks[index]);}catch(Exception e){}
			try{vo.setLinkDivCD(this.getLinkDivCD());}catch(Exception e){}
			try{vo.setLinkID(this.getLinkID());}catch(Exception e){}
			try{vo.setLinkID1(this.getLinkID1());}catch(Exception e){}
			try{vo.setLinkID2(this.getLinkID2());}catch(Exception e){}
			try{vo.setLinkID3(this.getLinkID3());}catch(Exception e){}
			try{vo.setLinkID4(this.getLinkID4());}catch(Exception e){}
			try{vo.setLinkID5(this.getLinkID5());}catch(Exception e){}
		}
		return vo;
	}
	
	public String getUuID() {
		return uuID;
	}

	public void setUuID(String uuID) {
		this.uuID = uuID;
	}
	
	public String[] getDocLinks() {
		return docLinks;
	}
	
	public void setDocLinks(String[] docLinks) {
		this.docLinks = docLinks;
	}
	
	public String getDocLinkID() {
		return docLinkID;
	}
	
	public void setDocLinkID(String docLinkID) {
		this.docLinkID = docLinkID;
	}
	
	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileTypeCD() {
		return fileTypeCD;
	}
	
	public void setFileTypeCD(String fileTypeCD) {
		this.fileTypeCD = fileTypeCD;
	}
	
	public String getFileSize() {
		return fileSize;
	}
	
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	
	public String getFileUrl() {
		return fileUrl;
	}
	
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	
	public String getLinkDivCD() {
		return linkDivCD;
	}
	
	public void setLinkDivCD(String linkDivCD) {
		this.linkDivCD = linkDivCD;
	}
	
	public String getLinkID() {
		return linkID;
	}
	
	public void setLinkID(String linkID) {
		this.linkID = linkID;
	}
	
	public String getLinkID1() {
		return linkID1;
	}

	public void setLinkID1(String linkID1) {
		this.linkID1 = linkID1;
	}

	public String getLinkID2() {
		return linkID2;
	}

	public void setLinkID2(String linkID2) {
		this.linkID2 = linkID2;
	}

	public String getLinkID3() {
		return linkID3;
	}

	public void setLinkID3(String linkID3) {
		this.linkID3 = linkID3;
	}

	public String getLinkID4() {
		return linkID4;
	}

	public void setLinkID4(String linkID4) {
		this.linkID4 = linkID4;
	}

	public String getLinkID5() {
		return linkID5;
	}

	public void setLinkID5(String linkID5) {
		this.linkID5 = linkID5;
	}

	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}
}