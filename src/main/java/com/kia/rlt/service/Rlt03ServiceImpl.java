package com.kia.rlt.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT05MT;

@Service("rlt03Service")
public class Rlt03ServiceImpl implements Rlt03Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void insertResultDiffNo_G2(GRLT05MT grlt05mt) throws Exception {
		simpleDao.insert("RLT0300101I", grlt05mt);
	}
	
	public void updateResultDiffNo_G2(GRLT05MT grlt05mt) throws Exception {
		simpleDao.update("RLT0300101U", grlt05mt);
	}
	
	public void deleteResultDiffNo_G2(GRLT05MT grlt05mt) throws Exception {
		simpleDao.delete("RLT0300101D", grlt05mt);
	}
	
	public void resultCreation(GRLT01MT grlt01mt) throws Exception {
		List list = simpleDao.queryForList("RLT0300106S", grlt01mt);		//G1과 틀린부분
		
		if(list!=null && list.size()>0) {
			for(int i=0; i<list.size(); i++) {
				Map map = (Map) list.get(i);
				String activeFlg = map.get("activeFlg").toString();
				String venueCD = map.get("venueCD").toString();
				String apprStateCD = map.get("apprStateCD")!=null?map.get("apprStateCD").toString():"";
				grlt01mt.setVenueCD(venueCD);
				
				if(activeFlg.equals("I")) {
					simpleDao.insert("RLT0300102I", grlt01mt);		//G1과 틀린부분
					simpleDao.insert("RLT0300103I", grlt01mt);		//G1과 틀린부분
					simpleDao.insert("RLT0300104I", grlt01mt);		//G1과 틀린부분(plan에 등록된 키맨등록)
					
					//GRLT01DT의 insert정보 토대로 GRLT01MT실적정보 갱신
					Map map_tmp = simpleDao.queryForMap("RLT0300107S", grlt01mt);		//G1과 틀린부분(가이드지급률,지급률100%)
					grlt01mt.setResultTQty(map_tmp.get("resultTQty").toString());
					grlt01mt.setTargetRate(map_tmp.get("targetRate").toString());
					grlt01mt.setGuidPayRate(map_tmp.get("guidPayRate").toString());
					grlt01mt.setPayRate(map_tmp.get("payRate").toString());
					grlt01mt.setExcPayTpCD(map_tmp.get("excPayTpCD")!=null?map_tmp.get("excPayTpCD").toString():"");
					grlt01mt.setTpayAmt(map_tmp.get("tpayAmt").toString());
					grlt01mt.setResultTpCD(map_tmp.get("resultTpCD").toString());
					grlt01mt.setGsvRate(map_tmp.get("gsvRate").toString());
					simpleDao.update("RLT0100101U", grlt01mt);
					simpleDao.update("RLT0300103U", grlt01mt);
				}
				else if(activeFlg.equals("U")) {
					//승인상태 등록시 삭제 후 다시생성
					if(apprStateCD.equals("10")) {
						simpleDao.delete("RLT0100101D", grlt01mt);
						simpleDao.delete("RLT0100102D", grlt01mt);
						simpleDao.delete("RLT0100103D", grlt01mt);
						
						simpleDao.insert("RLT0300102I", grlt01mt);		//G1과 틀린부분
						simpleDao.insert("RLT0300103I", grlt01mt);		//G1과 틀린부분
						simpleDao.insert("RLT0300104I", grlt01mt);		//G1과 틀린부분(plan에 등록된 키맨등록)
						
						//GRLT01DT의 insert정보 토대로 GRLT01MT실적정보 갱신
						Map map_tmp = simpleDao.queryForMap("RLT0300107S", grlt01mt);		//G1과 틀린부분(가이드지급률,지급률100%)
						grlt01mt.setResultTQty(map_tmp.get("resultTQty").toString());
						grlt01mt.setTargetRate(map_tmp.get("targetRate").toString());
						grlt01mt.setGuidPayRate(map_tmp.get("guidPayRate").toString());
						grlt01mt.setPayRate(map_tmp.get("payRate").toString());
						grlt01mt.setExcPayTpCD(map_tmp.get("excPayTpCD")!=null?map_tmp.get("excPayTpCD").toString():"");
						grlt01mt.setTpayAmt(map_tmp.get("tpayAmt").toString());
						grlt01mt.setResultTpCD(map_tmp.get("resultTpCD").toString());
						grlt01mt.setGsvRate(map_tmp.get("gsvRate").toString());
						simpleDao.update("RLT0100101U", grlt01mt);
						simpleDao.update("RLT0300103U", grlt01mt);
					}
				}
			}
		}
	}
	
	public void determineResult(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			simpleDao.update("RLT0300102U", grlt01mt.getObject_determine(i));
		}
		
	}
	
	public void determineCancelResult(GRLT01MT grlt01mt) throws Exception {
		for(int i=0; i<grlt01mt.getSize(); i++) {
			simpleDao.update("RLT0300102U", grlt01mt.getObject_determine(i));
		}
	}
	
}