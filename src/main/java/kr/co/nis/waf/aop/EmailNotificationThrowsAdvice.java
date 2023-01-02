// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.aop;

import org.apache.commons.logging.LogFactory;
import kr.co.nis.waf.mail.ExceptionMailSender;
import org.apache.commons.logging.Log;
import org.springframework.aop.ThrowsAdvice;

public class EmailNotificationThrowsAdvice implements ThrowsAdvice
{
    protected final Log logger;
    private ExceptionMailSender mailSender;
    
    public EmailNotificationThrowsAdvice() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public void setMailSender(final ExceptionMailSender mailSender) {
        this.mailSender = mailSender;
    }
    
    public void afterThrowing(final RuntimeException ex) throws Throwable {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)"afterThrowing() Start");
            this.logger.debug((Object)("Caught : " + ex.getClass().getName()));
        }
        this.mailSender.sendMessage(ex);
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)"afterThrowing() End");
        }
    }
    
    public void afterThrowing(final Exception ex) throws Throwable {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)"afterThrowing() Start");
            this.logger.debug((Object)("Caught : " + ex.getClass().getName()));
        }
        if (this.logger.isErrorEnabled()) {
            this.logger.error((Object)"Checked Exception\ufffd\ufffd \ufffd\u07fb\ufffd\ufffd\u07fd\ufffd\ufffd\u03f4\ufffd.", (Throwable)ex);
        }
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)"afterThrowing() End");
        }
    }
}
