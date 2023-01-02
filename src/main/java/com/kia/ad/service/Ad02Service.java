package com.kia.ad.service;

import com.kia.ad.model.GAD01MT;
import com.kia.ad.model.GME01DT;
import com.kia.ad.model.GME01MT;

public interface Ad02Service {

	public void approvalResultAD(GAD01MT gad01mt) throws Exception;

	public void lastApprovalResultAD(GAD01MT gad01mt) throws Exception;

	public void rejectResultAD(GAD01MT gad01mt) throws Exception;

	public void finishContractAD(GAD01MT gad01mt) throws Exception;

	public void finishPayAD(GAD01MT gad01mt) throws Exception;

	public void tmpInsertSupport(GAD01MT gad01mt) throws Exception;

	public void tmpModifySupport(GAD01MT gad01mt) throws Exception;

	public void requestContractAppResultAD(GAD01MT gad01mt) throws Exception;

	public void clearRequestContractAppResultAD(GAD01MT gad01mt) throws Exception;

	public void lastContractApprovalAD(GAD01MT gad01mt) throws Exception;

	public void contractApprovalAD(GAD01MT gad01mt) throws Exception;

	public void contractRejectAD(GAD01MT gad01mt) throws Exception;

	public void afterDateDelay(GAD01MT gad01mt) throws Exception;
	
	public void tmpSaveSupportRequestAD(GAD01MT gad01mt) throws Exception;

}