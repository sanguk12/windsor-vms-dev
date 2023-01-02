package com.kia.sup.service;

import com.kia.sup.model.GSUP01MT;


public interface Sup01Service {
	
	public String insertSupport(GSUP01MT gsup01mt) throws Exception;
	
	public void updateSupport(GSUP01MT gsup01mt) throws Exception;
	
	public void saveSupportKeyman(GSUP01MT gsup01mt) throws Exception;
	
	public void deleteSupport(GSUP01MT gsup01mt) throws Exception;
	
	public void requestPaySupport(GSUP01MT gsup01mt) throws Exception;
	
	public void clearRequestPaySupport(GSUP01MT gsup01mt) throws Exception;
	
	public void requestPaySupport_add(GSUP01MT gsup01mt) throws Exception;
	
	public void clearRequestPaySupport_add(GSUP01MT gsup01mt) throws Exception;
	
	public void saveSupportKeyman_add(GSUP01MT gsup01mt) throws Exception;
	
	public void deleteSupportKeyman_add(GSUP01MT gsup01mt) throws Exception;
}