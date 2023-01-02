package com.kia.pay.service;

import com.kia.mil.model.GMIL01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;


public interface Pay03Service {

	public void verifyFinishVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void verifyErrorVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void verifyFinishBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void verifyErrorBrand(GRLT02MT grlt02mt) throws Exception;

	public void verifyFinishMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void verifyErrorMileage(GMIL01MT gmil01mt) throws Exception;
	
}