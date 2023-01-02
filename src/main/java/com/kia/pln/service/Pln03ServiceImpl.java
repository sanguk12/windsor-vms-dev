package com.kia.pln.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02DT;
import com.kia.pln.model.GPLN02DTs;
import com.kia.pln.model.GPLN02MT;

@Service("pln03Service")
public class Pln03ServiceImpl implements Pln03Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void savePlanVenueChg(GPLN01MT gpln01mt) throws Exception {
		/*
		simpleDao.update("PLN0300107I", gpln01mt);
		//승인요청으로 초기화 - GPLN01MT
		simpleDao.update("PLN0300101U", gpln01mt);
		//승인요청으로 초기화 - GPLN03MT
		simpleDao.update("PLN0300102U_1", gpln01mt);
		simpleDao.update("PLN0300102U_2", gpln01mt);
		simpleDao.update("PLN0300102U_3", gpln01mt);
		//업소 마스터 변경
		simpleDao.update("PLN0100201U", gpln01mt);
		//업소 제품별 변경
		for(int i=0; i<gpln01mt.getSize_write(); i++) {
			simpleDao.update("PLN0100202U", gpln01mt.getObject_write(i));
		}
		*/
		simpleDao.update("PLN0300407I", gpln01mt);
		//승인요청으로 초기화 - GPLN01MT
		simpleDao.update("PLN0300401U", gpln01mt);
		//승인요청으로 초기화 - GPLN03MT
		simpleDao.update("PLN0300402U_1", gpln01mt);
		simpleDao.update("PLN0300402U_2", gpln01mt);
		simpleDao.update("PLN0300402U_3", gpln01mt);
		//업소 마스터 변경
		simpleDao.update("PLN0100701U", gpln01mt);
		//업소 제품별 변경
		for(int i=0; i<gpln01mt.getSize_write(); i++) {
			simpleDao.update("PLN0100702U", gpln01mt.getObject_write(i));
		}
	}	
	
	public void savePlanBrandChg(GPLN02DTs gpln02dts) throws Exception {
		
		GPLN01MT gpln01mt = new GPLN01MT();
		
		
		String empid   = null;
		String eventYM = null;
		String venueCD = null;
		
		for (int i = 0; i < gpln02dts.getSize(); i++) {
			GPLN02DT gpln02dt = gpln02dts.getGPLN02DT(i);
			//상태가 등록	
			if(gpln02dt.getActiveFlg().equals("D")) {
				simpleDao.delete("PLN0100503D", gpln02dt);
				//승인관련 삭제 필요
				simpleDao.delete("PLN0300203D", gpln02dt);
			}else if(gpln02dt.getActiveFlg().equals("I")) {
				if(simpleDao.queryForInt("PLN0100506S", gpln02dts.getGPLN02DT(i)) > 0) {
					throw new DuplicateKeyException("duplicate exception");
				}
				gpln02dt.setApprStateCD("10");
				simpleDao.insert("PLN0100501I", gpln02dt);
				//승인관련 신규 추가 필요
				GPLN02MT gpln02mt = new GPLN02MT();
				gpln02mt.setEventYM(gpln02dt.getEventYM());
				gpln02mt.setVenueCD(gpln02dt.getVenueCD());
				gpln02mt.setPrdCD(gpln02dt.getPrdCD());
				gpln02mt.setEmpID(gpln02dt.getUserID());
				gpln02mt.setUserID(gpln02dt.getUserID());
				simpleDao.insert("PLN0300304I", gpln02mt);
			}else if(gpln02dt.getActiveFlg().equals("U")) {
				
				if(gpln02dt.getApprStateCD().equals("10")){
					//승인관련 신규 추가 필요
					GPLN02MT gpln02mt = new GPLN02MT();
					gpln02mt.setEventYM(gpln02dt.getEventYM());
					gpln02mt.setVenueCD(gpln02dt.getVenueCD());
					gpln02mt.setPrdCD(gpln02dt.getPrdCD());
					gpln02mt.setEmpID(gpln02dt.getUserID());
					gpln02mt.setUserID(gpln02dt.getUserID());
					simpleDao.insert("PLN0300304I", gpln02mt);
				}
				
				
				simpleDao.update("PLN0100502U", gpln02dt);
				
			}
			//승인요청으로 초기화 		
			simpleDao.update("PLN0300201U_2", gpln02dt);
			simpleDao.update("PLN0300202U_1", gpln02dt);
			simpleDao.update("PLN0300202U_2", gpln02dt);
			simpleDao.update("PLN0300202U_3", gpln02dt);
			empid   = gpln02dt.getUserID();
			eventYM = gpln02dt.getEventYM();
			venueCD = gpln02dt.getVenueCD();
		}
		
		gpln01mt.setEventYM(eventYM);
		gpln01mt.setVenueCD(venueCD);
		gpln01mt.setEmpID(empid);
		
		simpleDao.update("PLN0300204I", gpln01mt);
	}
}