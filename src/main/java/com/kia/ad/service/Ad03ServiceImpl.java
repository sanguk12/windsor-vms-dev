package com.kia.ad.service;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.ad.model.GME01DT;
import com.kia.ad.model.GME01MT;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.dao.SimpleService;

@Service("ad03Service")
public class Ad03ServiceImpl implements Ad03Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	@Resource
	private SimpleService simpleService;
	
	@Override
	public void requestUseProcess(GME01MT gme01mt) throws Exception {

		for(int i = 0; i < gme01mt.getSize(); i++) {
			simpleDao.update("AD0300101U", gme01mt.getObject(i));
			simpleDao.update("AD0300103U", gme01mt.getObject(i));
		}
	}
	
	@Override
	public void requestUnUsedProcess(GME01MT gme01mt) throws Exception {
		
		for(int i = 0; i < gme01mt.getSize(); i++) {
			simpleDao.update("AD0300102U", gme01mt.getObject(i));
			simpleDao.update("AD0300104U", gme01mt.getObject(i));
		}
		
	}
	
	@Override
	public void savePrdGrid(GME01DT gme01dt) throws Exception {

		for(int i = 0; i < gme01dt.getSize(); i++) {
			simpleDao.insert("AD0300101I", gme01dt.getObject(i));
			simpleDao.update("AD0300106U", gme01dt.getObject(i));
		}
	}

	@Override
	public void saveAdList(GME01MT gme01mt) throws Exception {
		for (int i = 0; i < gme01mt.getSize(); i++) {
			GME01MT gme01mts = gme01mt.getObject(i);
			
			//삭제
			if(gme01mts.getActiveFlg().equals("D")) {
				simpleDao.delete("AD0300101D", gme01mts);
				simpleDao.delete("AD0300102D", gme01mts);
			//수정	
			}else if(gme01mts.getActiveFlg().equals("U")) {
				int cntSeq = simpleDao.queryForInt("AD0300104S", gme01mts);
				
				if(cntSeq > 0) {
					simpleDao.update("AD0300105U", gme01mts);
				}
				else {
					int maxSeq = simpleService.queryForInt("AD0300105S", gme01mts);
					maxSeq = maxSeq + 1;
					gme01mts.setSeq(String.valueOf(maxSeq));
					simpleDao.insert("AD0300102I", gme01mts);
				}
			}
		}
	}

	
}