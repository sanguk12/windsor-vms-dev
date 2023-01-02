package com.kia.rlt.service;

import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;


public interface Rlt02Service {

	public void approvalResultVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void lastApprovalResultVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void rejectResultVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void approvalResultBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void lastApprovalResultBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void rejectResultBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void approvalResultVenue_apprType(GRLT01MT grlt01mt) throws Exception;
	
	public void lastApprovalResultVenue_apprType(GRLT01MT grlt01mt) throws Exception;
	
	public void approvalResultVenue_new(GRLT01MT grlt01mt) throws Exception;
	
	public void lastApprovalResultVenue_new(GRLT01MT grlt01mt) throws Exception;
	
	public void rejectResultVenue_new(GRLT01MT grlt01mt) throws Exception;
	
	public void approvalResult(GRLT01MT grlt01mt) throws Exception;
	
	public void lastApprovalResult(GRLT01MT grlt01mt) throws Exception;
	
	public void rejectResult(GRLT01MT grlt01mt) throws Exception;
}