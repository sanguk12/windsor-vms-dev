package kr.co.nis.waf.system.common.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.system.auth.model.ProgramUseLog;
import kr.co.nis.waf.system.auth.service.AuthService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class ProgramUseLogInterceptor extends HandlerInterceptorAdapter {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private AuthService authService;
	
	/*
	public void setAuthService(AuthService authService) {
		this.authService = authService;
	}
	*/

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		String uri = request.getRequestURI();
		
		if (uri.contains("simpleCommand")) {
			SessionManager sessionManager = new SessionManager(request, response);
			
			String pgmID = (String) request.getParameter("pgmID");
			String viewID = (String) request.getParameter("viewID");
			
			if (sessionManager.getUserID() != null && viewID == null && !pgmID.equals("") ){
				ProgramUseLog programUseLog = new ProgramUseLog();
				programUseLog.setCompanyID(sessionManager.getCompanyID());
				programUseLog.setUserID(sessionManager.getUserID());
				programUseLog.setPgmID(pgmID);
				authService.saveProgramUseLog(programUseLog);
			}
		}
		return true;
	}

}