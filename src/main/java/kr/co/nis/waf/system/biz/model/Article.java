package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class Article extends CommonObject implements Model{
	
	private String boardID = null;
	private String articleID = null;
	private String title = null;
	private String keyWord = null;	
	private String content = null;
	private String ref = null;
	private int refStep = 0;
	private int refNo = 0;
	private String bulletinTermCD = null;
	private String bulletinTermName = null;
	private int reading = 0;
	private String writeUserID = null;
	private String writeUserName = null;
	private String writeDate = null;
	private String writeIP = null;
	private String email = null;
	private String homepage = null;
	private int listCount = 0;
	private String boardTypeCD = null;
	private int pageNum = 0;
	private int pageSize = 0;
	private int page= 0;
	private int superPage= 0;
	
	private int recordPerPage = 0;
            
	private int rn = 0;
	private String isNew = null;
	private String remark = null;
	private int seq = 0;
	
	private String writeReplyUserID = null;
	private String writeReplyUserName = null;
	private String writeReplyDate = null;
	
	private int replyCnt = 0;
	private int recommendCount = 0;
	
	private String viewYN = "";
	private String topYN = "";
	private String hotYN = "";
	
	private String publicID = "";
	private String publicClassCD = "";
	private String publicName = "";
	
	private String writeAuth = "";
	
	private String boardPgmID = "";
	private String boardIDNotice = "";
	
	private String activeFlg = "";
	
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public String getBoardID() {
		return boardID;
	}

	public void setBoardID(String boardID) {
		this.boardID = boardID;
	}

	public String getArticleID() {
		return articleID;
	}

	public void setArticleID(String articleID) {
		this.articleID = articleID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRef() {
		return ref;
	}

	public void setRef(String ref) {
		this.ref = ref;
	}

	public int getRefStep() {
		return refStep;
	}

	public void setRefStep(int refStep) {
		this.refStep = refStep;
	}

	public int getRefNo() {
		return refNo;
	}

	public void setRefNo(int refNo) {
		this.refNo = refNo;
	}

	public String getBulletinTermCD() {
		return bulletinTermCD;
	}

	public void setBulletinTermCD(String bulletinTermCD) {
		this.bulletinTermCD = bulletinTermCD;
	}

	public String getBulletinTermName() {
		return bulletinTermName;
	}

	public void setBulletinTermName(String bulletinTermName) {
		this.bulletinTermName = bulletinTermName;
	}

	public int getReading() {
		return reading;
	}

	public void setReading(int reading) {
		this.reading = reading;
	}

	public String getWriteUserID() {
		return writeUserID;
	}

	public void setWriteUserID(String writeUserID) {
		this.writeUserID = writeUserID;
	}

	public String getWriteUserName() {
		return writeUserName;
	}

	public void setWriteUserName(String writeUserName) {
		this.writeUserName = writeUserName;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public String getWriteIP() {
		return writeIP;
	}

	public void setWriteIP(String writeIP) {
		this.writeIP = writeIP;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public int getListCount() {
		return listCount;
	}

	public void setListCount(int listCount) {
		this.listCount = listCount;
	}

	public String getBoardTypeCD() {
		return boardTypeCD;
	}

	public void setBoardTypeCD(String boardTypeCD) {
		this.boardTypeCD = boardTypeCD;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getSuperPage() {
		return superPage;
	}

	public void setSuperPage(int superPage) {
		this.superPage = superPage;
	}

	public int getRecordPerPage() {
		return recordPerPage;
	}

	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}

	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}

	public String getIsNew() {
		return isNew;
	}

	public void setIsNew(String isNew) {
		this.isNew = isNew;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWriteReplyUserID() {
		return writeReplyUserID;
	}

	public void setWriteReplyUserID(String writeReplyUserID) {
		this.writeReplyUserID = writeReplyUserID;
	}

	public String getWriteReplyUserName() {
		return writeReplyUserName;
	}

	public void setWriteReplyUserName(String writeReplyUserName) {
		this.writeReplyUserName = writeReplyUserName;
	}

	public String getWriteReplyDate() {
		return writeReplyDate;
	}

	public void setWriteReplyDate(String writeReplyDate) {
		this.writeReplyDate = writeReplyDate;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	public int getRecommendCount() {
		return recommendCount;
	}

	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}

	public String getViewYN() {
		return viewYN;
	}

	public void setViewYN(String viewYN) {
		this.viewYN = viewYN;
	}

	public String getTopYN() {
		return topYN;
	}

	public void setTopYN(String topYN) {
		this.topYN = topYN;
	}

	public String getHotYN() {
		return hotYN;
	}

	public void setHotYN(String hotYN) {
		this.hotYN = hotYN;
	}

	public String getPublicID() {
		return publicID;
	}

	public void setPublicID(String publicID) {
		this.publicID = publicID;
	}

	public String getPublicClassCD() {
		return publicClassCD;
	}

	public void setPublicClassCD(String publicClassCD) {
		this.publicClassCD = publicClassCD;
	}

	public String getPublicName() {
		return publicName;
	}

	public void setPublicName(String publicName) {
		this.publicName = publicName;
	}

	public String getWriteAuth() {
		return writeAuth;
	}

	public void setWriteAuth(String writeAuth) {
		this.writeAuth = writeAuth;
	}

	public String getBoardPgmID() {
		return boardPgmID;
	}

	public void setBoardPgmID(String boardPgmID) {
		this.boardPgmID = boardPgmID;
	}

	public String getBoardIDNotice() {
		return boardIDNotice;
	}

	public void setBoardIDNotice(String boardIDNotice) {
		this.boardIDNotice = boardIDNotice;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

}