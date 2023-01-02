package kr.co.nis.waf.system.auth.service;

import kr.co.nis.waf.system.auth.model.Group;


public interface GroupService {

	public void deleteGroup(Group group) throws Exception;
	public void addGroupUser(Group group) throws Exception;
}
