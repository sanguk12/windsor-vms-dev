package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class MP4Player extends WebControl {

	protected final Log logger = LogFactory.getLog(getClass());
	
	public int doStartTag() {

		try {
			outTag();
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
				e.printStackTrace();
			}
		}

		return SKIP_BODY;
	}

	private void outTag() {
		try {
			JspWriter out = pageContext.getOut();
			StringBuffer html = new StringBuffer();
			
			String height = String.valueOf(getHeight());
			String width = String.valueOf(getWidth());
			
			html.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" height=\"100%\">");
			
			if (height != null && !height.equals("0")) {
				html.append("<tr><td height=\""+height+"\">");
			}
			else {
				html.append("<tr><td height=\"320\">");
			}
			html.append("<iframe ");
			if (super.getId() == null && super.getName() == null) {
				html.append(" id=\"_code\" name=\"_code\"");
			} else if (super.getId() != null && super.getName() == null) {
				html.append(" id=\"_" + super.getId() + "\" name=\"_"+ super.getId() + "\"");
			} else if (super.getId() == null && super.getName() != null) {
				html.append(" id=\"_" + super.getName() + "\" name=\"_"+ super.getName() + "\"");
			} else if (super.getId() != null && super.getName() != null) {
				html.append(" id=\"_" + super.getId() + "\" name=\"_" + super.getName() + "\"");
			}
			html.append(" style=\"width:100%; height:100%;\" frameborder=\"0\" scrolling=\"no\" src=\"/sys3/cms/mp4player.page?width="+width+"&height="+height+"\"></iframe>");
			html.append("</td></tr>");
			html.append("</table>");

			if (super.getPreset() != null && super.getPreset().equals("aw")) {
				out.print(html.toString().replace("\"", "\\\""));
			} else {
				out.print(html.toString());
			}

		} catch (IOException e) {
			if (logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
	}

}