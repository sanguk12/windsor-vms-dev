package com.kia.sup.service;

import com.kia.sup.model.GSUP01MT;


public interface Sup02Service {
	
	public void approvalSupport(GSUP01MT gsup01mt) throws Exception;
	
	public void rejectSupport(GSUP01MT gsup01mt) throws Exception;
	
	public void approvalSupport_add(GSUP01MT gsup01mt) throws Exception;
	
	public void rejectSupport_add(GSUP01MT gsup01mt) throws Exception;
	
}