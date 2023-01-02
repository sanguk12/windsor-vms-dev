// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.dao;

import java.util.List;
import org.springframework.dao.DataAccessException;
import java.util.Map;

public interface SimpleDao
{
    void delete(final Map p0) throws DataAccessException;
    
    void delete(final Map p0, final Object p1) throws DataAccessException;
    
    void delete(final String p0, final Map p1) throws DataAccessException;
    
    void delete(final String p0, final Object p1) throws DataAccessException;
    
    void insert(final Map p0) throws DataAccessException;
    
    void insert(final Map p0, final Object p1) throws DataAccessException;
    
    void insert(final String p0, final Map p1) throws DataAccessException;
    
    void insert(final String p0, final Object p1) throws DataAccessException;
    
    int queryForInt(final Map p0) throws DataAccessException;
    
    int queryForInt(final Map p0, final Object p1) throws DataAccessException;
    
    int queryForInt(final String p0, final Map p1) throws DataAccessException;
    
    int queryForInt(final String p0, final Object p1) throws DataAccessException;
    
    List queryForList(final Map p0) throws DataAccessException;
    
    List queryForList(final Map p0, final Object p1) throws DataAccessException;
    
    List queryForList(final String p0, final Map p1) throws DataAccessException;
    
    List queryForList(final String p0, final Object p1) throws DataAccessException;
    
    long queryForLong(final Map p0) throws DataAccessException;
    
    long queryForLong(final Map p0, final Object p1) throws DataAccessException;
    
    long queryForLong(final String p0, final Map p1) throws DataAccessException;
    
    long queryForLong(final String p0, final Object p1) throws DataAccessException;
    
    Map queryForMap(final Map p0) throws DataAccessException;
    
    Map queryForMap(final Map p0, final Object p1) throws DataAccessException;
    
    Map queryForMap(final String p0, final Map p1) throws DataAccessException;
    
    Map queryForMap(final String p0, final Object p1) throws DataAccessException;
    
    Object queryForObject(final Map p0) throws DataAccessException;
    
    Object queryForObject(final Map p0, final Object p1) throws DataAccessException;
    
    Object queryForObject(final String p0, final Map p1) throws DataAccessException;
    
    Object queryForObject(final String p0, final Object p1) throws DataAccessException;
    
    int update(final Map p0) throws DataAccessException;
    
    int update(final Map p0, final Object p1) throws DataAccessException;
    
    int update(final String p0, final Map p1) throws DataAccessException;
    
    int update(final String p0, final Object p1) throws DataAccessException;
}
