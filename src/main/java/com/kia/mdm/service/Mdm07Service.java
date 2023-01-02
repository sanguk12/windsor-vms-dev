package com.kia.mdm.service;

import com.kia.mdm.model.GVEN02MT;
import com.kia.mdm.model.GVEN03MT;


public interface Mdm07Service {

	public void saveRmTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void requestApprRmTmpVenue(GVEN02MT gven02mt) throws Exception;
	
	public void clearRequestApprRmTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void lastApprovalRmTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void approvalRmTmpVenue(GVEN02MT gven02mt) throws Exception;

	public void rejectRmTmpVenue(GVEN02MT gven02mt) throws Exception;
	
	public void updatePrintYN(GVEN02MT gven02mt) throws Exception;
	
	

}