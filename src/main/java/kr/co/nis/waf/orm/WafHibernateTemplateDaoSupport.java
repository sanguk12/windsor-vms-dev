// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.orm;

import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.context.support.MessageSourceAccessor;

public class WafHibernateTemplateDaoSupport
{
    private MessageSourceAccessor messageSourceAccessor;
    private HibernateTemplate hibernateTemplate;
    
    public void setMessageSourceAccessor(final MessageSourceAccessor newMessageSourceAccessor) {
        this.messageSourceAccessor = newMessageSourceAccessor;
    }
    
    protected final MessageSourceAccessor getMessageSourceAccessor() {
        return this.messageSourceAccessor;
    }
    
    public void setHibernateTemplate(final HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }
    
    protected final HibernateTemplate getHibernateTemplate() {
        return this.hibernateTemplate;
    }
}
