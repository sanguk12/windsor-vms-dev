package com.kia.pln.service;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02DTs;

public interface Pln03Service {

	public void savePlanVenueChg(GPLN01MT gpln01mt) throws Exception;
	
	public void savePlanBrandChg(GPLN02DTs gpln02dts) throws Exception;

}