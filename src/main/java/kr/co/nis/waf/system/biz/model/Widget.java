package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.util.StringUtil;

public class Widget extends CommonObject implements Model {
	
	private String widgetID = "";
	private String widgetName = "";
	private String titleScript = "";
	private String bodyScript = "";
	private String width = "0";
	private String height = "0";
	private String x = "0";
	private String y = "0";
	private String refreshYN = "";
	private String interval = "0";
	private String useYN = "";
	private String remark = "";
	private String loadMethod = "";
	private String activeFlg = "";
	private String partnerID = "";
	
	public void clean() {
		try {
			this.width = StringUtil.unFormatNum(this.width);
			if (this.width.equals("")) this.width = "0";
		} catch (Exception e){this.width = "0";}
		try {
			this.height = StringUtil.unFormatNum(this.height);
			if (this.height.equals("")) this.height = "0";
		} catch (Exception e){this.height = "0";}
		try {
			this.x = StringUtil.unFormatNum(this.x);
			if (this.x.equals("")) this.x = "0";
		} catch (Exception e){this.x = "0";}
		try {
			this.y = StringUtil.unFormatNum(this.y);
			if (this.y.equals("")) this.y = "0";
		} catch (Exception e){this.y = "0";}
		try {
			this.interval = StringUtil.unFormatNum(this.interval);
			if (this.interval.equals("")) this.interval = "0";
		} catch (Exception e){this.interval = "0";}
	}

	public void validate(int action) throws Exception {

	}

	public String getWidgetID() {
		return widgetID;
	}

	public void setWidgetID(String widgetID) {
		this.widgetID = widgetID;
	}

	public String getWidgetName() {
		return widgetName;
	}

	public void setWidgetName(String widgetName) {
		this.widgetName = widgetName;
	}

	
	public String getTitleScript() {
		return titleScript;
	}

	public void setTitleScript(String titleScript) {
		this.titleScript = titleScript;
	}

	public String getBodyScript() {
		return bodyScript;
	}

	public void setBodyScript(String bodyScript) {
		this.bodyScript = bodyScript;
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

	public String getRefreshYN() {
		return refreshYN;
	}

	public void setRefreshYN(String refreshYN) {
		this.refreshYN = refreshYN;
	}

	public String getInterval() {
		return interval;
	}

	public void setInterval(String interval) {
		this.interval = interval;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getPartnerID() {
		return partnerID;
	}

	public void setPartnerID(String partnerID) {
		this.partnerID = partnerID;
	}

	public String getLoadMethod() {
		return loadMethod;
	}

	public void setLoadMethod(String loadMethod) {
		this.loadMethod = loadMethod;
	}

	
	
}
