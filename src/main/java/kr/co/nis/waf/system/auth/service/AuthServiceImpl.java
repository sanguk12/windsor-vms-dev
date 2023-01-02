package kr.co.nis.waf.system.auth.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.auth.model.Auth;
import kr.co.nis.waf.system.auth.model.ProgramUseLog;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("authService")
public class AuthServiceImpl implements AuthService {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	/*
	public void setSimpleDao(SimpleDao simpleDao) {
		this.simpleDao = simpleDao;
	}
	*/
	
	public void applyFunctionGroupAuth(Auth auth) throws Exception {
		simpleDao.delete("commonservice.auth.groupAuth.delete", auth);
		for (int i = 0; i < auth.getDataFuncID().length; i++) {
			auth.setFuncID(auth.getDataFuncID()[i]);
			if ("N".equals(auth.getDataActiveYN()[i])) {
				simpleDao.insert("commonservice.auth.groupAuth.insert", auth);
			}
		}
	}

	public void applyFunctionUserAuth(Auth auth) throws Exception {
		simpleDao.delete("commonservice.auth.userAuth.delete", auth);
		for (int i = 0; i < auth.getDataFuncID().length; i++) {
			auth.setFuncID(auth.getDataFuncID()[i]);
			if ("N".equals(auth.getDataActiveYN()[i])) {
				simpleDao.insert("commonservice.auth.userAuth.insert", auth);
			}
		}
	}

	public void saveProgramUseLog(ProgramUseLog programUseLog) throws Exception {
		if (simpleDao.queryForInt("commonservice.auth.programUseLogCount.select", programUseLog) == 0) {
			simpleDao.insert("commonservice.auth.programUseLog.insert", programUseLog);
		}
		else {
			simpleDao.update("commonservice.auth.programUseLog.update", programUseLog);
		}
	}
}
