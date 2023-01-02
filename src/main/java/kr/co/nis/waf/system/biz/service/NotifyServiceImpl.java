package kr.co.nis.waf.system.biz.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.Notify;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("notifyService")
public class NotifyServiceImpl implements NotifyService {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	public void saveNotify_Master(Notify notify) throws Exception {
		simpleDao.update("CMP04001A02U", notify);
		
		for(int i=0; i<notify.getSize(); i++) {
			if("I".equals(notify.getObject(i).getActiveFlg())) {
				simpleDao.insert("CMP04001A01I", notify.getObject(i));
			}
			else if("U".equals(notify.getObject(i).getActiveFlg())) {
				simpleDao.update("CMP04001A01U", notify.getObject(i));
			}
			else if("D".equals(notify.getObject(i).getActiveFlg())) {
				simpleDao.update("CMP04001A01D", notify.getObject(i));
			}
		}
	}
	
	public void saveNotify(Notify notify) throws Exception {
		simpleDao.insert("CMP04001A02I", notify);
		simpleDao.insert("CMP04001A03I", notify);
	}

	public void saveNotify_confirm(Notify notify) throws Exception {
		simpleDao.insert("CMP04001A04I", notify);
	}
	
}