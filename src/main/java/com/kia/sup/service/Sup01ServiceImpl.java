package com.kia.sup.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.sup.model.GSUP01MT;

@Service("sup01Service")
public class Sup01ServiceImpl implements Sup01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public String insertSupport(GSUP01MT gsup01mt) throws Exception {
		String supportID = "";
		supportID = simpleDao.queryForMap("SUP0100100S", gsup01mt).get("supportID").toString();
		gsup01mt.setSupportID(supportID);
		
		simpleDao.insert("SUP0100101I", gsup01mt);
		
		for(int i=0; i<gsup01mt.getSize(); i++) {
			if(gsup01mt.getObject(i).getActiveFlg().equals("D")) {
				simpleDao.delete("SUP0100102D", gsup01mt.getObject(i));
			}
			else if(gsup01mt.getObject(i).getActiveFlg().equals("I")) {
				simpleDao.insert("SUP0100102I", gsup01mt.getObject(i));
			}
			else if(gsup01mt.getObject(i).getActiveFlg().equals("U")) {
				simpleDao.update("SUP0100102U", gsup01mt.getObject(i));
			}
		}
		
		return supportID;
	}
	
	public void updateSupport(GSUP01MT gsup01mt) throws Exception {
		//상태가 반려, 보류일때만 저장, 상태를 등록으로 변경
		gsup01mt.setSupportStateCD("10");
		gsup01mt.setCommt("");
		simpleDao.update("SUP0100101U", gsup01mt);
		
		for(int i=0; i<gsup01mt.getSize(); i++) {
			if(gsup01mt.getObject(i).getActiveFlg().equals("D")) {
				simpleDao.delete("SUP0100102D", gsup01mt.getObject(i));
			}
			else if(gsup01mt.getObject(i).getActiveFlg().equals("I")) {
				simpleDao.insert("SUP0100102I", gsup01mt.getObject(i));
			}
			else if(gsup01mt.getObject(i).getActiveFlg().equals("U")) {
				simpleDao.update("SUP0100102U", gsup01mt.getObject(i));
			}
		}
	}
	
	public void saveSupportKeyman(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_keyman(); i++) {
			if(gsup01mt.getObject_keyman(i).getActiveFlg().equals("D")) {
				simpleDao.delete("SUP0100103D", gsup01mt.getObject_keyman(i));
			}
			else if(gsup01mt.getObject_keyman(i).getActiveFlg().equals("I")) {
				simpleDao.insert("SUP0100103I", gsup01mt.getObject_keyman(i));
			}
			else if(gsup01mt.getObject_keyman(i).getActiveFlg().equals("U")) {
				simpleDao.update("SUP0100103U", gsup01mt.getObject_keyman(i));
			}
		}
	}
	
	public void deleteSupport(GSUP01MT gsup01mt) throws Exception {
		simpleDao.delete("SUP0100105D", gsup01mt);
		simpleDao.delete("SUP0100104D", gsup01mt);
		simpleDao.delete("SUP0100101D", gsup01mt);
	}
	
	public void requestPaySupport(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			simpleDao.update("SUP0100104U", gsup01mt.getObject_req(i));
		}
	}
	
	public void clearRequestPaySupport(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			simpleDao.update("SUP0100104U", gsup01mt.getObject_req(i));
		}
	}
	
	public void requestPaySupport_add(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			simpleDao.update("SUP0100201U", gsup01mt.getObject_req(i));
		}
	}
	
	public void clearRequestPaySupport_add(GSUP01MT gsup01mt) throws Exception {
		for(int i=0; i<gsup01mt.getSize_req(); i++) {
			simpleDao.update("SUP0100201U", gsup01mt.getObject_req(i));
		}
	}
	
	public void saveSupportKeyman_add(GSUP01MT gsup01mt) throws Exception {
		//10:등록(보류, 반려시에도 등록으로 변경)
		gsup01mt.setSupportStateCD("10");
		gsup01mt.setCommt("");
		if(simpleDao.queryForInt("SUP0100206S", gsup01mt) == 0) {
			simpleDao.insert("SUP0100201I", gsup01mt);
		}
		else {
			simpleDao.update("SUP0100202U", gsup01mt);
		}
		
		for(int i=0; i<gsup01mt.getSize_keyman(); i++) {
			if(gsup01mt.getObject_keyman(i).getActiveFlg().equals("D")) {
				simpleDao.delete("SUP0100103D", gsup01mt.getObject_keyman(i));
			}
			else if(gsup01mt.getObject_keyman(i).getActiveFlg().equals("I")) {
				simpleDao.insert("SUP0100103I", gsup01mt.getObject_keyman(i));
			}
			else if(gsup01mt.getObject_keyman(i).getActiveFlg().equals("U")) {
				simpleDao.update("SUP0100103U", gsup01mt.getObject_keyman(i));
			}
		}
	}
	
	public void deleteSupportKeyman_add(GSUP01MT gsup01mt) throws Exception {
		simpleDao.delete("SUP0100201D", gsup01mt);
		simpleDao.delete("SUP0100202D", gsup01mt);
	}
	
}