package kr.co.nis.waf.system.biz.service;

import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.ClasseList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("classService")
public class ClassServiceImpl implements ClassService {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	/*
	public void setSimpleDao(SimpleDao simpleDao) {
		this.simpleDao = simpleDao;
	}
	*/
	
	public void saveClass(Map command, ClasseList classes) throws Exception {

		simpleDao.update("commonservice.biz.class.delete", command);

		for (int i = 0; i < classes.getSize(); i++) {
			if (simpleDao.queryForInt("commonservice.biz.classCount.select", classes.getClass(i)) == 0) {
				simpleDao.insert("commonservice.biz.class.insert", classes.getClass(i));
			}
			else {
				simpleDao.update("commonservice.biz.class.update", classes.getClass(i));
			}
		}
	}
}