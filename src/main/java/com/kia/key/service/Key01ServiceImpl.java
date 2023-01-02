package com.kia.key.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.key.model.GKEY01MT;

@Service("key01Service")
public class Key01ServiceImpl implements Key01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void addKeymanID(GKEY01MT gkey01mt) throws Exception {
		simpleDao.insert("KEY0100101I", gkey01mt);
		simpleDao.insert("KEY0100102I", gkey01mt);
	}
	
	public void updateKeymanID(GKEY01MT gkey01mt) throws Exception {
		simpleDao.update("KEY0100101U", gkey01mt);
		simpleDao.delete("KEY0100102D", gkey01mt);
		simpleDao.insert("KEY0100102I", gkey01mt);
	}
	
	public void modifyKeymanID(GKEY01MT gkey01mt) throws Exception {
		simpleDao.insert("KEY0100101I", gkey01mt);
		simpleDao.delete("KEY0100102D", gkey01mt);
		simpleDao.insert("KEY0100102I", gkey01mt);
	}
	
	public void deleteKeymanID(GKEY01MT gkey01mt) throws Exception {
		simpleDao.delete("KEY0100101D", gkey01mt);
		simpleDao.delete("KEY0100102D", gkey01mt);
	}
	
	public void addKeymanID_m(GKEY01MT gkey01mt) throws Exception {
		simpleDao.insert("KEY0100401I", gkey01mt);
		simpleDao.insert("KEY0100402I", gkey01mt);
	}
	
	public void updateKeymanID_m(GKEY01MT gkey01mt) throws Exception {
		simpleDao.update("KEY0100401U", gkey01mt);
		simpleDao.delete("KEY0100402D", gkey01mt);
		simpleDao.insert("KEY0100402I", gkey01mt);
	}
	
	public void modifyKeymanID_m(GKEY01MT gkey01mt) throws Exception {
		simpleDao.insert("KEY0100401I", gkey01mt);
		simpleDao.delete("KEY0100402D", gkey01mt);
		simpleDao.insert("KEY0100402I", gkey01mt);
	}
	
	public void deleteKeymanID_m(GKEY01MT gkey01mt) throws Exception {
		simpleDao.delete("KEY0100401D", gkey01mt);
		simpleDao.delete("KEY0100402D", gkey01mt);
	}
	
}