package kr.co.nis.waf.system.common.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.orm.WafSqlMapClientDaoSupport;
import kr.co.nis.waf.system.common.model.SwitchObject;
import kr.co.nis.waf.view.SimpleDoc;

import org.springframework.dao.DataAccessException;
import org.springframework.web.servlet.ModelAndViewDefiningException;

/** 
 * 프레임워크에서 제공하는 공통 Dao 구현 클래스
 * iBATIS 를 이용하여 query_xx.xml 파일을 쿼리 저장소로 사용  
 * @version: 1.0
 * @author: NuriInfos Lab (admin@nis.co.kr)
 */
public class SimpleSqlMapClientDaoImpl extends WafSqlMapClientDaoSupport implements SimpleDao {

	SwitchObject switchObject = new SwitchObject();
	
	public void delete(Map parameters) throws DataAccessException {
		getSqlMapClientTemplate().update((String) parameters.get("queryKey"), parameters);
	}

	public void delete(Map parameters, Object obj) throws DataAccessException {
		getSqlMapClientTemplate().update((String) parameters.get("queryKey"), obj);
	}

	public void delete(String queryKey, Map parameters) throws DataAccessException {
		getSqlMapClientTemplate().update(queryKey, parameters);
	}

	public void delete(String queryKey, Object obj) throws DataAccessException {
		getSqlMapClientTemplate().update(queryKey, obj);
	}

	public void insert(Map parameters) throws DataAccessException {
		getSqlMapClientTemplate().update((String) parameters.get("queryKey"), parameters);
	}

	public void insert(Map parameters, Object obj) throws DataAccessException {
		getSqlMapClientTemplate().update((String) parameters.get("queryKey"), obj);
	}

	public void insert(String queryKey, Map parameters) throws DataAccessException {
		getSqlMapClientTemplate().update(queryKey, parameters);
	}

	public void insert(String queryKey, Object obj) throws DataAccessException {
		getSqlMapClientTemplate().update(queryKey, obj);
	}

	public int queryForInt(Map parameters) throws DataAccessException {
		return Integer.parseInt(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(
				(String) parameters.get("queryKey"), parameters)));
	}

	public int queryForInt(Map parameters, Object obj) throws DataAccessException {
		return Integer.parseInt(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(
				(String) parameters.get("queryKey"), obj)));
	}

	public int queryForInt(String queryKey, Map parameters) throws DataAccessException {
		return Integer
				.parseInt(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(queryKey, parameters)));
	}

	public int queryForInt(String queryKey, Object obj) throws DataAccessException {
		return Integer.parseInt(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(queryKey, obj)));
	}

	public List queryForList(Map parameters) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList((String) parameters.get("queryKey"), parameters);
	}

	public List queryForList(Map parameters, Object obj) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList((String) parameters.get("queryKey"), obj);
	}

	public List queryForList(String queryKey, Map parameters) throws DataAccessException {
		List result = new ArrayList();
		result = getSqlMapClientTemplate().queryForList(queryKey, parameters);
		return result;
	}

	public List queryForList(String queryKey, Object obj) throws DataAccessException {
		List result = new ArrayList();
		result = getSqlMapClientTemplate().queryForList(queryKey, obj);
		return result;
	}

	public long queryForLong(Map parameters) throws DataAccessException {
		return Long.parseLong(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(
				(String) parameters.get("queryKey"), parameters)));
	}

	public long queryForLong(Map parameters, Object obj) throws DataAccessException {
		return Long.parseLong(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(
				(String) parameters.get("queryKey"), obj)));
	}

	public long queryForLong(String queryKey, Map parameters) throws DataAccessException {
		return Long.parseLong(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(queryKey, parameters)));
	}

	public long queryForLong(String queryKey, Object obj) throws DataAccessException {
		return Long.parseLong(String.valueOf((Object) getSqlMapClientTemplate().queryForObject(queryKey, obj)));
	}

	public Map queryForMap(Map parameters) throws DataAccessException {
		return (Map) getSqlMapClientTemplate().queryForObject((String) parameters.get("queryKey"), parameters);
	}

	public Map queryForMap(Map parameters, Object obj) throws DataAccessException {
		return (Map) getSqlMapClientTemplate().queryForObject((String) parameters.get("queryKey"), obj);
	}

	public Map queryForMap(String queryKey, Map parameters) throws DataAccessException {
		return (Map) getSqlMapClientTemplate().queryForObject(queryKey, parameters);
	}

	public Map queryForMap(String queryKey, Object obj) throws DataAccessException {
		return (Map) getSqlMapClientTemplate().queryForObject(queryKey, obj);
	}

	public Object queryForObject(Map parameters) throws DataAccessException {
		return getSqlMapClientTemplate().queryForObject((String) parameters.get("queryKey"), parameters);
	}

	public Object queryForObject(Map parameters, Object obj) throws DataAccessException {
		return getSqlMapClientTemplate().queryForObject((String) parameters.get("queryKey"), obj);
	}

	public Object queryForObject(String queryKey, Map parameters) throws DataAccessException {
		return getSqlMapClientTemplate().queryForObject(queryKey, parameters);
	}

	public Object queryForObject(String queryKey, Object obj) throws DataAccessException {
		return getSqlMapClientTemplate().queryForObject(queryKey, obj);
	}

	public int update(Map parameters) throws DataAccessException {
		return getSqlMapClientTemplate().update((String) parameters.get("queryKey"), parameters);
	}

	public int update(Map parameters, Object obj) throws DataAccessException {
		return getSqlMapClientTemplate().update((String) parameters.get("queryKey"), obj);
	}

	public int update(String queryKey, Map parameters) throws DataAccessException {
		return getSqlMapClientTemplate().update(queryKey, parameters);
	}

	public int update(String queryKey, Object obj) throws DataAccessException {
		int result = 0;
		result = getSqlMapClientTemplate().update(queryKey, obj);
		return result;
	}
	
//	//true:using
//	public boolean checkSwitchSoultion(String queryKey) {
//		boolean result =true;
//		if(switchObject.getTestModuleYN().equals("N")) {
//			if(switchObject.getTestModule_queryKeys().contains(queryKey)) {
//				logger.debug("$$$$$$$$$switchObject.getTestModule_queryKeys() : "+switchObject.getTestModule_queryKeys());
//				result = false;
//			}
//		}
//		else {
//			result = true;
//		}
//		logger.debug("$$$$$$$$$result : "+result);
//		return result;
//	}
	
}