package kr.co.nis.waf.system.biz.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.util.StringUtil;

public class Notice extends CommonObject implements Model {
	
	private String noticeID = "";
	private String noticeTitle = "";
	private String startDate = "";
	private String endDate = "";
	private String useYN = "";
	private String doclinkID = "";
	private String width = "";
	private String height = "";
	private String activeFlg = "";
	private String x = "";
	private String y = "";
	
	private String publicID = null;
	private String publicClassCD = null;
	private String publicName = null;
	
	
	public void clean() {
		try {
			this.startDate = StringUtil.unFormat(this.startDate);
		} catch (Exception e){}
		try {
			this.endDate = StringUtil.unFormat(this.endDate);
		} catch (Exception e){}
	}

	
	public void validate(int action) throws Exception {
		// TODO Auto-generated method stub
		
	}


	public Map getParameter(String RFC) throws Exception {
		Map parameter = new HashMap();
		
		if (RFC.equals("ZCWCOMMC05_WCM_159") || RFC.equals("ZCWCOMMC05_WCM_160")){
			parameter.put("NOTICEID", getNoticeID());
			parameter.put("NOTICETITLE", getNoticeTitle());
			parameter.put("STARTDATE", getStartDate());
			parameter.put("ENDDATE", getEndDate());
			parameter.put("DOCLINKID", getDoclinkID());
			parameter.put("USEYN", getUseYN());
			parameter.put("ACTIVEFLG", getActiveFlg());
			//parameter.put("USERID", getUserID());
			parameter.put("WIDTH", getWidth());
			parameter.put("HEIGHT", getHeight());
			parameter.put("X", getX());
			parameter.put("Y", getY());
		}
		else if (RFC.equals("ZCWCOMMC05_WCM_161")){
			parameter.put("NOTICEID", getNoticeID());
		}
		parameter.put("LOGONID", getUserID());
		return parameter;
	}

	public List getParameterList(String RFC) throws Exception {
		List parameterList = new ArrayList();

		if (RFC.equals("ZCWCOMMC05_WCM_159") || RFC.equals("ZCWCOMMC05_WCM_160")) {
			if (this.publicID != null && !(this.publicID.equals(""))){
				 String[] arrPublicId 	 = this.publicID.split(";");
		         String[] arrPublicClassCd = this.publicClassCD.split(";");
		         String[] arrPublicName  = this.publicName.split(";");
		         for (int i=0; i < arrPublicId.length; i++){
					Map record = new HashMap();
					record.put("NOTICEID", getNoticeID());
					record.put("PUBLICID", arrPublicId[i]);
					record.put("PUBLICCLASSCD", ""); //arrPublicClassCd[i]);
					record.put("PUBLICNAME", arrPublicName[i]);
					parameterList.add(record);
				}     
			}
		}
		return parameterList;
	}
	
	public List getReturnParameterKey(String RFC) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public void validate(String RFC) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public String getNoticeID() {
		return noticeID;
	}

	public void setNoticeID(String noticeID) {
		this.noticeID = noticeID;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getDoclinkID() {
		return doclinkID;
	}

	public void setDoclinkID(String doclinkID) {
		this.doclinkID = doclinkID;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getX() {
		return x;
	}

	public void setX(String x) {
		this.x = x;
	}

	public String getY() {
		return y;
	}

	public void setY(String y) {
		this.y = y;
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

	
	
}
