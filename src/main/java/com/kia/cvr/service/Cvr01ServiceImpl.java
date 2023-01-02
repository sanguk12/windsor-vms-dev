package com.kia.cvr.service;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.cvr.model.GCVR01MT;
import com.kia.cvr.model.GCVR01MTs;

import kr.co.nis.waf.dao.SimpleDao;

@Service("cvr01Service")
public class Cvr01ServiceImpl implements Cvr01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	public void addRate(GCVR01MTs gcvr01mts) throws Exception {
		simpleDao.delete("CVR0100102D", gcvr01mts);
		for(int i= 0; i < gcvr01mts.getSize();i++){
			GCVR01MT gcvr01mt = gcvr01mts.getGCVR01MT(i);
			simpleDao.insert("CVR0100103I", gcvr01mt);
		}
	}
	
	
}