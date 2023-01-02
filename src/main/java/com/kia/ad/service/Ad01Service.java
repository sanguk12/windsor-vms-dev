package com.kia.ad.service;

import com.kia.ad.model.GAD01MT;
import com.kia.rlt.model.GRLT01MT;

public interface Ad01Service {

	public void requestAppResultAD(GAD01MT gad01mt) throws Exception;

	public void clearRequestAppResultAD(GAD01MT gad01mt) throws Exception;

	public String insertSupport(GAD01MT gad01mt);

	public void updateSupport(GAD01MT gad01mt);
	
}