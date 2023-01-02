package com.kia.ltc.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.ltc.model.GLTC01MT;

@Service("ltc01Service")
public class Ltc01ServiceImpl implements Ltc01Service {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Override
	public String insertSupport(GLTC01MT gltc01mt) throws Exception {
		String supportID = "";
		supportID = simpleDao.queryForMap("LTC0100100S", gltc01mt).get("supportID").toString();
		gltc01mt.setSupportID(supportID);
		
		simpleDao.insert("LTC0100101I", gltc01mt);
		
		for(int i=0; i<gltc01mt.getSize(); i++) {
				simpleDao.insert("LTC0100102I", gltc01mt.getObject(i));
		}
		
		return supportID;
	}

	@Override
	public void updateSupport(GLTC01MT gltc01mt) throws Exception {
		gltc01mt.setApprStateCD("10");
		simpleDao.update("LTC0100101U", gltc01mt);
		
		for(int i=0; i<gltc01mt.getSize(); i++) {
			simpleDao.update("LTC0100102U", gltc01mt.getObject(i));
		}
	}

	@Override
	public void deleteSupport(GLTC01MT gltc01mt) throws Exception {
		simpleDao.delete("LTC0100101D", gltc01mt);
		simpleDao.delete("LTC0100102D", gltc01mt);
	}

	@Override
	public void requestApp(GLTC01MT gltc01mt) throws Exception {
		for(int i=0; i<gltc01mt.getSize_req(); i++){
			simpleDao.delete("LTC0100103D",gltc01mt.getObject_req(i));
			simpleDao.insert("LTC0100103I",gltc01mt.getObject_req(i));
			simpleDao.update("LTC0100103U",gltc01mt.getObject_req(i));
		}
	}

	@Override
	public void clearRequestApp(GLTC01MT gltc01mt) throws Exception {
		for(int i=0; i<gltc01mt.getSize_req(); i++){
			simpleDao.delete("LTC0100103D",gltc01mt.getObject_req(i));
			simpleDao.update("LTC0100103U",gltc01mt.getObject_req(i));
		}
	}

	@Override
	public void updatePlanQty(String venueCD, Map<String, String[]> plnParam) throws Exception {
		for(int i=0; i<plnParam.get("prdCDs").length;i++){
			Map tmp = new HashMap();
			tmp.put("venueCD", venueCD);
			tmp.put("prdCD", plnParam.get("prdCDs")[i]);
			tmp.put("eventYM", plnParam.get("eventYMs")[i]);
			tmp.put("planQty", plnParam.get("planQtys")[i]);
			simpleDao.update("LTC0100104U",tmp);
			simpleDao.update("LTC0100105U",tmp);
		}
	}

	@Override
	public void contractCancel(GLTC01MT gltc01mt) throws Exception {
		for(int i=0; i<gltc01mt.getSize_req(); i++){
			simpleDao.delete("LTC0100103D",gltc01mt.getObject_req(i));
			simpleDao.insert("LTC0100103I",gltc01mt.getObject_req(i));
		}
	}

}
