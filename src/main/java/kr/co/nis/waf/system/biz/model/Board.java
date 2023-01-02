package kr.co.nis.waf.system.biz.model;

import java.util.ArrayList;
import java.util.List;

import kr.co.nis.waf.system.biz.model.BoardAuthorityList;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class Board extends CommonObject implements Model {
	
	private String boardID = "";
	private String boardName = "";
	private String boardTitle = "";
	private String boardTypeCD = "";
	private String remark = "";
	private String useYN = "";
	private String mgtUserID = "";
	private String isBulletinTerm = "";
	private String isAttachFile = "";
	private String isAnswer = "";
	private String isReply = "";
	private String isView = "";
	private String isTop = "";
	private String isHot = "";
	private String isRecommend = "";
	private String isPublic = "";
	
	List boardAuthority = null;
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public void load(BoardAuthorityList boardWriteAuthorityList) throws Exception {
		
		boardAuthority = new ArrayList();
		
		for(int i=0; i < boardWriteAuthorityList.getSize(); i++) {
			boardAuthority.add(boardWriteAuthorityList.getObject(i));
		}
	}
	
	public void validate() throws Exception {
		//throw new InputRequiredException("");		
	}
	
	public String getBoardID() {
		return boardID;
	}

	public void setBoardID(String boardID) {
		this.boardID = boardID;
	}

	public String getBoardName() {
		return boardName;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getIsBulletinTerm() {
		return isBulletinTerm;
	}

	public void setIsBulletinTerm(String isBulletinTerm) {
		this.isBulletinTerm = isBulletinTerm;
	}

	public String getIsAttachFile() {
		return isAttachFile;
	}

	public void setIsAttachFile(String isAttachFile) {
		this.isAttachFile = isAttachFile;
	}

	public String getIsAnswer() {
		return isAnswer;
	}

	public void setIsAnswer(String isAnswer) {
		this.isAnswer = isAnswer;
	}

	public String getIsReply() {
		return isReply;
	}

	public void setIsReply(String isReply) {
		this.isReply = isReply;
	}

	public String getBoardTypeCD() {
		return boardTypeCD;
	}

	public void setBoardTypeCD(String boardTypeCD) {
		this.boardTypeCD = boardTypeCD;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getMgtUserID() {
		return mgtUserID;
	}

	public void setMgtUserID(String mgtUserID) {
		this.mgtUserID = mgtUserID;
	}

	public void setRecordPerPage(int recordPerPage) {
		recordPerPage = recordPerPage;
	}

	public String getIsView() {
		return isView;
	}

	public void setIsView(String isView) {
		this.isView = isView;
	}

	public String getIsTop() {
		return isTop;
	}

	public void setIsTop(String isTop) {
		this.isTop = isTop;
	}

	public String getIsHot() {
		return isHot;
	}

	public void setIsHot(String isHot) {
		this.isHot = isHot;
	}

	public String getIsRecommend() {
		return isRecommend;
	}

	public void setIsRecommend(String isRecommend) {
		this.isRecommend = isRecommend;
	}

	public String getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}

	public List getBoardAuthority() {
		return boardAuthority;
	}

	public void setBoardAuthority(List boardAuthority) {
		this.boardAuthority = boardAuthority;
	}
}