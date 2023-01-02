package com.kia.mdm.service;

import com.kia.mdm.model.GVEN03MT;


public interface Mdm05Service {

	public String insertVenue(GVEN03MT gven03mt) throws Exception;
	
	public void updateVenue(GVEN03MT gven03mt) throws Exception;
	
	public void saveTmpVenueGrid(GVEN03MT gven03mt) throws Exception;

	public void requestApprTmpVenue(GVEN03MT gven03mt) throws Exception;

	public void clearRequestApprTmpVenue(GVEN03MT gven03mt) throws Exception;

	public void lastApprovalTmpVenue(GVEN03MT gven03mt) throws Exception;

	public void approvalTmpVenue(GVEN03MT gven03mt) throws Exception;

	public void rejectTmpVenue(GVEN03MT gven03mt) throws Exception;

	public void printChk(GVEN03MT gven03mt) throws Exception;

	public void resetTmpVenue(GVEN03MT gven03mt) throws Exception;

	public void excelCount(GVEN03MT gven03mt) throws Exception;

	public void excelSeq(GVEN03MT gven03mt) throws Exception;

}