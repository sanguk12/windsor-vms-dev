package com.kia.pay.service;

import com.kia.mil.model.GMIL01MT;
import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT02MT;
import com.kia.sup.model.GSUP01MT;


public interface Pay04Service {

	public void applicationPayVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void reVerifyReq(GRLT01MT grlt01mt) throws Exception;
	
	public void approvalPayVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void rejectPayVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void finishPayVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void holdPayVenue(GRLT01MT grlt01mt) throws Exception;
	
	public void savePayCommVenue(GRLT01MT grlt01mt) throws Exception;

	public void payDueDateSave(GRLT01MT grlt01mt) throws Exception;
	
	public void saveKeymanVenue_G2(GRLT01MT grlt01mt) throws Exception;
	
	public void finishPaySupport(GSUP01MT gsup01mt) throws Exception;
	
	public void holdPaySupport(GSUP01MT gsup01mt) throws Exception;
	
	public void savePayCommSupport(GSUP01MT gsup01mt) throws Exception;

	public void payDueDateSaveSupport(GSUP01MT gsup01mt) throws Exception;

	public void saveKeymanBrand(GRLT02MT grlt02mt) throws Exception;

	public void applicationPayBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void reVerifyReqBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void approvalPayBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void rejectPayBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void finishPayBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void holdPayBrand(GRLT02MT grlt02mt) throws Exception;
	
	public void savePayCommBrand(GRLT02MT grlt02mt) throws Exception;

	public void payDueDateSaveBrand(GRLT02MT grlt02mt) throws Exception;

	public void finishPayMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void holdPayMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void savePayCommMileage(GMIL01MT gmil01mt) throws Exception;

	public void payDueDateSaveMileage(GMIL01MT gmil01mt) throws Exception;

	public void applicationPayMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void reVerifyReqMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void approvalPayMileage(GMIL01MT gmil01mt) throws Exception;
	
	public void rejectPayMileage(GMIL01MT gmil01mt) throws Exception;
	
}