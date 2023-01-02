package kr.co.nis.waf.system.auth.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.auth.model.GroupUser;
import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.system.auth.model.UserExtend;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements UserService {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	private SimpleDao simpleDao;
	
	public void removeUser(User user, GroupUser groupUser) throws Exception {
		//F_User
		simpleDao.update("CMP0100809U", user);
		//F_GroupUser
		simpleDao.delete("CMP0100811D", groupUser);
	}

	public void saveUser(User user, GroupUser groupUser) throws Exception {
		User temp = new User();
		temp.setCompanyID(user.getCompanyID());
		temp.setUserID(user.getUserID());
		
		if (simpleDao.queryForInt("CMP0100804S", temp) != 0) { //F_User
			//F_User
			simpleDao.update("CMP0100805U", user);
			//F_GroupUser
			simpleDao.delete("CMP0100811D", groupUser);
			//F_GroupUser
			simpleDao.insert("CMP0100810I", groupUser);
		}
		else {
			//F_User
			simpleDao.insert("CMP0100806I", user);
			//F_GroupUser
			simpleDao.insert("CMP0100810I", groupUser);
		}
	}
	
	public void saveUser(UserExtend user, GroupUser groupUser) throws Exception {
		
		User temp = new User();
		temp.setCompanyID(user.getCompanyID());
		temp.setUserID(user.getUserID());
		
		if (simpleDao.queryForInt("CMP0100804S", temp) != 0) { //F_User
			//F_User
			simpleDao.update("CMP0100805U", user);
			//F_User_X_Package
			simpleDao.update("CMP0100808U", user);
			//F_GroupUser
			simpleDao.delete("CMP0100811D", groupUser);
			//F_GroupUser
			simpleDao.insert("CMP0100810I", groupUser);

		}
		else {
			//F_User
			simpleDao.insert("CMP0100806I", user);
			//F_User_X_Package
			simpleDao.insert("CMP0100807I", user);
			//F_GroupUser
			simpleDao.insert("CMP0100810I", groupUser);
		}
	}
	
}
