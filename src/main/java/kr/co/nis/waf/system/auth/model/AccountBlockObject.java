package kr.co.nis.waf.system.auth.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.service.SecurityService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class AccountBlockObject {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private SimpleService simpleService;
	private SecurityService securityService;
	
	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}

	public void setSecurityService(SecurityService securityService) {
		this.securityService = securityService;
	}

	public void accountBlock(){
		
		try {
			List params = simpleService.queryForList("commonservice.auth.company.select", null);
			
			for (int i=0; i < params.size(); i++) {
				
				try {
					Map param = new HashMap();
					param = (Map)params.get(i);
					
					securityService.modifyAccountBlock(param);
				}
				catch (Exception e) {
					logger.error(e.toString());
				}
			}
		}
		catch(Exception e){
			if (logger.isDebugEnabled()){
				e.printStackTrace();
			}
		}
	}
}