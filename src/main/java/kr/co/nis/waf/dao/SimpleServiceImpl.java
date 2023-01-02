// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.dao;

import java.util.List;
import java.util.Map;

public class SimpleServiceImpl implements SimpleService
{
    private SimpleDao simpleDao;
    
    public void setSimpleDao(final SimpleDao simpleDao) {
        this.simpleDao = simpleDao;
    }
    
    @Override
    public void delete(final Map parameters) throws Exception {
        this.simpleDao.delete(parameters);
    }
    
    @Override
    public void delete(final Map parameters, final Object obj) throws Exception {
        this.simpleDao.delete(parameters, obj);
    }
    
    @Override
    public void delete(final String queryKey, final Map parameters) throws Exception {
        this.simpleDao.delete(queryKey, parameters);
    }
    
    @Override
    public void delete(final String queryKey, final Object obj) throws Exception {
        this.simpleDao.delete(queryKey, obj);
    }
    
    @Override
    public void insert(final Map parameters) throws Exception {
        this.simpleDao.insert(parameters);
    }
    
    @Override
    public void insert(final Map parameters, final Object obj) throws Exception {
        this.simpleDao.insert(parameters, obj);
    }
    
    @Override
    public void insert(final String queryKey, final Map parameters) throws Exception {
        this.simpleDao.insert(queryKey, parameters);
    }
    
    @Override
    public void insert(final String queryKey, final Object obj) throws Exception {
        this.simpleDao.insert(queryKey, obj);
    }
    
    @Override
    public int queryForInt(final Map parameters) throws Exception {
        return this.simpleDao.queryForInt(parameters);
    }
    
    @Override
    public int queryForInt(final Map parameters, final Object obj) throws Exception {
        return this.simpleDao.queryForInt(parameters, obj);
    }
    
    @Override
    public int queryForInt(final String queryKey, final Map parameters) throws Exception {
        return this.simpleDao.queryForInt(queryKey, parameters);
    }
    
    @Override
    public int queryForInt(final String queryKey, final Object obj) throws Exception {
        return this.simpleDao.queryForInt(queryKey, obj);
    }
    
    @Override
    public List queryForList(final Map parameters) throws Exception {
        return this.simpleDao.queryForList(parameters);
    }
    
    @Override
    public List queryForList(final Map parameters, final Object obj) throws Exception {
        return this.simpleDao.queryForList(parameters, obj);
    }
    
    @Override
    public List queryForList(final String queryKey, final Map parameters) throws Exception {
        return this.simpleDao.queryForList(queryKey, parameters);
    }
    
    @Override
    public List queryForList(final String queryKey, final Object obj) throws Exception {
        return this.simpleDao.queryForList(queryKey, obj);
    }
    
    @Override
    public long queryForLong(final Map parameters) throws Exception {
        return this.simpleDao.queryForLong(parameters);
    }
    
    @Override
    public long queryForLong(final Map parameters, final Object obj) throws Exception {
        return this.simpleDao.queryForLong(parameters, obj);
    }
    
    @Override
    public long queryForLong(final String queryKey, final Map parameters) throws Exception {
        return this.simpleDao.queryForLong(queryKey, parameters);
    }
    
    @Override
    public long queryForLong(final String queryKey, final Object obj) throws Exception {
        return this.simpleDao.queryForLong(queryKey, obj);
    }
    
    @Override
    public Map queryForMap(final Map parameters) throws Exception {
        return this.simpleDao.queryForMap(parameters);
    }
    
    @Override
    public Map queryForMap(final Map parameters, final Object obj) throws Exception {
        return this.simpleDao.queryForMap(parameters, obj);
    }
    
    @Override
    public Map queryForMap(final String queryKey, final Map parameters) throws Exception {
        return this.simpleDao.queryForMap(queryKey, parameters);
    }
    
    @Override
    public Map queryForMap(final String queryKey, final Object obj) throws Exception {
        return (Map)this.simpleDao.queryForObject(queryKey, obj);
    }
    
    @Override
    public Object queryForObject(final Map parameters) throws Exception {
        return this.simpleDao.queryForObject(parameters);
    }
    
    @Override
    public Object queryForObject(final Map parameters, final Object obj) throws Exception {
        return this.simpleDao.queryForObject(parameters, obj);
    }
    
    @Override
    public Object queryForObject(final String queryKey, final Map parameters) throws Exception {
        return this.simpleDao.queryForObject(queryKey, parameters);
    }
    
    @Override
    public Object queryForObject(final String queryKey, final Object obj) throws Exception {
        return this.simpleDao.queryForObject(queryKey, obj);
    }
    
    @Override
    public void update(final Map parameters) throws Exception {
        this.simpleDao.update(parameters);
    }
    
    @Override
    public void update(final Map parameters, final Object obj) throws Exception {
        this.simpleDao.update(parameters, obj);
    }
    
    @Override
    public void update(final String queryKey, final Map parameters) throws Exception {
        this.simpleDao.update(queryKey, parameters);
    }
    
    @Override
    public void update(final String queryKey, final Object obj) throws Exception {
        this.simpleDao.update(queryKey, obj);
    }
}
