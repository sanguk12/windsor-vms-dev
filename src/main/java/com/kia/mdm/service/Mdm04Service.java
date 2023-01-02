package com.kia.mdm.service;

import java.util.Map;

import com.kia.mdm.model.GDAT01MT;
import com.kia.mdm.model.GEVN01MTs;
import com.kia.mdm.model.GEVN02MTs;


public interface Mdm04Service {
	
	public void saveEventRegDate(GEVN01MTs gevn01mts) throws Exception;
	
	public void saveResultRegDate(GEVN02MTs gevn02mts) throws Exception;
	
	public void insertBatSchedule(GDAT01MT gdat01mt)throws Exception;

}