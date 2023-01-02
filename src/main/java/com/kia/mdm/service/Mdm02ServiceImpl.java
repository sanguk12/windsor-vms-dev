package com.kia.mdm.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mdm.model.GVEN01MT;

@Service("mdm02Service")
public class Mdm02ServiceImpl implements Mdm02Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void insertVenue(GVEN01MT gven01mt) throws Exception {
		simpleDao.insert("MDM0200101I", gven01mt);
	}
	
	public void updateVenue(GVEN01MT gven01mt) throws Exception {
		simpleDao.update("MDM0200101U", gven01mt);
	}
	
	public void saveVenueGrid(GVEN01MT gven01mt) throws Exception {
		for(int i=0;i<gven01mt.getActiveYNs().length;i++)
			System.out.print(gven01mt.getActiveYNs()[i]+", ");
		for(int i=0; i<gven01mt.getSize(); i++) {
			simpleDao.insert("MDM0200102I", gven01mt.getObject(i));
		}
	}
}