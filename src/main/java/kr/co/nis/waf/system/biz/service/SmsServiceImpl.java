package kr.co.nis.waf.system.biz.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.SmsSend;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;


@Service("smsService")
public class SmsServiceImpl implements SmsService {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	/*
	public void setSimpleDao(SimpleDao simpleDao) {
		this.simpleDao = simpleDao;
	}
	*/

	public void addSmsSend(SmsSend smsSend) throws Exception {
		
		for (int i = 0; i < smsSend.getSize(); i++) {
			SmsSend send = smsSend.getObject(i);
			simpleDao.insert("system.sms.insert", send);
		}
	}

}
