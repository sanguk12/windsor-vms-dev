package kr.co.nis.waf.system.auth.service;

import kr.co.nis.waf.system.auth.model.GroupUser;
import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.system.auth.model.UserExtend;

public interface UserService {

	public void removeUser(User user, GroupUser groupUser) throws Exception;

	public void saveUser(User user, GroupUser groupUser) throws Exception;
	
	public void saveUser(UserExtend userExtend, GroupUser groupUser) throws Exception;
}