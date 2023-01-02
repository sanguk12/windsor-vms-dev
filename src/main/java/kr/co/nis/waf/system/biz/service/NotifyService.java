package kr.co.nis.waf.system.biz.service;

import kr.co.nis.waf.system.biz.model.Notify;

public interface NotifyService {

	public void saveNotify_Master(Notify notify) throws Exception;
	
	public void saveNotify(Notify notify) throws Exception;
	
	public void saveNotify_confirm(Notify notify) throws Exception;
	
}
