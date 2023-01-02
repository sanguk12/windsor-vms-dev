package kr.co.nis.waf.system.auth.service;

import kr.co.nis.waf.system.auth.model.Auth;
import kr.co.nis.waf.system.auth.model.ProgramUseLog;

public interface AuthService {
	public void applyFunctionGroupAuth(Auth auth) throws Exception;
	public void applyFunctionUserAuth(Auth auth) throws Exception;
	public void saveProgramUseLog(ProgramUseLog programUseLog) throws Exception;
}