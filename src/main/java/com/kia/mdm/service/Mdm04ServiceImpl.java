package com.kia.mdm.service;

import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.dao.SimpleService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mdm.model.GDAT01MT;
import com.kia.mdm.model.GEVN01MT;
import com.kia.mdm.model.GEVN01MTs;
import com.kia.mdm.model.GEVN02MT;
import com.kia.mdm.model.GEVN02MTs;

@Service("mdm04Service")
public class Mdm04ServiceImpl implements Mdm04Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private SimpleService simpleService;
	
	public void saveEventRegDate(GEVN01MTs gevn01mts) throws Exception {
		for (int i = 0; i < gevn01mts.getSize(); i++) {
			GEVN01MT gevn01mt = gevn01mts.getGEVN01MT(i);
			
			if(gevn01mt.getActiveFlg().equals("D")) {
				simpleDao.delete("MDM0400107D", gevn01mt);
			}
			else if(gevn01mt.getActiveFlg().equals("U")) {
				int cntSeq = simpleDao.queryForInt("MDM0400102S", gevn01mt);
				if(cntSeq > 0) {
					//seq가 있는지 없는지 확인, 있으면 업데이트 없으면 인서트
					int eventSeq = simpleService.queryForInt("MDM0400104S", gevn01mt);

					if(eventSeq > 0) {
						simpleDao.update("MDM0400106U", gevn01mt);
					}
					else {
						int maxSeq = simpleService.queryForInt("MDM0400103S", gevn01mt);
						maxSeq = maxSeq + 1;
						gevn01mt.setEventSeq(String.valueOf(maxSeq));
						simpleDao.insert("MDM0400105I", gevn01mt);
					}
				}
				else {
					int maxSeq = simpleDao.queryForInt("MDM0400103S", gevn01mt);
					maxSeq = maxSeq + 1;
					gevn01mt.setEventSeq(String.valueOf(maxSeq));
					simpleDao.insert("MDM0400105I", gevn01mt);
				}
			}
		}
	}
	
	public void saveResultRegDate(GEVN02MTs gevn02mts) throws Exception {
		for (int i = 0; i < gevn02mts.getSize(); i++) {
			GEVN02MT gevn02mt = gevn02mts.getGEVN02MT(i);
			if(gevn02mt.getActiveFlg().equals("D")) {
				simpleDao.delete("MDM0400202D", gevn02mt);
			}
			else if(gevn02mt.getActiveFlg().equals("U")) {
				int cnt = simpleDao.queryForInt("MDM0400203S", gevn02mt);
				if(cnt > 0) {
					simpleDao.update("MDM0400204U", gevn02mt);
				}
				else {
					simpleDao.insert("MDM0400205I", gevn02mt);
				}
				
			}
			
		}
	}

	@Override
	public void insertBatSchedule(GDAT01MT gdat01mt) throws Exception {
		
		// TODO Auto-generated method stub
		System.out.println("==================service==================");
		System.out.println(gdat01mt);
		System.out.println("==================service==================");
		//simpleService.queryForMap("MDM0400209S", gdat01mt);
		simpleDao.insert("MDM0400206I",gdat01mt);
		
	}
	
}