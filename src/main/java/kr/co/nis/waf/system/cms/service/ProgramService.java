package kr.co.nis.waf.system.cms.service;

import kr.co.nis.waf.system.cms.model.Program;


public interface ProgramService {

	public void addProgram(Program program) throws Exception;
	
	public void modifyProgram(Program program) throws Exception;
	
	public void removeProgram(Program program) throws Exception;
	
}
