package com.kia.ad.service;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.ad.model.GCHA01MT;
import com.kia.ad.model.GME01DT;
import com.kia.ad.model.GME01MT;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.dao.SimpleService;

@Service("ad04Service")
public class Ad04ServiceImpl implements Ad04Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	@Resource
	private SimpleService simpleService;
	
	@Override
	public void saveChain(GCHA01MT gcha01mt) throws Exception {
		// TODO Auto-generated method stub
		simpleDao.delete("AD0400101D", gcha01mt);
		
		for(int i = 0; i < gcha01mt.getSize(); i++) {
			simpleDao.insert("AD0400101I", gcha01mt.getChainObject(i));
		}
	}

	@Override
	public void saveChainVenue(GCHA01MT gcha01mt) throws Exception {
		simpleDao.delete("AD0400102D", gcha01mt);
		
		for(int i = 0; i < gcha01mt.getSize(); i++) {
			simpleDao.insert("AD0400102I", gcha01mt.getChainVenueObject(i));
		}
		
	}

	
}