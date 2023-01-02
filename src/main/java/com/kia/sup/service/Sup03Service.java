package com.kia.sup.service;

import com.kia.sup.model.GSUP01MT;


public interface Sup03Service {
	
	public void addMM(GSUP01MT gsup01mt) throws Exception;
	
	public void endContract(GSUP01MT gsup01mt) throws Exception;
	
}