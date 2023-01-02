package com.kia.key.service;

import java.util.HashMap;

import com.kia.key.model.GKEY05MT;
import com.kia.key.model.GKEY06MT;
import com.kia.key.model.GKEY07MT;
import com.kia.key.model.GKEY08MT;

public interface Key04Service {
	
	public void testSignCheck(String output) throws Exception;
	
	public Object signSearch(HashMap param) throws Exception;
	
	public void insertSaleRegist(GKEY05MT gkey05mt, GKEY06MT gkey06mt, GKEY07MT gkey07mt, GKEY08MT gkey08mt) throws Exception;		// 키맨 문서 등록
	public void updateGKEY05MT(GKEY05MT gkey05mt) throws Exception;		// 사업자등록증 등록
}
