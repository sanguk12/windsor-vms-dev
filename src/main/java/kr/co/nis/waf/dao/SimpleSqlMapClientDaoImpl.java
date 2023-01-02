// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.dao;

import java.util.List;
import org.springframework.dao.DataAccessException;
import java.util.Map;
import kr.co.nis.waf.orm.WafSqlMapClientDaoSupport;

public class SimpleSqlMapClientDaoImpl extends WafSqlMapClientDaoSupport implements SimpleDao
{
    @Override
    public void delete(final Map parameters) throws DataAccessException {
        this.getSqlMapClientTemplate().update((String)parameters.get("queryKey"), (Object)parameters);
    }
    
    @Override
    public void delete(final Map parameters, final Object obj) throws DataAccessException {
        this.getSqlMapClientTemplate().update((String)parameters.get("queryKey"), obj);
    }
    
    @Override
    public void delete(final String queryKey, final Map parameters) throws DataAccessException {
        this.getSqlMapClientTemplate().update(queryKey, (Object)parameters);
    }
    
    @Override
    public void delete(final String queryKey, final Object obj) throws DataAccessException {
        this.getSqlMapClientTemplate().update(queryKey, obj);
    }
    
    @Override
    public void insert(final Map parameters) throws DataAccessException {
        this.getSqlMapClientTemplate().update((String)parameters.get("queryKey"), (Object)parameters);
    }
    
    @Override
    public void insert(final Map parameters, final Object obj) throws DataAccessException {
        this.getSqlMapClientTemplate().update((String)parameters.get("queryKey"), obj);
    }
    
    @Override
    public void insert(final String queryKey, final Map parameters) throws DataAccessException {
        this.getSqlMapClientTemplate().update(queryKey, (Object)parameters);
    }
    
    @Override
    public void insert(final String queryKey, final Object obj) throws DataAccessException {
        this.getSqlMapClientTemplate().update(queryKey, obj);
    }
    
    @Override
    public int queryForInt(final Map parameters) throws DataAccessException {
        return Integer.parseInt(String.valueOf(this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), (Object)parameters)));
    }
    
    @Override
    public int queryForInt(final Map parameters, final Object obj) throws DataAccessException {
        return Integer.parseInt(String.valueOf(this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), obj)));
    }
    
    @Override
    public int queryForInt(final String queryKey, final Map parameters) throws DataAccessException {
        return Integer.parseInt(String.valueOf(this.getSqlMapClientTemplate().queryForObject(queryKey, (Object)parameters)));
    }
    
    @Override
    public int queryForInt(final String queryKey, final Object obj) throws DataAccessException {
        return Integer.parseInt(String.valueOf(this.getSqlMapClientTemplate().queryForObject(queryKey, obj)));
    }
    
    @Override
    public List queryForList(final Map parameters) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForList((String)parameters.get("queryKey"), (Object)parameters);
    }
    
    @Override
    public List queryForList(final Map parameters, final Object obj) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForList((String)parameters.get("queryKey"), obj);
    }
    
    @Override
    public List queryForList(final String queryKey, final Map parameters) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForList(queryKey, (Object)parameters);
    }
    
    @Override
    public List queryForList(final String queryKey, final Object obj) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForList(queryKey, obj);
    }
    
    @Override
    public long queryForLong(final Map parameters) throws DataAccessException {
        return Long.parseLong(String.valueOf(this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), (Object)parameters)));
    }
    
    @Override
    public long queryForLong(final Map parameters, final Object obj) throws DataAccessException {
        return Long.parseLong(String.valueOf(this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), obj)));
    }
    
    @Override
    public long queryForLong(final String queryKey, final Map parameters) throws DataAccessException {
        return Long.parseLong(String.valueOf(this.getSqlMapClientTemplate().queryForObject(queryKey, (Object)parameters)));
    }
    
    @Override
    public long queryForLong(final String queryKey, final Object obj) throws DataAccessException {
        return Long.parseLong(String.valueOf(this.getSqlMapClientTemplate().queryForObject(queryKey, obj)));
    }
    
    @Override
    public Map queryForMap(final Map parameters) throws DataAccessException {
        return (Map)this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), (Object)parameters);
    }
    
    @Override
    public Map queryForMap(final Map parameters, final Object obj) throws DataAccessException {
        return (Map)this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), obj);
    }
    
    @Override
    public Map queryForMap(final String queryKey, final Map parameters) throws DataAccessException {
        return (Map)this.getSqlMapClientTemplate().queryForObject(queryKey, (Object)parameters);
    }
    
    @Override
    public Map queryForMap(final String queryKey, final Object obj) throws DataAccessException {
        return (Map)this.getSqlMapClientTemplate().queryForObject(queryKey, obj);
    }
    
    @Override
    public Object queryForObject(final Map parameters) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), (Object)parameters);
    }
    
    @Override
    public Object queryForObject(final Map parameters, final Object obj) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForObject((String)parameters.get("queryKey"), obj);
    }
    
    @Override
    public Object queryForObject(final String queryKey, final Map parameters) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForObject(queryKey, (Object)parameters);
    }
    
    @Override
    public Object queryForObject(final String queryKey, final Object obj) throws DataAccessException {
        return this.getSqlMapClientTemplate().queryForObject(queryKey, obj);
    }
    
    @Override
    public int update(final Map parameters) throws DataAccessException {
        return this.getSqlMapClientTemplate().update((String)parameters.get("queryKey"), (Object)parameters);
    }
    
    @Override
    public int update(final Map parameters, final Object obj) throws DataAccessException {
        return this.getSqlMapClientTemplate().update((String)parameters.get("queryKey"), obj);
    }
    
    @Override
    public int update(final String queryKey, final Map parameters) throws DataAccessException {
        return this.getSqlMapClientTemplate().update(queryKey, (Object)parameters);
    }
    
    @Override
    public int update(final String queryKey, final Object obj) throws DataAccessException {
        return this.getSqlMapClientTemplate().update(queryKey, obj);
    }
}
