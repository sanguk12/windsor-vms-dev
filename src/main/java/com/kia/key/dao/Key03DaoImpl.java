package com.kia.key.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import kr.co.nis.waf.orm.WafSqlMapClientDaoSupport;

import org.springframework.orm.ibatis.SqlMapClientCallback;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class Key03DaoImpl extends WafSqlMapClientDaoSupport implements Key03Dao {

	@Override
	public int smsSend(final ArrayList<HashMap<String, String>> smsList) {
			Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<smsList.size(); i++) {
						executor.insert("KEY03004SENDSMS", smsList.get(i));
						executor.update("KEY0300401U", smsList.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
	}

}
