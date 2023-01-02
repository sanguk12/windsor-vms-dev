package kr.co.nis.waf.system.biz.service;

import java.util.List;
import java.util.Map;

import kr.co.nis.waf.system.biz.model.OrganizationList;


public interface OrganizationService {

	public void saveOrganization(Map command, OrganizationList organizations) throws Exception;

	//public List findOrganizationChart(Map command) throws Exception;
}
