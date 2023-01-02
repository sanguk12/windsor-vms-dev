package com.kia.ltc.service;

import com.kia.ltc.model.GLTC01MT;

public interface Ltc02Service {
	
	public void lastApprovalSupport(GLTC01MT gltc01mt) throws Exception;
	
	public void approvalSupport(GLTC01MT gltc01mt) throws Exception;

	public void rejectSupport(GLTC01MT gltc01mt) throws Exception;

	public void lastApprovalContractCancel(GLTC01MT gltc01mt) throws Exception;

	public void approvalContractCancel(GLTC01MT gltc01mt) throws Exception;

	public void rejectContractCancel(GLTC01MT gltc01mt) throws Exception;
	
}
