package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class ArticleReply extends CommonObject implements Model {

	private String boardID = null;
	private String articleID = null;
	private String replyID = null;
	private String content = null;
	private String writeUserID = null;
	private String writeDate = null;
	private String writeIP = null;
	private String activeFlg = null;

	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public String getBoardID()
	{
		return boardID;
	}

	public void setBoardID(String boardID)
	{
		this.boardID = boardID;
	}

	public String getArticleID()
	{
		return articleID;
	}

	public void setArticleID(String articleID)
	{
		this.articleID = articleID;
	}

	public String getReplyID()
	{
		return replyID;
	}

	public void setReplyID(String replyID)
	{
		this.replyID = replyID;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public String getWriteUserID()
	{
		return writeUserID;
	}

	public void setWriteUserID(String writeUserID)
	{
		this.writeUserID = writeUserID;
	}

	public String getWriteDate()
	{
		return writeDate;
	}

	public void setWriteDate(String writeDate)
	{
		this.writeDate = writeDate;
	}

	public String getWriteIP()
	{
		return writeIP;
	}

	public void setWriteIP(String writeIP)
	{
		this.writeIP = writeIP;
	}

	public String getActiveFlg()
	{
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg)
	{
		this.activeFlg = activeFlg;
	}
}