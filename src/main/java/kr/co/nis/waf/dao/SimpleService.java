// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.dao;

import java.util.List;
import java.util.Map;

public interface SimpleService
{
    void delete(final Map p0) throws Exception;
    
    void delete(final Map p0, final Object p1) throws Exception;
    
    void delete(final String p0, final Map p1) throws Exception;
    
    void delete(final String p0, final Object p1) throws Exception;
    
    void insert(final Map p0) throws Exception;
    
    void insert(final Map p0, final Object p1) throws Exception;
    
    void insert(final String p0, final Map p1) throws Exception;
    
    void insert(final String p0, final Object p1) throws Exception;
    
    int queryForInt(final Map p0) throws Exception;
    
    int queryForInt(final Map p0, final Object p1) throws Exception;
    
    int queryForInt(final String p0, final Map p1) throws Exception;
    
    int queryForInt(final String p0, final Object p1) throws Exception;
    
    List queryForList(final Map p0) throws Exception;
    
    List queryForList(final Map p0, final Object p1) throws Exception;
    
    List queryForList(final String p0, final Map p1) throws Exception;
    
    List queryForList(final String p0, final Object p1) throws Exception;
    
    long queryForLong(final Map p0) throws Exception;
    
    long queryForLong(final Map p0, final Object p1) throws Exception;
    
    long queryForLong(final String p0, final Map p1) throws Exception;
    
    long queryForLong(final String p0, final Object p1) throws Exception;
    
    Map queryForMap(final Map p0) throws Exception;
    
    Map queryForMap(final Map p0, final Object p1) throws Exception;
    
    Map queryForMap(final String p0, final Map p1) throws Exception;
    
    Map queryForMap(final String p0, final Object p1) throws Exception;
    
    Object queryForObject(final Map p0) throws Exception;
    
    Object queryForObject(final Map p0, final Object p1) throws Exception;
    
    Object queryForObject(final String p0, final Map p1) throws Exception;
    
    Object queryForObject(final String p0, final Object p1) throws Exception;
    
    void update(final Map p0) throws Exception;
    
    void update(final Map p0, final Object p1) throws Exception;
    
    void update(final String p0, final Map p1) throws Exception;
    
    void update(final String p0, final Object p1) throws Exception;
}
