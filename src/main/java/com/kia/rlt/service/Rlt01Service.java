package com.kia.rlt.service;

import com.kia.pln.model.GPLN01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;


public interface Rlt01Service {

	public void resultCreationVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void saveResultKeymanVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void saveResultWriteVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void requestAppResultVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void clearRequestAppResultVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void resultCreationBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void saveResultWriteBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void requestAppResultBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void clearRequestAppResultBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void requestAppResult(GRLT01MT grlt01mt) throws Exception;
	
	public void clearRequestAppResult(GRLT01MT grlt01mt) throws Exception;
}