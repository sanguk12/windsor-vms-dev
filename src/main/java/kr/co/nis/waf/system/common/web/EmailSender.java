package kr.co.nis.waf.system.common.web;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import kr.co.nis.waf.mail.AbstractMessageSender;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.mail.javamail.MimeMessageHelper;

public class EmailSender extends AbstractMessageSender {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private MessageSourceAccessor msAccessor = null;
	
	@Value("#{appenv['app.mail.sender']}")
	private String mail_sender;

	@Value("#{appenv['app.activeProfile']}")
	private String activeProfile;

	public void setMessageSourceAccessor(MessageSourceAccessor msAccessor) {
		this.msAccessor = msAccessor;
	}
	
	public void sendMail(Map<String, String> map) {
		
		try {
			if("local".contentEquals(activeProfile) || "dev".contentEquals(activeProfile)){
				super.sender = super.daumSender;
			}
			MimeMessage msg = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");

			String[] to = map.get("to").toString().split(";");
			helper.setTo(to);
			//helper.setFrom(map.get("from").toString());
			helper.setFrom(mail_sender);
			helper.setSubject(map.get("subject").toString());
			
			if(map.get("addcc")!=null) {
				helper.addCc(map.get("addcc").toString());		//참조
			}
			if(map.get("addbcc")!=null) {
				helper.addBcc(map.get("addbcc").toString());	//숨은참조
			}

			StringBuffer sb = new StringBuffer();
			sb.append(map.get("content").toString());
			
			if (logger.isDebugEnabled()) {
				logger.debug("*************e-mail*************\n");
				for(int i=0; i<to.length; i++) {
					logger.debug("to["+i+"] : "+to[i]);
				}
				//logger.debug("from : "+map.get("from").toString());
				logger.debug("from : "+mail_sender);
				logger.debug("subject : "+map.get("subject").toString());
				if(map.get("addcc")!=null) {
					logger.debug("addCc : "+map.get("addcc").toString());
				}
				if(map.get("addbcc")!=null) {
					logger.debug("addbcc : "+map.get("addbcc").toString());
				}
				logger.debug("text : "+sb.toString());
				logger.debug("******************************\n");
			}
			
			helper.setText(sb.toString());
			msg.setContent(sb.toString(), "text/html; charset=utf-8");

			sender.send(msg);
			
		} catch (MessagingException me) {
			if( logger.isErrorEnabled() ) {
				logger.error(msAccessor.getMessage("error.emailNotSend"), me);
			}
		} catch (Exception ex) {
			if( logger.isErrorEnabled() ) {
				ex.printStackTrace();
				logger.error(msAccessor.getMessage("error.emailNotSend"), ex);
			}			
		}
	}
}
