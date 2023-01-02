package kr.co.nis.waf.system.biz.service;

import java.util.List;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.LangDescription;
import kr.co.nis.waf.system.biz.model.LangDescriptions;
import kr.co.nis.waf.system.biz.model.SystemLangDescription;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;


@Service("languageService")
public class LanguageServiceImpl implements LanguageService {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void createLangDescription(SystemLangDescription systemLangDescription) throws Exception {
		
		simpleDao.update("CMP0101905P",systemLangDescription);
		
		if (systemLangDescription.getResultCode().equals("E")) {
			throw new DataIntegrityViolationException(systemLangDescription.getResultMessage());
		}
	}

	public void saveLangDescription(LangDescriptions langDescriptions) throws Exception {
		
		for (int i = 0; i < langDescriptions.getSize(); i++) {
			LangDescription langDescription = langDescriptions.getLangDescription(i);
			
			if (simpleDao.queryForInt("CMP0101902S", langDescription) == 0) {
				simpleDao.insert("CMP0101903I", langDescription);
			}
			else {
				simpleDao.update("CMP0101904U", langDescription);
			}
		}
	}
	
	public void saveLangDescription(List langDescriptions) throws Exception {
		
		for (int i = 0; i < langDescriptions.size(); i++) {
			LangDescription langDescription = (LangDescription)langDescriptions.get(i);
			
			if (simpleDao.queryForInt("CMP0101902S", langDescription) == 0) {
				simpleDao.insert("CMP0101903I", langDescription);
			}
			else {
				simpleDao.update("CMP0101904U", langDescription);
			}
		}
	}

}
