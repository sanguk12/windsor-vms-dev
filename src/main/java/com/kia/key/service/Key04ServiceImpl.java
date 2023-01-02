package com.kia.key.service;

import java.io.IOException;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import oracle.sql.CLOB;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.key.model.GKEY05MT;
import com.kia.key.model.GKEY06MT;
import com.kia.key.model.GKEY07MT;
import com.kia.key.model.GKEY08MT;

@Service("key04Service")
public class Key04ServiceImpl implements Key04Service {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void testSignCheck(String output) throws Exception {
		simpleDao.insert("KEY04001I01", output);
	}
	
	public Object signSearch(HashMap map) throws Exception {
		Map o = (Map)simpleDao.queryForObject("KEY0400105S", map);
		
		if(o != null) {
			o.put("signvector1", extractClob((Clob) o.get("SIGNVECTOR1"))) ;
			o.put("signvector2", extractClob((Clob) o.get("SIGNVECTOR2"))) ;
			return o;
		}
		
		return o;
	}
	
	public static String extractClob(Clob clob) throws SQLException {
		final int length = (int) ((Clob)clob).length();
		final char [] buffer = new char [length];
		int charactersRead;
		try {
			charactersRead = clob.getCharacterStream().read(buffer, 0, length);
		} catch (IOException e) {
			throw new RuntimeException("CLOB를 읽는데 문제가 발생했습니다:",e);
		}
		return new String(buffer,0,charactersRead);
	}
	
	public void insertSaleRegist(GKEY05MT gkey05mt, GKEY06MT gkey06mt, GKEY07MT gkey07mt, GKEY08MT gkey08mt) throws Exception {
		HashMap param = new HashMap();
		
		if(gkey05mt.getKeymanDocTpCd().equals("100")) {
			simpleDao.insert("KEY0400101I", gkey05mt);
			simpleDao.insert("KEY0400102I", gkey06mt);
			if(simpleDao.queryForInt("KEY0400107S", gkey08mt) > 0) {
				simpleDao.update("KEY0400102U", gkey08mt);
			}
			else {
				simpleDao.insert("KEY0400104I", gkey08mt);
			}
		}
		else if(gkey05mt.getKeymanDocTpCd().equals("200")) {
			simpleDao.insert("KEY0400101I", gkey05mt);
			simpleDao.insert("KEY0400103I", gkey07mt);
			if(simpleDao.queryForInt("KEY0400107S", gkey08mt) > 0) {
				simpleDao.update("KEY0400102U", gkey08mt);
			}
			else {
				simpleDao.insert("KEY0400104I", gkey08mt);
			}
		}
		else {
			simpleDao.insert("KEY0400101I", gkey05mt);
		}
	}
	
	public void updateGKEY05MT(GKEY05MT gkey05mt) throws Exception {
		simpleDao.update("KEY0400101U", gkey05mt);
	}
	
}
