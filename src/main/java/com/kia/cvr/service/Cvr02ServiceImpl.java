package com.kia.cvr.service;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.cvr.model.GCVR02MT;
import com.kia.cvr.model.GCVR02MTs;

import kr.co.nis.waf.dao.SimpleDao;

@Service("cvr02Service")
public class Cvr02ServiceImpl implements Cvr02Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	public void requestApp(GCVR02MTs gcvr01mts) throws Exception {
		simpleDao.delete("CVR0100102D", gcvr01mts);
		for(int i= 0; i < gcvr01mts.getSize();i++){
			GCVR02MT gcvr01mt = gcvr01mts.getGCVR02MT(i);
			simpleDao.insert("CVR0100103I", gcvr01mt);
		}
	}
	
	public void saveApprReq(GCVR02MTs gcvr02mts) throws Exception{
		for(int i= 0; i < gcvr02mts.getSize();i++){
			GCVR02MT gcvr02mt = gcvr02mts.getGCVR02MT(i);
			simpleDao.update("CVR0200101U", gcvr02mt);
		}
	}
	
	public void saveApprReqCancel(GCVR02MTs gcvr02mts) throws Exception{
		for(int i= 0; i < gcvr02mts.getSize();i++){
			GCVR02MT gcvr02mt = gcvr02mts.getGCVR02MT(i);
			simpleDao.update("CVR0200102U", gcvr02mt);
		}
	}
	
	public void saveApproval(GCVR02MTs gcvr02mts) throws Exception{
		for(int i= 0; i < gcvr02mts.getSize();i++){
			GCVR02MT gcvr02mt = gcvr02mts.getGCVR02MT(i);
			simpleDao.update("CVR0200103U", gcvr02mt);
		}
	}
	
	public void saveApprReject(GCVR02MTs gcvr02mts) throws Exception{
		for(int i= 0; i < gcvr02mts.getSize();i++){
			GCVR02MT gcvr02mt = gcvr02mts.getGCVR02MT(i);
			simpleDao.update("CVR0200104U", gcvr02mt);
		}
	}
	
}