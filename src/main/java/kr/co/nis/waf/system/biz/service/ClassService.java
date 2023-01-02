package kr.co.nis.waf.system.biz.service;

import java.util.Map;

import kr.co.nis.waf.system.biz.model.ClasseList;


public interface ClassService {
	public void saveClass(Map command, ClasseList classifications) throws Exception;
}
