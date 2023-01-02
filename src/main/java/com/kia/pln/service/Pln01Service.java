package com.kia.pln.service;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02DT;
import com.kia.pln.model.GPLN02DTs;
import com.kia.pln.model.GPLN02MT;
import com.kia.pln.model.GPLN02MTs;


public interface Pln01Service {

	public void savePlanVenue(GPLN01MT gpln01mt) throws Exception;
	
	public void copyBefMonPlanVenue(GPLN01MT gpln01mt) throws Exception;
	
	public void savePlanVenueWrite(GPLN01MT gpln01mt) throws Exception;
	
	public void copyBefMonPlanVenueWrite(GPLN01MT gpln01mt) throws Exception;
	
	public void requestAppPlanVenue(GPLN01MT gpln01mt) throws Exception;
	
	public void clearRequestAppPlanVenue(GPLN01MT gpln01mt) throws Exception;
	
	public void savePlanBrand(GPLN02MTs gpln02mts) throws Exception;

	public void copyBefMonPlanBrand(GPLN02MT gpln02mt, GPLN02DT gpln02dt) throws Exception;

	public void savePlanBrandWrite(GPLN02DTs gpln02dts) throws Exception;
	
	public void copyBefMonPlanBrandWrite(GPLN02DT gpln02dt) throws Exception;
	
	public void requestAppPlanBrand(GPLN02MT gpln02mt) throws Exception;
	
	public void clearRequestAppPlanBrand(GPLN02MT gpln02mt) throws Exception;
	
	public void requestAppPlan(GPLN01MT gpln01mt) throws Exception;
	
	public void clearRequestAppPlan(GPLN01MT gpln01mt) throws Exception;
}