package com.kia.mdm.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.mdm.model.GPRD01MT;
import com.kia.mdm.model.GPRD02MT;
import com.kia.mdm.model.GPRD02MTs;

@Service("mdm03Service")
public class Mdm03ServiceImpl implements Mdm03Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void addPrdinfo(GPRD01MT gprd01mt) throws Exception {
		//GPRD01MT
		simpleDao.insert("MDM0300103I", gprd01mt);
	}
	
	public void modifyPrdinfo(GPRD01MT gprd01mt) throws Exception {
		simpleDao.update("MDM0300104U", gprd01mt);
	}
	
	public void addPrdGuidAmt(GPRD02MTs gprd02mts) throws Exception {
		simpleDao.delete("MDM0300203D", gprd02mts);
		
		int guidSeq = 0;
		
		for (int i = 0; i < gprd02mts.getSize(); i++) {
			GPRD02MT gprd02mt = gprd02mts.getGPRD02MT(i);
			
			guidSeq = guidSeq + 1;
			gprd02mt.setGuidSeq(String.valueOf(guidSeq));
			
			//GSTK06MT
			simpleDao.insert("MDM0300204I", gprd02mt);
		}
	}
	
}