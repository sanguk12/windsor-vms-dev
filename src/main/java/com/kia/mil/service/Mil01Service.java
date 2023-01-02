package com.kia.mil.service;

import com.kia.mil.model.GMIL01MT;


public interface Mil01Service {
	
	public String insertMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void updateMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void saveMileageKeyman(GMIL01MT gmil01mt) throws Exception;
	
	public void deleteMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void requestPayMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void clearRequestPayMileage(GMIL01MT gmil01mt) throws Exception;

	public void updateMileageRlt(GMIL01MT gmil01mt) throws Exception;
	
	public void deleteMileageRlt(GMIL01MT gmil01mt) throws Exception;
	
	public void requestPayMileageRlt(GMIL01MT gmil01mt) throws Exception;
	
	public void clearRequestPayMileageRlt(GMIL01MT gmil01mt) throws Exception;
	/*
	public void requestPayMileage_add(GMIL01MT gmil01mt) throws Exception;
	
	public void clearRequestPayMileage_add(GMIL01MT gmil01mt) throws Exception;
	
	public void saveMileageKeyman_add(GMIL01MT gmil01mt) throws Exception;
	
	public void deleteMileageKeyman_add(GMIL01MT gmil01mt) throws Exception;
	*/
}