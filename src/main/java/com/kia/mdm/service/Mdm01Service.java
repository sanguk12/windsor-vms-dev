package com.kia.mdm.service;

import com.kia.mdm.model.GAPP01MT;
import com.kia.mdm.model.GEMP01MT;
import com.kia.mdm.model.GEMP01MTs;
import com.kia.mdm.model.GVEN01MT;


public interface Mdm01Service {

	public void insertAppr(GAPP01MT gapp01mt) throws Exception;
	
	public void updateAppr(GAPP01MT gapp01mt) throws Exception;
	
	public void deleteAppr(GAPP01MT gapp01mt) throws Exception;
	
	public void insertApprGrp(GAPP01MT gapp01mt) throws Exception;
	
	public void updateApprGrp(GAPP01MT gapp01mt) throws Exception;
	
	public void deleteApprGrp(GAPP01MT gapp01mt) throws Exception;
	
	public void addEmployee(GEMP01MT gemp01mt) throws Exception;
	
	public void modifyEmployee(GEMP01MT gemp01mt) throws Exception;
	
}