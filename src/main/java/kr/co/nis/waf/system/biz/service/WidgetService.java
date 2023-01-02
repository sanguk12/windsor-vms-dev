package kr.co.nis.waf.system.biz.service;

import java.util.List;
import java.util.Map;

import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.system.biz.model.UserWidget;
import kr.co.nis.waf.system.biz.model.UserWidgetList;
import kr.co.nis.waf.system.biz.model.Widget;

public interface WidgetService {

	//public void addWidget(Widget widget) throws Exception;

	//public List findUserWidget(User user) throws Exception;
	
	//public Map getWidgetContent(Map parameter) throws Exception;

	//public void modifyUserWidget(UserWidget userWidget) throws Exception;

	//public void modifyWidget(Widget widget) throws Exception;
	
	//public void removeUserWidget(UserWidget userWidget) throws Exception;
	
	//public void removeWidget(Widget widget) throws Exception;
	
	public void saveUserWidget(UserWidgetList userWidgetList) throws Exception;
}
