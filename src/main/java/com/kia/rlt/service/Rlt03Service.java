package com.kia.rlt.service;

import com.kia.rlt.model.GRLT01MT;
import com.kia.rlt.model.GRLT05MT;


public interface Rlt03Service {

	public void insertResultDiffNo_G2(GRLT05MT grlt05mt) throws Exception;
	
	public void updateResultDiffNo_G2(GRLT05MT grlt05mt) throws Exception;
	
	public void deleteResultDiffNo_G2(GRLT05MT grlt05mt) throws Exception;
	
	public void resultCreation(GRLT01MT grlt01mt) throws Exception;
	
	public void determineResult(GRLT01MT grlt01mt) throws Exception;
	
	public void determineCancelResult(GRLT01MT grlt01mt) throws Exception;
}