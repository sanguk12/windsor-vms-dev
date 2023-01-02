package com.kia.mdm.service;

import com.kia.mdm.model.GVEN01MT;


public interface Mdm02Service {

	public void insertVenue(GVEN01MT gven01mt) throws Exception;
	
	public void updateVenue(GVEN01MT gven01mt) throws Exception;
	
	public void saveVenueGrid(GVEN01MT gven01mt) throws Exception;
}