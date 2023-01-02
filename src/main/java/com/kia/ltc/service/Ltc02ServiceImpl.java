package com.kia.ltc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.ltc.model.GLTC01MT;

@Service("ltc02Service")
public class Ltc02ServiceImpl implements Ltc02Service {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Override
	public void lastApprovalSupport(GLTC01MT gltc01mt) throws Exception {
		Map plnMap = new HashMap();
		List list = new ArrayList();
		String [] eventYM;
		gltc01mt.setApprStateCD("50");
		simpleDao.update("LTC0200101U", gltc01mt);
		simpleDao.update("LTC0200102U", gltc01mt);
		
		plnMap = simpleDao.queryForMap("LTC0200104S",gltc01mt);
		eventYM = new String[Integer.parseInt(plnMap.get("contractMonthCt").toString())];
		list = simpleDao.queryForList("LTC0200105S",gltc01mt);
		
		for(int j=0; j<eventYM.length;j++){
			if(j==0){
				eventYM[j] = plnMap.get("contractDateFrom").toString();
			}else{
				int yyyy = Integer.parseInt(eventYM[j-1].substring(0, 4));
				int mm = Integer.parseInt(eventYM[j-1].substring(4, 6))+1;
				String year = null;
				String month = null;
				if(mm>12){
					year=String.valueOf(yyyy+1);
					month=String.valueOf(mm-12);
					
				}else{
					year=String.valueOf(yyyy);
					month=String.valueOf(mm);
				}
				if (month.length() < 2){month = "0" + month;}
				eventYM[j] = year + month;
			}
		}
		
		if (plnMap.size() > 0) {
			for (int k = 0; k < eventYM.length; k++) {
				plnMap.put("eventYM", eventYM[k]);
				simpleDao.insert("LTC0200101I", plnMap);
				for (int i = 0; i < list.size(); i++) {
					Map dtMap = new HashMap();
					dtMap = (Map) list.get(i);
					dtMap.put("eventYM", eventYM[k]);
					dtMap.put("empID", plnMap.get("empID"));
					if (dtMap.get("supportID") != null) {
						simpleDao.insert("LTC0200102I", dtMap);
					}
				}
				plnMap.remove("eventYM");
			}
		}
	}

	@Override
	public void approvalSupport(GLTC01MT gltc01mt) throws Exception {
		if(gltc01mt.getLevelNo().equals("2")){
			gltc01mt.setApprStateCD("30");
			simpleDao.update("LTC0200101U", gltc01mt);
			simpleDao.update("LTC0200102U", gltc01mt);
			simpleDao.update("LTC0200103U", gltc01mt);
		}else {
			simpleDao.update("LTC0200102U", gltc01mt);
			simpleDao.update("LTC0200103U", gltc01mt);
		}
	}

	@Override
	public void rejectSupport(GLTC01MT gltc01mt) throws Exception {
		gltc01mt.setApprStateCD("40");
		simpleDao.update("LTC0200101U",gltc01mt);
		simpleDao.update("LTC0200104U",gltc01mt);
	}

	@Override
	public void lastApprovalContractCancel(GLTC01MT gltc01mt) throws Exception {
		List plnList = new ArrayList();
		gltc01mt.setApprStateCD("60");
		simpleDao.update("LTC0200101U", gltc01mt);
		simpleDao.update("LTC0200102U", gltc01mt);
		
		plnList = simpleDao.queryForList("LTC0200106S",gltc01mt);
		
		if (plnList.size() > 0) {
			for (int i = 0; i < plnList.size(); i++) {
				Map plnMap = new HashMap();
				plnMap = (Map) plnList.get(i);
				if(plnMap.get("activeFlg").equals("D")){
					simpleDao.delete("LTC0200101D", plnMap);
					simpleDao.delete("LTC0200102D", plnMap);
				}else if(plnMap.get("activeFlg").equals("U")){
					simpleDao.update("LTC0200105U", plnMap);
				}
			}
		}
	}

	@Override
	public void approvalContractCancel(GLTC01MT gltc01mt) throws Exception {
		simpleDao.update("LTC0200102U", gltc01mt);
		simpleDao.update("LTC0200103U", gltc01mt);
	}

	@Override
	public void rejectContractCancel(GLTC01MT gltc01mt) throws Exception {
		gltc01mt.setApprStateCD("40");
		simpleDao.update("LTC0200104U",gltc01mt);
	}
}
