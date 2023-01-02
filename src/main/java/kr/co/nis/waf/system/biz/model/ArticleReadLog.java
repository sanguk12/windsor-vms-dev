package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class ArticleReadLog extends CommonObject implements Model {
	
	private String boardID = "";
	private String articleID = "";
	private String readDate = "";
	private String downloadDate = "";
	
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

	public String getReadDate()
	{
		return readDate;
	}

	public void setReadDate(String readDate)
	{
		this.readDate = readDate;
	}

	public String getDownloadDate()
	{
		return downloadDate;
	}

	public void setDownloadDate(String downloadDate)
	{
		this.downloadDate = downloadDate;
	}	
}