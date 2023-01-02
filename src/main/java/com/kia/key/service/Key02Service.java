package com.kia.key.service;

import com.kia.key.model.GKEY01MT;

public interface Key02Service {

	public void approvalKeymanID(GKEY01MT gkey01mt) throws Exception;
	
	public void lastApprovalKeymanID(GKEY01MT gkey01mt) throws Exception;
	
	public void rejectKeymanID(GKEY01MT gkey01mt) throws Exception;
}