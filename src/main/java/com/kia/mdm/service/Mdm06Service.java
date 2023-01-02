package com.kia.mdm.service;

import com.kia.mdm.model.GVEN02MT;
import com.kia.mdm.model.GVEN03MT;


public interface Mdm06Service {

	public String modifyTmpVenue_insert(GVEN02MT gven02mt) throws Exception;
	
	public void modifyTmpVenue_update(GVEN02MT gven02mt) throws Exception;
	
	public void modifyTmpVenueGrid(GVEN02MT gven02mt) throws Exception;

	public void requestApprMdfTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void clearRequestApprMdfTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void lastApprovalMdfTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void approvalMdfTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void rejectMdfTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void resetModifyTmpVenue(GVEN02MT gven02mt) throws Exception;

}