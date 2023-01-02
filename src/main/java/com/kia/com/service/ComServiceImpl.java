package com.kia.com.service;

import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;


@Service("comService")
public class ComServiceImpl implements ComService {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	public void initialPwdCustStaff(Map map) throws Exception {
		simpleDao.update("COM0001U", map);
	}
	
	public void initialPwdUser(Map map) throws Exception {
		simpleDao.update("COM0002U", map);
		simpleDao.update("COM0003U", map);
		simpleDao.update("COM0004U", map);
	}
	
}