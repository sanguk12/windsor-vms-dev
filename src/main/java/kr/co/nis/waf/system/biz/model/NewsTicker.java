package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.util.FormatUtil;
import kr.co.nis.waf.util.StringUtil;

public class NewsTicker extends CommonObject implements Model {
	
	private String newsID = "";
	private String newsText = "";
	private String newsStartDate = "";
	private String newsEndDate = "";
	private String URL = "";
	private String useYN = "";
	private String activeFlg = "";
	
	public void clean() {
		
	}

	public void validate(int action) throws Exception {
		try{this.newsStartDate = FormatUtil.convertDate(this.newsStartDate, super.getDateFormatCD(), "YMD", "");} catch (Exception e){this.newsStartDate = "";}
		try{this.newsEndDate = FormatUtil.convertDate(this.newsEndDate, super.getDateFormatCD(), "YMD", "");} catch (Exception e){this.newsEndDate = "";}
	}

	public String getNewsID() {
		return newsID;
	}

	public void setNewsID(String newsID) {
		this.newsID = newsID;
	}

	public String getNewsText() {
		return newsText;
	}

	public void setNewsText(String newsText) {
		this.newsText = newsText;
	}

	public String getNewsStartDate() {
		return newsStartDate;
	}

	public void setNewsStartDate(String newsStartDate) {
		this.newsStartDate = newsStartDate;
	}

	public String getNewsEndDate() {
		return newsEndDate;
	}

	public void setNewsEndDate(String newsEndDate) {
		this.newsEndDate = newsEndDate;
	}

	public String getURL() {
		return URL;
	}

	public void setURL(String uRL) {
		URL = uRL;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

}
