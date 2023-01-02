// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.dao;

import java.util.List;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.dao.DataAccessException;
import java.util.Map;
import kr.co.nis.waf.jdbc.WafNamedParameterJdbcDaoSupport;

public class SimpleNamedParameterDaoImpl extends WafNamedParameterJdbcDaoSupport implements SimpleDao
{
    @Override
    public void delete(final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), parameters);
    }
    
    @Override
    public void delete(final Map parameters, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public void delete(final String queryKey, final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage(queryKey), parameters);
    }
    
    @Override
    public void delete(final String queryKey, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage(queryKey), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public void insert(final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), parameters);
    }
    
    @Override
    public void insert(final Map parameters, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public void insert(final String queryKey, final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage(queryKey), parameters);
    }
    
    @Override
    public void insert(final String queryKey, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage(queryKey), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public int queryForInt(final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey"))));
        }
        return this.getNamedParameterJdbcTemplate().queryForInt(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), parameters);
    }
    
    @Override
    public int queryForInt(final Map parameters, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey"))));
        }
        return this.getNamedParameterJdbcTemplate().queryForInt(this.getMessageSourceAccessor().getMessage(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey"))), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public int queryForInt(final String queryKey, final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForInt(this.getMessageSourceAccessor().getMessage(queryKey), parameters);
    }
    
    @Override
    public int queryForInt(final String queryKey, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForInt(this.getMessageSourceAccessor().getMessage(queryKey), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public List queryForList(final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        return this.getNamedParameterJdbcTemplate().queryForList(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), parameters);
    }
    
    @Override
    public List queryForList(final Map parameters, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        return this.getNamedParameterJdbcTemplate().queryForList(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public List queryForList(final String queryKey, final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForList(this.getMessageSourceAccessor().getMessage(queryKey), parameters);
    }
    
    @Override
    public List queryForList(final String queryKey, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForList(this.getMessageSourceAccessor().getMessage(queryKey), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public long queryForLong(final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey"))));
        }
        return this.getNamedParameterJdbcTemplate().queryForLong(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), parameters);
    }
    
    @Override
    public long queryForLong(final Map parameters, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey"))));
        }
        return this.getNamedParameterJdbcTemplate().queryForLong(this.getMessageSourceAccessor().getMessage(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey"))), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public long queryForLong(final String queryKey, final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForLong(this.getMessageSourceAccessor().getMessage(queryKey), parameters);
    }
    
    @Override
    public long queryForLong(final String queryKey, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForLong(this.getMessageSourceAccessor().getMessage(queryKey), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public Map queryForMap(final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        return this.getNamedParameterJdbcTemplate().queryForMap(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), parameters);
    }
    
    @Override
    public Map queryForMap(final Map parameters, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        return this.getNamedParameterJdbcTemplate().queryForMap(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public Map queryForMap(final String queryKey, final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForMap(this.getMessageSourceAccessor().getMessage(queryKey), parameters);
    }
    
    @Override
    public Map queryForMap(final String queryKey, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().queryForMap(this.getMessageSourceAccessor().getMessage(queryKey), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public Object queryForObject(final Map parameters) throws DataAccessException {
        return null;
    }
    
    @Override
    public Object queryForObject(final Map parameters, final Object obj) throws DataAccessException {
        return null;
    }
    
    @Override
    public Object queryForObject(final String queryKey, final Map parameters) throws DataAccessException {
        return null;
    }
    
    @Override
    public Object queryForObject(final String queryKey, final Object obj) throws DataAccessException {
        return null;
    }
    
    @Override
    public int update(final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        return this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), parameters);
    }
    
    @Override
    public int update(final Map parameters, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")));
        }
        return this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage((String)parameters.get("queryKey")), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
    
    @Override
    public int update(final String queryKey, final Map parameters) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage(queryKey), parameters);
    }
    
    @Override
    public int update(final String queryKey, final Object obj) throws DataAccessException {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)this.getMessageSourceAccessor().getMessage(queryKey));
        }
        return this.getNamedParameterJdbcTemplate().update(this.getMessageSourceAccessor().getMessage(queryKey), (SqlParameterSource)new BeanPropertySqlParameterSource(obj));
    }
}
