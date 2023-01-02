// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.jdbc;

import org.springframework.jdbc.support.incrementer.DataFieldMaxValueIncrementer;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

public class WafNamedParameterJdbcDaoSupport extends NamedParameterJdbcDaoSupport
{
    private MessageSourceAccessor messageSourceAccessor;
    private DataFieldMaxValueIncrementer incrementer;
    
    public void setIncrementer(final DataFieldMaxValueIncrementer incrementer) {
        this.incrementer = incrementer;
    }
    
    protected final DataFieldMaxValueIncrementer getIncrementer() {
        return this.incrementer;
    }
    
    public void setMessageSourceAccessor(final MessageSourceAccessor newMessageSourceAccessor) {
        this.messageSourceAccessor = newMessageSourceAccessor;
    }
    
    protected final MessageSourceAccessor getMessageSourceAccessor() {
        return this.messageSourceAccessor;
    }
}
