package com.kia.pay.service;

import com.kia.mil.model.GMIL01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;


public interface Pay02Service {

	public void approvalResultVenue_err(GRLT01MT grlt01mt) throws Exception;
	
	public void lastApprovalResultVenue_err(GRLT01MT grlt01mt) throws Exception;
	
	public void rejectResultVenue_err(GRLT01MT grlt01mt) throws Exception;
	
	public void approvalResultBrand_err(GRLT02MT grlt02mt) throws Exception;
	
	public void lastApprovalResultBrand_err(GRLT02MT grlt02mt) throws Exception;
	
	public void rejectResultBrand_err(GRLT02MT grlt02mt) throws Exception;

	public void approvalResultMileage_err(GMIL01MT gmil01mt) throws Exception;
	
	public void lastApprovalResultMileage_err(GMIL01MT gmil01mt) throws Exception;
	
	public void rejectResultMileage_err(GMIL01MT gmil01mt) throws Exception;
}