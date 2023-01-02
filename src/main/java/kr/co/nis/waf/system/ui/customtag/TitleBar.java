package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class TitleBar extends WebControl {
	protected final Log logger = LogFactory.getLog(getClass());

	public int doStartTag() {
		try {
			JspWriter out = pageContext.getOut();
			String appContextPath = this.pageContext.getRequest().getServletContext().getContextPath();
			if("list".equals(this.getPreset())) {
				out.println("<table width=\"100%\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-bottom:8px;\">");
				out.println("	<tr><td width=\"100%\" height=\"22\" class=\"txDarkgray\" valign=\"middle\">");
				out.println("		<img src=\""+ appContextPath +"/images/lblBlue03.gif\" width=\"16\" height=\"17\" align=\"absmiddle\" class=\"lbl02\"><label id=\""+super.getId()+"\">"+super.getValue()+"</label>");
				out.println("	</td></tr>");
				out.println("</table>");
			} else {
				out.println("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-bottom:8px;\">");
				out.println("	<tr><td height=\"29\" class=\"tblViewTh\"><label id=\""+super.getId()+"\">"+super.getValue()+"</label></td></tr>");
				out.println("</table>");
			}
		} catch (IOException e) {
			if(logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
		return SKIP_BODY;
	}
}
