package kr.co.nis.waf.system.auth.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.auth.model.Group;
import kr.co.nis.waf.system.auth.model.GroupUser;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("groupService")
public class GroupServiceImpl implements GroupService {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	private SimpleDao simpleDao;
	
	public void deleteGroup(Group group) throws Exception {
		
		if (group.getGrpIDs() != null) {
			for(int i=0;i<group.getGrpIDs().length;i++) {
				group.setGrpID(group.getGrpIDs()[i]);
				
				//F_Group
				simpleDao.delete("CMP0100906D", group);
			}
		} 
		else {
			//F_Group
			simpleDao.delete("CMP0100906D", group);
		}
	}

	public void addGroupUser(Group group) throws Exception {
		GroupUser groupUser = null;
		if(group.getUserIDs()!=null) {
			for(int i=0; i < group.getUserIDs().length;i++) {
				groupUser = new GroupUser();
				groupUser.setCompanyID(group.getCompanyID());
				groupUser.setGrpID(group.getGrpID());
				groupUser.setUserID(group.getUserIDs()[i]);
				//F_GroupUser
				//simpleDao.insert("CMP0100810I", groupUser);
				simpleDao.update("commonservice.auth.groupUser.update", groupUser);
			}
		}
	}
}
