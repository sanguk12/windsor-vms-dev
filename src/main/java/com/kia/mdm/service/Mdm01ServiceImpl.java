package com.kia.mdm.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mdm.model.GAPP01MT;
import com.kia.mdm.model.GEMP01MT;

@Service("mdm01Service")
public class Mdm01ServiceImpl implements Mdm01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void insertAppr(GAPP01MT gapp01mt) throws Exception {
		simpleDao.insert("MDM0100201I", gapp01mt);
	}
	
	public void updateAppr(GAPP01MT gapp01mt) throws Exception {
		simpleDao.update("MDM0100201U", gapp01mt);
	}
	
	public void deleteAppr(GAPP01MT gapp01mt) throws Exception {
		for(int i=0; i<gapp01mt.getSize(); i++) {
			simpleDao.delete("MDM0100201D", gapp01mt.getObject(i));
			simpleDao.delete("MDM0100202D", gapp01mt.getObject(i));
		}
	}
	
	public void insertApprGrp(GAPP01MT gapp01mt) throws Exception {
		simpleDao.insert("MDM0100202I", gapp01mt);
	}
	
	public void updateApprGrp(GAPP01MT gapp01mt) throws Exception {
		simpleDao.update("MDM0100202U", gapp01mt);
	}
	
	public void deleteApprGrp(GAPP01MT gapp01mt) throws Exception {
		for(int i=0; i<gapp01mt.getSize_grp(); i++) {
			simpleDao.delete("MDM0100203D", gapp01mt.getObject_grp(i));
		}
	}

	public void addEmployee(GEMP01MT gemp01mt) throws Exception {
		//GEMP01MT
		simpleDao.insert("MDM0100105I", gemp01mt);
		simpleDao.insert("MDM0100106I", gemp01mt);
		simpleDao.insert("MDM0100107I", gemp01mt);
		simpleDao.insert("MDM0100108I", gemp01mt);
		for(int i=0; i<gemp01mt.getSize(); i++) {
			simpleDao.insert("MDM0100109I", gemp01mt.getObject_request(i));
		}
	
	}
	
	public void modifyEmployee(GEMP01MT gemp01mt) throws Exception {
		simpleDao.update("MDM0100109U", gemp01mt);
		simpleDao.update("MDM0100110U", gemp01mt);
		simpleDao.update("MDM0100111U", gemp01mt);
		simpleDao.delete("MDM0100101D", gemp01mt);
		for(int i=0; i<gemp01mt.getSize(); i++) {
			simpleDao.insert("MDM0100109I", gemp01mt.getObject_request(i));
		}
		
	}
}