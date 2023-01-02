// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mail;

import javax.mail.internet.MimeMessage;
import javax.mail.MessagingException;
import kr.co.nis.waf.util.StringUtil;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.apache.commons.logging.Log;

public class ExceptionMailSender extends AbstractMessageSender
{
    protected final Log logger;
    private MessageSourceAccessor msAccessor;
    
    public ExceptionMailSender() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.msAccessor = null;
    }
    
    public void setMessageSourceAccessor(final MessageSourceAccessor msAccessor) {
        this.msAccessor = msAccessor;
    }
    
    public void sendMessage(final Throwable e) {
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)"sendMessage() - START");
        }
        try {
            final MimeMessage msg = this.sender.createMimeMessage();
            final MimeMessageHelper helper = new MimeMessageHelper(msg);
            helper.setTo(this.to);
            helper.setFrom(this.from);
            helper.setSubject(e.getMessage());
            final StringBuffer sb = new StringBuffer();
            sb.append("<html><head></head><body>");
            sb.append("<h1>");
            sb.append(e.getMessage());
            sb.append("</h1><br/>");
            sb.append(StringUtil.stackTraceToString(e));
            sb.append("</body></html>");
            helper.setText(sb.toString());
            this.sender.send(msg);
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)"sendMessage() - END");
            }
        }
        catch (final MessagingException me) {
            if (this.logger.isErrorEnabled()) {
                this.logger.error((Object)this.msAccessor.getMessage("email.not.send"), (Throwable)me);
                this.logger.error((Object)this.msAccessor.getMessage("original.error.message"), e);
            }
        }
        catch (final Exception ex) {
            if (this.logger.isErrorEnabled()) {
                this.logger.error((Object)this.msAccessor.getMessage("email.not.send"), (Throwable)ex);
                this.logger.error((Object)this.msAccessor.getMessage("original.error.message"), e);
            }
        }
    }
}
