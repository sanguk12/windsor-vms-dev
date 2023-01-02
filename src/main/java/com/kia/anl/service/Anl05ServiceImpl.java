package com.kia.anl.service;


import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.anl.model.VENUE_INFO_LOG;


@Service("anl05Service")
public class Anl05ServiceImpl implements Anl05Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Override
	public void changeEmpID(VENUE_INFO_LOG venue_info_log){
					
			simpleDao.update("ANL0500103U", venue_info_log);
			simpleDao.update("ANL0500104U", venue_info_log);
			simpleDao.update("ANL0500105U", venue_info_log);
			simpleDao.update("ANL0500106U", venue_info_log);
			simpleDao.update("ANL0500107U", venue_info_log);
			simpleDao.update("ANL0500108U", venue_info_log);
		
		}
		
}	