package kr.co.nis.waf.system.biz.service;

import java.util.List;

import kr.co.nis.waf.system.biz.model.LangDescriptions;
import kr.co.nis.waf.system.biz.model.SystemLangDescription;


public interface LanguageService {
	
	public void createLangDescription(SystemLangDescription systemLangDescription) throws Exception;
	
	public void saveLangDescription(LangDescriptions langDescriptions) throws Exception;
	
	public void saveLangDescription(List langDescriptions) throws Exception;
	
}
