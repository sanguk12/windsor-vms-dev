package kr.co.nis.waf.system.biz.service;

import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.OrganizationList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("organizationService")
public class OrganizationServiceImpl implements OrganizationService {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	/*
	public void setSimpleDao(SimpleDao simpleDao) {
		this.simpleDao = simpleDao;
	}
	*/

	public void saveOrganization(Map command, OrganizationList organizations) throws Exception {

		simpleDao.update("commonservice.biz.organization.delete", command);

		for (int i = 0; i < organizations.getSize(); i++) {
			if (simpleDao.queryForInt("commonservice.biz.organizationCount.select", organizations.getOrganization(i)) == 0) {
				simpleDao.insert("commonservice.biz.organization.insert", organizations.getOrganization(i));
			}
			else {
				simpleDao.update("commonservice.biz.organization.update", organizations.getOrganization(i));
			}
		}
	}
}
