package com.kia.sup.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.sup.model.GSUP01MT;

@Service("sup03Service")
public class Sup03ServiceImpl implements Sup03Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void addMM(GSUP01MT gsup01mt) throws Exception {
		
		simpleDao.update("SUP0300101U", gsup01mt);
		
	}
	
	
	public void endContract(GSUP01MT gsup01mt) throws Exception {
		simpleDao.update("SUP0300101P", gsup01mt);
		
	}
	
}