package com.kia.pln.service;

import com.kia.pln.model.GPLN01MT;
import com.kia.pln.model.GPLN02MT;


public interface Pln02Service {

	public void approvalPlanVenue(GPLN01MT gpln01mt) throws Exception;
	
	public void lastApprovalPlanVenue(GPLN01MT gpln01mt) throws Exception;
	
	public void rejectPlanVenue(GPLN01MT gpln01mt) throws Exception;
	
	public void approvalPlanBrand(GPLN02MT gpln02mt) throws Exception;
	
	public void lastApprovalPlanBrand(GPLN02MT gpln02mt) throws Exception;
	
	public void rejectPlanBrand(GPLN02MT gpln02mt) throws Exception;
	
	public void approvalPlanVenue_new(GPLN01MT gpln01mt) throws Exception;
	
	public void lastApprovalPlanVenue_new(GPLN01MT gpln01mt) throws Exception;
	
	public void rejectPlanVenue_new(GPLN01MT gpln01mt) throws Exception;
	
	public void approvalPlan(GPLN01MT gpln01mt) throws Exception;
	
	public void lastApprovalPlan(GPLN01MT gpln01mt) throws Exception;
	
	public void rejectPlan(GPLN01MT gpln01mt) throws Exception;
}