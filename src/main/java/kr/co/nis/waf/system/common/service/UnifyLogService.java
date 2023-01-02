package kr.co.nis.waf.system.common.service;

import kr.co.nis.waf.system.common.model.UnifyLog;

/** 
 * gtf 통합로그
 * @version: 1.0
 * @author: taejoon.jang
 */
public interface UnifyLogService {

	public void insertUnifyLog(UnifyLog unifyLog) throws Exception;
	
	public void insertUnifyLog2(UnifyLog unifyLog) throws Exception;
	
	public void insertUnifyLog3(UnifyLog unifyLog) throws Exception;
	
}