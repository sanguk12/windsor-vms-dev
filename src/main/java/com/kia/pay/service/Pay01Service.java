package com.kia.pay.service;

import com.kia.mil.model.GMIL01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;


public interface Pay01Service {

	public void saveResultWriteVenue_err(GRLT01MT grlt01mt) throws Exception;
	
	public void requestAppResultVenue_err(GRLT01MT grlt01mt) throws Exception;
	
	public void clearRequestAppResultVenue_err(GRLT01MT grlt01mt) throws Exception;
	
	public void saveResultWriteBrand_err(GRLT02MT grlt02mt) throws Exception;
	
	public void requestAppResultBrand_err(GRLT02MT grlt02mt) throws Exception;
	
	public void clearRequestAppResultBrand_err(GRLT02MT grlt02mt) throws Exception;

	public void saveResultWriteMileage_err(GMIL01MT gmil01mt) throws Exception;
	
	public void requestAppResultMileage_err(GMIL01MT gmil01mt) throws Exception;
	
	public void clearRequestAppResultMileage_err(GMIL01MT gmil01mt) throws Exception;
}