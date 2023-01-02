package com.kia.key.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kia.key.model.GKEY01MT;

public interface Key03Service {
	
	public void completeAccreKeymanID(GKEY01MT gkey01mt) throws Exception;
	
	public void errorAccreKeymanID(GKEY01MT gkey01mt) throws Exception;

	public void saveKeymanActiveYN(GKEY01MT gkey01mt) throws Exception;
	
	public void updateKeymanDocComp(GKEY01MT gkey01mt) throws Exception;
	
	public void updateKeymanDocMngFl(GKEY01MT gkey01mt) throws Exception;
	
	public void sendSMS(ArrayList<HashMap<String, String>> smsList) throws Exception;
	
}