package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class UserWidget extends CommonObject implements Model {
	
	private String widgetID = "";
	private String width = "0";
	private String height = "0";
	private String x = "0";
	private String y = "0";
	
	private String activeFlg = "";
	
	public void clean() {
		
	}

	public void validate(int action) throws Exception {

	}

	public String getWidgetID() {
		return widgetID;
	}

	public void setWidgetID(String widgetID) {
		this.widgetID = widgetID;
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

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	
	
	
}
