package com.kia.mdm.service;

import com.kia.mdm.model.GPRD01MT;
import com.kia.mdm.model.GPRD02MTs;


public interface Mdm03Service {

	public void addPrdinfo(GPRD01MT gprd01mt) throws Exception;
	
	public void modifyPrdinfo(GPRD01MT gprd01mt) throws Exception;
	
	public void addPrdGuidAmt(GPRD02MTs gprd02mts) throws Exception;

}