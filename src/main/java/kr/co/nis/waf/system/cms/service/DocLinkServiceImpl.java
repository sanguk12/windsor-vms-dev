package kr.co.nis.waf.system.cms.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.cms.model.DocLink;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("docLinkService")
public class DocLinkServiceImpl implements DocLinkService {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	/*
	public void setSimpleDao(SimpleDao simpleDao) {
		this.simpleDao = simpleDao;
	}
	*/

	public void deleteDocLink(DocLink docLink) throws Exception {
		if (docLink.getDocLinks() == null) {
			simpleDao.delete("commonservice.docLink.delete", docLink);
		}
		else {
			for (int i = 0; i < docLink.getDocLinks().length; i++) {
				docLink.setDocLinkID(docLink.getDocLinks()[i]);
				simpleDao.delete("commonservice.docLink.delete", docLink);
			}
		}
	}
}
