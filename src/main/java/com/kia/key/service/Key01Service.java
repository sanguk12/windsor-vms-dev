package com.kia.key.service;

import com.kia.key.model.GKEY01MT;


public interface Key01Service {
	
	public void addKeymanID(GKEY01MT gkey01mt) throws Exception;
	
	public void updateKeymanID(GKEY01MT gkey01mt) throws Exception;
	
	public void modifyKeymanID(GKEY01MT gkey01mt) throws Exception;
	
	public void deleteKeymanID(GKEY01MT gkey01mt) throws Exception;

	public void addKeymanID_m(GKEY01MT gkey01mt) throws Exception;
	
	public void updateKeymanID_m(GKEY01MT gkey01mt) throws Exception;
	
	public void modifyKeymanID_m(GKEY01MT gkey01mt) throws Exception;
	
	public void deleteKeymanID_m(GKEY01MT gkey01mt) throws Exception;
}