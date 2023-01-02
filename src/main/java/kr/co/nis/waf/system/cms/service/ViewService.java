package kr.co.nis.waf.system.cms.service;

import kr.co.nis.waf.system.cms.model.View;


public interface ViewService {

	public void addView(View view) throws Exception;
	
	public void modifyView(View view) throws Exception;
	
	public void removeView(View view) throws Exception;

}
