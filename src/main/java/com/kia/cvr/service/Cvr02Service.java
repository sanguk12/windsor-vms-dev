package com.kia.cvr.service;

import com.kia.cvr.model.GCVR02MTs;

public interface Cvr02Service {
	
	public void requestApp(GCVR02MTs gcvr02mts) throws Exception;
	
	public void saveApprReq(GCVR02MTs gcvr02mts) throws Exception;
	
	public void saveApprReqCancel(GCVR02MTs gcvr02mts) throws Exception;
	
	public void saveApproval(GCVR02MTs gcvr02mts) throws Exception;
	
	public void saveApprReject(GCVR02MTs gcvr02mts) throws Exception;
}