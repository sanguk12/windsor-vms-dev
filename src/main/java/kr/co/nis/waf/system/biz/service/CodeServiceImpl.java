package kr.co.nis.waf.system.biz.service;

import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.Code;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("codeService")
public class CodeServiceImpl implements CodeService {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	public void deleteCode(Code code) throws Exception {
		code.setActiveFlg("D");
		if (code.getComCodes() != null) {
			for (int i = 0; i < code.getComCodes().length; i++) {
				code.setComCode(code.getComCodes()[i]);
				
				//F_Code
				simpleDao.update("CMP0100305U", code);
			}
		}
		else {
			//F_Code
			simpleDao.update("CMP0100305U", code);
		}
	}

	public Map getSeqID(Code code) throws Exception {
		//F_IDCreationRule
		simpleDao.update("SYS0005U", code);
		//F_IDCreationRule
		return simpleDao.queryForMap("SYS0006S", code);
	}
	
	@Transactional(propagation=Propagation.REQUIRES_NEW) 
	public Map getSeqIDNoComp(Code code) throws Exception {
		//F_IDCreationRule
		simpleDao.update("SYS0005U02", code);
		//F_IDCreationRule
		return simpleDao.queryForMap("SYS0006S02", code);
	}
}