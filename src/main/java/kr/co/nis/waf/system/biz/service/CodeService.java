package kr.co.nis.waf.system.biz.service;

import java.util.Map;

import kr.co.nis.waf.system.biz.model.Code;

public interface CodeService {

	public Map getSeqID(Code code) throws Exception;
	
	public Map getSeqIDNoComp(Code code) throws Exception;
	
	public void deleteCode(Code code) throws Exception;
}
