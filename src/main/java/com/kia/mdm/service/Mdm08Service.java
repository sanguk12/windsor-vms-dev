package com.kia.mdm.service;

import com.kia.mdm.model.GVEN02MT;


public interface Mdm08Service {

	public void insertVenue(GVEN02MT gven02mt) throws Exception;
	
	public void updateVenue(GVEN02MT gven02mt) throws Exception;
	
	public void saveTmpVenueGrid(GVEN02MT gven02mt) throws Exception;

	public void requestApprTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void clearRequestApprTmpVenue(GVEN02MT gven02mt) throws Exception;
	
	public void venueSynchronize(GVEN02MT gven02mt) throws Exception;

	public void saveTmpVenueGrid_Del(GVEN02MT gven02mt) throws Exception;


}