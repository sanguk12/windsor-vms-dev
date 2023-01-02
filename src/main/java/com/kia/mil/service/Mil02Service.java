package com.kia.mil.service;

import com.kia.mil.model.GMIL01MT;


public interface Mil02Service {
	
	public void approvalMileage(GMIL01MT gmil01mt) throws Exception;

	public void lastApprovalMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void rejectMileage(GMIL01MT gmil01mt) throws Exception;

	public void approvalMileageRlt(GMIL01MT gmil01mt) throws Exception;

	public void lastApprovalMileageRlt(GMIL01MT gmil01mt) throws Exception;
	
	public void rejectMileageRlt(GMIL01MT gmil01mt) throws Exception;
	/*
	public void approvalMileage_add(GMIL01MT gmil01mt) throws Exception;
	
	public void rejectMileage_add(GMIL01MT gmil01mt) throws Exception;
	*/
	
}