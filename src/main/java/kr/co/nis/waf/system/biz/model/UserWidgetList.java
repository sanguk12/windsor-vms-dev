package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.biz.model.UserWidget;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class UserWidgetList extends CommonObject implements Model {
	
	private String[] widgetID = null;
	private String[] width = null;
	private String[] height = null;
	private String[] x = null;
	private String[] y = null;
	private String[] activeFlg = null;
	
	public void clean() {
		
	}

	public void validate(int action) throws Exception {

	}

	public int getSize() {
		int size = 0 ;
		
		if (this.widgetID != null) {
			 size = this.widgetID.length;
		}
		
		return size;
	}

	public UserWidget getObject(int index) {
		
		UserWidget userWidget = new UserWidget();
		if (getSize() > index) {
			
			userWidget.setCompanyID(super.getCompanyID());
			userWidget.setUserID(super.getUserID());
			try{userWidget.setWidgetID(this.widgetID[index]);}catch(Exception e){};
			try{userWidget.setWidth(this.width[index]);}catch(Exception e){};
			try{userWidget.setHeight(this.height[index]);}catch(Exception e){};
			try{userWidget.setX(this.x[index]);}catch(Exception e){};
			try{userWidget.setY(this.y[index]);}catch(Exception e){};
			try{userWidget.setActiveFlg(this.activeFlg[index]);}catch(Exception e){};
		}
		
		return userWidget;
	}

	public String[] getWidgetID() {
		return widgetID;
	}

	public void setWidgetID(String[] widgetID) {
		this.widgetID = widgetID;
	}

	public String[] getWidth() {
		return width;
	}

	public void setWidth(String[] width) {
		this.width = width;
	}

	public String[] getHeight() {
		return height;
	}

	public void setHeight(String[] height) {
		this.height = height;
	}

	public String[] getX() {
		return x;
	}

	public void setX(String[] x) {
		this.x = x;
	}

	public String[] getY() {
		return y;
	}

	public void setY(String[] y) {
		this.y = y;
	}

	public String[] getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String[] activeFlg) {
		this.activeFlg = activeFlg;
	}
	
	
	
}
