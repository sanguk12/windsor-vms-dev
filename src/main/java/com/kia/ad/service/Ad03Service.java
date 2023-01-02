package com.kia.ad.service;

import com.kia.ad.model.GME01DT;
import com.kia.ad.model.GME01MT;

public interface Ad03Service {

	public void requestUseProcess(GME01MT gme01mt) throws Exception;
	
	public void requestUnUsedProcess(GME01MT gme01mt) throws Exception;
	
	public void savePrdGrid(GME01DT gme01dt) throws Exception;

	public void saveAdList(GME01MT gme01mt) throws Exception;

}