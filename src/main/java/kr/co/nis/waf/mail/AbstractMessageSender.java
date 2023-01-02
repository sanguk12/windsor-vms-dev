// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mail;

import org.springframework.mail.javamail.JavaMailSender;

public abstract class AbstractMessageSender
{
    protected String to;
    protected String from;
    protected String subject;
    protected String text;
    protected JavaMailSender sender;
    
    public void setFrom(final String from) {
        this.from = from;
    }
    
    public void setSender(final JavaMailSender sender) {
        this.sender = sender;
    }
    
    public void setSubject(final String subject) {
        this.subject = subject;
    }
    
    public void setTo(final String to) {
        this.to = to;
    }
    
    public void setText(final String text) {
        this.text = text;
    }
}
