package com.kia.ad.service;

import com.kia.ad.model.GCHA01MT;
import com.kia.ad.model.GME01DT;
import com.kia.ad.model.GME01MT;

public interface Ad04Service {

	public void saveChain(GCHA01MT gcha01mt) throws Exception;

	public void saveChainVenue(GCHA01MT gcha01mt) throws Exception;


}