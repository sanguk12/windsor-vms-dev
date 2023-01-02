package com.kia.ltc.service;

import java.util.Map;

import com.kia.ltc.model.GLTC01MT;

public interface Ltc01Service {
	
	public String insertSupport(GLTC01MT gltc01mt) throws Exception;
	
	public void updateSupport(GLTC01MT gltc01mt) throws Exception;

	public void deleteSupport(GLTC01MT gltc01mt) throws Exception;

	public void requestApp(GLTC01MT gltc01mt) throws Exception;

	public void clearRequestApp(GLTC01MT gltc01mt) throws Exception;

	public void updatePlanQty(String venueCD, Map<String,String[]> plnParam) throws Exception;

	public void contractCancel(GLTC01MT gltc01mt) throws Exception;

}
