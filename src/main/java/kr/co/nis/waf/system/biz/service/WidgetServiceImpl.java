package kr.co.nis.waf.system.biz.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.UserWidget;
import kr.co.nis.waf.system.biz.model.UserWidgetList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("widgetService")
public class WidgetServiceImpl implements WidgetService {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void saveUserWidget(UserWidgetList userWidgetList) throws Exception {
		for (int i=0; i<userWidgetList.getSize(); i++){
			UserWidget userWidget = userWidgetList.getObject(i);
			
			if (userWidget.getActiveFlg().equals("U")) {
				if (simpleDao.queryForInt("system.userWidgetCount.select", userWidget) == 0) {
					//F_UserWidget
					simpleDao.insert("CMP0101501I", userWidget);
				}
				else {
					//F_UserWidget
					simpleDao.update("CMP0101502U", userWidget);
				}
			}
			else if (userWidget.getActiveFlg().equals("D")){
				//F_UserWidget
				simpleDao.delete("CMP0101503D", userWidget);
			}
		}
	}
}