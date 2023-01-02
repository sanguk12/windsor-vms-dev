package com.kia.mil.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mil.model.GMIL01MT;

@Service("mil01Service")
public class Mil01ServiceImpl implements Mil01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public String insertMileage(GMIL01MT gmil01mt) throws Exception {
		String mileageID = "";
		mileageID = simpleDao.queryForMap("MIL0100100S", gmil01mt).get("mileageID").toString();
		gmil01mt.setMileageID(mileageID);
		
		simpleDao.insert("MIL0100101I", gmil01mt);
		
		for(int i=0; i<gmil01mt.getSize(); i++) {
			if(gmil01mt.getObject(i).getActiveFlg().equals("D")) {
				simpleDao.delete("MIL0100102D", gmil01mt.getObject(i));
			}
			else if(gmil01mt.getObject(i).getActiveFlg().equals("I")) {
				simpleDao.insert("MIL0100102I", gmil01mt.getObject(i));
			}
			else if(gmil01mt.getObject(i).getActiveFlg().equals("U")) {
				simpleDao.update("MIL0100102U", gmil01mt.getObject(i));
			}
		}
		
		return mileageID;
	}
	
	public void updateMileage(GMIL01MT gmil01mt) throws Exception {
		//상태가 반려, 보류일때만 저장, 상태를 등록으로 변경
		gmil01mt.setMileageStateCD("10");
		simpleDao.update("MIL0100101U", gmil01mt);
		gmil01mt.setCommt("");
		
		for(int i=0; i<gmil01mt.getSize(); i++) {
			if(gmil01mt.getObject(i).getActiveFlg().equals("D")) {
				simpleDao.delete("MIL0100102D", gmil01mt.getObject(i));
			}
			else if(gmil01mt.getObject(i).getActiveFlg().equals("I")) {
				simpleDao.insert("MIL0100102I", gmil01mt.getObject(i));
			}
			else if(gmil01mt.getObject(i).getActiveFlg().equals("U")) {
				simpleDao.update("MIL0100102U", gmil01mt.getObject(i));
			}
		}
	}
	
	public void saveMileageKeyman(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_keyman(); i++) {
			if(gmil01mt.getObject_keyman(i).getActiveFlg().equals("D")) {
				simpleDao.delete("MIL0100103D", gmil01mt.getObject_keyman(i));
			}
			else if(gmil01mt.getObject_keyman(i).getActiveFlg().equals("I")) {
				simpleDao.insert("MIL0100103I", gmil01mt.getObject_keyman(i));
			}
			else if(gmil01mt.getObject_keyman(i).getActiveFlg().equals("U")) {
				simpleDao.update("MIL0100103U", gmil01mt.getObject_keyman(i));
			}
		}
	}
	
	public void deleteMileage(GMIL01MT gmil01mt) throws Exception {
		simpleDao.delete("MIL0100105D", gmil01mt);
		simpleDao.delete("MIL0100104D", gmil01mt);
		simpleDao.delete("MIL0100101D", gmil01mt);
		simpleDao.delete("MIL0100106D", gmil01mt);
	}
	
	public void requestPayMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.delete("MIL0100106D", gmil01mt.getObject_req(i));
			simpleDao.update("MIL0100104U", gmil01mt.getObject_req(i));
			simpleDao.insert("MIL0100104I", gmil01mt.getObject_req(i));
		}
	}
	
	public void clearRequestPayMileage(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.update("MIL0100106D", gmil01mt.getObject_req(i));
			simpleDao.update("MIL0100104U", gmil01mt.getObject_req(i));
		}
	}

	public void updateMileageRlt(GMIL01MT gmil01mt) throws Exception {
		//상태가 반려, 보류일때만 저장, 상태를 등록으로 변경
		gmil01mt.setMileageStateCD("10");
		simpleDao.update("MIL0100201U", gmil01mt);
		gmil01mt.setCommt("");
		
		for(int i=0; i<gmil01mt.getSize(); i++) {
			if(gmil01mt.getObject(i).getActiveFlg().equals("D")) {
				simpleDao.delete("MIL0100202D", gmil01mt.getObject(i));
			}
			else if(gmil01mt.getObject(i).getActiveFlg().equals("I")) {
				simpleDao.insert("MIL0100202I", gmil01mt.getObject(i));
			}
			else if(gmil01mt.getObject(i).getActiveFlg().equals("U")) {
				simpleDao.update("MIL0100202U", gmil01mt.getObject(i));
			}
		}
	}
	
	public void deleteMileageRlt(GMIL01MT gmil01mt) throws Exception {
		simpleDao.delete("MIL0100205D", gmil01mt);
		simpleDao.delete("MIL0100204D", gmil01mt);
		simpleDao.delete("MIL0100201D", gmil01mt);
		simpleDao.delete("MIL0100206D", gmil01mt);
		simpleDao.delete("MIL0100105D", gmil01mt);
		simpleDao.delete("MIL0100104D", gmil01mt);
		simpleDao.delete("MIL0100101D", gmil01mt);
		simpleDao.delete("MIL0100106D", gmil01mt);
	}
	
	public void requestPayMileageRlt(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.delete("MIL0100206D", gmil01mt.getObject_req(i));
			simpleDao.update("MIL0100204U", gmil01mt.getObject_req(i));
			simpleDao.insert("MIL0100204I", gmil01mt.getObject_req(i));
		}
	}
	
	public void clearRequestPayMileageRlt(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.update("MIL0100206D", gmil01mt.getObject_req(i));
			simpleDao.update("MIL0100204U", gmil01mt.getObject_req(i));
		}
	}
	/*
	public void requestPayMileage_add(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.update("MIL0100201U", gmil01mt.getObject_req(i));
		}
	}
	
	public void clearRequestPayMileage_add(GMIL01MT gmil01mt) throws Exception {
		for(int i=0; i<gmil01mt.getSize_req(); i++) {
			simpleDao.update("MIL0100201U", gmil01mt.getObject_req(i));
		}
	}
	
	public void saveMileageKeyman_add(GMIL01MT gmil01mt) throws Exception {
		//10:등록(보류, 반려시에도 등록으로 변경)
		gmil01mt.setMileageStateCD("10");
		gmil01mt.setCommt("");
		if(simpleDao.queryForInt("MIL0100206S", gmil01mt) == 0) {
			simpleDao.insert("MIL0100201I", gmil01mt);
		}
		else {
			simpleDao.update("MIL0100202U", gmil01mt);
		}
		
		for(int i=0; i<gmil01mt.getSize_keyman(); i++) {
			if(gmil01mt.getObject_keyman(i).getActiveFlg().equals("D")) {
				simpleDao.delete("MIL0100103D", gmil01mt.getObject_keyman(i));
			}
			else if(gmil01mt.getObject_keyman(i).getActiveFlg().equals("I")) {
				simpleDao.insert("MIL0100103I", gmil01mt.getObject_keyman(i));
			}
			else if(gmil01mt.getObject_keyman(i).getActiveFlg().equals("U")) {
				simpleDao.update("MIL0100103U", gmil01mt.getObject_keyman(i));
			}
		}
	}
	
	public void deleteMileageKeyman_add(GMIL01MT gmil01mt) throws Exception {
		simpleDao.delete("MIL0100201D", gmil01mt);
		simpleDao.delete("MIL0100202D", gmil01mt);
	}
	*/
	
}