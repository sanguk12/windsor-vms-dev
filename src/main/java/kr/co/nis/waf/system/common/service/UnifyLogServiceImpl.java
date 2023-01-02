package kr.co.nis.waf.system.common.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.common.model.UnifyLog;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;


@Service("unifyLogService")
public class UnifyLogServiceImpl implements UnifyLogService {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	public void insertUnifyLog(UnifyLog unifyLog) throws Exception {
		for(int i=0; i<unifyLog.getSize(); i++) {
			simpleDao.insert("COM0201I", unifyLog.getObject(i));
		}
	}
	
	public void insertUnifyLog2(UnifyLog unifyLog) throws Exception {
		for(int i=0; i<unifyLog.getSize2(); i++) {
			simpleDao.insert("COM0202I", unifyLog.getObject2(i));
		}
	}
	
	public void insertUnifyLog3(UnifyLog unifyLog) throws Exception {
		for(int i=0; i<unifyLog.getSize3(); i++) {
			simpleDao.insert("COM0203I", unifyLog.getObject3(i));
		}
	}
	
}