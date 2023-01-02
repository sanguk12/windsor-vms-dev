package com.kia.mdm.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mdm.model.GVEN02MT;

@Service("mdm08Service")
public class Mdm08ServiceImpl implements Mdm08Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void insertVenue(GVEN02MT gven02mt) throws Exception {
		String tmpVenueCD = "";
		//int maxCnt = 0;
		
		tmpVenueCD = simpleDao.queryForMap("MDM0800100S", gven02mt).get("tmpVenueCD").toString();
		//maxCnt = simpleDao.queryForInt("MDM0800109S", gven02mt);

		//gven02mt.setVenSeq(String.valueOf(maxCnt));
		gven02mt.setRequestStateCD("10");
		gven02mt.setTmpVenueCD(tmpVenueCD);
		
		simpleDao.insert("MDM0800101I", gven02mt);
	}
	
	public void updateVenue(GVEN02MT gven02mt) throws Exception {
		simpleDao.update("MDM0800101U", gven02mt);
	}
	
	// 업소신규등록_엑셀업로드
	public void saveTmpVenueGrid(GVEN02MT gven02mt) throws Exception {
		
		for(int i = 0; i < gven02mt.getSize_Admin(); i++) {
			simpleDao.insert("MDM0800101I", gven02mt.getObject_Admin(i));
		}
	}

	@Override
	public void requestApprTmpVenue(GVEN02MT gven02mt) throws Exception {

		//AD 승인요청 정보 갱신
		for(int i = 0; i < gven02mt.getTmpSize(); i++) {
			GVEN02MT gven02mt_a = gven02mt.getObject_request(i);
			simpleDao.delete("MDM0800201D", gven02mt_a);
			simpleDao.insert("MDM0800201I", gven02mt_a);
			simpleDao.update("MDM0800201U", gven02mt_a);
		}
	}

	@Override
	public void clearRequestApprTmpVenue(GVEN02MT gven02mt) throws Exception {

		//AD 승인요청취소 정보 갱신
		for(int i = 0; i < gven02mt.getTmpSize(); i++) {
			GVEN02MT gven02mt_a = gven02mt.getObject_request(i);
			
			simpleDao.delete("MDM0800201D", gven02mt_a);
			simpleDao.update("MDM0800202U", gven02mt_a);
		}
	}
	
	@Override
	public void venueSynchronize(GVEN02MT gven02mt) throws Exception {
			simpleDao.insert("MDM0800102I", gven02mt);
	}

	@Override
	public void saveTmpVenueGrid_Del(GVEN02MT gven02mt) throws Exception {
		
		for (int i = 0; i < gven02mt.getSize_Admin_Del(); i++) {
			simpleDao.update("MDM0800102U", gven02mt.getObject_Admin_Del(i));
		}
	}
}