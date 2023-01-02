// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mail;

import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class EmailServiceImpl implements EmailService
{
    protected final Log logger;
    
    public EmailServiceImpl() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    @Override
    public void sendException(final RuntimeException e) {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)"Received sendException()");
            this.logger.debug((Object)("Class Name : " + e.getClass()));
            this.logger.debug((Object)("Received Message : " + e.getMessage()));
        }
    }
}
